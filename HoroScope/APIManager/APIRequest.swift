//
//  File.swift
//  Test
//
//  Created by Hoa on 1/10/17.
//  Copyright © 2017 Hoa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration
import KRProgressHUD

enum ErrorCode: String {
    case NoCode
}

enum NetworkConnection {
    case available
    case notAvailable
}

class Respone: NSObject {
    var status: Bool
    var code: ErrorCode
    var responeJson: JSON
    
    init(_ statusAPI: Bool, code: ErrorCode, json: JSON) {
        self.status = statusAPI
        self.responeJson = json
        self.code = code
    }
}

class APIRequest: NSObject {
    static let shared = APIRequest()
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    typealias SuccessHandle = (Respone) -> Void
    typealias FailHandle = (Error) -> Void
    typealias SessionHandler = (Bool) -> Void
    
    // MARK: - Helper Methods
    
    func webServiceCall(_ strURL: String,
                        params: [String:Any]?,
                        isShowLoader: Bool,
                        method: HTTPMethod,
                        isHasHeader: Bool,
                        success: @escaping SuccessHandle) {
        switch connection() {
        case .available:
            if isShowLoader {
                KRProgressHUD.show()
            }
            
            manager.request(strURL,
                            method: method,
                            parameters: params,
                            encoding: JSONEncoding.default,
                            headers: getHeader(isHasHeader)).responseJSON(completionHandler: {(resObj) -> Void in
                                print(strURL)
                                print(params ?? "non-param")
                                if resObj.result.isSuccess {
                                    let respone = self.hanleRespone(resObj.result.value!, url: strURL)
                                    success(respone)
                                    
                                    if isShowLoader {
                                        KRProgressHUD.dismiss()
                                    }
                                }
                                if resObj.result.isFailure {
                                    let error: Error = resObj.result.error!
                                    let errorCode: Int = (error as NSError).code
                                    print("error: \(error) \((error as NSError).code == -1005)")
                                    if errorCode == -1005 {
                                        self.webServiceCall(strURL,
                                                            params: params,
                                                            isShowLoader: isShowLoader,
                                                            method: method,
                                                            isHasHeader: isHasHeader, success: { (respone) in
                                                                success(respone)
                                        })
                                    }else{
                                        if isShowLoader {
                                            KRProgressHUD.dismiss()
                                        }
                                        let respone = self.hanleRespone(resObj.result.error!, url: strURL)
                                        success(respone)
                                    }
                                }
                                
                            })
            break
        case .notAvailable:
            Common.showAlert("err_network_available")
            break
        }
    }
    
    func webServiceCallMultiPartMultiImage(_ strURL : String, params : [String:String]?, images : [UIImage]?, isShowLoader : Bool, method : HTTPMethod, isHasHeader : Bool, success : @escaping SuccessHandle) {
        switch connection() {
        case .available:
            if isShowLoader {
                KRProgressHUD.show()
            }
            manager.upload(multipartFormData: { (multipartFormData) in
                if let imgs = images {
                    for image in imgs {
                        if let imageData = image.jpegData(compressionQuality: 1) {
                            print(imageData.count)
                            multipartFormData.append(imageData, withName: "File", fileName: "image.jpg", mimeType: "image/jpg")
                        }
                    }
                }
                
                if params != nil {
                    for (key, value) in params! {
                        
                        let data = value
                        
                        multipartFormData.append(data.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
            }, usingThreshold: UInt64.init(), to: strURL, method: .post, headers: getHeader(isHasHeader), encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    KRProgressHUD.dismiss()
                    Common.showAlert("err_unexpected_exception")
                }
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { (response) -> Void in
                        KRProgressHUD.dismiss()
                        if response.result.isSuccess
                        {
                            let responeObj = self.hanleRespone(response.result.value!, url: strURL)
                            success(responeObj)
                        }
                        
                        if response.result.isFailure {
                            let responeObj = self.hanleRespone(response.result.error!, url: strURL)
                            success(responeObj)
                        }
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    KRProgressHUD.dismiss()
                    Common.showAlert("err_unexpected_exception")
                }
            })
            break
        case .notAvailable:
            Common.showAlert("err_network_available")
            break
        }
    }
}

let apiRequestShared = APIRequest.shared

extension APIRequest {
    func connection() -> NetworkConnection {
        if self.isNetworkAvailable() {
            return .available
        }
        return .notAvailable
    }
    
    func isNetworkAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func getHeader(_ isHasHeader : Bool) -> [String : String]? {
        if isHasHeader {
            let tokenType = SaveHelper.get(.tokenType) as! String
            let accessToken = SaveHelper.get(.accessToken) as! String
            return ["Authorization": "\(tokenType) \(accessToken)",
                "Content-Type":"application/json"]
        }
        return nil
    }
    
    func hanleRespone(_ value: Any, url: String) -> Respone {
        let json = JSON(value)
        print("success: \(json)")
        let status = json["success"].boolValue
        let code = ErrorCode(rawValue: json["errorCode"].stringValue) ?? .NoCode
        return Respone(status, code: code, json: json)
    }
}

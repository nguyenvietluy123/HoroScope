//
//  ScanVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import Vision

class ScanningVC: BaseVC {
    @IBOutlet weak var imageView1: KHImageView!
    @IBOutlet weak var imageView2: KHImageView!
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lbProgress: KHLabel!
    @IBOutlet weak var viewScan: UIView!
    @IBOutlet weak var lbStatus: KHLabel!
    
    var isDetect: Bool = true
    var isBeautyPrediction: Bool = false
    var timer: Timer = Timer()
    var img1: UIImage?
    var img2: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.progressView.layer.cornerRadius = self.progressView.frame.height/2
        progressView.clipsToBounds = true
        
        
        
    }
}

extension ScanningVC {
    func initUI() {
        navi.handleBack = {
            self.clickBack()
        }
        self.imageView1.image = img1
        self.imageView2.image = img2
        GCDCommon.mainQueue {
//            let gradient = CAGradientLayer()
//            gradient.colors = [UIColor.clear.cgColor, UIColor.red.cgColor, UIColor.clear.cgColor]
//            gradient.locations = [0.0, 0.75, 1.0]
//            gradient.startPoint = CGPoint(x: 0, y: 0)
//            gradient.endPoint = CGPoint(x: 1, y: 0)
//            gradient.frame = self.viewScan.frame
//            self.view.layer.addSublayer(gradient)
//            let gradientAnimation = CABasicAnimation(keyPath: "locations")
//            gradientAnimation.fromValue = [0, 0, 0.25]
//            gradientAnimation.toValue = [0.75, 1, 1.0]
//            gradientAnimation.duration = 3
//            gradientAnimation.autoreverses = true
//            gradientAnimation.repeatCount = Float.infinity
//            gradient.add(gradientAnimation, forKey: nil)
        }
        
        
        Common.addNotificationCenter(observer: self, selector: #selector(cantDetectFace), key: NotificationCenterKey.CantDetectFace)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { (timer) in
            if self.progressView.progress < 0.8 {
                self.progressTo_80()
            } else {
                self.progressWhenCompleted()
            }
            self.lbProgress.text = "\(Int(self.progressView.progress*100))%"
        })
        timer.fire()
    }
    
    func progressTo_80 () {
        UIView.animate(withDuration: 0.5, delay: 0, options:
            UIView.AnimationOptions.curveEaseOut, animations: {
                self.progressView.setProgress(self.progressView.progress + 0.01, animated: true)
        }, completion: nil)
    }
    
    func progressWhenCompleted() {
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            ScanningVC.scan(imageScan: self.imageView1)
            ScanningVC.scan(imageScan: self.imageView2)
            self.timer.invalidate()
            if self.isDetect {
                self.progressView.setProgress(1, animated: true)
                self.lbStatus.text = "Your baby is generating"
            } else {
                return
            }
        }, completion: { (completed) in
            GCDCommon.mainQueueWithDelay(1.5, {
                if self.isBeautyPrediction {
                    let vc = BabyPredictionVC.init(nibName: "BabyPredictionVC", bundle: nil)
                    vc.imgLeftTranfer = self.imageView1.image
                    vc.imgRightTranfer = self.imageView2.image
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = BeautyContestVC.init(nibName: "BeautyContestVC", bundle: nil)
                    vc.imgLeftTranfer = self.imageView1.image
                    vc.imgRightTranfer = self.imageView2.image
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
        })
    }
    
    @objc func cantDetectFace() {
        self.isDetect = false
        _ = AlertController.present(style: .alert, title: "Alert", message: "Can't detect face, Please try again!", actionTitles: ["Ok"], handler: { (action) in
            self.clickBack()
        })
    }
}


//draw face
extension ScanningVC {
    class func scan(imageScan: UIImageView, wantDraw: Bool = true) {
        var orientation:Int32 = 0
        
        // detect image orientation, we need it to be accurate for the face detection to work
        switch imageScan.image!.imageOrientation {
        case .up:
            orientation = 1
        case .right:
            orientation = 6
        case .down:
            orientation = 3
        case .left:
            orientation = 8
        default:
            orientation = 1
        }
        
        // vision
        let faceLandmarksRequest = VNDetectFaceLandmarksRequest { (request, error) in
            guard let observations = request.results as? [VNFaceObservation] else {
                fatalError("unexpected result type!")
            }
            if observations.count == 0 {
                Common.postNotificationCenter(key: NotificationCenterKey.CantDetectFace, object: nil)
            }
            
            if wantDraw {
                for face in observations {
                    imageScan.image = addFaceLandmarksToImage(face, imageScan: imageScan)
                }
            }
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: imageScan.image!.cgImage!, orientation: CGImagePropertyOrientation(rawValue: CGImagePropertyOrientation.RawValue(orientation))! ,options: [:])
        do {
            try requestHandler.perform([faceLandmarksRequest])
        } catch {
            print(error)
        }
    }
    
    class func addFaceLandmarksToImage(_ face: VNFaceObservation, imageScan: UIImageView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageScan.image!.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the image
        imageScan.image!.draw(in: CGRect(x: 0, y: 0, width: imageScan.image!.size.width, height: imageScan.image!.size.height))
        
        context?.translateBy(x: 0, y: imageScan.image!.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        // draw the face rect
        let w = face.boundingBox.size.width * imageScan.image!.size.width
        let h = face.boundingBox.size.height * imageScan.image!.size.height
        let x = face.boundingBox.origin.x * imageScan.image!.size.width
        let y = face.boundingBox.origin.y * imageScan.image!.size.height
        let faceRect = CGRect(x: x, y: y, width: w, height: h)
        context?.saveGState()
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(1.0)
        context?.addRect(faceRect)
        context?.drawPath(using: .stroke)
        context?.restoreGState()
        
        // face contour
//        context?.saveGState()
//        context?.setStrokeColor(UIColor.white.cgColor)
//        if let landmark = face.landmarks?.faceContour {
//            for i in 0...landmark.pointCount - 1 { // last point is 0,0
//                let point = landmark.normalizedPoints[i] //.point(at: i)
//                if i == 0 {
//                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
//                } else {
//                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
//                }
//            }
//        }
//        context?.setLineWidth(8.0)
//        context?.drawPath(using: .stroke)
//        context?.saveGState()
        
        // outer lips
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.outerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // inner lips
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.innerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eye
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.leftEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eye
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.rightEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left pupil
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.leftPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right pupil
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.rightPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eyebrow
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.leftEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eyebrow
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.rightEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.nose {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose crest
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.noseCrest {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // median line
        context?.saveGState()
        context?.setStrokeColor(UIColor.white.cgColor)
        if let landmark = face.landmarks?.medianLine {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i] //.point(at: i)
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(1.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // get the final image
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end drawing context
        UIGraphicsEndImageContext()
        guard let imageFinal = finalImage else { return nil }
        return imageFinal
    }
}

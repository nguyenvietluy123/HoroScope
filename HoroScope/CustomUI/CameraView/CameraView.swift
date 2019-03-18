//
//  CameraView.swift
//  FakeTime
//
//  Created by Luy Nguyen on 1/28/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class CameraView: UIView {
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var img: UIImageView!
    
    var photoOutput: AVCapturePhotoOutput = {
        let p = AVCapturePhotoOutput()
        p.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
        return p
    }()
    
    lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        v.connection(with: .video)?.isEnabled = true
        return v
    }()
    
    let videoDataOutputQueue: DispatchQueue = DispatchQueue(label: "JKVideoDataOutputQueue")
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        return l
    }()
    
    let captureDevice: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: AVCaptureDevice.Position.front)
    
    var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .hd1280x720
        return s
    }()
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius * heightRatio
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBAction func action_takePhoto(_ sender: Any) {
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
        
    }
    
    func initializeSubviews() {
        let xibFileName = "CameraView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
}

extension CameraView {
    func commonInit() {
        contentMode = .scaleAspectFill
        beginSession()
    }
    
    func beginSession() {
        do {
            guard let captureDevice = captureDevice else {
                fatalError("Camera doesn't work on the simulator! You have to test this on an actual device!")
            }
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }
            
            if session.canAddOutput(photoOutput) {
                session.addOutput(photoOutput)
            }
            layer.masksToBounds = true
            previewLayer.frame = bounds
            viewCamera.layer.addSublayer(previewLayer)
            createOverlayView()
            session.startRunning()
        } catch let error {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }
    
    func createOverlayView() {
        let whiteView = UIView(frame: viewCamera.bounds)
        let maskLayer = CAShapeLayer() //create the mask layer
        
        // Set the radius to 1/3 of the screen width
        let radius : CGFloat = viewCamera.bounds.width/2
        
        // Create a path with the rectangle in it.
        let path = UIBezierPath(rect: viewCamera.bounds)
        // Put a circle path in the middle
        path.addArc(withCenter: viewCamera.center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        // Give the mask layer the path you just draw
        maskLayer.path = path.cgPath
        // Fill rule set to exclude intersected paths
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        // By now the mask is a rectangle with a circle cut out of it. Set the mask to the view and clip.
        whiteView.layer.mask = maskLayer
        whiteView.clipsToBounds = true
        
        whiteView.alpha = 0.8
        whiteView.backgroundColor = UIColor.white
        
        //If you are in a VC add to the VC's view (over the image)
        self.viewCamera.addSubview(whiteView)
    }
    
}

extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            let imageView = UIImageView()
            imageView.frame = self.bounds
            imageView.image = UIImage(data: imageData) ?? UIImage()
            let cropImage = cropToBounds(image: imageView.image!, width: Double(imageView.frame.width/2), height: Double(imageView.frame.height/2))
            img.image = cropImage
        }
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {}

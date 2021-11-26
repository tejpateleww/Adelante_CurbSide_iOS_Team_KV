//
//  QRScannerView.swift
//  Prediction
//
//  Created by PCQ224 on 25/01/21.
//  Copyright © 2021 MAC100. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

/// Delegate callback for the QRScannerView.
protocol QRScannerViewDelegate: class {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
}

class QRScannerView: UIView {
    
    weak var delegate: QRScannerViewDelegate?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    /// capture settion which allows us to start and stop scanning.
    var captureSession: AVCaptureSession?
    
    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitialSetup()
    }
    
    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
}

extension QRScannerView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
        captureSession?.startRunning()
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        delegate?.qrScanningDidStop()
    }
    
    /// Does the initial setup for captureSession
    private func doInitialSetup() {
        clipsToBounds = true
        captureSession = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.frame = self.layer.frame
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.layer.addSublayer(previewLayer!)
        //  let cgRect =  CGRect.init(x: previewLayer.frame.width * 0.5 / 2 , y: previewLayer.frame.height * 0.5 / 2 , width: previewLayer.frame.width * 0.5, height: previewLayer.frame.height * 0.5 )
        //let myView = RectangleView.init(frame: cgRect)
        //myView.backgroundColor = UIColor.clear
        //myView.isOpaque = false
        let previewView = UIView(frame: self.frame)
        self.addSubview(previewView)
        previewView.layer.addSublayer(previewLayer!)
        // self.addSubview(myView)
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error)
            return
        }
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            scanningDidFail()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
            metadataOutput.rectOfInterest = CGRect(x: 0.4, y: 0.2, width: 0.3, height: 1)
        } else {
            scanningDidFail()
            return
        }
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        captureSession?.startRunning()
        metadataOutput.rectOfInterest = CGRect(x: 0.4, y: 0.2, width: 0.3, height: 1)
    }
    
    func scanningDidFail() {
        delegate?.qrScanningDidFail()
        captureSession = nil
    }
    
    func found(code: String) {
        delegate?.qrScanningSucceededWithCode(code)
    }
    
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
}

class RectangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        UIColor.white.set()
        aPath.move(to: CGPoint(x: rect.minX, y: 0.2*rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX , y: rect.minY))
        aPath.addLine(to: CGPoint(x: 40, y: rect.minY))
        aPath.lineWidth = 7
        aPath.stroke()
        aPath.move(to: CGPoint(x: rect.maxX - 0.2*rect.maxX, y: rect.minY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: 0.2*rect.maxY))
        aPath.lineWidth = 7
        aPath.stroke()
        aPath.move(to: CGPoint(x: rect.maxX, y: rect.maxY - 0.2*rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.maxX - 0.2*rect.maxX, y: rect.maxY))
        aPath.lineWidth = 7
        aPath.stroke()
        aPath.move(to: CGPoint(x: rect.minX + 0.2*rect.maxX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        aPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 0.2*rect.maxY))
        aPath.lineWidth = 7
        aPath.stroke()
    }
}

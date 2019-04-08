//
//  ViewController.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 07/02/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import AVFoundation
import Pulley

class ScannerViewController: PrimaryContentViewController {
    // MARK: - Camera instance should be commented to avoid errors with simulator
    // all comments in this file will protect app
    // private var video = AVCaptureVideoPreviewLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScanner()
    }
    // MARK: - Private funcs
    private func configureScanner() {
        let session = AVCaptureSession()
        //let captureDevice = AVCaptureDevice.default(for: .video)
        /*
         do {
         let input = try AVCaptureDeviceInput(device: captureDevice!)
         session.addInput(input)
         } catch {
         print ("ERROR")
         }
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]
        session.addOutput(output)
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        */
        session.startRunning()
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .qr {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { _ in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

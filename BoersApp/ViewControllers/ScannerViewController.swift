//
//  ViewController.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 07/02/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import AVFoundation
import PanModal

final class ScannerViewController: UIViewController {

    @IBOutlet var videoView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private static let captureSession = AVCaptureSession()
    
    private var video: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        permissionManagerConfigure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if video == nil { return }
        video.frame = videoView.layer.bounds
    }

    // MARK: - Private funcs

    private func configureScanner() {
        let captureDevice = AVCaptureDevice.default(for: .video)

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            ScannerViewController.captureSession.addInput(input)
        } catch {
            print(error)
        }
        let output = AVCaptureMetadataOutput()
        ScannerViewController.captureSession.addOutput(output)
        output.metadataObjectTypes = [.qr]
        output.setMetadataObjectsDelegate(self, queue: .main)
        video = AVCaptureVideoPreviewLayer(session: ScannerViewController.captureSession)
        video.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(video)
        view.sendSubviewToBack(videoView)
        ScannerViewController.captureSession.startRunning()
    }

    private func permissionManagerConfigure() {
        if PermissionsManager.isAllowed(type: .camera) {
            configureScanner()
        } else {
            PermissionsManager.requireAccess(from: self, to: .camera) { success in
                if success {
                    self.configureScanner()
                    self.video.frame = self.videoView.layer.bounds
                }
            }
        }
    }

    static func startRunning() {
        ScannerViewController.captureSession.startRunning()
    }

    static func stopRunning() {
        ScannerViewController.captureSession.stopRunning()
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject, object.type == .qr {
            if let stringURL = object.stringValue {
                if let number = ScannerDataProcessor.extractID(from: stringURL) {
                    ScannerViewController.stopRunning()
                    if let productInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as? ProductInfoViewController {
                        let navigationController = NavigationController()
                        navigationController.rootVC = productInfoVC
                        productInfoVC.jobNumer = number
                        presentPanModal(navigationController, sourceView: nil, sourceRect: view.bounds)
                    }
                } else {
                    showMessageAlert(title: "Error", message: "Wrong QR code", buttonTitle: "OK")
                }
            }
        }
    }
}

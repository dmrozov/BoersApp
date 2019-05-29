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

    private let captureSession = AVCaptureSession()
    private var video: AVCaptureVideoPreviewLayer!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        permissionManagerConfigure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if video == nil { return }
        video.frame = videoView.layer.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        captureSession.startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        captureSession.stopRunning()
    }

    // MARK: - Private funcs

    private func configureScanner() {
        let captureDevice = AVCaptureDevice.default(for: .video)

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
        } catch {
            print(error)
        }
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        output.metadataObjectTypes = [.qr]
        output.setMetadataObjectsDelegate(self, queue: .main)
        video = AVCaptureVideoPreviewLayer(session: captureSession)
        video.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(video)
        view.sendSubviewToBack(videoView)
        captureSession.startRunning()
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
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject, object.type == .qr {
            if let stringURL = object.stringValue {
                if let number = ScannerDataProcessor.extractID(from: stringURL) {
                    captureSession.stopRunning()
                    // TODO: - Сделать крассивый экстеншен с энамами для сторибордов и их контроллеров
                    if let productInfoVC = UIStoryboard(name: "Main", bundle: nil)
                        .instantiateViewController(withIdentifier: "ProductInfoVC") as? ProductInfoViewController {
                        let navigationController = NavigationController.with(productInfoVC) { [weak self] in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                self?.captureSession.startRunning()
                            })
                        }
                        productInfoVC.jobNumer = number
                        presentPanModal(navigationController)
                    }
                } else {
                    showMessageAlert(title: "Error", message: "Wrong QR code", buttonTitle: "OK")
                }
            }
        }
    }
}

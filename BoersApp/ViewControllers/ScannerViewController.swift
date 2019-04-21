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

//TODO: -  Make it ScannerViewController property
var captureSession: AVCaptureSession!

class ScannerViewController: UIViewController {

    @IBOutlet var videoView: UIView!

    private var video: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: - в didViewappear
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if video == nil { return }
        video.frame = videoView.layer.bounds
    }

    // MARK: - Private funcs

    private func configureScanner() {
        captureSession = AVCaptureSession()
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
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject, object.type == .qr {

            if let container = parent as? ContainerViewController,
                let productInfoVC = container.drawerContentViewController as? ProductInfoViewController,
                let stringURL = object.stringValue {

                if let number = ScannerDataProcessor.extractID(from: stringURL) {
                    productInfoVC.getProductInfo(jobNum: number)
                    pulleyViewController!.setDrawerPosition(position: .open, animated: true)
                } else {
                    showMessageAlert(title: "Error", message: "Wrong QR code", buttonTitle: "OK") // TODO: - Проверить, что по кнопке ок все закрывается
                }
            }
        }
    }
}

// TODO: - в отдельный файл

enum ScannerDataProcessor {

    static func extractID(from stringURL: String) -> String? {
        if let url = URL(string: stringURL), let productNumber = url.queryParameters?["Id"] {
            return productNumber
        }
        if let productNumber = stringURL.components(separatedBy: "/").last {
            if Int(productNumber) == nil { return nil }
            return productNumber
        }
        return nil
    }
}

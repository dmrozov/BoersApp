//
//  CaptureSession.swift
//  BoersApp
//
//  Created by Alex Alekseev on 14.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import AVFoundation

class CaptureSession {
    var captureSession: AVCaptureSession!
    static let instance = CaptureSession()
    private init () {}
}

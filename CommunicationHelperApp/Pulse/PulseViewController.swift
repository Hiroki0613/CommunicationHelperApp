//
//  PulseViewController.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/23.
//

// https://github.com/athanasiospap/Pulse
import AVFoundation
import UIKit

class PulseViewController: UIViewController {
    // TODO: previewLayerShadowView、previewLayer、pulseLabel、thresholdLabelはコードで実装する
    var previewLayerShadowView = UIView()
    var previewLayer = UIView()
    var pulseLabel = UILabel()
    var thresholdLabel = UILabel()
    private var validFrameCounter = 0
    // TODO: 暫定対応で強制アンラップをしています
    private var heartRateManager: HeartRateManager!
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

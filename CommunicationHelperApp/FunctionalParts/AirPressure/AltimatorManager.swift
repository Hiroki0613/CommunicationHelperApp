//
//  AltimatorManager.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import Combine
import CoreMotion
import Foundation

class AltimatorManager: NSObject, ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    var altimeter: CMAltimeter?
    @Published var pressureString: String = ""

    override init() {
        super.init()
        altimeter = CMAltimeter()
        startUpdate()
    }

    func startUpdate() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            guard let altimeter = altimeter else { return }
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                    if error == nil {
                        let pressure: Double = data!.pressure.doubleValue
                        self.pressureString = String(format: "気圧:　%.1f hPa", pressure * 10)
                        self.willChange.send()
                    }
            })
        }
    }
}

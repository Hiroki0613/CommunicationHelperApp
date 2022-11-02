//
//  PressureView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import CoreMotion
import SwiftUI

struct PressureView: View {
    @ObservedObject var manager = AltimatorManager()
    let availabe = CMAltimeter.isRelativeAltitudeAvailable()

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack(spacing: 30) {
                VStack(spacing: 30) {
                    Text(availabe ? manager.pressureString : "----")
                }
            }
        }
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView()
    }
}

//
//  PressureView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/03.
//

import ComposableArchitecture
import CoreMotion
import SwiftUI

struct PressureView: View {
    @ObservedObject var manager = AltimatorManager()
    let viewStore: ViewStore<OwnerState, OwnerAction>
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
        .onAppear {
            viewStore.send(.setPressure(manager.pressureString))
        }
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView(
            viewStore: ViewStore(
                Store(
                    initialState: OwnerState(),
                    reducer: ownerReducer,
                    environment: OwnerEnvironment()
                )
            )
        )
    }
}

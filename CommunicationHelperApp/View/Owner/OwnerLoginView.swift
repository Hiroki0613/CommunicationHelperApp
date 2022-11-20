//
//  OwnerLoginView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/11/20.
//

import ComposableArchitecture
import SwiftUI

struct OwnerLoginView: View {
    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>

    var body: some View {
        ZStack {
            PrimaryColor.background
            VStack {
                Spacer()
                Text("新規登録")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 50)
                Text("EMail\nexample＠gmail.com")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 30)
                Text("PassWord\n*************")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .background(PrimaryColor.buttonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 19)
                Spacer().frame(height: 50)
                Button(action: {
                    viewStore.send(.registratedByEmailAndPassword(true))
                }, label: {
                    Text("登録")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 91)
                        .background(PrimaryColor.buttonRedColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 22)
                })
                Spacer().frame(height: 50)
            }
        }
    }
}

struct OwnerLoginView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerLoginView(
            viewStore: ViewStore(
                Store(
                    initialState: OwnerTopState(),
                    reducer: ownerTopReducer,
                    environment: OwnerTopEnvironment()
                )
            )
        )
    }
}

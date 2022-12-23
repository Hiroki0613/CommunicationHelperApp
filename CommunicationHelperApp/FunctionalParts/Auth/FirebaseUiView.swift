//
//  FirebaseUiView.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/12/18.
//

import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import SwiftUI

struct FirebaseUIView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // signInApple
    // https://ios-docs.dev/guideline4-8/
    // https://www.amefure.com/tech/swift-firebase-authentication-apple
    // https://i-app-tec.com/ios/apply-application.html
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()!
        let providers: [FUIAuthProvider] = [
            FUIEmailAuth(),
            FUIGoogleAuth(authUI: authUI)
        ]
        authUI.providers = providers
        authUI.delegate = context.coordinator
        return authUI.authViewController()
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }

    class Coordinator: NSObject, FUIAuthDelegate {
        let parent: FirebaseUIView
        init(_ parent: FirebaseUIView) {
            self.parent = parent
        }
    }
}

class FirebaseAuthStateObserver: ObservableObject {
    @Published var isSignin: Bool = false
    private var listener: AuthStateDidChangeListenerHandle!

    init() {
        listener = Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = user {
                self.isSignin = true
            } else {
                self.isSignin = false
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
    }
}

struct AuthTestView: View {
    @ObservedObject private var authState = FirebaseAuthStateObserver()
    @State var isShowSheet = false
    
    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
            VStack {
                if authState.isSignin {
                    Text("You are logined")
                        .padding()
                    Button(
                        action: {
                            do {
                                try Auth.auth().signOut()
                            } catch {
                                print("error")
                            }
                        }, label: {
                            Text("logout")
                        })
                } else {
                    Text("You are not logged in.")
                        .padding()
                    Button(
                        action: {
                            isShowSheet.toggle()
                        }, label: {
                            Text("login")
                        })
                }
            }
        }
        .sheet(isPresented: $isShowSheet, content: {
            ZStack {
                FirebaseUIView()
            }
        })
    }
}

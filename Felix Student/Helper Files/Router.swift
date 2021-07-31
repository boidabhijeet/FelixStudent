//
//  Router.swift
//  Felix Student
//
//  Created by Mac on 29/04/21.
//
import Foundation
import UIKit
import SwiftUI

class Router {
    
    class var window: UIWindow? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let sceneDelegate = scene.delegate as? SceneDelegate {
                let window = UIWindow(windowScene: scene)
                sceneDelegate.window = window
                window.makeKeyAndVisible()
                return window
            }
        }
        return nil
    }
    
    static func showTabbar() {
        window?.rootViewController = UIHostingController(rootView: CustomTabBar())
    }
    
    static func showLogin() {
        window?.rootViewController = UIHostingController(rootView: ContentView())
    }
}

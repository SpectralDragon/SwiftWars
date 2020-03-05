//
//  SceneDelegate.swift
//  SwiftWars
//
//  Created by Vladislav Prusakov on 21.02.2020.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = ContentView()
            .environment(\.title, "notKek")
            .environmentObject(ViewModel())
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}








































struct Movie: Decodable, Identifiable {
    
    let id: Int
    
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Float
    var voteAverageColor: Color {
        switch voteAverage {
        case 0..<3: return .red
        case 3..<7: return .yellow
        default: return .green
        }
    }
    
    
    
    static var mock: [Movie] {
        [
            Movie(id: 0, title: "Star Wars", overview: "", releaseDate: "20-02-2020", voteAverage: 7),
            Movie(id: 1, title: "Avangers", overview: "", releaseDate: "20-07-2018", voteAverage: 10)
        ]
    }
}

//
//  EnvironmentValues.swift
//  SwiftWars
//
//  Created by v.prusakov on 3/4/20.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import SwiftUI

// TitleEnvironmentKey

struct TitleEnvironmentKey: EnvironmentKey {
    typealias Value = String
    
    static var defaultValue: String = "Kek"
}

extension EnvironmentValues {
    var title: String {
        get { self[TitleEnvironmentKey.self] }
        set { self[TitleEnvironmentKey.self] = newValue }
    }
}

// UserDefault

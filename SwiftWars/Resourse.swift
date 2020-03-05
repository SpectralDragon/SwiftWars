//
//  Resourse.swift
//  SwiftWars
//
//  Created by Vladislav Prusakov on 21.02.2020.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import SwiftUI

// prop Resource

@propertyWrapper
struct Resource<T: ResourceConvert> {
    var wrappedValue: T {
        get { T.init(resourceName: name) }
    }
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}


// res

protocol ResourceConvert {
    init(resourceName: String)
}

extension Image: ResourceConvert {
    init(resourceName: String) {
        self = Image(resourceName)
    }
}

extension String: ResourceConvert {
    init(resourceName: String) {
        self = NSLocalizedString(resourceName, comment: "")
    }
}


extension Array: ResourceConvert where Element: Decodable {
    init(resourceName: String) {
        do {
            let mockURL = Bundle.main.url(forResource: resourceName, withExtension: "json")!
            let mockData = try Data(contentsOf: mockURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self = try decoder.decode([Element].self, from: mockData)
        } catch {
            self = []
        }
    }
}


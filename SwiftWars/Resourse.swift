//
//  Resourse.swift
//  SwiftWars
//
//  Created by Vladislav Prusakov on 21.02.2020.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import SwiftUI


//@_functionBuilder
//struct URLQuery {
//    static func buildBlock(_ body: String...) -> URL {
//        let string = body.joined(separator: "/")
//        return URL(string: string)!
//    }
//}
//
//struct MyURL {
//    let url: URL
//    
//    init(@URLQuery content: () -> URL) {
//        self.url = content()
//    }
//}
//

@propertyWrapper
struct Resource<T: ResourceConvert> {
    var wrappedValue: T {
        get { T.init(resourceName: self.name) }
    }
    
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
}


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
            self = try JSONDecoder().decode([Element].self, from: mockData)
        } catch {
            self = []
        }
        
        self = []
    }
}

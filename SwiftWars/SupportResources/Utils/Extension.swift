//
//  Extension.swift
//  SwiftWars
//
//  Created by v.prusakov on 3/2/20.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import SwiftUI

struct RefreshButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "arrow.clockwise")
                .resizable()
                .font(.system(size: 20, weight: .semibold))
        })
    }
}

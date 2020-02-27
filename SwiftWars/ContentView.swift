//
//  ContentView.swift
//  SwiftWars
//
//  Created by Vladislav Prusakov on 21.02.2020.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Resource("logo") var logo: Image
    @Resource("sw") var title: String
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    logo
                        .resizable()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 300, maxHeight: 300)
                    
                    Spacer()
                }
                .buttonStyle(PlainButtonStyle())

            }
            .navigationBarTitle(title)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

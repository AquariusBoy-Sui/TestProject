//
//  ContentView.swift
//  NewSwift
//
//  Created by MrSui on 2021/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            ScrollView(Axis.Set.init(), showsIndicators: true, content: {
                Text("Hello, world!")
                    .padding()
            })

            
                .navigationBarTitle("仰望星空")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




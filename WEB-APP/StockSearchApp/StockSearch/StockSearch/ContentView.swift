//
//  ContentView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Karthik!")
            Spacer()
        }
        .padding()
    }
}

//struct HomeScreenView: View{
//    var body: some View{
//        VStack{
//            Text("PORTFOLIO")
//        }
//    }
//}

#Preview {
//    ContentView()
    HomeScreenView()
}

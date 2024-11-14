//
//  ContentView.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 11/11/24.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack (spacing: 0) {
            if selectedTab == 0 {
                MyListView()
            } else {
                HomeView()
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image("homeIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Home")
                            .font(.caption)
                    }
                    .foregroundColor(selectedTab == 0 ? .white : .gray)
                }
                
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image("favoriteIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Favorites")
                            .font(.footnote)
                    }
                    .foregroundColor(selectedTab == 1 ? .white : .gray)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.black)
        }
    }
}


#Preview {
    ContentView()
}

//
//  SplashView.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 11/11/24.
//

import SwiftUI

struct SplashView: View {
    @State var showingSplash: Bool = false
    var body: some View {
        VStack {
            if showingSplash {
                ContentView()
            } else {
                Image("splash")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showingSplash = true
                    }
                }
            }
    }}

#Preview {
    SplashView()
}

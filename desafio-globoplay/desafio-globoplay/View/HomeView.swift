//
//  SectionView.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 12/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack () {
                Text("Globoplay")
                    .frame(
                    maxWidth: .infinity,
                    alignment: .center
                    )
                    .font(.custom("Montserrat", size: 28))
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                Spacer()
            }.background(Color.black)
            
            NavigationView {
                ScrollView {
                    ScrollView(.horizontal) {
                        HStack(spacing: 50) {
                            ForEach(0..<20) { num in
                                GeometryReader { proxy in
                                    
                                    NavigationLink(
                                        destination: Image("ww1984"),
                                        label: {
                                            VStack {
                                                let scale = getScale(proxy: proxy)
                                                
                                                Image("example")
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 150)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5)
                                                    )
                                                    .clipped()
                                                    .cornerRadius(5)
                                                    .shadow(radius: 5)
                                                    .scaleEffect(CGSize(width: scale, height: scale))
                                                    .animation(.easeOut(duration: 0.5))
                                                
                                                Text("Filminho \(num)")
                                                    .padding(.top)
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color(.label))
                                            }
                                        })
                                }
                                .frame(width: 125, height: 300)
                            }
                        }.padding(32)
                    }
                } .navigationTitle("Filmes")
            }
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
            if diff < 100 {
                scale = 1 + (100 - diff) / 500
            }
        return scale
        }
}

#Preview {
    HomeView()
}

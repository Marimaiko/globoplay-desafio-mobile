import SwiftUI

struct MyListView: View {
    // Mock de imagens
    let images = Array(repeating: "example", count: 9) // Nome da imagem mockada no assets
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
               
                HStack {
                    Text("Minha lista")
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
                .background(Color.black)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 18), count: 3), spacing: 20) {
                        ForEach(0..<images.count, id: \.self) { n in
                            Image(images[n])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 180)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .background(Color.backgroundGray)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    MyListView()
}

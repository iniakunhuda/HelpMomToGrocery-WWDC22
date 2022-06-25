import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg_grocery")
                    .resizable()
                    .overlay {
                        LinearGradient(
                            colors: [.black, .black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ).opacity(0.7)
                    }
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    Image(systemName: "cart.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                    
                    Text("Help Mom to Grocery")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.top, 20)
                        .padding(.bottom, 1)
                        .foregroundColor(.white)
                    
                    Text("Learn math and money management with a fun ways")
                        .font(.body)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        print("Hallo")
                    }, label: {
                        NavigationLink(destination: GroceryListView()) {
                            HStack {
                                Image(systemName: "play")
                                Text("Play")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .padding()
                        }
                    })
                    .padding(.bottom, 30)
                    
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
}

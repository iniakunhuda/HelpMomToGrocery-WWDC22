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
                
                // MARK: Content
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 60))
                                .padding(.leading, 30)
                            
                            VStack(alignment: .leading) {
                                Text("HelpMama")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .padding(.top, 20)
                                    .padding(.bottom, 1)
                                    .foregroundColor(.white)
                                
                                Text("Help Your Mom to Buy Grocery")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                Text("Learn math and money management with a fun ways")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                            }
                            
                            
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        print("Hallo")
                    }, label: {
                        NavigationLink(destination: GroceryListView()) {
                            HStack {
                                Image(systemName: "play")
                                    .font(.title)
                                    .padding(.trailing, 10)
                                
                                Text("Play")
                                    .font(.title)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 80)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                    })
                    .padding(.bottom, 30)
                    
                }
                .padding([.horizontal], 40)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
}

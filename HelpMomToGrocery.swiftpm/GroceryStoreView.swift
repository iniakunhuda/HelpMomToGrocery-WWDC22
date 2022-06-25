//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 21/04/22.
//

import SwiftUI

struct ButtonDefaultGrocery: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cart")
                Text("Add item to cart first (swipe right to add item)")
            }
            .padding()
            .frame(minWidth: 10, maxWidth: .infinity)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(19)
            .padding()
        }
    }
}
struct ButtonViewShoppingCart: View {
    var count: Int
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cart")
                Text("View Shopping Cart (\(count))")
            }
            .padding()
            .frame(minWidth: 10, maxWidth: .infinity)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(19)
            .padding()
        }
    }
}
struct ButtonCheckout: View {
    var count: Int
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cart")
                Text("Go To Checkout (\(count))")
            }
            .padding()
            .frame(minWidth: 10, maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(19)
            .padding()
        }
    }
}

@ViewBuilder
func DynamicButtonGrocery(cartResult: CartResult) -> some View {
    switch(cartResult.status) {
        case CartStatus.normal:
            if(cartResult.count > 0) {
                ButtonViewShoppingCart(count: cartResult.count)
            } else {
                ButtonDefaultGrocery()
            }
        case CartStatus.success:
            ButtonCheckout(count: cartResult.count)
        default:
            ButtonDefaultGrocery()
    }
}

struct GroceryStoreView: View {
    
    @ObservedObject var cartResult = CartResult()
    @State private var showingPopover = false
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("bg_grocery")
                .resizable()
                .ignoresSafeArea()
            
            // Your Money
            Spacer()
            
            VStack {
                HStack {
                    Image("wallet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("Your Money")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        HStack {
                            Text(cartResult.getWallet())
                                .font(.title)
                            
                            Button(action: {
                                showingPopover = true
                            }, label: {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.gray)
                            })
                            .popover(isPresented: $showingPopover) {
                                Text("Your money will be decrease according to the items you buy")
                                    .font(.headline)
                                    .padding()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("View Note")
                    }, label: {
                        NavigationLink(destination: GroceryListView(isViewDetail: true)){
                            HStack {
                                Image(systemName: "note.text")
                                    .font(.title)
                                    .padding(.trailing, 5)
                                Text("Shopping Note")
                            }
                        }
                    })
                    .padding()
                    
                }
                .padding()
                .frame(minWidth: 10, maxWidth: .infinity)
                .background(.white)
                .cornerRadius(19)
                .padding([.leading, .trailing])
                
                
    
                // Quiz View
                VStack {
                    QuizView(cartResultModel: cartResult)
                }.padding()
                    .frame(minWidth: 10, maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(19)
                    .padding()
                
                
                // Shopping cart normal
                Button(action: {
                }, label: {
                    if(cartResult.count > 0) {
        
                        NavigationLink(
                            destination: (cartResult.status == CartStatus.normal) ? ShoppingCartView(cartResultModel: cartResult) : ShoppingCartView(cartResultModel: cartResult)
                        ){
                            DynamicButtonGrocery(cartResult: cartResult)
                        }
                    } else {
                        DynamicButtonGrocery(cartResult: cartResult)
                    }
                })
                .hidden(((cartResult.status != CartStatus.normal) && (cartResult.status != CartStatus.success)) ? true : false)
                .padding(.bottom, 30)
                
                
                
            }
            
            Spacer()
                
        }
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GroceryStoreView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryStoreView()
    }
}

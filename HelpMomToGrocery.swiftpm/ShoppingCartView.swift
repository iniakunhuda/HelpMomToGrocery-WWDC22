//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 24/04/22.
//
import SwiftUI

func formatRupiah(nominal: Int) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    guard let formattedTipAmount = formatter.string(from: nominal as NSNumber) else { return "Rp" + String(nominal) }
    return "Rp" + formattedTipAmount
}

struct ShoppingCartRow: View {
    var name: String!
    var pict: String!
    var qty: Int! = 0
    var price: Int! = 0
    
    var body: some View {
        let subtotal = price * qty
        HStack {
            HStack {
                Image(pict)
                    .resizable()
                    .frame(width: 75, height: 75)
            
                VStack(alignment: .leading) {
                    Text(name)
                    Text(formatRupiah(nominal: price))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text(String(qty) + "x")
            
            Spacer()
            
            Text(formatRupiah(nominal: subtotal))
        }
    }
}

struct ShoppingCartView: View {
    @ObservedObject var cartResultModel: CartResult
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Image("bg_grocery")
                .resizable()
                .ignoresSafeArea()
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Shopping Cart")
                    .font(.system(size: 30))
                    .padding()
                
                Group {
                    HStack {
                        Text("Product Name")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("Quantity")
                            .foregroundColor(.gray)
                            .padding([.leading], 30)
                        
                        Spacer()
                        
                        Text("Subtotal")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                ScrollView {
                    ForEach(cartResultModel.getShoppingCart()) { item in
                        Group {
                            ShoppingCartRow(
                                name: item.name,
                                pict: item.pict,
                                qty: item.qty,
                                price: item.price
                            )
                        }
                        .padding([.leading, .trailing])
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Total Pay")
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(cartResultModel.getSubtotal())
                        .font(.title2)
                }
                .padding()
                
                if(cartResultModel.status == CartStatus.success) {
                    Button(action: {}, label: {
                        NavigationLink(destination: GroceryEndView()) {
                            HStack {
                                Text("Pay Now")
                            }
                            .padding()
                            .frame(minWidth: 10, maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(19)
                        }
                    })
                }
                
            }.padding()
            .frame(minWidth: 10, maxWidth: .infinity)
            .background(.white)
            .cornerRadius(19)
            .padding()
        }
        .navigationBarTitle("")
    }
    
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        let cartResultModel = CartResult()
        ShoppingCartView(cartResultModel: cartResultModel)
    }
}

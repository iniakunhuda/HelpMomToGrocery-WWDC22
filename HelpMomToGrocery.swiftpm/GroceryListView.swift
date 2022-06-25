//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 20/04/22.
//

import SwiftUI

var STORY = stories.randomStory()

struct GroceryList: View {
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("Product Name")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("Quantity")
                        .foregroundColor(.gray)
                }
            }
            ScrollView {
                ForEach(STORY.items) { item in
                    Group {
                        GroceryRow(
                            name: item.name,
                            pict: item.pict,
                            qty: item.qty
                        )
                    }
                    .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct GroceryListView: View {
    @State var isViewDetail = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image((isViewDetail) ? "bg_grocery" : "bg_home")
                .resizable()
                .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                if (!isViewDetail) {
                    HStack {
                        Image("mom")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .leading)
                        
                        VStack(alignment: .leading) {
                            Text("My Mom")
                                .font(.title)
                            Text("please help me 🙏🏻")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(minWidth: 10, maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(19)
                    .padding([.leading, .trailing])
                    
                    // Text
                    
                    HStack() {
                        Text("Mom said: \"Please help me to buy this grocery list at **Giant Grocery Store** based on shopping list note below. This is your money, **\(formatRupiah(nominal: STORY.money))**. You can buy grocery first and then toys if money still exist.\"")
                            .font(.title2)
                    }
                    .padding()
                    .frame(minWidth: 10, maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(16)
                    .padding([.leading, .trailing])
                }
                
                // Grocery List
                
                VStack(alignment: .leading) {
                    if(!isViewDetail) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Shopping List Note")
                                    .font(.title)
                                    .padding(.bottom, 20)
                            }
                        }
                    } else {
                        Text("Shopping List Note")
                            .font(.system(size: 30))
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                    }
                    GroceryList()
                }
                .padding()
                .frame(minWidth: 10, maxWidth: .infinity)
                .background(.white)
                .cornerRadius(16)
                .padding()
                
                Spacer()
                
                
                
                if (!isViewDetail) {
                    Button(action: {
                    }, label: {
                        NavigationLink(destination: GroceryStoreView()){
                            HStack {
                                Image(systemName: "cart")
                                Text("Go to Grocery Store")
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
        }
        .navigationBarTitle("")
        .navigationBarHidden((!isViewDetail) ? true : false)
        .navigationBarBackButtonHidden((!isViewDetail) ? true : false)
    }
}

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}

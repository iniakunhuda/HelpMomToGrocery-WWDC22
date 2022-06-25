//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 21/04/22.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
            case true: self.hidden()
            case false: self
        }
    }
}

public struct QuizView: View {
    @State var firstCardOffset = CGSize.zero
    @State var currentX: CGFloat = 0.0
    @State var currentQuestion = 1
    @State var indexQuestion = 0
    
    @State var isQuizDone = false  // indexQuestion == quiz_first.count
    @State var isQuizOutOfMoney = false
    @State var isQuizFailed = false // wrong item what buyed
    
    @ObservedObject var cartResultModel: CartResult
    
    func handleItem(swipe: String, i: Int, item: Item, item_status: Bool) {
        // swipe right
        if(swipe == "right") {
            cartResultModel.addToCart(item: item)
            print(cartResultModel.shoppingCart)
            
            let result_pay = cartResultModel.pay(subtotal: item.price)
            if(result_pay == false) {
                isQuizOutOfMoney = true
                cartResultModel.status = CartStatus.out_of_money
                return
            }
        } else {
            // swipe left when item is true -> quiz failed
            if(item_status) {
                isQuizFailed = true
            }
        }
        
        currentQuestion += 1
        indexQuestion += 1
        
        let target = STORY.quizes.count
        
        if(indexQuestion == target) {
            isQuizDone = true
            if(!isQuizFailed) {
                cartResultModel.status = CartStatus.success
            } else {
                cartResultModel.status = CartStatus.error
            }
            print(cartResultModel.status.rawValue)
        } else {
            isQuizDone = false
        }
    }
    
    func tryAgain() {
        cartResultModel.wallet = STORY.money
        cartResultModel.status = CartStatus.normal
        cartResultModel.resetCart()
        cartResultModel.count = 0
        currentQuestion = 1
        indexQuestion = 0
        isQuizDone = false
        isQuizOutOfMoney = false
        isQuizFailed = false
    }
    
    public var body: some View {
        VStack {
            
            //=========== SCENE IF QUIZ START ===================
            if(!isQuizDone && !isQuizOutOfMoney) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .foregroundColor(currentX < -150 ? Color(UIColor.systemRed) : Color.secondary.opacity(0.5))
                        .colorMultiply(currentX < -150 ? Color(UIColor.systemRed) : Color.secondary.opacity(0.5))
                        .animation(.easeInOut(duration: 0.2))
                    
                    Spacer()
                    
                    VStack {
                        Text("Item \(currentQuestion)/ \(STORY.quizes.count)")
                            .font(.title)
                        HStack {
                            Text("If you want to add item to cart, swipe right")
                                .multilineTextAlignment(.center)
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }
                        HStack {
                            Text("If you want to skip item, swipe left")
                                .multilineTextAlignment(.center)
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(UIColor.systemRed))
                        }
                    }
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .foregroundColor(currentX > 150 ? Color(UIColor.systemGreen) : Color.secondary.opacity(0.5))
                        .colorMultiply(currentX > 150 ? Color(UIColor.systemGreen) : Color.secondary.opacity(0.5))
                        .animation(.easeInOut)
                }
                .padding()
                
            }
            
                        
            ZStack {
                
                //=========== SCENE IF QUIZ DONE (ANY FALSE) ===================
                VStack {
                    Text("Congratulations 🎉")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Text("Yeay, you already buy all items! 🥳 \n Click checkout to process next step")
                        .font(.system(size:30))
                        .foregroundColor(.green)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .hidden((isQuizDone && !isQuizFailed) ? false : true)
                .onChange(of: currentQuestion, perform: { _ in
                    if isQuizDone {
                        print("Completed")
                    }
                })
                
                //=========== SCENE IF QUIZ OUT OF MONEY ===================
                VStack {
                    Text("Failed")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Text("Sorry, you ran out of money 💵")
                        .font(.system(size:40))
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                    Text("Tips: Buy important grocery first")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("Try Again?") {
                        tryAgain()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemBlue))
                    .cornerRadius(12)
                    .contentShape(Rectangle())
                    .padding()
                    
                }
                .hidden(isQuizOutOfMoney ? false : true)
                .onChange(of: currentQuestion, perform: { _ in
                    if isQuizOutOfMoney {
                        print("Out of Money")
                    }
                })
                
                //=========== SCENE IF QUIZ OUT OF MONEY ===================
                VStack {
                    Text("Failed")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Text("Sorry, you don't buy the things you need 🥲")
                        .font(.system(size:35))
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                    Text("Tips: View shopping notes")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("Try Again?") {
                        tryAgain()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemBlue))
                    .cornerRadius(12)
                    .contentShape(Rectangle())
                    .padding()
                    
                }
                .hidden((isQuizDone && isQuizFailed) ? false : true)
                
                
                //=========== SCENE QUIZ ===================
            
                ForEach(STORY.quizes.indices){ i in
                    
                    let det_item = STORY.quizes[i]
                        
                    VStack {
                        Spacer()
                        
                        Image(det_item.image)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 30)
                        
                        
                        Text(det_item.title)
                            .multilineTextAlignment(.center)
                            .font(Font.title.bold())
                            .textCase(.uppercase)
                            .foregroundColor(.orange)
                            .padding(.bottom, 5)
                        
                        Text(det_item.priceRupiah)
                            .multilineTextAlignment(.center)
                            .font(Font.body.bold())
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 300, maxHeight: 400, alignment: .center)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(14.0)
                    .padding(.horizontal, 40.0)
                    .offset(firstCardOffset)
                    .gesture(DragGesture()
                                .onChanged { value in
                                    self.firstCardOffset.width = value.translation.width * 1.4
                                    currentX = value.translation.width * 1.4
                                }
                                .onEnded { value in
                                    if self.firstCardOffset.width > 150 {
                                        self.firstCardOffset.width = 800
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            self.firstCardOffset = CGSize.zero
                                            currentX = 0
                                            
                                            handleItem(
                                                swipe: "right",
                                                i: i,
                                                item: Item(
                                                    name: det_item.title,
                                                    pict: det_item.image,
                                                    qty: 1,
                                                    price: det_item.price
                                                ),
                                                item_status: det_item.isSuccess
                                            )
                                        }
                                    } else if self.firstCardOffset.width < -150 {
                                        self.firstCardOffset.width = -800
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            self.firstCardOffset = CGSize.zero
                                            currentX = 0
                                            
                                            handleItem(
                                                swipe: "left",
                                                i: i,
                                                item: Item(
                                                    name: det_item.title,
                                                    pict: det_item.image,
                                                    qty: 1,
                                                    price: det_item.price
                                                ),
                                                item_status: det_item.isSuccess
                                            )
                                            
                                        }
                                    } else {
                                        self.firstCardOffset.width = 0
                                        currentX = 0
                                    }
                                }
                    )
//                    .hidden(true)
                    .hidden((indexQuestion == i) && (!isQuizDone) && (!isQuizOutOfMoney) ? false : true)
                    .animation(Animation.interactiveSpring(response: 0.3))
                    .padding(.bottom, 50)

                }
                
                
            }
            
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let cartResultModel = CartResult()
        QuizView(cartResultModel: cartResultModel)
    }
}

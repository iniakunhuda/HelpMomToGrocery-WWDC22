//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 21/04/22.
//

import SwiftUI

struct Quiz: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var price: Int
    var isSuccess: Bool = false
    var image: String!
    
    var priceRupiah: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        guard let formattedTipAmount = formatter.string(from: price as NSNumber) else { return "Rp" + String(price) }
        return "Rp" + formattedTipAmount
    }
}

struct QuizStories: Identifiable {
    var id: String = UUID().uuidString
    var stories: [QuizStory]
    
    func randomStory() -> QuizStory {
        let random = stories.randomElement()!
        return random
    }
}

struct QuizStory: Identifiable {
    var id: String = UUID().uuidString
    var money: Int = 0
    var items: [Item] = []
    var quizes: [Quiz] = []
}



enum CartStatus: String {
    case normal, success, out_of_money, error
}
let DEFAULT_WALLET = STORY.money

final class CartResult: ObservableObject {
    @Published var status: CartStatus = CartStatus.normal
    @Published var wallet = STORY.money
    @Published var count = 0
    @Published var shoppingCart: [Item] = [
//        Item(name: "Carrot", pict: "carrot", qty: 3, price: 1000)
    ]
    
    func getShoppingCart() -> [Item] {
        return self.shoppingCart.sorted{ $0.name < $1.name }
    }
    
    func getWallet() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        guard let formattedTipAmount = formatter.string(from: wallet as NSNumber) else { return "Rp" + String(wallet) }
        return "Rp" + formattedTipAmount
    }
    
    func pay(subtotal: Int) -> Bool {
        if(wallet < subtotal) {
            wallet = 0
            return false
        }
        
        wallet = wallet - subtotal
        count += 1
        return true
    }
    
    func addToCart(item: Item) {
        if let itemIndex = shoppingCart.firstIndex(where: { $0.name ==  item.name}) {
            shoppingCart[itemIndex].qty += 1
        } else {
            shoppingCart.append(item)
        }
    }
    
    func resetCart() {
        shoppingCart = []
    }
    
    func getSubtotal() -> String {
        let items = getShoppingCart()
        var total = 0
        
        for item in items {
            total += item.price * item.qty
        }
        
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        guard let formattedTipAmount = formatter.string(from: total as NSNumber) else { return "Rp" + String(total) }
        return "Rp" + formattedTipAmount
    }
}

// STORIES

let story1 = QuizStory(
    money: 20000,
    items: [
        Item(name: "Carrot", pict: "carrot", qty: 4, price: 1000),
        Item(name: "Broccoli", pict: "broccoli", qty: 2, price: 1500),
        Item(name: "Chili", pict: "chili", qty: 10, price: 500),
        Item(name: "Mango", pict: "mango", qty: 2, price: 2500),
        Item(name: "Potato", pict: "potato", qty: 4, price: 500),
    ].sorted{ $0.name < $1.name },
    quizes: [
        Quiz(
            title: "Carrot",
            price: 1000,
            isSuccess: true,
            image: "carrot"
        ),
        Quiz(
            title: "Carrot",
            price: 1000,
            isSuccess: true,
            image: "carrot"
        ),
        Quiz(
            title: "Carrot",
            price: 1000,
            isSuccess: true,
            image: "carrot"
        ),
        Quiz(
            title: "Carrot",
            price: 1000,
            isSuccess: true,
            image: "carrot"
        ),
        Quiz(
            title: "Carrot",
            price: 1000,
            isSuccess: true,
            image: "carrot"
        ),

        // potato 4x
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),

        Quiz(
            title: "Plane Toys",
            price: 15000,
            isSuccess: false,
            image: "toy_plane"
        ),

        Quiz(
            title: "Broccoli",
            price: 1500,
            isSuccess: true,
            image: "broccoli"
        ),
        Quiz(
            title: "Broccoli",
            price: 1500,
            isSuccess: true,
            image: "broccoli"
        ),

        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),

        Quiz(
            title: "Car Toys",
            price: 10000,
            isSuccess: false,
            image: "toy_car"
        ),

        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: true,
            image: "chili"
        ),

        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        ),

        Quiz(
            title: "Teddybear",
            price: 10000,
            isSuccess: false,
            image: "toy_doll"
        ),

        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        )
    ].shuffled()
)


let story2 = QuizStory(
    money: 30000,
    items: [
        Item(name: "Strawberry", pict: "strawberry", qty: 5, price: 700),
        Item(name: "Apple", pict: "apple", qty: 2, price: 2500),
        Item(name: "Mango", pict: "mango", qty: 4, price: 2500),
        Item(name: "Potato", pict: "potato", qty: 3, price: 500),
    ].sorted{ $0.name < $1.name },
    quizes: [
        Quiz(
            title: "Strawberry",
            price: 700,
            isSuccess: true,
            image: "strawberry"
        ),
        Quiz(
            title: "Strawberry",
            price: 700,
            isSuccess: true,
            image: "strawberry"
        ),
        Quiz(
            title: "Strawberry",
            price: 700,
            isSuccess: true,
            image: "strawberry"
        ),
        Quiz(
            title: "Strawberry",
            price: 700,
            isSuccess: true,
            image: "strawberry"
        ),
        Quiz(
            title: "Strawberry",
            price: 700,
            isSuccess: true,
            image: "strawberry"
        ),
        
        // apple 2x
        Quiz(
            title: "Apple",
            price: 2500,
            isSuccess: true,
            image: "apple"
        ),
        Quiz(
            title: "Apple",
            price: 2500,
            isSuccess: true,
            image: "apple"
        ),
        
        // mango 4x
        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        ),
        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        ),
        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        ),
        Quiz(
            title: "Mango",
            price: 2500,
            isSuccess: true,
            image: "mango"
        ),
        
        // potato 3x
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        Quiz(
            title: "Potato",
            price: 500,
            isSuccess: true,
            image: "potato"
        ),
        
        // false
        Quiz(
            title: "Broccoli",
            price: 1500,
            isSuccess: false,
            image: "broccoli"
        ),
        Quiz(
            title: "Broccoli",
            price: 1500,
            isSuccess: false,
            image: "broccoli"
        ),
        
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: false,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: false,
            image: "chili"
        ),
        Quiz(
            title: "Chili",
            price: 500,
            isSuccess: false,
            image: "chili"
        ),
        
        
        Quiz(
            title: "Plane Toys",
            price: 15000,
            isSuccess: false,
            image: "toy_plane"
        ),
        
        Quiz(
            title: "Teddybear",
            price: 10000,
            isSuccess: false,
            image: "toy_doll"
        ),
        
        Quiz(
            title: "Car Toys",
            price: 10000,
            isSuccess: false,
            image: "toy_car"
        ),
    ].shuffled()
)

let stories = QuizStories(
    stories: [story1, story2]
)

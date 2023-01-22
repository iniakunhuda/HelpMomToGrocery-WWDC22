//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 21/04/22.
//

import Foundation
import SwiftUI

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var pict: String
    var qty: Int
    var price: Int
    
    func totalQty() -> String {
        return String(qty)
    }
}

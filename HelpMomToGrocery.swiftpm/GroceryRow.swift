//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 21/04/22.
//

import SwiftUI

struct GroceryRow: View {
    var name: String!
    var pict: String!
    var qty: Int!
    
    var body: some View {
        HStack {
            Image(pict)
                .resizable()
                .frame(width: 75, height: 75)
            
            Text(name)
            
            Spacer()
            
            Text(String(qty) + "x")
        }
    }
}

//
//  File.swift
//  HelpMomToGrocery
//
//  Created by Miftahul Huda on 24/04/22.
//

import SwiftUI

let listOfGift = ["toy_car", "toy_doll", "toy_plane"]

struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    let gift = listOfGift.randomElement() ?? "toy_car"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image(gift)
                .resizable()
                .frame(width: 250, height: 250)
            
            
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}


struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.2))
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.7))
                .padding()
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .padding()
                .frame(width: width, height: height)
            
            Image(systemName: "gift")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 90, height: 90)
                .foregroundColor(.blue.opacity(0.7))
            
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
}

struct GroceryEndView: View {
    //MARK: Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let width : CGFloat = 500
    let height : CGFloat = 500
    let durationAndDelay : CGFloat = 0.3
    
    func flipPresent () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    let backgroundGradient = LinearGradient(
        colors: [Color.black],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack(alignment: .center) {
            backgroundGradient
            VStack {
                Spacer()
                Text("🥳🎉🎉")
                    .font(.system(size: 60))
                
                Text("Congratulations")
                    .font(.system(size: 40))
                    .padding(5)
                    .foregroundColor(.white)
                
                Text("You have succeeded in carrying out orders from your mother to buy grocery. As a token of gratitude, your mom bought you a present. You can open the present below")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom, 50)
                
                ZStack {
                    CardFront(width: width, height: height, degree: $frontDegree)
                    CardBack(width: width, height: height, degree: $backDegree)
                }.onTapGesture {
                    flipPresent ()
                }
                
                Spacer()
                
                Button(action: {
                }, label: {
                    NavigationLink(destination: GroceryListView()) {
                        HStack {
                            Text("Play Again?")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding()
                    }.simultaneousGesture(TapGesture().onEnded{
                        STORY = stories.randomStory()
                    })
                })
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GroceryEndView_Preview: PreviewProvider {
    static var previews: some View {
        GroceryEndView()
    }
}

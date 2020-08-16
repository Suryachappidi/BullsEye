//
//  ContentView.swift
//  BullsEye
//
//  Created by Surya Chappidi on 15/08/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible:Bool = false
    @State var sliderValue: Double = 10.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var sliderValueRounded:Int{
           Int(sliderValue.rounded())
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to :")
                    .lineLimit(nil)
                    
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
                    
                Text("\(self.target)")
                  .fontWeight(.bold)
                  .lineLimit(nil)
                    .foregroundColor(Color.yellow)
            }
            
            Spacer()
            
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                    .accentColor(.orange)
                Text("100")
            }
            
            Spacer()
            
            Button(action: {
                print("Button Pressed")
                self.alertIsVisible = true
                
            }) {
                Text("Hit me")
                    .foregroundColor(.black)
            }
            .frame(width:100,height: 40)
            .background(Color.yellow)
            .cornerRadius(10)
                
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text(alertTitle()), message: Text(self.scoringMessage()), dismissButton: .default(Text("Next Round")){
                    self.score = self.score + self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round = self.round + 1
                    })
                
            }
            
            Spacer()
            
            
            HStack{
                Button(action: {
                    self.StartNewGame()
                }) {
                    Text("Start Over")
                }
                Spacer()
                
                Text("Score:")
                Text("\(self.score)")
                .fontWeight(.bold)
                
                  .foregroundColor(Color.yellow)
                Spacer()
                
                Text("Round:")
                Text("\(self.round)")
                .fontWeight(.bold)
                
                  .foregroundColor(Color.yellow)
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom,20)
        }
        .background(Image("background"))
    }
    
    func pointsForCurrentRound() -> Int {
        let difference = abs(self.sliderValueRounded - self.target)
        return 100 - difference
    }
    func scoringMessage() -> String {
        return "The Slider Value is \(sliderValueRounded).\n" + "The target value is \(self.target).\n" + "You scored \(self.pointsForCurrentRound()) points this Round."
    }
    func alertTitle() -> String {
        let difference: Int = abs(self.sliderValueRounded - self.target)
        let AlertTitle: String
        if difference == 0{
            AlertTitle = "perfect!"
        }
        else if difference < 5{
            AlertTitle = "You Almost Had It"
        }
        else if difference <= 10{
            AlertTitle = "Not Bad"
        }
        else{
            AlertTitle = "Are you even trying?"
        }
        return AlertTitle
    }
    func StartNewGame(){
        self.score = 0
        self.round = 1
        self.resetSliderAndTarget()
    }
    
    func StartNewRound(){
        self.score = self.score + self.pointsForCurrentRound()
        self.round = self.round + 1
        self.resetSliderAndTarget()
    }
    
    func resetSliderAndTarget(){
        self.sliderValue = 50.0
        self.target = Int.random(in: 1...100)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 568, height: 320))
    }
}

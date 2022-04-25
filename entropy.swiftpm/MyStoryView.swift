//
//  MyStoryView.swift
//  entropy
//
//  Created by Emrah Yıldırım on 21.04.2022.
//

import SwiftUI

struct MyStoryView: View {
    var body: some View {
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [Color.blue, Color.black]), center: .center, startRadius: 5, endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("My Story")
                    .bold()
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 50, design: .rounded))
                
                Image(information.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 5))
                    .shadow(radius: 15)
                    .frame(width: UIScreen.main.bounds.width*0.80, height: UIScreen.main.bounds.height*0.25, alignment: .center)
                    .padding()
                    
                
                Text(information.name)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    
                
                ScrollView {
                    Text(information.story)
                        .font(.title2)
                        .padding()
                        .padding()
                        .foregroundColor(Color.white)
                        .font(.system(size: 100))
                    
                }
            }.padding([.top, .bottom], 50)
        }
    }
}

struct MyStoryView_Previews: PreviewProvider {
    static var previews: some View {
        MyStoryView()
    }
}

//
//  Created by Emrah Yıldırım
//

/* Project Formula :
 
 L = Password Length; Number of symbols in the password
 S = Size of the pool of unique possible symbols (character set).
 Number of Possible Combinations = S^L
 Entropy = log2(Number of Possible Combinations)
 Expected Number of guesses (to have a 50% chance of guessing the password) = 2^Entropy-1
 Cracking Time = (Expected Number of guesses / crackSpeed) --> for seconds
*/

import SwiftUI
import Foundation

struct EntropyView: View {
    
    
    @State private var passwd : String = ""
    @State private var ifUppercase : Bool = true
    @State private var ifLowercase : Bool = true
    @State private var ifCharacter : Bool = true
    @State private var ifNumber : Bool = true
    @State private var uppercaseTotal : Int = 0
    @State private var lowercaseTotal : Int = 0
    @State private var characterTotal : Int = 0
    @State private var numberTotal : Int = 0
    @State private var passwdTotalTry : Int = 0
    @State private var passwdTotal : Double = 0.0
    @State private var totalCharacter : Int = 0
    @State private var entropy : Double = 0.0
    @State private var crackValue : Int = 0
    @State private var crackTime : String = ""
    @State private var crackSpeed = 100 // Password Crack Speed(if you want change do it), this value is passwords/second
    @State private var showingResult = false
    
    var body: some View {
        
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.blue, Color.black]), center: .center, startRadius: 5, endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
        
                Text("👾 entropy")
                    .font(.system(size: 150, design: .rounded))
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width*0.95, height: UIScreen.main.bounds.height*0.15, alignment: .center)
                
                TextField("Enter your password", text: $passwd)
                    .padding(10)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 10)
                    .font(.system(size: 50))
                    .frame(width: UIScreen.main.bounds.width*0.95, height: UIScreen.main.bounds.height*0.1, alignment: .center)
                
                
                Button(action: {
                    upperLetter(password: passwd)
                    lowerLetter(password: passwd)
                    characters(password: passwd)
                    numbers(password: passwd)
                    
                    passwdPk()
                    timeCalculate()
                    showingResult.toggle()
                    
                }, label: {
                    
                    Image(systemName: "play")
                        .font(.system(size: 105))
                        .foregroundColor(Color.white)
                    
                })
                .alert(isPresented: $showingResult) {
                    
                    Alert(title: Text("\(crackValue) \(crackTime)"), message: Text("👾 Password Cracking Time 👾"), dismissButton: .default(Text("OK.")))
                    
                }
                .frame(width: UIScreen.main.bounds.width*0.95, height: UIScreen.main.bounds.height*0.1, alignment: .center)
    
                
                Group {
                Text("Total number of characters:\(passwd.count)") // Length
                    .font(.title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 10)
                
                
                
                HStack {
                    Text("Uppercase letters : \(String(ifUppercase))")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 10)
                    
                    Text("Lowercase letters : \(String(ifLowercase))")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 10)
                }
                
                HStack{
                    Text("Special characters : \(String(ifCharacter))")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 10)
                    
                    Text("Number : \(String(ifNumber))")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .foregroundColor(Color.white)
                        .shadow(color: .black, radius: 10)
                    
                }
                    
     
                Text("entropy: \(entropy)") // Bits of Entropy
                    .font(.title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 10)
                
                
                Text("total number of attempts :\(passwdTotalTry)") // Possible combinations
                    .font(.title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 10)
                } .frame(width: UIScreen.main.bounds.width*0.95, height: UIScreen.main.bounds.height*0.07, alignment: .center)
            }
            
        }
        
    }
    
    func characters(password: String) {
        
        let specialCharacterRegEx  = ".*[ !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        self.ifCharacter = texttest2.evaluate(with: password)
        
    }
    
    func lowerLetter(password:String) {
        let smallLetterRegEx  = ".*[a-z]+.*"
        let texttest3 = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        self.ifLowercase = texttest3.evaluate(with: password)
        
    }
    
    func upperLetter(password:String) {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        self.ifUppercase =  texttest.evaluate(with: password)
        
    }
    
    func numbers(password:String) {
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        self.ifNumber = texttest1.evaluate(with: password)
        
    }
    
    func passwdPk() {
        if ifUppercase == true {
            uppercaseTotal = 26
        } else {
            uppercaseTotal = 0
        }
        if ifLowercase == true {
            lowercaseTotal = 26
        } else {
            lowercaseTotal = 0
        }
        if ifCharacter == true {
            characterTotal = 33
        } else {
            characterTotal = 0
        }
        if ifNumber == true {
            numberTotal = 9
        } else {
            numberTotal = 0
        }
        
        totalCharacter = uppercaseTotal + characterTotal + numberTotal + lowercaseTotal // Possible Symbols
        passwdTotal = pow(Double(totalCharacter), Double(passwd.count)) // Possible combinations
        // passwdTotalTry = Int(passwdTotal)
        entropy = log2(passwdTotal)
        passwdTotalTry = Int(pow(2.0, entropy-1.0)) // Expected Number of guesses
        
    }
    
    func timeCalculate() {
        
        crackValue = passwdTotalTry / crackSpeed // for second
        crackTime = "SECOND"
        
        if crackValue >= 60 && crackValue < 3600 { // minutes in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 60
            crackTime = "MINUTE"
        }
        if crackValue >= 3600 && crackValue < 86400 { // hours in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 3600
            crackTime = "HOUR"
        }
        if crackValue >= 86400 && crackValue < 31536000 { // days in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 86400
            crackTime = "DAY"
        }
        if crackValue >= 31536000 && crackValue < 3153600000 { // years in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 31536000
            crackTime = "YEAR"
        }
        if crackValue >= 3153600000 && crackValue < 31536000000 { // centuries in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 3153600000
            crackTime = "CENTURIE"
        }
        if crackValue >= 31536000000 { // millennia in seconds
            crackValue = (passwdTotalTry/crackSpeed) / 31536000000
            crackTime = "MILLENNIA"
        }
        
        
    }
}


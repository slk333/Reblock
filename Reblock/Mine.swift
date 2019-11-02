//
//  Mine.swift
//  Reblock
//
//  Created by Antoine Weber on 01/11/2019.
//  Copyright © 2019 Antoine Weber. All rights reserved.
//

import SwiftUI
import CryptoKit









struct Mine: View {
    
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
    
    
    @State var input = ""
    @State var output = ""
    @State var tries = ""
    @State var miningDuration = ""
    @State var hashPerSec = ""
    @State var difficulty = 4
    
    
    
    
    func hashFor(input:String)->String{
        let data = input.data(using: .utf8)!
        let digest = SHA256.hash(data: data)
        let bytes = [UInt8](digest)
        let hexString = bytes.map{String(format:"%02x",$0)}.joined()
        return hexString
    }
    
    
    
    
    func hashDigestConformsToRequirement(digest:SHA256.Digest,requirement:Int)-> Bool{
        let prefix = digest.prefix { (byte) -> Bool in
            byte == 0
        }
        if prefix.isEmpty{return false}
        else if prefix.count >= requirement{return true}
        else {return false}
    }
    
    
    func mine(){
        
        let startDate = Date()
        var done = false
        let initialNonce = UInt.random(in: UInt.min...UInt.max)
        var nonce = initialNonce
        
        while done == false{
            nonce += 1
            // print(nonce)
            let data = String(nonce).data(using: .utf8)!
            let digest = SHA256.hash(data:data)
            done = hashDigestConformsToRequirement(digest: digest, requirement: difficulty/2)
            
            
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let elapsedTime = Date().timeIntervalSince(startDate)
        let numberOfTries = nonce - initialNonce
        hashPerSec = formatter.string(for: Int(Double(numberOfTries) / elapsedTime))!  + " hash/sec"
        miningDuration = String(Float(elapsedTime)) + " s"
        input = String(nonce)
        output = hashFor(input: input)
        
        tries = formatter.string(for: numberOfTries)! + " tries"
        
        
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    func copyResult(){
        UIPasteboard.general.string = "SHA256(\(input)) = \(output)"
        
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
    }
    
    
    
    
    var body: some View {
        NavigationView{
            Form{
                //            Section(header:Text("Difficulty")){
                //                Text(String(difficulty))
                //            }
                Section(header:Text("Input")){
                    Text(input)
                        .onLongPressGesture {
                            
                            UIPasteboard.general.string = self.input
                            self.impactFeedbackgenerator.prepare()
                            self.impactFeedbackgenerator.impactOccurred()
                    }
                }
                
                Section(header:Text("SHA256 Hash")){
                    Text(output)
                }
                
                Section(header:Text("Stats")){
                    Group{
                        Text(tries)
                        Text(miningDuration)
                        Text(hashPerSec)
                    }
                    
                }
                
                Section(header:Text("Difficulty")){
                    Picker("Difficulty:",selection:$difficulty){
                        Text("Easy").tag(2)
                        Text("Medium").tag(4)
                        Text("Hard").tag(6)
                        
                        
                        
                        
                    }  .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                
                
                Button("Mine"){
                    
                    self.mine()
                    
                }
                
                Section{
                    Button("Copy Result"){
                        self.copyResult()
                    }
                }.navigationBarTitle("Mine")
            }
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
}

struct Mine_Previews: PreviewProvider {
    static var previews: some View {
        Mine()
    }
}

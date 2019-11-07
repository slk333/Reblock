//
//  KeyExchange.swift
//  Reblock
//
//  Created by Antoine Weber on 07/11/2019.
//  Copyright © 2019 Antoine Weber. All rights reserved.
//

import SwiftUI
import CryptoKit
struct KeyAgreement: View {
    

    
    
    
    @State var recipientPublicKeyHex : String = ""
    
    let myPrivateKey = Curve25519.KeyAgreement.PrivateKey()
    var myPublicKey : Curve25519.KeyAgreement.PublicKey{
        return myPrivateKey.publicKey
    }
    var myPublicKeyHex : String{
        let data = myPublicKey.rawRepresentation
        return hexStringFrom(data: data)
    }
    var recipientPublicKey : Curve25519.KeyAgreement.PublicKey?{
        guard let data = Data(hexString: recipientPublicKeyHex) else {return nil}
        return try? Curve25519.KeyAgreement.PublicKey(rawRepresentation: data)
    }
    
    var sharedSymmetricKey:SymmetricKey?{
        guard let recipientPublicKey = recipientPublicKey else{return nil}
        let sharedSecret = try? myPrivateKey.sharedSecretFromKeyAgreement(with: recipientPublicKey)
        let sharedSymmetricKey = sharedSecret?.hkdfDerivedSymmetricKey(using: SHA256.self, salt: Data(), sharedInfo: Data(), outputByteCount: 32)
        return sharedSymmetricKey
    }
    
    var sharedSymmetricKeyHex:String?{
        var bytesBuffer: [UInt8] = []
        sharedSymmetricKey?.withUnsafeBytes {bytes in
            bytesBuffer.append(contentsOf: bytes)
        }
        return bytesBuffer.map{String(format:"%02x",$0)}.joined()
    }
    
 
    
    
    
    
    
    var body: some View {
        NavigationView{
            Form{
                
                
                Section(
                    header:Text("My public key"),
                    footer: CopyButton(stringToCopy: self.myPublicKeyHex)){
                            
                            Text(myPublicKeyHex)
                            
                }
                
                Section(header:Text("Recipient public key")){
                    TextField("Type recipient public key..",text:$recipientPublicKeyHex)
                }
                
                
                
                
                Section(
                    header:Text("Shared Symmetric Key"),
                    footer:CopyButton(stringToCopy: self.sharedSymmetricKeyHex ?? "")){
                        
                        
                        Text(sharedSymmetricKeyHex ?? "")
                        
                        
                }.navigationBarTitle("Key Agreement")
            }
            
            
            
            
            
            
            
            
            
        }
        
    }
}



struct CopyButton: View{
     let stringToCopy:String
     var body: some View{
         Button("Copy"){
             UIPasteboard.general.string = self.stringToCopy}.font(.footnote)
     }
 }


struct KeyAgreement_Previews: PreviewProvider {
    static var previews: some View {
        KeyAgreement()
    }
}




//
//  Symmetric.swift
//  Reblock
//
//  Created by Antoine Weber on 05/11/2019.
//  Copyright © 2019 Antoine Weber. All rights reserved.
//

import SwiftUI
import CryptoKit

struct Symmetric: View {
    @State var input = ""
    @State var isEncrypting = true
    @State var receivedDecryptionKey = ""
    @State var receivedSealedBoxBase64 = ""
    @State var createdSealedBoxBase64 = ""
    
    let key = SymmetricKey(size:.bits256)
    
    var keyAsHex : String {
        var bytesBuffer: [UInt8] = []
        key.withUnsafeBytes {bytes in
            bytesBuffer.append(contentsOf: bytes)
        }
        return bytesBuffer.map{String(format:"%02x",$0)}.joined()
    }
    
    func createSealedBoxBase64()-> String {
        let data = input.data(using: .utf8)!
        let sealedBox = try! ChaChaPoly.seal(data, using: key)
        let encryptedText = sealedBox.combined
        let cipherAsBase64 = encryptedText.base64EncodedString()
        return cipherAsBase64
        
    }
    
    var decryptedText : String {
        
        guard let sealedBoxData = Data(base64Encoded: receivedSealedBoxBase64) else {return ""}
        guard let sealedBox = try?
            ChaChaPoly.SealedBox(combined: sealedBoxData) else{return ""}
        guard let keyData = Data(hexString: receivedDecryptionKey) else {return ""}
        let key = SymmetricKey(data: keyData)
        guard let returnedData = try? ChaChaPoly.open(sealedBox, using: key) else{return ""}
        let returnedString = String(data: returnedData, encoding: .utf8)!
        return returnedString
    }
    
    
    
    
    
    
    
    
    var body: some View {
        NavigationView{
            
            
            
            
            
            
            
            
            Form{
                
                Section(header:Text("Mode")){
                    
                    Picker("Mode:",selection:$isEncrypting){
                        Text("Encrypt").tag(true)
                        Text("Decrypt").tag(false)
                        
                    }  .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                
                
                
                
                
                if isEncrypting{
                    
                    Section(header:Text("Symmetric Key - 256")){
                        Text(keyAsHex)
                            .onTapGesture {
                                UIPasteboard.general.string = self.keyAsHex
                        }
                        
                    }
                    Section(header:Text("Input")){
                        TextField("Type input..", text: $input){
                            self.createdSealedBoxBase64 = self.createSealedBoxBase64()
                        }
                    }
                    
                    Section(header:Text("Sealed Box")){
                        Text(createdSealedBoxBase64)
                            .onTapGesture {
                                UIPasteboard.general.string = self.createdSealedBoxBase64
                        }
                    }
                }
                else{
                    
                    Section(header:Text("Symmetric Key - 256")){
                        TextField("Type key..", text: $receivedDecryptionKey)
                        
                    }
                    
                    Section(header:Text("Sealed Box")){
                        TextField("Paste SealedBox", text: $receivedSealedBoxBase64)
                        
                    }
                    Section(header:Text("Decrypted")){
                        Text(decryptedText)
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            }.navigationBarTitle("Symmetric")
        }
    }
}

struct Symmetric_Previews: PreviewProvider {
    static var previews: some View {
        Symmetric()
    }
}




extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}

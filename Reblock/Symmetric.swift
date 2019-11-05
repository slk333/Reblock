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
    
    let key = SymmetricKey(size:.bits256)
    
    var keyAsHex : String {
        var bytesBuffer: [UInt8] = []
        key.withUnsafeBytes {bytes in
            bytesBuffer.append(contentsOf: bytes)
        }
        return bytesBuffer.map{String(format:"%02x",$0)}.joined()
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Symmetric Key - 256")){
                    Text(keyAsHex)
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

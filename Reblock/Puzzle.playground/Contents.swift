import Foundation
import CryptoKit


func hashDigestConformsToRequirement(digest:SHA256.Digest,requirement:String)-> Bool{
   
    let prefix = digest.prefix { (byte) -> Bool in
        byte == 0
    }

    if prefix.isEmpty{
        return false
    }
    
    else if prefix.count == 2{
        return true
    }
    else {return false
    }
    
    
    
}


let initialNonce = Int.random(in: Int.min...Int.max)
var nonce = initialNonce
var done = false
while done == false{
    nonce += 1
   // print(nonce)
    let data = String(nonce).data(using: .utf8)!
    let digest = SHA256.hash(data:data)
    done = hashDigestConformsToRequirement(digest: digest, requirement: "00")
    
}
print(nonce)
print(nonce - initialNonce)
print(SHA256.hash(data:String(nonce).data(using: .utf8)!))




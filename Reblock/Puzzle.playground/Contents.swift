import Foundation
import CryptoKit


func hashDigestConformsToRequirement(digest:SHA256.Digest,requirement:String)-> Bool{
   
    
    let string = digest.description.dropFirst(15)
   // print(string)
    return string.hasPrefix(requirement)
    
}


let initialNonce = Int.random(in: Int.min...Int.max)
var nonce = initialNonce
var done = false
while done == false{
    nonce += 1
   // print(nonce)
    let data = String(nonce).data(using: .utf8)!
    let digest = SHA256.hash(data:data)
    done = hashDigestConformsToRequirement(digest: digest, requirement: "000")
    
}
print(nonce)
print(nonce - initialNonce)
print(SHA256.hash(data:String(nonce).data(using: .utf8)!))




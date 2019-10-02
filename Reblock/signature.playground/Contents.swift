import Foundation
import CryptoKit

// PROVE I'M THE OWNER OF A PRIVATE KEY
// BY SIGNING A MESSAGE
// WHICH IS ONLY POSSIBLE WITH THE PRIVATE KEY
// we verify both the authenticity and the integrity of the message
// which makes sense because the main goal of a signature is to establish the authenticity of a document

let privateKey = P256.Signing.PrivateKey(compactRepresentable: true)
// the private key

let publicKey = privateKey.publicKey
// the public key

// the public message
let message = "I'm Satoshi Nakomoto"

// the signature, aka the link between between the private key and the message
let signature = try privateKey.signature(for: message.data(using: .utf8)!)

// the verification: using the signature, the message and the public key, we can verify that the signature corresponds to the public key and the message
let messageToVerify = "I'm Satoshi Nakomoto"

let correspond = publicKey.isValidSignature(signature, for: messageToVerify.data(using: .utf8)!)

// if true, it means the owner of the private key have signed himseslf this message.



print("the message: " + messageToVerify)
print("the signature: " + signature.rawRepresentation.base64EncodedString())
print(correspond ? ("corresponds to the public key: " + publicKey.rawRepresentation.base64EncodedString()) : "the message has not been signed by the public key: " + publicKey.rawRepresentation.base64EncodedString())


import Foundation
import CryptoKit

let string = "Hello World!"
let data = string.data(using: .utf8)!


let key = SymmetricKey(size: .bits256)
let sealedBox = try! ChaChaPoly.seal(data, using: key)
let encryptedText = sealedBox.ciphertext
encryptedText.base64EncodedString()

let returnedData = try! ChaChaPoly.open(sealedBox, using: key)
let returnedString = String(data: returnedData, encoding: .utf8)!


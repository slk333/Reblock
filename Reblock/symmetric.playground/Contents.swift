import Foundation
import CryptoKit

let string = "Hello World!\n"
let data = string.data(using: .utf8)!
let clearText = data.base64EncodedString()

let key = SymmetricKey(size: .bits256)
let sealedBox = try! ChaChaPoly.seal(data, using: key)
let encryptedText = sealedBox.ciphertext
encryptedText.base64EncodedString()

let returnedData = try! ChaChaPoly.open(sealedBox, using: key)
returnedData.base64EncodedString()
let returnedString = String(data: returnedData, encoding: .utf8)!
 





let path = Bundle.main.path(forResource: "randomText", ofType: "txt")!
let fileData = FileManager.default.contents(atPath: path)!
fileData.base64EncodedString()
let sealedBox2 = try! ChaChaPoly.seal(fileData, using: key)
sealedBox2.ciphertext.base64EncodedString()

let returnedFileData = try! ChaChaPoly.open(sealedBox2, using: key)
returnedFileData.base64EncodedString()
let stringreturned = String(data: returnedFileData, encoding: .utf8)

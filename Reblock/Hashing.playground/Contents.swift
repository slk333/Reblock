import UIKit
import CryptoKit

let string = "Hello World!"
let data = string.data(using: .utf8)!

let digest = SHA256.hash(data: data)
print("\"Hello World!\" hash is:")
print(digest)
// prints SHA256 digest: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069





/* Hashing a file */
/* hashing the correct file will always produce the same hash , as long as the file has not been corrupted or changed */
/* hash a file to verify it's integrity */

let path = Bundle.main.path(forResource: "randomText", ofType: "txt")!
let fileData = FileManager.default.contents(atPath: path)!
let fileHash = SHA256.hash(data: fileData)
print("file hash is:")
print(fileHash)
// prints SHA256 digest: d8c3afaa6afb006d063849f45c14d64ce18a53f7b896ef8a83816caa86d9f184



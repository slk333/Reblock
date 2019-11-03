import UIKit
import CryptoKit


let alicePrivateKey = Curve25519.KeyAgreement.PrivateKey()
let alicePublicKey = alicePrivateKey.publicKey

let bobPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let bobPublicKey = bobPrivateKey.publicKey

let aliceSharedSecret = try! alicePrivateKey.sharedSecretFromKeyAgreement(with: bobPublicKey)
let bobSharedSecret = try! bobPrivateKey.sharedSecretFromKeyAgreement(with: alicePublicKey)

aliceSharedSecret == bobSharedSecret

let salt = "Hey there".data(using: .utf8)!

let aliceSymmetricKey = aliceSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)
let bobSymmetricKey = bobSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

aliceSymmetricKey == bobSymmetricKey




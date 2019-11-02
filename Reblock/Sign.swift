import SwiftUI
import CryptoKit

struct Sign: View {
    let privateKey = Curve25519.Signing.PrivateKey()
    
    @State  var signature = ""
    @State var message = ""
    
    
    func publicKey(from privateKey:Curve25519.Signing.PrivateKey) -> String {
        let publicKeyData = privateKey.publicKey.rawRepresentation
        return hexStringFrom(data: publicKeyData)
    }
    
    
    func generateSignature(){
        let messageData = message.data(using: .utf8)!
        guard let eCDSASignature = try? self.privateKey.signature(for: messageData) else{return}
        
        
        signature = hexStringFrom(data: eCDSASignature)
        
        
    }
    
    
    
    var body: some View {
        
        
        NavigationView{
            Form{
                
                            Section(header: Text("Private Key")){
                               Text(hexStringFrom(data: privateKey.rawRepresentation))
                          }
                
                
                Section(header: Text("Public Key")){
                    Text(publicKey(from: privateKey))
                }
                
                
                
                TextField("Your message",text: $message, onEditingChanged:{startEditing in if startEditing{self.signature = ""}}){
                    self.generateSignature()
                }
                
                Section(header: Text("Curve25519 Signature")){
                    Text(signature)
                }
            }
                
            .navigationBarTitle("Sign")
            
            
        }
        
        
        
        
        
    }
}

struct Sign_Previews: PreviewProvider {
    static var previews: some View {
        Sign()
    }
}

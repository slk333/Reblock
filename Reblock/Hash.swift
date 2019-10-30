import SwiftUI
import CryptoKit



struct Hash: View {
    @State var input:String = ""
    @State var ouput:String = ""
    
    func hashFor(input:String)->String{
        let data = input.data(using: .utf8)!
        let digest = SHA256.hash(data: data)
        let bytes = [UInt8](digest)
        let hexString = bytes.map{String(format:"%02x",$0)}.joined()
        return hexString
    }

    
    
    
    var body: some View {
        
        NavigationView{
            Form{
                TextField("Type input..", text: $input,onEditingChanged:{startEditing in if startEditing{self.ouput = ""}}){
                    self.ouput = self.hashFor(input: self.input)
                }
                Text(ouput)
            }
            .navigationBarTitle("SHA256 Hash")
        }
        
    }
    
}









struct Hash_Previews: PreviewProvider {
    static var previews: some View {
        Hash()
    }
}

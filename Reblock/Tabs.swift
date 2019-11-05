import SwiftUI

struct Tabs : View {
    
    
    var body: some View {
        
        TabView{
            
            
            
            Sign()
                .tabItem{
                    Text("Sign")
                    Image(systemName: "signature")
            }
            
            
            
            Hash()
                .tabItem{
                    Text("Hash")
                    Image(systemName: "number")
            }
            
            Mine()
                .tabItem{
                    Text("Mine")
                    Image(systemName: "bitcoinsign.square")
            }
            Symmetric()
                .tabItem{
                    Text("Symmetric")
                    Image(systemName: "arrow.right.arrow.left")
            }
            
            
            
            
            
            
            
        }
        
    }
}


struct Tabs_Previews : PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

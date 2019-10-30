import Foundation

func hexStringFrom(data:Data)->String{
    
    let bytes = [UInt8](data)
    let hexString = bytes.map{String(format:"%02x",$0)}.joined()
    return hexString
    
}

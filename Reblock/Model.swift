import Foundation

// a ledger is a list of transactions
struct Ledger{
    var transactions = [String:Transaction]()
}

    var ledger = Ledger()


// an address has an id and can be targetted by transactions
// the balance of an address is the total received from transactions that target this address
struct Address {
    
    let address = UUID().uuidString
    // ask the ledger about any transaction targeting this address
    var inputTransaction : Transaction? {return (transactionForAddress(address: self))}
    // compute the balance from the transaction(s)  targeting this address
    var balance : Double {return inputTransaction?.amount ?? 0}
    
    
    
}

func transactionForAddress(address:Address)->Transaction?{
    
    // asks the ledger "is there any transaction that matches this address?"
    // if there is a match, we get the transaction
    // else we get nil
    
    let transactions = ledger.transactions.values
    let matchingTransaction = transactions.first {$0.recipient.address == address.address} ?? nil
    return matchingTransaction
    
}



// a transaction has an id and targets an address
struct Transaction{
    
    let id = UUID().uuidString
    let recipient : Address
    let amount : Double
    
}



struct Model{
   init(){
    


    // creating an address that has no input transaction yet
    let myAddress = Address()
    // creating a transaction that targets this address
    let myTransaction = Transaction(recipient: myAddress, amount: 2)
    // saving this transaction in the ledger
    ledger.transactions[myTransaction.id] = myTransaction


    // reading the balance by reading in the ledger the value of the transaction that outputs to this address
   // print(myAddress.balance)
    
    
    
    }



}





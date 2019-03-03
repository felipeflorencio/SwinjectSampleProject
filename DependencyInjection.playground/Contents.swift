import Foundation

// To be used as dependency
class Account {
    var number: Int
    var name: String
    
    init(name owner: String, account digit: Int) {
        name = owner
        number = digit
    }
}

// This is the old way of doing we can see here an
// dependency between Bank and the Account as we are
// creating account direct inside Bank.
class Bank {
    var account = Account(name: "Felipe Banking", account: 0987654321)
}

// Now let's start improve our code decopling our code and use
// DI pattern in order to achieve this.
class NewBank {
    var account: Account?
}

// If you see down below we are not anymore responsible for
// creating its own dependency direct inside our "NewBank",
// we are doing now one kind of DI, it's called property injection.
// were we crete "NewBank" object we create "Account" object and
// set "Account" to "NewBank", so "NewBank" don't know anything about
// "Account" object creation.
class FoundingNewBank {
    
    func setupNewBank() {
        let newBank = NewBank()
        newBank.account = Account(name: "Felipe Founding Bank", account: 67890)
    }
}

// Another way of dependency injection it's called constructor
// injection, in this way we inject our dependency right on it's
// creation, in the initializer.
// In iOS, this type of injection is often preferred because it
// prevents us from using an object that isn’t fully configured
// or missing pieces.
class FoundingANewStartup {
    
    let myAccount: Account // Don't know how to create
    
    init(with account: Account) {
        myAccount = account // Don't know how to create, just pass the reference
    }
}

let newStartupAccount = Account(name: "Felipe Startup", account: 54321)
let foundingNewStartup = FoundingANewStartup(with: newStartupAccount)

// We can now move further to another type of injection, one called
// method injection, as the name sugest we pass our dependency using
// a method.

class BigBank {
    
    var myAccount: Account?
    
    func manageAccount(with account: Account) {
        myAccount = account
        let accountNumber = account.number
        let accountOwner = account.name
        debugPrint("My account number is: \(accountNumber)")
        debugPrint("Account owner is: \(accountOwner)")
    }
}

let myBigBank = BigBank()
let myAccount = Account(name: "Felipe", account: 12345)

myBigBank.manageAccount(with: myAccount)
let myAccountIs = myBigBank.myAccount

//: [Previous](@previous)

import Foundation

//: ### Factory method
/*:
 Паттерн позволяет переложить создание специфических объектов, на наследников родительского класса, потому можно манипулировать объектами на более высоком уровне, не заморачиваясь объект какого класса будет создан. Частенько этот паттерн называют виртуальный конструктор, что по моему мнению более выражает его предназначение.
 */

/*:
 Используется, когда необходимо сделать выбор между классами, которые реализуют общий протокол или разделяют общий базовый класс. Шаблон содержит в себе логику, которая решает, какой класс выбрать.
 
 Вся логика, как предполагает название шаблона, находится в методе, который инкапсулирует решение.
 У нас есть два варианта реализации: глобальный метод или использование базового класса.
 */
/*:
 The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.
 */

protocol Product {
    
    static var priceRange: CountableRange<UInt> { get set } //optional
    
    var price: UInt { get }
    var name: String { get }
    
    func saveObject()
}


class Toy: Product {
    
    static var priceRange = CountableRange<UInt>(uncheckedBounds: (0, 100)) // or use below in switch as 0..<100
    
    var price: UInt {
        return 50
    }
    var name: String {
        return "Toy"
    }
    
    func saveObject() {
        print("Saving object into Toys database")
    }
}

class Dress: Product {
    
    static var priceRange = CountableRange<UInt>(uncheckedBounds: (0, UInt.max)) // or use below in switch as 100..<UInt.max
    
    var price: UInt {
        return 150
    }
    var name: String {
        return "Dress"
    }
    
    func saveObject() {
        print("Saving object into Dress database")
    }
    
}

class ProductGenerator { // or ProductFactory
    
    func getProduct(price: UInt) -> Product? {
        
        switch price {
        case Toy.priceRange: return Toy()
        case Dress.priceRange: return Dress()
        default: return nil
        }
    }
}

func saveExpenses(price: UInt) {
    let pd = ProductGenerator()
    let expense = pd.getProduct(price: price)
    expense?.saveObject()
}

saveExpenses(price: 50)
saveExpenses(price: 56)
saveExpenses(price: 79)
saveExpenses(price: 100)
saveExpenses(price: 123)
saveExpenses(price: 51)

separator()
//OR

protocol Currency {
    var symbol: String { get }
    var code: String { get }
}

class Euro: Currency {
    
    var symbol: String {
        return "€"
    }
    var code: String {
        return "EUR"
    }
}

class UnitedStatesDolar : Currency {
    
    var symbol: String {
        return "$"
    }
    var code: String {
        return "USD"
    }
}

enum Country {
    case unitedStates, spain, uk, greece
}

func currency(for country: Country) -> Currency? {
    
    switch country {
    case .spain, .greece: return Euro()
    case .unitedStates: return UnitedStatesDolar()
    default: return nil
    }
}


func currencyCodes(for countries: Country...) -> [String?] {
    return countries.map { currency(for: $0)?.code } // or use flatMap for non-Optional
}

print(currencyCodes(for: .unitedStates, .spain, .uk, .greece))
//print([.unitedStates, .spain, .uk, .greece].map(currency)) //Or immediately using a higher order function

//: [Next](@next)

//: [Previous](@previous)

import Foundation

//: ### Prototype
/*
 Прототип – один из самых простых паттернов, который позволяет нам получить точную копию необходимого объекта. Тоесть использовать как прототип для нового объекта
 */
/*:
 The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone. This practise is particularly useful when the construction of a new object is inefficient.
 */

class ChungasRevengeDisplay {
    
    var name: String?
    let font: String
    
    init(font: String) {
        self.font = font
    }
    
    var clone: ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font: font)
    }
}

let Prototype = ChungasRevengeDisplay(font: "GotanProject")

let Philippe = Prototype.clone
Philippe.name = "Philippe"

let Christoph = Prototype.clone
Christoph.name = "Christoph"

let Eduardo = Prototype.clone
Eduardo.name = "Eduardo"

//OR

protocol Copying {
    init(instance: Self)
}

extension Copying {
    
    var copy: Self {
        return Self.init(instance: self)
    }
}


class Person: Copying {
    
    var name: String
    
    
    init(name: String) {
        self.name = name
    }
    
    required init(instance: Person) {
        self.name = instance.name
    }
}

let firstPerson = Person(name: "Dima")
let secondPerson = firstPerson.copy

print("First Person name = \(firstPerson.name)")
secondPerson.name = "Roma"
print("Second Person name = \(secondPerson.name)")
print("First Person name = \(firstPerson.name)")

separator()

//OR

class Person1: NSObject, NSCopying {
    
    var name: String
    
    
    init(name: String) {
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Person1(name: name)
    }
}

let firstPerson1 = Person1(name: "Dima")
let secondPerson1 = firstPerson1.copy() as! Person1

print("First Person name = \(firstPerson1.name)")
secondPerson1.name = "Roma"
print("Second Person name = \(secondPerson1.name)")
print("First Person name = \(firstPerson1.name)")

//: [Next](@next)

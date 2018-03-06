//: [Previous](@previous)

import Foundation

//: ### Abstract Factory
//: ![](abstractFactory.png)
/*
 Абстрактная фабрика – еще один очень популярный паттерн, который как и в названии так и в реализации слегка похож на фабричный метод.
 Итак, что же делает абстрактная фабрика:
 Абстрактная фабрик дает простой интерфейс для создания объектов которые принадлежат к тому или иному сеймейству объектов.
 
 Отличия от фабричного метода:
 1. Фабричный метод порождает объекты одного итого же типа,фабрике же может создавать независимые объекты.
 2. Чтобы добавить новый тип объекта– надо поменять интерфейс фабрики,в фабричном методе же легко просто поменять внутренности метода, который ответственный за порождение объектов.
 */

/*
 The abstract factory pattern is used to provide a client with a set of related or dependant objects. The "family" of objects created by the factory are determined at run-time.
 */


protocol GenericIPhone {
    
    var osName: String { get }
    var productName: String { get }
}

protocol GenericIPad {
    
    var osName: String { get }
    var productName: String { get }
    var screenSize: Double { get }
}

protocol DeviceFactory {
    
    var iPhone: GenericIPhone { get }
    var iPad: GenericIPad { get }
}


struct AppleIPhone: GenericIPhone {
    
    var osName: String {
        return "iOS"
    }
    var productName: String {
        return "iPhone"
    }
}

struct AppleIPad: GenericIPad {
    
    var osName: String {
        return "iOS"
    }
    var productName: String {
        return "iPad"
    }
    var screenSize: Double {
        return 7.7
    }
}

struct ChinaIPhone: GenericIPhone {
    
    var osName: String {
        return "Android"
    }
    var productName: String {
        return "Chi Huan Hua Phone"
    }
}

struct ChinaIPad: GenericIPad {
    
    var osName: String {
        return "Windows CE"
    }
    var productName: String {
        return "Buan Que Ipado Killa"
    }
    var screenSize: Double {
        return 12.5
    }
}

class AppleFactory: DeviceFactory {
    
    var iPhone: GenericIPhone {
        return AppleIPhone()
    }
    var iPad: GenericIPad {
        return AppleIPad()
    }
}

class ChinaFactory: DeviceFactory {
    
    var iPhone: GenericIPhone {
        return ChinaIPhone()
    }
    var iPad: GenericIPad {
        return ChinaIPad()
    }
}

//As you can see, the factories are the same, but the devices are different :D

enum AbstractFactory {
    case original, fake
    
    var factory: DeviceFactory {
        switch self {
        case .original: return AppleFactory()
        case .fake: return ChinaFactory()
        }
    }
}

let originalFactory = AbstractFactory.original.factory
print(originalFactory.iPhone)
print(originalFactory.iPad)

let chinaFactory = AbstractFactory.fake.factory
print(chinaFactory.iPhone)
print(chinaFactory.iPad)



//: [Next](@next)

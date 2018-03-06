//: [Previous](@previous)

import Foundation

//: ### Builder
/*:
 Вот представьте что у нас есть фабрика. Но в отличии от фабрики из предыдущего поста, она умеет создавать только телефоны на базе андроида, и еще при этом различной конфигурации. Тоесть, есть один объект, но при этом его состояние может быть совершенно разным, а еще представьте если его очень трудно создавать, и во время создания этого объекта еще и создается миллион дочерних объектов. Именно в такие моменты, нам очень помогает такой паттерн как строитель.
 Когда использовать:
 1. Созданиесложногообъекта
 2. Процесссозданияобъектатожеоченьнетривиальный–кпримеру
 получение данных из базы и манипуляция ими.
 Сам паттерн состоит из двух компонент – Bulilder и Director. Builder занимается именно построение объекта, а Director знает какой Builder использовать чтобы выдать необходимый продукт.

 */

/*:
 The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. An external class controls the construction algorithm.
 */

struct AndroidPhone {
    
    var osVersion: String
    var name: String
    var cpuCodeName: String
    var RAMsize: Int
    var osVersionCode: Double
    var launcher: String
}

protocol BPAndroidPhoneBuilder {
    
    var phone: AndroidPhone { get }
}

class LowPricePhoneBuilder: BPAndroidPhoneBuilder {
    
    var phone: AndroidPhone {
        return AndroidPhone(osVersion: "Android 2.3",
                            name: "Low price phone!",
                            cpuCodeName: "Some shitty CPU",
                            RAMsize: 256,
                            osVersionCode: 3.0,
                            launcher: "Hia Tsung!")
    }
}

class HighPricePhoneBuilder: BPAndroidPhoneBuilder {
    
    var phone: AndroidPhone {
        return AndroidPhone(osVersion: "Android 4.1",
                            name: "High price phone!",
                            cpuCodeName: "Some shitty but expensive CPU",
                            RAMsize: 1024,
                            osVersionCode: 4.1,
                            launcher: "Samsung Launcher")
    }
}

class FactorySalesMan {
    
    var builder: BPAndroidPhoneBuilder?
    var phone: AndroidPhone?
    
    func constructPhone() {
        phone = builder?.phone
    }
}

let cheapPhoneBuilder = LowPricePhoneBuilder()
let expensivePhoneBuilder = HighPricePhoneBuilder()

let salesMan = FactorySalesMan()
salesMan.builder = cheapPhoneBuilder
salesMan.constructPhone()

var phone = salesMan.phone!

print("Phone Name = \(phone.name), osVersion = \(phone.osVersion), cpu code name = \(phone.cpuCodeName), ram size = \(phone.RAMsize), osversion code = \(phone.osVersionCode), launcher = \(phone.launcher)")

salesMan.builder = expensivePhoneBuilder
salesMan.constructPhone()
phone = salesMan.phone!

print("Phone Name = \(phone.name), osVersion = \(phone.osVersion),cpu code name = \(phone.cpuCodeName), ram size = \(phone.RAMsize), osversion code = \(phone.osVersionCode), launcher = \(phone.launcher)")

//: [Amazing example](https://github.com/kingreza/Swift-Builder)


//: [Next](@next)

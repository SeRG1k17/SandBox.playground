//: [Previous](@previous)Br

import Foundation

//: ### Bridge

/*:
 Представьте себе, что у нас есть что-то однотипное, к примеру у нас есть телефон и куча наушников. Если бы у каждого телефона был свой разъем, то мы могли бы пользоваться только одним типом наушников. Но Бог миловал! Собственно та же штука и с наушникам. Они могут выдавать различный
 звук, иметь различные дополнительные функции, но основная их цель –
 просто
 звучание:) И хорошо, что во многих случаях штекер у них одинаковый ( я не говорю про различные студийные наушники:) ).
 Собственно, Мост (Bridge) позволяет разделить абстракцию от реализации, так чтобы реализация в любой момент могла быть поменяна, не меняя при этом абстракции.
 Когда использовать?
 1. Вамсовершенноненужнасвязьмеждуабстракциейиреализацией.
 2. Собственно,какабстракциютакиимплементациюмогутнаследовать
 независимо.
 3. Вы не хотите чтобы изменения в реализации имело влияния на клиентский
 код.
 */

/*:
 The bridge pattern is used to separate the abstract elements of a class from the implementation details, providing the means to replace the implementation details without modifying the abstraction.
 */

protocol BaseHeadphones {
    
    func playSimpleSound()
    func playBassSound()
}

class CheapHeadphones: BaseHeadphones {
    func playSimpleSound() {
        print("beep - beep - bhhhrhrhrep")
    }
    func playBassSound() {
        print("puf - puf - pufhrrr")
    }
}

class ExpensiveHeadphones: BaseHeadphones {
    func playSimpleSound() {
        print("Beep-Beep-Beep Taram - Rararam")
    }
    func playBassSound() {
        print("Bam-Bam-Bam")
    }
}

class MusicPlayer {
    
    var headPhones: BaseHeadphones?
    
    func playMusic() {
        
        headPhones?.playBassSound()
        headPhones?.playBassSound()
        headPhones?.playSimpleSound()
        headPhones?.playSimpleSound()
    }
}

let p = MusicPlayer()
let ch = CheapHeadphones()
let ep = ExpensiveHeadphones()

p.headPhones = ch
p.playMusic()

p.headPhones = ep
p.playMusic()


protocol Switch {
    var appliance: Appliance { get set }
    func turnOn()
}

protocol Appliance {
    func run()
}

class RemoteControl: Switch {
    var appliance: Appliance
    
    func turnOn() {
        self.appliance.run()
    }
    
    init(appliance: Appliance) {
        self.appliance = appliance
    }
}

class TV: Appliance {
    func run() {
        print("tv turned on");
    }
}

class VacuumCleaner: Appliance {
    func run() {
        print("vacuum cleaner turned on")
    }
}

var tvRemoteControl = RemoteControl(appliance: TV())
tvRemoteControl.turnOn()

var fancyVacuumCleanerRemoteControl = RemoteControl(appliance: VacuumCleaner())
fancyVacuumCleanerRemoteControl.turnOn()


//: [Next](@next)

//: [Previous](@previous)

import Foundation

//: ### Adapter
/*:
 Тяжело найти более красочно описание паттерна Адаптер, чем пример из жизни каждого, кто покупал технику из США. Розетка! Вот почему не сделать одинаковую розетку всюду? Но нет, в США розетка с квадратными дырками, в Европе с круглыми, а в некоторых странах вообще треугольные. Следовательно – потому вилки на зарядный устройствах, и других устройствах питания тоже различные.
 Представьте, что Вы едете в коммандировку в США. У Вас есть, допустим, ноутбук купленный в Европе – следовательно вилка на проводе от блока питания имеет круглые окончания. Что делать? Покупать зарядку для американского типа розетки? А когда вы вернетесь домой – она будет лежать у Вас мертвым грузом?
 Потому, вероятнее всего, Вы приобретете один из адаптеров, которые надеваются на вилку, и которая позволяет Вам использовать старую зарядку и заряжаться от совершенно другой розетки.
 Так и с Адаптером – он конвертит интерфейс класса – на такой, который ожидается.
 Сам паттерн состоит из трех частей: Цели (target), Адаптера (adapter), и адаптируемого (adaptee).
 В нашей с вами проблеме:
 1. Target–ноутбук со старой зарядкой
 2. Adapter–переходник.
 3. Adaptee – розетка с квадртаными дырками.
 */

/*:
 The adapter pattern is used to provide a link between two otherwise incompatible types by wrapping the "adaptee" with a class that supports the interface required by the client
 */

protocol BirdProtocol {
    
    func sing()
    func fly()
}

class Bird: BirdProtocol {
    
    func sing() {
        print("Tew-tew-tew")
    }
    func fly() {
        print("OMG! I am flying!")
    }
}

class Raven {
    
    func flySearchAndDestroy() {
        print("I am flying and seak for killing!")
    }
    func voice() {
        print("Kaaaar-kaaaaar-kaaaaaaar!")
    }
}

class RavenAdapter: BirdProtocol {
    
    private var raven: Raven
    
    init(adaptee: Raven) {
        raven = adaptee
    }
    
    func sing() {
        raven.voice()
    }
    func fly() {
        raven.flySearchAndDestroy()
    }
}

func makeTheBirdTest(bird: BirdProtocol) {
    bird.fly()
    bird.sing()
}
let simpleBird = Bird()
let simpleRaven = Raven()
let ravenAdapter = RavenAdapter(adaptee: simpleRaven)

makeTheBirdTest(bird: simpleBird)
makeTheBirdTest(bird: ravenAdapter)



protocol Charger {
    func charge()
}

protocol EuropeanNotebookChargerDelegate {
    
    func chargetNotebookRoundHoles(charger: Charger)
}

extension EuropeanNotebookChargerDelegate {
    
    func chargetNotebookRoundHoles(charger: Charger) {
        print("Charging with 220 and round holes!")
    }
}

class EuropeanNotebookCharger: Charger, EuropeanNotebookChargerDelegate {
    
    var delegate: EuropeanNotebookChargerDelegate!
    
    init() {
        delegate = self
    }
    
    func charge() {
        delegate.chargetNotebookRoundHoles(charger: self)
    }
}

class USANotebookCharger {
    
    func chargeNotebookRectHoles() {
        print("Charge Notebook Rect Holes")
    }
}

class USANotebookEuropeanAdapter: Charger, EuropeanNotebookChargerDelegate {
    
    var usaCharger: USANotebookCharger
    
    init(charger: USANotebookCharger) {
        usaCharger = charger
    }
    
    func chargetNotebookRoundHoles(charger: Charger) {
        usaCharger.chargeNotebookRectHoles()
    }
    
    func charge() {
        let euroCharge = EuropeanNotebookCharger()
        euroCharge.delegate = self
        euroCharge.charge()
    }
}

func makeTheNotebookCharge(charger: Charger) {
    charger.charge()
}

let euroCharger = EuropeanNotebookCharger()
makeTheNotebookCharge(charger: euroCharger)

let charger = USANotebookCharger()
let adapter = USANotebookEuropeanAdapter(charger: charger)

makeTheNotebookCharge(charger: adapter)



//: [Next](@next)

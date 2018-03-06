//: [Previous](@previous)

import Foundation

//: ### Mediator
/*:
 
 */
/*:
 The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.
 */


protocol Part {
    weak var processor: CentrallProcessor? { get set }
    
    func numbersChanged()
}

extension Part {
    
    func numbersChanged() {
        processor?.valueChanged(in: self)
    }
}

class SmartHousePart: Part {

    weak var processor: CentrallProcessor?

    init(processor: CentrallProcessor) {
        self.processor = processor
    }
}

class CentrallProcessor {
    
    var thermometer: Thermometer!
    var condSystem: ConditioningSystem!
    
    func valueChanged(in part: Part) {
        print("Value changed! We need to do smth!")
        
        if part is Thermometer {
            condSystem.startCondition()
        }
    }
}

class Thermometer: SmartHousePart {
    
    private var temperature: Int! {
        didSet {
            numbersChanged()
        }
    }
    
    func temperatureChanged(to value: Int) {
        temperature = value
    }
}
class ConditioningSystem: SmartHousePart {

    func startCondition() {
        print("Conditioning...")
    }
}

let proccessor = CentrallProcessor()
let therm = Thermometer(processor: proccessor)
let condSystem = ConditioningSystem(processor: proccessor)
proccessor.condSystem = condSystem
proccessor.thermometer = therm
therm.temperatureChanged(to: 45)



protocol Receiver {
    associatedtype MessageType
    func receive(message: MessageType)
}

protocol Sender {
    associatedtype MessageType
    associatedtype ReceiverType: Receiver
    
    var recipients: [ReceiverType] { get }
    
    func send(message: MessageType)
}

struct Programmer: Receiver {
    
    typealias MessageType = String
    
    let name: String
    
    
    init(name: String) {
        self.name = name
    }
    
    func receive(message: String) {
        print("\(name) received: \(message)")
    }
}

final class MessageMediator: Sender {
    
    typealias MessageType = String
    typealias ReceiverType = Programmer
    
    var recipients: [Programmer] = []
    
    func add(recipient: Programmer) {
        recipients.append(recipient)
    }
    
    func send(message: String) {
        recipients.forEach { $0.receive(message: message) }
    }
}

func spamMonster(message: String, worker: MessageMediator) {
    worker.send(message: message)
}

let messagesMediator = MessageMediator()

let user0 = Programmer(name: "Linus Torvalds")
let user1 = Programmer(name: "Avadis 'Avie' Tevanian")
messagesMediator.add(recipient: user0)
messagesMediator.add(recipient: user1)

spamMonster(message: "I'd Like to Add you to My Professional Network", worker: messagesMediator)


//: [Next](@next)

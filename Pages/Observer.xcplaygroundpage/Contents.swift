//: [Previous](@previous)

import Foundation

//: ### Observer
/*:
 Как описывает этот паттерн наша любимая GoF книга – Observer определяет одно-ко-многим отношение между объектами, и если изменения происходят в объекте – все подписанные на него объекты тут же узнают про это изменение.
 Идея проста, объект который мы называем Subject – дает возможность другим объектам, которые реализуют интерфейс Observer, подписываться и отписываться от изменений происходящих в Subject. Когда изменение происходит
 – всем заинтересованным объектам высылается сообщение, что изменение произошло. В нашем случае – Subject – это издатель газеты, Observer это мы с
 вами – те кто подписывается на газету, ну и собственно изменение – это выход новой газеты, а оповещение – отправка газеты всем кто подписался.
 Когда используется паттерн:
 1. Когда Вам необходимо сообщить всем объектам подписанным на изменения, что изменение произошло, при этом вы не знаете типы этих объектов.
 2. Изменения в одном объекте,требуют чтоб состояние изменилось в других объектах, при чем количество объектов может быть разное.
 */
/*:
 The observer pattern is used to allow an object to publish changes to its state. Other objects subscribe to be immediately notified of any changes.
 */

class StandardObserver: Hashable {

    var hashValue: Int { return "\(Mirror(reflecting: self).subjectType)".hashValue }
    func valueChanged(name: String, value: String) {}

    static func ==(lhs: StandardObserver, rhs: StandardObserver) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

protocol StandardSubject {
    func addObserver(observer: StandardObserver)
    func removeObserver(observer: StandardObserver)
    func notifyObjects()
}

class StandardSubjectImplementation: StandardSubject {
    private var name: String!
    private var value: String!

    var observerCollection = Set<StandardObserver>()
    func addObserver(observer: StandardObserver) {
        observerCollection.insert(observer)
    }
    func removeObserver(observer: StandardObserver) {
        observerCollection.remove(observer)
    }
    func notifyObjects() {
        for observer in observerCollection {
            observer.valueChanged(name: name, value: value)
        }
    }
    func changeValue(name: String, value: String) {
        self.name = name
        self.value = value
        notifyObjects()
    }
}

class SomeSubscriber: StandardObserver {
    override func valueChanged(name: String, value: String) {
        print("And some subscriber tells: Hmm, value \(value) changed to \(name)")
    }
}
class OtherSubscriber: StandardObserver {
    override func valueChanged(name: String, value: String) {
        print("And some another subscriber tells: Hmm, value \(value) changed to \(name)")
    }
}

let subj = StandardSubjectImplementation()
let someSubscriber = SomeSubscriber()
let otherSubscriber = OtherSubscriber()
subj.addObserver(observer: someSubscriber)
subj.addObserver(observer: otherSubscriber)
subj.changeValue(name: "strange value", value: "newValue")



class KVOSubject: NSObject {
    @objc dynamic var changeableProperty: String!
}

class KVOObserver: NSObject {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("KVO: Value changed")
    }
}

let kvoSubj = KVOSubject()
let kvoObserver = KVOObserver()
let keyPath = #keyPath(KVOSubject.changeableProperty)
kvoSubj.addObserver(kvoObserver, forKeyPath: keyPath, options: .new, context: nil)

kvoSubj.changeableProperty = "test"
kvoSubj.removeObserver(kvoObserver, forKeyPath: keyPath)




protocol PropertyObserver: class {
    func willChange(propertyName: String, newPropertyValue: Any?)
    func didChange(propertyName: String, oldPropertyValue: Any?)
}

final class TestChambers {
    
    weak var observer: PropertyObserver?
    
    private let testChamberNumberName = "testChamberNumber"
    
    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
        }
        didSet {
            observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
        }
    }
}

final class Observer: PropertyObserver {
    
    func willChange(propertyName: String, newPropertyValue: Any?) {
        if newPropertyValue as? Int == 1 {
            print("Okay. Look. We both said a lot of things that you're going to regret.")
        }
    }
    
    func didChange(propertyName: String, oldPropertyValue: Any?) {
        
        if oldPropertyValue as? Int == 0 {
            print("Sorry about the mess. I've really let the place go since you killed me.")
        }
    }
}

var observerInstance = Observer()
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1

//: [Next](@next)

//: [Previous](@previous)

import Foundation

//: ### Composite
/*:
 The composite pattern is used to create hierarchical, recursive tree structures of related objects where any element of the structure may be accessed and utilised in a standard manner.
 */
/*:
 Вы задумывались как много в нашей жизни древовидных структур? Начиная собственно от самих деревьев, и заканчивая структурами компаний. Да даже, ладно компаний – целые страны используют древовидные структуры, чтобы построить власть.
 Во главе компании или страны частенько стоит один человек, у него есть с 10 помощников. У них тоже есть с десяток помощников, и так далее... Если нарисовать их отношения на листе бумаги – увидим дерево!
 Очень часто, и мы используем такие типы даных, которые лучше всего хранятся в древовидной структуре. Возьмите к примеру стандартный UI: в начале у нас есть View, в нем находятся Subview, в которых могут быть или другие View, или все такие компоненты. Та же самая структура:)
 Именно для хранения таких типов данных, а вернее их организации, используется паттерн – Композит.
 Когда использовать такой паттерн?
 Собственно когда вы работаете с древовидными типами данных, или хотите отобразить иерархию даных таким образом.
 Давайте разберем более детально структуру:
 В начале всегда есть контейнер в котором находятся все остальные объекта. Контейнер может хранить как другие контейнеры – ветки нашего дерева, так и объекты которые контейнерами не являются – листья нашего дерева. Не сложно представить, что контейнеры второго уровня могут хранить как другие контейнеры, так и листья.
*/

protocol Composite {
    
    var data: String { get }
    mutating func addComponent(_ component: Composite)
}

struct Leaf: Composite {
    
    var value: String
    
    var data: String {
        return "\n" + "<\(value)/>"
    }
    
    mutating func addComponent(_ component: Composite) {
        print("Can't add component. Sorry, man")
    }
}

struct Container: Composite {
    
    var name: String
    
    private var components = [Composite]()
    
    init(name: String) {
        self.name = name
    }
    
    var data: String {
        return components.reduce("<\(name)-ContainerValues>") { $0 + $1.data + "\n" } + "</\(name)-ContainerValues>"
    }
    
    mutating func addComponent(_ component: Composite) {
        components.append(component)
    }
}

var rootContainer = Container(name: "rootContainer")

let object = Leaf(value: "level1 value")
rootContainer.addComponent(object)

var firstLevelContainer1 = Container(name: "firstLevelContainer1")
rootContainer.addComponent(firstLevelContainer1)

let object2 = Leaf(value: "level2 value")
firstLevelContainer1.addComponent(object2)

var firstLevelContainer2 = Container(name: "firstLevelContainer2")


let object3 = Leaf(value: "level2 value 2")
firstLevelContainer2.addComponent(object3)

print(rootContainer.data)

//: [Next](@next)

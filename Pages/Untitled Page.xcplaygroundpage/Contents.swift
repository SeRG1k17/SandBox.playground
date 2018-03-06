//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

func separator() {
    print("//---------------------------------------------------------------")
}
//let urlStrings = ["https://ya.ru",
//                  "https://gooogle.ru"]
//
//let urls = urlStrings.map { (<#String#>) -> T in
//    <#code#>
//}
//URL
//let urls1 = urlStrings.flatMap { (<#String#>) -> ElementOfResult? in
//    <#code#>
//}
//
//
//
//print(urls == urls1)

//func divisible(by numbers: Int...) -> (Int) -> Bool {
//    return { input -> Bool in
//
//        return !numbers.contains(where: { input % $0 != 0 })
////        print("input: \(input), numbers: \(numbers)")
////        return numbers.reduce(true) { divisible, number in
////            print("divisible: \(divisible), input: \(input), number: \(number), res: \(divisible && input % number == 0)")
////            return divisible && input % number == 0
////        }
//    }
//}
//
//let items = [6, 12, 24, 13]
//let result = items.filter(divisible(by: 2, 3, 4)) // [12, 24]

//func f(_ x: Int) -> Int {
//    return x + 3
//}
//
//func g(_ function: (Int) -> Int, x: Int) -> Int {
//    return function(x) * function(x)
//}
//
//print(g(f, x: 7))

//let g: (Int, (Int) -> Int) -> Int = { (x, f) in f(x) * f(x) }
//print(g(7) { x in x + 3 })

//// С сокращенными именами параметров
//let g: (Int, (Int) -> Int) -> Int = { $1($0) * $1($0) }
//print(g(7) { $0 + 3 })


//let optionalStrings: [String?] = ["a", nil, "b", "c", nil]
//let strings = optionalStrings.flatMap { $0 } // ["a", "b", "c"]
//
//let odds = [1,3,5,7,9]
//let evensAndOdds = odds.flatMap { [$0, $0 + 1] } // [1,2,3,4,5,6,7,8,9,10]

//let name: String? = nil// = "World"
//let greeting = name.map { "Hello " + $0 + "!" } // "Hello World!"

//let string: String? = "42"
//let number = string.flatMap { Int($0) } // 42

//let string: String? = "сорок два"
//let number: Int? = string.flatMap { Int($0) } // nil
//
////let number: Int? = string.map { Int($0) }
//print(number)


var arrayOfArrays = [ [[1, 1], [1,1]], [[2, 2], [2, 2]], [[3, 3], [3, 3]] ]

//// first iterating the array of arrays
//arrayOfArrays.map { array in
//    // and second iterating
//    // the current array
//    return array.map { integer in
//        // multiplying its content by 2
//        return integer * 2
//    }
//} // [ [2, 2], [4, 4], [6, 6] ]
//
//var multipliedByTwo = arrayOfArrays.map { array in
//    return array.map { integer in
//        return integer * 2
//    }
//}
//var flattened = Array(multipliedByTwo.joined())
//print(flattened) // outputs: [ 2, 2, 4, 4, 6, 6 ]

var flattenedArray = arrayOfArrays.flatMap { array in
    return array.flatMap { array in
        return array.map { integer in
            return integer * 2
        }
    }
}

//var flattenedArray = arrayOfArrays.flatMap { $0.map { $0 * 2 } }
print(flattenedArray) // outputs: [ 2, 2, 4, 4, 6, 6 ]

//let numbers: [Int] = [1, 2, 3]
//let numbersMap = numbers.map { return $0 }
//print(numbersMap) // [1, 2, 3]
//let numbersFlatMap = numbers.flatMap { return $0 }
//print(numbersFlatMap) // [1, 2, 3]

//let numbers: [Int?] = [1, nil, 3]
//let numbersMap = numbers.map { return $0 }
//print(numbersMap) // [Optional(1), nil, Optional(3)]
//let numbersFlatMap = numbers.flatMap { return $0 }
//print(numbersFlatMap) // [1, 3]
//
//struct User {
//    var id: Int
//    var name: String
//
//    init?(dictionary: Dictionary<String, Any>) {
//        return nil
//    }
//}
//
//let dictionaries: [Dictionary<String, Any>]? = []
//
//if let dicts = dictionaries {
//    let users = dicts.flatMap(User.init)
//}
////let closure: (Dictionary<String, Any>) ->Void?
////closur
//
//let superView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
//superView.backgroundColor = .white
////superView.backgroundColor = .red
//
//let blueView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 350, height: 350)))
//blueView.backgroundColor = .blue
//blueView.center = superView.center
//superView.addSubview(blueView)
//
//let blueViewLayer = blueView.layer
//blueViewLayer.cornerRadius = 15.0
//blueViewLayer.shadowOffset = CGSize(width: 0, height: 5)
//blueViewLayer.shadowColor = UIColor.black.cgColor
//blueViewLayer.shadowRadius = 10.0
//blueViewLayer.shadowOpacity = 0.8
//
//let greenView = UIView(frame: CGRect(origin: CGPoint(x: blueView.frame.size.width / 2 - 175,
//                                                     y: blueView.frame.size.height / 2 - 175),
//                                     size: CGSize(width: 350, height: 350)))
//
//greenView.layer.cornerRadius = blueViewLayer.cornerRadius
//
//greenView.backgroundColor = .green
//blueView.addSubview(greenView)
//
////let blueViewLayer = greenView.layer
////blueViewLayer.cornerRadius = 15.0
////blueViewLayer.shadowOffset = CGSize(width: 0, height: 5)
////blueViewLayer.shadowColor = UIColor.black.cgColor
////blueViewLayer.shadowRadius = 10.0
////blueViewLayer.shadowOpacity = 0.8
//
//print(superView.frame)
//print(blueView.frame)
//print(greenView.frame)
//
//PlaygroundPage.current.liveView = superView

//: # Patterns
//: ## Creational

/*:
Порождающие паттерны (creational) делают систему независимой от способа создания объектов.
 */

/*:
 In software engineering, creational design patterns are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. The basic form of object creation could result in design problems or added complexity to the design. Creational design patterns solve this problem by somehow controlling this object creation.
 */

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

var listeners = Dictionary<String, Array<Person>>()
listeners["eventName"] = [Person(name: "Ivan"), Person(name: "Sergey")]
print(listeners)

var array = listeners["eventName"]
print(listeners["eventName"]! == array!)

array?.append(Person(name: "Alex"))
//listeners["eventName"]?.append(Person(name: "Alex"))
print(listeners)


struct Student {
    var name: String
}

let students = [Student(name: "Sergey")]
print(students)

func change(student: Student) -> Student {
    return Student(name: "Alex")
}

let updated = students.map(change)
print(updated)



//: [Previous](@previous)

import Foundation

//: ### Singleton
/*:
 Паттерн «одиночка» гарантирует, что во всём приложении существует только один экземпляр данного класса. Существует глобальная точка доступа к этому экземпляру. Обычно применяется отложенная инициализация: этот единственный экземпляр создаётся, когда он нужен в первый раз.
 
 Знаете ли вы? Apple широко использует данный подход. Например: [NSUserDefaults standardUserDefaults], [UIApplication sharedApplication], [UIScreen mainScreen], [NSFileManager defaultManager] — каждый из этих методов возвращает объект-синглтон.
 
 Вы спросите, зачем беспокоиться о том, что где-то существует два или больше экземпляров класса. Почему не больше одного экземпляра? Память нынче дешёвая, разве нет?
 
 Есть такие случаи, где требуется иметь ровно один экземпляр класса. Например, вам ни к чему держать несколько экземпляров класса Logger (только если вы не пишете несколько разных логов одновременно). Или класс обращения к глобальной конфигурации: гораздо лучше обеспечить потоко-безопасный доступ к определённому общему ресурсу (например, к файлу настроек), чем иметь много классов, модифицирующих файл настроек, возможно, одновременно.
 */

/*:
 The singleton pattern ensures that only one object of a particular class is ever created. All further references to objects of the singleton class refer to the same underlying instance. There are very few applications, do not overuse this pattern!
 */

class Logger { //Also applicable to structures, but I do not know why you might need a singleton structure
    
    static let shared = Logger()
    var string: String!
    
    private init() {
        // Private initialization to ensure just one instance is created.
        print("Logger initialization")
    }
}

let logger = Logger.shared
logger.string = "Hello 2 You!"
print(logger.string)

let anotherLogger = Logger.shared
print(anotherLogger.string)
// "Logger initialization" printed once

//: [Next](@next)

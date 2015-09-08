//: Playground - noun: a place where people can play

import UIKit

// String, Boolean, Int, Float, Double, Object, Class, Struct, Enum, Array, Dictionary, Set
var myName = "Leon"
myName += " Baird"

var meaningOfLife = 42
var floatingStuff = 4541.2121

var shit:NSInteger = 42

shit = 100

let otherValue = CGFloat(20.3)

var anything:AnyObject = 42
anything = "BOB"

let name = anything as! String

var data:String?

data = "I love pies"

if data != nil {
    print(data!)
}

if let pieFetish = data {
    print(name)
}

// data?.prop1!.doSomthing()

var sender:AnyObject = UIButton()

if let button = sender as? UIButton {
    
}

var size:CGRect!


// functions

func myFunction(age a:Int, name b:String, fun c:Bool) {
    // code
}

myFunction(age: 40, name: "Leon", fun: true)

func addValues(A a:Int, B b:Int) -> Int {
    return a + b
}

addValues(A: 10, B: 30)

var numbers:[AnyObject] = [10, 20, 30, 40, 50]
numbers.count
numbers[1]
numbers[3] = 500

var dict:Dictionary<String, String> = ["surname" : "Baird", "forename": "Leon"]
print(dict["surname"]!)

var setOfNumber:Set<Int> = [10, 20, 30, 40, 50]

var typedNumbers = numbers as! [Int]

for number in numbers as! [Int] {
    number * 2
}

for value in 0...1000 {
    sin(Double(value))
}

func getStuff() -> (numberOfEggs: Int, numberOfPies: Int) {
    return (10, 20)
}

getStuff().numberOfPies

class Person {
    var surname:String

    init() {
        surname = "Empty"
    }
    
    init(forename:String, surname:String) {
        self.surname = surname
        self.forename = forename
    }
    
    deinit {
        // being destroyed
    }
    
    lazy var forename:String = "leon"
    
    lazy var computeMe:String = {
        return "BOB"
    }()
    
    var fullname:String {
        return "\(forename) \(surname)"
    }
    
    func getFullName() -> String {
        return "Full name is \(forename) \(surname)"
    }
}

var myPerson = Person()

myPerson.getFullName()
myPerson.fullname

var anotherPerson = Person(forename: "Leon", surname: "Baird")



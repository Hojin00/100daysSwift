//
//  main.swift
//  100daysSwift - Introduction to Swift
//
//  Created by Hojin Ryu on 09/06/21.
//

import Foundation

enum errorCase: Int {
    case fail1
    case fail2
    case fail3
}


//print(errorCase.fail1.rawValue)

func testCase(val :Int...){
    for i in val{
        print(i)
    }
}
//... -> "until the end
//testCase(val: 1,2,3,4,5)


enum passwordError: Error {
    case passwordNotGenerated
}


func getPassword(name: String) throws -> Bool {
    if (name == "NoEmail"){
        throw passwordError.passwordNotGenerated
    }
    
    return true
}
//getPassword(name: "NoEmail")


// MARK: - 6DAYS Closures
let driving = {
    print("i'm driving")
}

func travel(action: () -> Void ){
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
//action: () -> Void means: parameter "action" receives a closure that has
//no parameter and returns nothing.

//travel(action: driving)

// MARK: - 7DAYS Closures (the least we need to know)
func reading(readingChapters: (String) -> Void){
    let notes = "Once upon a time..."
    
    for _ in 0..<10 {
        readingChapters(notes)
    }
}
// let's suppose we have this functions that accepts a closure.


//1. We have a way to call that function like this.
//let somenOTES = {(notes: String) in
//    print("i am reading a book \(notes)")
//}
//reading(readingChapters: somenOTES)

//2. The other way would be like this.
//reading {(notes: String) in
//    print("i am reading a book \(notes)")
//}
// this way is more like completionHandler and clean code.

// MARK: Closures with return values as parameters to a function
func addUp(_ allNums: [Int], handler: (Int, Int) -> Int) -> Int{
    
    var current = allNums[0]
    
    for num in allNums[1...]{
        current = handler(current, num) // returns 30 and passes to current and 60 as well.
//        print("current sum: \(current)") // 30, 60.
    }
    
    return current
}

let arrayNum = [10,20,30]

let sumHandler = addUp(arrayNum) { sum1, sum2 in
    return sum1 + sum2
}
//print(sumHandler) // 60

let sum = addUp(arrayNum, handler: +)
//print(sum)
//this sum with handler "+" work just same as function above.
//both closures want two Integers and return one Integer that's it. Just same func.


// MARK: - 7DAYS Closure(Advanced closures)

// MARK: Closures with multiple parameters
func travel(action: (String, Int) -> String){
    let destination = "LA"
    let trip = action(destination, 60)
    print(trip)
}

//travel { (dest: String, mile: Int) in
//    return "I am going to \(dest) with \(mile) speed"
//}

// MARK: Returning closure from function
func closureBack() -> () -> Int {
    let calculate = {Int.random(in: 1...10)}
    return calculate
}

let funcBack = closureBack()
//print("funcBack: \(funcBack)")
//returned "funcBack: (Function)", which means, it returns a closure(function), not a Int yet.

let cloBack = funcBack()
//here we actually called random gen func(closure)
//print("cloBack: \(cloBack)")


// MARK: - Just a quick study(Functions/Closures) in Swift document guide
// let's say we have a incrementer func
// link: https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID103
func calcIncrementer(forIncrement amount: Int) -> () -> Int{
    var runningTotal = 0
    print("runningTotal: \(runningTotal)") // 0, only runs this part once.
    func incrementer() -> Int{
        runningTotal += amount
        print("running: \(runningTotal)") // 10...20...30
        return runningTotal
    }
    return incrementer
}

/*
in the nested function "incrementer", var runningTotal and amount, they are passed by capturing reference from surrounding function. No need to pass any by parameter.
 
 More importantly, when outer function ends, they (references of variables) don't disappear.
 and also, ensures that runningTotal is available the next time incrementer is called.
*/

/*
let incrementsByTen = calcIncrementer(forIncrement: 10)
print(incrementsByTen()) // -> 10
print(incrementsByTen()) // -> 20
print(incrementsByTen()) // -> 30

let incrementsByTwo = calcIncrementer(forIncrement: 2)
print(incrementsByTwo()) // -> 2
print(incrementsByTwo()) // -> 4
print(incrementsByTwo()) // -> 6
*/

/*
Important: Closures & Functions are reference types.
Whenever closure is set to a constant or variable, it refers a reference.
So, what's happening above can happen because they are reference type.
*/
// MARK: -
//Ex. Capturing closures
func visitCountry() -> (String) -> Void{
    var places = [String: Int]()
    
    return {
        places[$0, default: 0] += 1
        let nTimes = places[$0, default: 0]
        print("number of times visited \($0): \(nTimes)")
        
    }
}
/*
let tour = visitCountry()
tour("LA")
tour("France")
tour("LA")
number of times visited LA: 1
number of times visited France: 1
number of times visited LA: 2
*/

// MARK: - 8DAYS Struct
// MARK: Keywords
/*
 Keywords:
    - Stored Property, Computed Property, Property Observer, Method, Mutating
 
 */

//- Stored Property -> already store in the memory
//- Computed Property -> literally compute value when it's called
//    * Always need to put type inference.

//Property Observer
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
//This will run some code every time amount changes
//var progress = Progress(task: "Loading data", amount: 0)
//progress.amount = 30
//progress.amount = 80
//progress.amount = 100

// MARK: -9DAYS Struct Part Two
// access control, static properties, and laziness

/*
 Keywords:
    - Memberwise initializer / Custom initializer, lazy, static,
 
 */

//If i want Memberwise initializer to stay and use custom initializer as well. Just add extension. And use both.
struct Employee {
    var name: String
    var yearsActive = 0
}

extension Employee {
    init() {
        self.name = "Anonymous"
//        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee()

//Important:  Initializers cannot finish until all properties have a value

// As a performance optimization, if we set a property as lazy
// Ex. lazy var a = A()
// It only creates this property when it's called at least once. If not called, don't even create. Just like computed property.
// But in this case, lazy stores values after it's called, and computed property doesn't.


// Static Properties & Methods
// Why static? -> To share common information between all instances.
struct Student {
    static var classSize = 0 // in this case, this classSize belongs to struct Student itself, not an instance of Student.
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
let stu1 = Student(name: "rob1")
//print("stu1: \(Student.classSize)") // stu1: 1
let stu2 = Student(name: "rob2")
//print("stu2: \(Student.classSize)") // stu1: 2
let stu3 = Student(name: "rob3")
//print("stu3: \(Student.classSize)") // stu1: 3


// MARK: -10DAYS classes and inheritance
// MARK: Classes

/*
 Keyword: super/parent class -> sub/child class, inheritance, reference type, override, final, deinitializers
 
 */

/*
 Difference between Classes and Structs
    1. classes don't have memberwise initializers. Need to have own initilazer.
    2. classes are reference type. structs are value type.
    3. classes can be created by other existing classes(inheritance, super/parent class -> sub/child class), and because class has inheritance, it doesn't support memberwise initializers.
    4. final classes. Literally, "final classes", no inheritance/subclassing available. The others cannot change or add.
    5. classes can have deinitializers – code that gets run when an instance of a class is destroyed.
    6. mutability -> If you have a constant struct with a variable property, that property can’t be changed because the struct itself is constant. But, classes can change thier properties.
 */

// Swift has automatic reference counting, or ARC -> keeps track of copy of reference count, so we can notice when # of instances gets to 0, we just deinit.
class IceCream {
    deinit {
        print("No more icecream :(")
    }
    
    init() {
        print("we have icecream :)")
    }
}

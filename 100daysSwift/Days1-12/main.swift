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
print("cloBack: \(cloBack)")

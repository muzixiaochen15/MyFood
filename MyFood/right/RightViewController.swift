//
//  RightViewController.swift
//  MyFood
//
//  Created by qunlee on 16/10/11.
//  Copyright © 2016年 qunlee. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.log()
        self.controlLog()
        self.numberValue()
        self.tuple()
        self.simicolon()
        self.location(somePoint: (4, 5))
        print(self.calculateStatistics(scores: [65, 34, 52, 77, 98, 21, 41]))
        print(self.sumof())
        print(self.sumof(numbers: 45, 67, 78, 33))
        print(self.returnfifteen())
        //获取函数指针
        let function = self.makincremeter()
        print(function(7))
        print(self.makincremeter()(7))
        print(self.hasAnyMatches(list: [88,22,34,14,5], condition: lessthanten)
)
        let shape = Shape()
        shape.numOfSides = 7
        print(shape.simpleDescription())
        
        let testSquare = Square(sideLength: 5.2, name: "my test")
        print(testSquare.area())
        print(testSquare.simpleDescription())
        let ace = Rank.jack;
        print("value = \(ace.rawValue)")
        let hearts = Suit.hearts
        print(hearts.simpleDescription())
        print(Card(rank: .three, suit: .spades).simpleDescription())
        let bounds:NSArray = [8, 5, -12, 65, 09, 21]
        print("the min string is \(bounds.min), the max string is\(bounds.max)")
    }
    public func log(){
        let testlabel = "the width is"
        let width = 74
        let labelWidth = testlabel + String(width);
        print(labelWidth)
        
        let apple = 3
        let oranges = 5
        let appleString = "I have \(apple) apple"
        let fruitSummery = "I have \(apple + oranges) fruit"
        print(appleString);
        print(fruitSummery)
    }
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0
        var height = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get{
                let centerX = origin.x + (size.width/2)
                let centerY = origin.y + (size.height/2)
                return Point(x: centerX, y: centerY)
            }
            set(newCenter){
                origin.x = newCenter.x - (size.width/2)
                origin.y = newCenter.y - (size.height/2)
            }
        }
    }
        public func controlLog(){
        let individualScores = [64, 73, 88, 100]
        var teamScore = 0
        for score in individualScores {
            //必须是表达式
            if score < 50 {
                teamScore += 3
            }else{
                teamScore += 1
            }
        }
        print(teamScore)
        
        //？表示变量的值是可选的，值缺失
        let optionalString:String? = "hello"
        print(optionalString == nil)
        
        var optionalName: String? = "John appleseed"
        optionalName = nil
        var greeting = "hello"
        if let name = optionalName {
            greeting = "hello, \(name)!"
        }
        print(greeting)
        //switch 支持任意类型
        let vegetable = "red pepper"
        var vegetablecomment:String? = nil
        switch vegetable {
        case "celery":
             vegetablecomment = "add some raisins and make ants on a log"
        case "cucumber", "water cress":
             vegetablecomment = "we would get a good tea sandwich"
        case let x where x.hasSuffix("pepper"):
             vegetablecomment = "i have \(x)"
        default:
             vegetablecomment = "everything"
        }
        print(vegetablecomment)
        
        var firstForLoop = 0
        for i in 0..<4 {
            firstForLoop += i
        }
        print(firstForLoop)
    }
    
    func swift3Log() -> Bool {
        var welcomeMessage: String
        var red, blue, green: Double
        
        welcomeMessage = "hello"
        red = 5 ; blue = 0.0 ; green = 10.0
        blue = 5.0
        green = 5.0
        print("min = \(UInt.min)\n max = \(UInt.max)")
        print("red = \(red) \n blue = \(blue) \n green = \(green)")
        let 你好 = "你好"
        print(你好)
        if welcomeMessage != "" {
            return true
        }else{
            return false
        }
    }
    func numberValue() {
        var value = 17
        print("value = \(value)")
        value = 0b1111;
        print("value = \(value)")
        value = 0o21;
        print("value = \(value)")
        value = 0x21
        print("value = \(value)")
        value = 1_000_000
        print("value = \(value)")

        let twothousand:UInt16 = 2_000
        print(twothousand)
        let one:UInt8 = 1
        print(one)
        let two_thousand_and_one = twothousand + UInt16(one)
        print(two_thousand_and_one)
        
        let three = 3
        let point_one_four_one_five_nine = 0.14159
        let pi = Double(three) + point_one_four_one_five_nine
        print(pi)
        
        typealias audioSample = UInt16
        let maxValue = audioSample.max
        print(maxValue)
    }
    
    func tuple() {
        let http404error = (404, "not found")
        let (statusCode, statusMessage) = http404error
        print("the status code is \(statusCode)")
        print("the status message is \(statusMessage)")
        
        print("the status code is \(http404error.0)")
        print("the status message is\(http404error.1)")
        
        let (justStatusCode, _) = http404error
        print(justStatusCode)
        
        let http200status = (httpstatus: 200, httpDescription: "ok")
        print("the code status is \(http200status.httpstatus) \n the message is \(http200status.httpDescription)")
        
    }
    func convertedNumber() {
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        print("convertednumber = \(convertedNumber)")
        
        if convertedNumber != nil {
            print("convertedNumber contains some integer value")
        }
    }
    
    func simicolon() {
        let cat = "🐱";print(cat)
    }
    func whileCode(){
        var n = 2
        while n < 100 {
            n = n * 2
        }
        print(n)
        
        var m = 2
        repeat {
            m = m * 2
        }while m < 100
        print(m)
        
        var firstloop = 0
        for i in 0..<4 {
            firstloop += i
        }
        print(firstloop)
    }
    func calculateStatistics(scores: [Int]) ->(min: Int, max: Int, sum: Int){
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        for score in scores {
            if score > max{
                max = score
            }else if score < min{
                min = score
            }
            sum += score
        }
        return (min, max, sum)
    }
    func sumof(numbers:Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }
    
    func returnfifteen() -> Int {
        var y = 10
        func add(){
            y += 5
        }
        add()
        return y
    }
    func makincremeter() -> ((Int) -> Int) {
        func addone(number: Int) -> Int {
            return number + 1
        }
        return addone
    }
    func hasAnyMatches(list: [Int], condition: (Int) ->Bool) -> Bool {
        for item in list {
            //满足条件
            if condition(item){
                return true
            }
        }
        return false
    }
    func lessthanten(number: Int) -> Bool {
        return number < 10
    }
    func location(somePoint: (value: Int, key: Int)){
        switch somePoint{
        case(0, 0):
            print("the point is origin")
        case(_, 0):
            print("the (\(somePoint.0), 0) on the x axis")
        case(0, _):
            print("the (0, \(somePoint.1)) on the y axis")
        case(-2...2, -2...2):
            print("the (\(somePoint.0), \(somePoint.1)) on the inside box")
        default:
            print("the (\(somePoint.0), \(somePoint.1)) on the outside box")
        }
    }
}
class Shape {
    var numOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numOfSides) sides"
    }
}
class NamedShape {
    var numOfSides:Int = 0
    var name:String = ""
    init(name: String) {
        self.name = name
    }
    func simpleDescription() -> String {
        return "A shape with \(numOfSides) sides"
    }
}
class Square: NamedShape {
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numOfSides = 4
    }
    func area() -> Double {
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numOfSides = 3
    }
    var perimeter: Double{
        get{
            return 3.0  * sideLength
        }
        set{
            sideLength = newValue / 3.0
        }
    }
    override func simpleDescription() -> String {
        return "An equilateral Triangle with sides of length\(sideLength)."
    }
}
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
enum Suit{
    case spades, hearts, diamand, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamand:
            return "diamand"
        case .clubs:
            return "clubs"
        }
    }
}
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "the \(rank.simpleDescription()) of \(suit.simpleDescription())."
    }
}
class NewRightViewController: RightViewController {
    override func log() {
        let string = "the width is"
        let width = 54
        let stringWidth = string + String(width)
        print(stringWidth)
        
        let apple = 3
        let orange = 5
        let appleSring = "the apple number is \(apple)"
        let fruitSummery = "the fruits number is \(apple + orange)"
        print(appleSring)
        print(fruitSummery)
    }
    override func   controlLog() {
        let individualScores = [87, 76, 45, 99]
        var teamScore = 0
        for score in individualScores {
            if score < 50 {
                teamScore += 3
            }else{
                teamScore += 1
            }
        }
        print(teamScore)
        
        var optionalString: String? = "John xxx"
        optionalString = "John hacks"
        if nil != optionalString {
            print("hello \(optionalString)")
        }
    }
}

enum ObjectType {
    case fruits, shucai, other
    func typeString() -> String {
        switch self {
        case .fruits:
            return "frutis"
        case .shucai:
            return "shucai"
        default:
            return "other"
        }
    }
}
struct SomeStructure {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

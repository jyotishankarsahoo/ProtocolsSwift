import Foundation

class UdemyCourse {
    var name: String
    var author: String
    var title: String

    init(name: String, author: String, title: String) {
        self.name = name
        self.author = author
        self.title = title
    }
    func getDescription() -> String {
        return "name: \(self.name) | author: \(self.author) | title: \(self.title)"
    }
}

let udemyCourse = UdemyCourse(name: "Swift 4 with iOS 12", author: "Jyoti", title: "POP")
print("\(udemyCourse.getDescription())")
let udemyCourse1 = udemyCourse
udemyCourse1.title = "Core Data"
print("udemyCourse1: \(udemyCourse1.getDescription())")
print("udemyCourse: \(udemyCourse.getDescription())")

enum TypeOfCourse: String {
    case swift
    case objC
}

class SwiftCourse: UdemyCourse {
    var type: TypeOfCourse = .swift

    init(title: String, author: String, type: TypeOfCourse? = nil) {
        super.init(name: "Programming", author: author, title: title)
        if let type = type {
            self.type = type
        }
    }
    func detailedCourseInfo() -> String {
        return "\(getDescription()) in \(self.type.rawValue.uppercased())"
    }
}

let swiftCourse = SwiftCourse(title: "Optionals", author: "Jyoti")
print(swiftCourse.detailedCourseInfo())
print(swiftCourse.getDescription())

let objCCourse = SwiftCourse(title: "OOP", author: "Jyoti", type: .objC)
print(objCCourse.detailedCourseInfo())

enum MusicalInstruments: String {
    case violin
    case piano
}

class MusicalCourse: UdemyCourse {
    var musicSource: MusicalInstruments
    init(title: String, author: String, musicSource: MusicalInstruments) {
        self.musicSource = musicSource
        super.init(name: "Music is Fun", author: "Jyoti", title: "Laugh out loud")
    }

    func courseDetails() -> String {
        return "\(getDescription()) in \(self.musicSource.rawValue.uppercased())"
    }
}

let musicalCourse = MusicalCourse(title: "Laugh out loud", author: "Jyoti", musicSource: .piano)
print(musicalCourse.courseDetails())


//Struct
// Initializer is Optional
// If any method in Struct is modifying the member variables than the func should marked as mutating
// Struct is pass by value
// Struct cannot do Inheritance

struct UdemyCourseStruct {
    var category: String
    var title: String
    var author: String
    mutating func updateTitle(with title: String) {
        self.title = title
    }
    func getCourseDetails() -> String {
        return "\(title) | \(category) | \(author)"
    }
}

var course = UdemyCourseStruct(category: "Swift Progarmming", title: "Struct", author: "Jyoti")
print(course.getCourseDetails())

course.updateTitle(with: "Value Type")
print(course.getCourseDetails())

var newCourse = course
newCourse.updateTitle(with: "Reference Type")
print("course: \(course.getCourseDetails())")
print("newCourse: \(newCourse.getCourseDetails())")

//Object Initialization

class ShoppingCarClass {
    var item: String
    var price: Double
    var description: String?

    init(item: String, price: Double) {
        self.item = item
        self.price = price
    }
}
// Default Initializer
struct ShoppingCartStruct {
    var item: String
    var price: Double
    var quantity: Int
    // Member wise initializer
    init(item: String, price: Double) {
        self.init(item: item, price: price, quantity: 1)
    }
    init(item: String, price: Double, quantity: Int) {
        self.item = item
        self.price = price
        self.quantity = quantity
    }
}
let shoppingCartStruct1 = ShoppingCartStruct(item: "Maggi", price: 10)
print("\(shoppingCartStruct1.item) | \(shoppingCartStruct1.price) | \(shoppingCartStruct1.quantity)")
let shoppingCartStruct2 = ShoppingCartStruct(item: "Maggi", price: 20, quantity: 2)
print("\(shoppingCartStruct2.item) | \(shoppingCartStruct2.price) | \(shoppingCartStruct2.quantity)")

class BookClass {
    var title: String
    var author: String
    var price: Double
// Primery Initilaizer of the class
// Duty is to initialize all the stored property of the class
    init(title: String, author: String, price: Double) {
        self.title = title
        self.author = author
        self.price = price
    }
// Convenience Intializer used for easy initialization of Object
    convenience init(title: String, price: Double) {
        let author = "Jyoti"
        self.init(title: title, author: author, price: price)
    }
}
class Fiction: BookClass {
    var isComic: Bool
    // The Stored Property of the sub class should be initialized before we delegate the Object Creation to the super class
    override init(title: String, author: String, price: Double) {
        self.isComic = false
        super.init(title: title, author: author, price: price)
    }
    init(title: String, author: String, price: Double, isComic: Bool) {
        self.isComic = isComic
        super.init(title: title, author: author, price: price)
    }
}

let fiction = Fiction(title: "Spider Man", author: "Jyoti", price: 19.99, isComic: true)
print("\(fiction.title) | \(fiction.author) | \(fiction.price) | isComic: \(fiction.isComic)")

// Failable initialaizer is type of initialaizer which will retun nil if Object creation fail
// We cannot use init method in Delegation approch if its failable
// Non failable initializer can not delegate to failable initializer
class NonFiction: BookClass {
    var coverType: String
    init?(coverType: String, title: String, author: String, price: Double) {
        if coverType.isEmpty {
            return nil
        }
        self.coverType = coverType
        super.init(title: title, author: author, price: price)
    }
}

/// PROTOCOLS
// Only Var is allowed
// No Stored Properties
// Method Declaration only
protocol Person {
    var name: String { get set }
    var isAdult : Bool { get }
    mutating func upateName(wih name: String) -> String
}
struct Student: Person {
    var firstName: String
    var lastName: String
    let isAdult: Bool = false   //We can declare it as Const since Person Protocol Declares it as Gettable
    var name: String {
        get { return "\(firstName) \(lastName)" }
        set { self.firstName = newValue }
    }
    mutating func upateName(wih name: String) -> String {
        self.firstName = name
        return "new Name is \(self.firstName)"
    }
}

// Even if we set the func as mutating in Protocol due to Struct, it worls fine with class
class StudentClass: Person {
    var firstName: String
    var lastName: String
    let isAdult: Bool = false   //We can declare it as Const since Person Protocol Declares it as Gettable
    var name: String {
        get { return "\(firstName) \(lastName)" }
        set { self.firstName = newValue }
    }
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
     func upateName(wih name: String) -> String {
        self.firstName = name
        return "new Name is \(self.firstName)"
    }
}

// What going under the hood for { get set }
var student1: Student = Student(firstName: "Joe", lastName: "smith")
print(student1.name)
student1.upateName(wih: "Kim")
print(student1.name)
// Name changed even if we set name as only gettable
// It depends upon the instance type that we created

var student2: Person = Student(firstName: "Devid", lastName: "Lio")
print(student2.name)
student2.name = "Susen" //Here is the Catch
print(student2.name)

//If a protocol requires a property to be gettable and settable that property requirment can not be full filled by Constant Stored Property or read only computed property

/// Protocol Initializer

protocol Human{
    init(name: String, age: Double)
}
// For Struct it is simple
struct Asian: Human {
    var name: String
    var age: Double
    init(name: String, age: Double) {
        self.name = name
        self.age = age
    }
}
// For class we need to use required Keyword
class AsianClass: Human {
    var isTaller: Bool
    var name: String
    var age: Double

    init(name: String, age: Double, isTaller: Bool) {
        self.name = name
        self.age = age
        self.isTaller = isTaller
    }
    // Using convenience init
    required convenience init(name: String, age: Double) {
        let isTaller = false
        self.init(name: name, age: age, isTaller: isTaller)
    }
    func info(){
        print("\(name) | \(age) | isTaller = \(isTaller)")
    }
}

let asian = AsianClass(name: "Luca", age: 23)
asian.info()
let asian1 = AsianClass(name: "Ton", age: 32, isTaller: true)
asian1.info()


///Protocol Extension

var str = "Hello There"
// In Build Class Functionality extended using Extension
extension String{
    func getChatAtIndex(x: Int) -> Character {
        return self[index(startIndex, offsetBy: x)]
    }

     subscript(x: Int) -> Character {
        return self[index(startIndex, offsetBy: x)]
    }
}
str[4]

// PROTOCOL
protocol Person1{
    var name: String {get set}
    func doActivity()
}
/// Extention is used to provide default implementaion of the method and is available to all the Class and Struct that conforms to this
/// However Conforming Classes and Structs can also override this to provide there own implementation
extension Person1{
    func doActivity() {
        print("\(name) is walking around")
    }
}

struct Student1: Person1{
    var name: String
}
let student5 = Student1(name: "Oliver")
student5.doActivity()

struct Teacher: Person1{
    var name: String
    // Overriden method
    func doActivity() {
        print("\(name) is Teaching")
    }
}
let student6 = Teacher(name: "Ethan")
student6.doActivity()

//Protocol Inheritance
protocol Person6{
    var name: String { get  set }
    func performActivity()
}
protocol Tenant: Person6 {
    var rent: UnitType {get set}
    func payRent()
}
enum UnitType{
    case A(withGarage: Bool)
    case B(withGarage: Bool)
    var rentFee: Double {
        switch self {
        case .A(let withGarage):
            if withGarage {
                return 1200 + 200
            }
            return 1200
        case .B(let withGarage):
            if withGarage {
                return 1300 + 200
            }
            return 1300
        }
    }
}
struct Occupant: Tenant {
    var rent: UnitType
    var name: String
    func payRent() {
        print("\(name) is paying \(rent.rentFee)")
    }
    func performActivity() {
        print("\(name) is living in the house" )
    }
}

let occupant = Occupant(rent: .A(withGarage: false), name: "Roon")
occupant.payRent()
let occupant1 = Occupant(rent: .B(withGarage: true), name: "Shon")
occupant1.payRent()

/// Optional In PROTOCOL

// for adding optional type and func in Swift Protocol we need to add @obcj
// Only Class can conform to optional Protocol not the Structs

@objc protocol Citizen{
    var name: String {get set}
    @objc optional var ssn: String {get set}
    @objc optional func getSSN() -> String
}
protocol Tenent: Citizen {
    var ssn: String {get set}
    var unitType: String {get set}
}
class Occupant1: Tenent {
    var name: String
    var ssn: String
    var unitType: String
    init(name: String, ssn: String, unitType: String) {
        self.name = name
        self.ssn = ssn
        self.unitType = unitType
    }
    func getSSN() -> String { return ssn }
}

class Student3: Citizen {
    var name: String
    init(name: String) { self.name = name }
}
let occupant4 = Occupant1(name: "Joee", ssn: "12121212", unitType: "A")
print("\(occupant4.getSSN())")
let occupant5 = Student3(name: "Lisly")
//occupant5.getSSN()
//This is error since its optional
/// Optional Properties and Methods are not checked by the compiler, so we should avoid using Optional Protocol
/// If child protocol is @objc then the parent protocol should be @objc

/// How to avoid Optional In PROTOCOL

/// Using the same exmaple without @objc Keyword
/// The key is to use seperate Protocol for the optional methods and conform when ever necessary

protocol CitizenWithoutOptional{
    var name: String {get set}
    func getInfo() -> String
}
extension CitizenWithoutOptional {
    func getInfo() -> String {
        return "\(name) is talking"
    }
}
protocol SSNEligible {
    var ssn: String {get set}
    func getSSN() -> String
}

struct Tenent12: CitizenWithoutOptional, SSNEligible {
    var name: String
    var ssn: String
    func getSSN() -> String { return ssn }
}

class Student12: CitizenWithoutOptional {
    var name: String
    init(name: String) { self.name = name }
}
let tenent23 = Tenent12(name: "Luca", ssn: "123-44-4546")
print("\(tenent23.name)'s  ssn is \(tenent23.getSSN())")
print("\(tenent23.getInfo())")


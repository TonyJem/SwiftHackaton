import UIKit
import Foundation

var skaicius = 25

if skaicius % 3 == 0 && skaicius % 5 == 0 {
    print("FooBar")
} else {
    if skaicius % 3 == 0 {
        print("Foo")
    }
    if skaicius % 5 == 0 {
        print("Bar")
    }
}



for number in stride(from: 1, to: 11, by: 1) {
    print(number)
}


func addNumbers<T: Numeric>(_ a: T, and b: T) -> T {
    return a + b
}

addNumbers(8, and: 8)
print(addNumbers(8, and: 8))

var x = ["raudona", "geltona", "menlyna"]

func printGeltona(_ color: String){
    if color == "geltona"{
        print("geltona")
    }
}
x.forEach(printGeltona)

func printItem(_ item: String){
    print(item)
}

x.forEach(printItem)


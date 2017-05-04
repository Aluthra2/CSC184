//: Playground - noun: a place where people can play
// Lab 1

import UIKit

var str = "Hello, playground"
var doub = 2.2;
var num = 2;
let num2 = "34";
var stre = "begin";
var float = 1.2;

var polish = String(num2);

let number = 1;
let word = "hello";
let double = 232;
let bloat = 78.2;

if word==str{
    print(true);
}else{
    print(false);
}

switch word {
case "hello":
    print(true);
case "world":
    print("eureka");
default:
    print(false);
}

print(number);

var test : String?
test = "I hope this works";
print(test!);

var casting1: String;
casting1 = num.description;

var casting2 = Int(num2);
var casting3 = Float(num2);
var casting4 = Float(num);

func addtion(_ a:Int, _ b:Int) -> Int{
    return a+b;
}

addtion(number, num);

var arr = [1,2,3,4,5];

for x in arr{
    print(arr[x-1]);
}

var x = 0;
while x < arr.capacity {
    print(arr[x]);
    x = x + 1;
}

var unsorted = [3,46,8,23,8,0,6,0,2,6,8,4];

var lisr = unsorted.capacity;

//bubble sort algo below
for x in 0...lisr - 1 {
    for y in 0...lisr - 1 {
        if unsorted[x] < unsorted[y]{
            var temp = unsorted[x];
            unsorted[x] = unsorted[y];
            unsorted[y] = temp;
        }
    }
}

print(unsorted);

var sampleArr = [Int]();
var sampleSet = Set<Int>();
var sampleDictionary = Dictionary<Int, String>();

sampleArr.append(1);
sampleArr.append(2);
print(sampleArr);

sampleSet.insert(3);
sampleSet.insert(4);
print(sampleSet);

sampleDictionary[0] = "zero";
sampleDictionary[1] = "one";
print(sampleDictionary);

for index in sampleArr{
    print(index);
}

for index2 in sampleSet{
    print(index2);
}

for index3 in sampleDictionary{
    print(index3);
    print(index3.key);
    print(index3.value);
}
var z = 0;

repeat{
    z = z + 1
    print(z);
}while z<10;

// for loop in Swift no longer exists
//for(var p = 0; p<10; p++){
//    print(p);
//}

var lmnop = 9.8;
var sLmnop = String(lmnop);
var dLmnop = Double(lmnop);
var fLmnop = Float(lmnop);
var iLmnop = Int(lmnop);
/*while lmnop < 10 {
    print(lmnop);
    lmnop += 1;
}
*/

var testArray = [Int]();
var testSet = Set<Int>();
var testDictionary = Dictionary<Int, String>();

testArray.append(contentsOf: sampleArr);




func maxMin(arr1:[Int]) -> (max:Int, min: Int){
    var max = arr1[0];
    var min = arr1[0];
    for index in arr1{
        if index < min{
            min = index
        }
        if index>max{
            max = index
        }
    }
    return (max, min);
}

maxMin(arr1: testArray);

print("The max is " + String(maxMin(arr1: testArray).max));
print("The min is " + String(maxMin(arr1: testArray).min));

var testString = "asdfghjkl";

//testString.index(testString.startIndex, offsetBy: 2);

for index in testString.characters{
    print(index);
}



protocol vehicle: class{}

for (var i = 0; i <10; i=+){
    print(x);
}




























//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 ------------------数组--------------------
 */
//字符串数组
var shoppingList: [String] = ["Eggs", "Milk"]

//isEmpty 检查是否为空

//count 元素个数

//append(_:)新项添加到数组的末尾
shoppingList.append("tt")

//或者，使用加法赋值运算符（+=）附加一个或多个兼容项目的数组：
shoppingList += ["Baking Powder"]

var firstItem = shoppingList[0]

shoppingList[0] = "Six eggs"

shoppingList[1...2] = ["Bananas", "Apples"]

//添加删除
shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)

//删除最终项，请使用removeLast()方法
let apples = shoppingList.removeLast()

//遍历数组
for item in shoppingList {
    print(item)
}
//带索引值遍历
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
/*
 ------------------集合--------------------
 */
//Swift中的Set类型被写为Set<T>,这里的T表示Set中允许存储的类型。
//你可以通过构造器语法创建一个特定类型的空集合:
var letters = Set<Character>()
//一个空的数组字面量创建一个空的Set:
letters.insert("a")
letters = []
//用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock","Classical","Hip hop"]
//这里将favoriteGenres显示声明为Set<String>,如果不这么做，favoriteGenres会被推断为Array<String>类型.


/*
 ------------------字典--------------------
 */




















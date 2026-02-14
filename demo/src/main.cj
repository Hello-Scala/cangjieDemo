package demo

import demo.demo.basic.domain.*
import demo.demo.basic.service.MathHelper

main() {
    println("Hello, world!")
    let h1 = Hero("Timorr", HeroType.APC)
    println(h1.say())
    let arr = [2, 4, 3, 5, 9, 1, 8, 7]
    bubbleSorting(arr)
    println("sorted: ${arr}")
    bubbleSorting(arr, true)
    println("reversed: ${arr}")

    println("Addition: ${MathHelper.add(5, 3)}")
    println("Subtraction: ${MathHelper.subtract(5, 3)}")
    println("Multiplication: ${MathHelper.multiply(5, 3)}")
    println("Division: ${MathHelper.divide(5, 3)}")
    try {
        println("Division: ${MathHelper.divide(5, 0)}")
    } catch (e: Exception) {
        println("Caught an exception: ${e.message}")
    }
    println("Power: ${MathHelper.power(5, 3)}")
}

func bubbleSorting(arr: Array<Int>): Unit {
    bubbleSorting(arr, false)
}

func bubbleSorting(arr: Array<Int>, reverse: Bool): Unit {
    for (i in 0 .. arr.size) {
        for (j in 0 .. arr.size - 1 - i) {
            let a = arr[j]
            let b = arr[j + 1]
            let needSwich: Bool = if (reverse) {
                a < b
            } else {
                a > b
            }
            if (needSwich) {
                arr[j] = b
                arr[j + 1] = a
            }
        }
    }
}

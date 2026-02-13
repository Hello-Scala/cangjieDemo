package demo
import demo.demo.game.domain.*

main() {
    println("Hello, world!")
    let h1 = Hero("Timorr", HeroType.APC)
    println(h1.say())
    let arr = [2, 4, 3, 5, 9, 1, 8, 7]
    bubbleSorting(arr)
    println(arr)
}

func bubbleSorting(arr: Array<Int>): Unit {
    for (i in 0..arr.size) {
        for (j in 0..arr.size - 1 - i) {
            let a = arr[j]
            let b = arr[j + 1]
            if (a > b) {
                arr[j] = b
                arr[j + 1] = a
            }
        }
    }
}

package  demo.demo.basic.service

public struct MathHelper {
    public static func add(a: Int, b: Int): Int {
        return a + b
    }

    public static func subtract(a: Int, b: Int): Int {
        return a - b
    }

    public static func multiply(a: Int, b: Int): Int {
        return a * b
    }

    public static func divide(a: Int, b: Int): Int {
        match (b) {
            case 0 => throw Exception("Division by zero is not allowed.")
            case _ => return a / b
        }
    }

    public static func power(base: Int, exponent: UInt64): Int64 {
        return base ** exponent
    }
}

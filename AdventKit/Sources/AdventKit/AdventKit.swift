/// Calculates the _greatest common divisor_ for the given values.
/// - Returns: the largest positive integer that divides each of the integers
public func gcd(_ m: Int, _ n: Int) -> Int {
    let r: Int = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

/// Calculates the _greatest common divisor_ for the given values.
/// - Returns: the largest positive integer that divides each of the integers
public func gcd(_ numbers: Int...) -> Int {
    gcd(numbers)
}

/// Calculates the _greatest common divisor_ for the given values.
/// - Returns: the largest positive integer that divides each of the integers
public func gcd(_ numbers: [Int]) -> Int {
    numbers.reduce(0) { gcd($0, $1) }
}

/// Calculates the _least common multiple_ for the given values
/// - Returns: the smallest positive integer that is divisible by each of the integers
public func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}

/// Calculates the _least common multiple_ for the given values
/// - Returns: the smallest positive integer that is divisible by each of the integers
public func lcm(_ numbers: Int...) -> Int {
    lcm(numbers)
}

/// Calculates the _least common multiple_ for the given values
/// - Returns: the smallest positive integer that is divisible by each of the integers
public func lcm(_ numbers: [Int]) -> Int {
    numbers.reduce(numbers[0]) { lcm($0, $1) }
}

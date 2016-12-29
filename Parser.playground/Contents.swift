//: Playground - noun: a place where people can play

import UIKit

class Parser<T> {
    var parse : (String) -> [(T, String)]
    init(parse : @escaping (String) -> [(T, String)]) {
        self.parse = parse;
    }
    
}

func runParser<T>(parser: Parser<T>, input: String) -> T {
    switch parser.parse(input).first {
    case let .some(res, _):
        return res
    default:
        fatalError()
    }
}


func fmap<T, U>(f: @escaping ((T) -> U), fa: Parser<T>) -> Parser<U> {
    
    return Parser<U>(parse: { (str: String) -> [(U, String)] in
        var ret :[(U, String)] = []
        for item in fa.parse(str) {
            ret.append((f(item.0), item.1))
        }
        return ret
    })
}

func pure<T>(a : T) -> Parser<T> {
    return Parser(parse: { (str) -> [(T, String)] in
        return [(a, str)]
    })
}


infix operator =>



func => <T, U>(ma: Parser<T>, mb: Parser<U>) -> Parser<U> {
    
    return bind(ma: ma, f: { (_) -> Parser<U> in
        return mb
    })
//    return Parser(parse: { (str) -> [(U, String)] in
//        var ret : [(U, String)] = []
//        for item in ma.parse(str) {
//            let s = item.1
//            ret.append(contentsOf: mb.parse(s))
//            
//        }
//        return ret
//        
//    })
}



func apply<T, U>(mf: Parser<((T) -> U)>, ma: Parser<T>) -> Parser<U> {
    return Parser<U>(parse: { (str) -> [(U, String)] in
        var ret: [(U, String)] = []
        for item in mf.parse(str) {
            let f = item.0
            let s = item.1
            let newItems = ma.parse(s)
            for newItem in newItems {
                ret.append((f(newItem.0), newItem.1))
            }
            
        }
        return ret
    })
}

func bind<T, U>(ma: Parser<T>, f: @escaping ((T) -> Parser<U>)) -> Parser<U> {
    return Parser<U>(parse: { (str) -> [(U, String)] in
        var ret : [(U, String)] = []
        for item in ma.parse(str) {
            let parseU = f(item.0)
            ret.append(contentsOf: parseU.parse(item.1))

        }
        return ret
    })
}


func mzero<T>() -> Parser<T> {
    return Parser<T>(parse: { (str) -> [(T, String)] in
        return []
    })
}

func mor<T>(left: Parser<T>, right: Parser<T>) -> Parser<T> {
    return Parser(parse: { (str) -> [(T, String)] in
        if left.parse(str).count == 0 {
            return right.parse(str)
        } else {
            return left.parse(str)
        }
    })
}

func item() -> Parser<Character> {
    return Parser(parse: { (str) -> [(Character, String)] in
        if str.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            return []
        } else {
            return [(str.characters.first!, str.substring(from: str.index(str.startIndex, offsetBy: 1)))]
        }
    })
}

func satisfy(f: @escaping ((Character) -> Bool)) -> Parser<Character> {
    return bind(ma: item()) { (c) -> Parser<Character> in
        if f(c) {
            return pure(a: c)
        } else {
            return mzero()
        }
    }
}

func isElem(str: String) -> ((Character) -> Bool) {
    return { (c) -> Bool in
        return str.characters.contains(c)
    }
}
func oneOf(str: String) -> Parser<Character> {
    return satisfy(f: isElem(str: str))
}

func char(c: Character) -> Parser<Character> {
    return satisfy(f: { (c1) -> Bool in
        return c == c1
    })
}



func preAppend<T>(item: T) -> (([T]) -> [T]) {
    return { (arr: [T]) -> [T] in
        var ret = arr
        ret.insert(item, at: 0)
        return ret
    }
}

runParser(parser: oneOf(str: "123"), input: "1")
runParser(parser: char(c: "1"), input: "1")
runParser(parser: mor(left: char(c: "1"), right: char(c: "2")), input: "2")



func someV<T>(p: Parser<T>) -> Parser<[T]> {
    return Parser(parse: { (str) -> [([T], String)] in
        let left: Parser<([T]) -> [T]> = fmap(f: preAppend, fa: p)
        return apply(mf: left, ma: manyV(p: p)).parse(str)
    })
}

func manyV<T>(p: Parser<T>) -> Parser<[T]> {
    return mor(left: someV(p: p), right: pure(a: []))
}
func some<T>(p: Parser<T>) -> Parser<[T]> {
    
    return someV(p: p)
}

func many<T>(p: Parser<T>) -> Parser<[T]> {
    return manyV(p: p)
}

runParser(parser: many(p: char(c: "1")) , input: "")
runParser(parser: some(p: char(c: "1")) , input: "1")
runParser(parser: many(p: char(c: "1")) , input: "11112")
runParser(parser: some(p: char(c: "1")) , input: "11112")


func spaces() -> Parser<[Character]> {
    return Parser(parse: { (str) -> [([Character], String)] in
        return many(p: oneOf(str: " \r\n")).parse(str)
    })
}

let x = runParser(parser: (spaces() => char(c: "1")) => char(c: "2"), input: " 12 121112")
















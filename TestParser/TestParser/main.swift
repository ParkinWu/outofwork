//
//  main.swift
//  TestParser
//
//  Created by parkinwu on 2016/12/30.
//  Copyright © 2016年 parkinwu. All rights reserved.
//


import Foundation

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
    return ma >=> { (_) in
        return mb
    }
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

infix operator >=>

func >=><T, U>(ma: Parser<T>, f: @escaping ((T) -> Parser<U>)) -> Parser<U> {
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
infix operator |
func |<T>(left: Parser<T>, right: Parser<T>) -> Parser<T> {
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
    let mf = { (c: Character) -> Parser<Character> in
        if f(c) {
            return pure(a: c)
        } else {
            return mzero()
        }
    }
    return item() >=> mf
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




func someV<T>(p: Parser<T>) -> Parser<[T]> {
    return Parser(parse: { (str) -> [([T], String)] in
        let left: Parser<([T]) -> [T]> = fmap(f: preAppend, fa: p)
        return apply(mf: left, ma: manyV(p: p)).parse(str)
    })
}

func manyV<T>(p: Parser<T>) -> Parser<[T]> {
    return someV(p: p) | pure(a: [])
}
func some<T>(p: Parser<T>) -> Parser<[T]> {
    
    return someV(p: p)
}

func many<T>(p: Parser<T>) -> Parser<[T]> {
    return manyV(p: p)
}



let manyC = some(p: char(c: "1")).parse("11112")
print(manyC)

let manyC1 = (some(p: char(c: "1")) => pure(a: "abc")).parse("11112")

print(manyC1)



func spaces() -> Parser<[Character]> {
    return Parser(parse: { (str) -> [([Character], String)] in
        return many(p: oneOf(str: " \r\n")).parse(str)
    })
}

let manySpace = (spaces() => some(p: char(c: "1"))).parse(" 111112")
print(manySpace)



let x = runParser(parser: (spaces() => char(c: "1")) => char(c: "2"), input: " 12 121112")


func isDigit(c: Character) -> Bool {
    return c >= "0" && c <= "9"
}


func digit() -> Parser<Character> {
    return satisfy(f: isDigit)
}

func string(str: String) -> Parser<String> {
    if str.lengthOfBytes(using: String.Encoding.utf8) == 0 {
        return Parser(parse: { (str) -> [(String, String)] in
            return [("", str)]
        })
    }
    let c = str.characters.first!
    let cs = str.substring(from: str.index(after: str.startIndex))
    return (char(c: c) => string(str: cs)) => pure(a: str)
}


func number() -> Parser<Int> {
    return (spaces() => (string(str: "-") | pure(a: ""))) >=> { (s) -> Parser<Int> in
        return some(p: digit()) >=> { (cs) -> Parser<Int> in
            return spaces() >=> { (_) -> Parser<Int> in
                var ret = ""
                for c in cs {
                    ret = ret + String(c)
                }
                ret = s + ret
                return Parser(parse: { (str) -> [(Int, String)] in
                    if let n = Int(ret) {
                        return [(n, str)]
                    } else {
                        return []
                    }
                    
                })
            }
            
        }
    }
    
}


func token<T>(p: Parser<T>) -> Parser<T> {
    return spaces() >=> { (_) -> Parser<T> in
        return p >=> { (a) -> Parser<T> in
            return spaces() => pure(a: a)
        }
    }
}

func reserved(s: String) -> Parser<String> {
    return token(p: string(str: s))
}

indirect enum Expr {
    case add(Expr, Expr)
    case mul(Expr, Expr)
    case sub(Expr, Expr)
    case lit(Int)
}

func eval(expr: Expr) -> Int {
    switch expr {
    case .add(let left, let right):
        return eval(expr: left) + eval(expr: right)
    case .sub(let left, let right):
        return eval(expr: left) - eval(expr: right)
    case .mul(let left, let right):
        return eval(expr: left) * eval(expr: right)
    case .lit(let i):
        return i
        
    }
}


func int() -> Parser<Expr> {
    return number() >=> { (n) -> Parser<Expr>  in
        return pure(a: .lit(n))
    }
}

let intTest = int().parse("123+")
print(intTest)


func parens<T>(m: Parser<T>) -> Parser<T> {
    return ((reserved(s: "(") => spaces()) => m) >=> { (n) -> Parser<T> in
        return (spaces() => reserved(s: ")")) => pure(a: n)
    }
}

let pars = parens(m: string(str: "1231")).parse("(1231)")
//print(pars)

func chain<T>(p: Parser<T>, op: Parser<((T) -> ((T) -> T))>) -> Parser<T> {
    func rest(a: T) -> Parser<T> {
        return (op >=> { (f) -> Parser<T> in
            return p >=> { (b) -> Parser<T> in
                return rest(a: f(a)(b))
            }
            }) | pure(a: a)
    }
    return p >=> { rest(a: $0)}
}

func infixOp<T>(str: String, f: @escaping ((T) -> ((T) -> T))) -> Parser<((T) -> ((T) -> T))> {
    return reserved(s: str) => pure(a: f)
}
func add(e:Expr) -> ((Expr) -> Expr) {
    return { Expr.add(e, $0) }
}
func addOp() -> Parser<((Expr) -> ((Expr) -> Expr))> {
    return infixOp(str: "+", f: add)
}

func mul(e:Expr) -> ((Expr) -> Expr) {
    return {Expr.mul(e, $0)}
}

func mulOp() -> Parser<((Expr) -> ((Expr) -> Expr))> {
    return infixOp(str: "-", f: mul)
}



func term() -> Parser<Expr> {
    return chain(p: factor(), op: mulOp())
}


func factor() -> Parser<Expr> {
    return int() //| parens(m: expr())
}
func expr() -> Parser<Expr> {
    return chain(p: term(), op: addOp())
}



//
let res = runParser(parser: expr(), input: "1+2+3+4")
print(eval(expr: res))

print("end")









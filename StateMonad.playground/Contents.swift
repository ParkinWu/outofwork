//
//  main.swift
//  RDMonad
//
//  Created by KatagiriSo on 2016/10/06.
//  Copyright © 2016年 Rodhos Soft. All rights reserved.
//

import Foundation


typealias CallBack<R> = (R)->Void
typealias Process<R> = (CallBack<R>)->Void


func unit<T>(_ t:T) -> Process<T> {
    func process(callBack:CallBack<T>) {
        callBack(t)
    }
    return process
}

func >>=<T,U>(left:@escaping Process<T>, right:@escaping (T)->Process<U>) -> Process<U> {
    
    let proc = {(callBack:CallBack<U>) -> Void in
        left {(t:T) in
            (right(t)) {(u:U) in
                callBack(u)
            }
        }
    }
    
    return proc
}

struct SomeUID {
    let uid:String
}
struct SomeRecord {
    let title:String
}


// CPS
func getUIDs(callBack:CallBack<[SomeUID]>) {
    let uids:[SomeUID] = [SomeUID(uid:"AX"),SomeUID(uid:"BC")]
    callBack(uids)
}

// CPS
func getRecords(uids:[SomeUID],callBack:CallBack<[SomeRecord]>) {
    // async...
    
    let records:[SomeRecord] = uids.map {uid in
        SomeRecord(title:"\(uid)'-record")
    }
    
    callBack(records)
}


func getUIDs() -> Process<[SomeUID]> {
    return getUIDs
}

func getRecords(uids:[SomeUID]) -> Process<[SomeRecord]> {
    func gR(callBack:CallBack<[SomeRecord]>) -> Void{
        getRecords(uids: uids, callBack: callBack)
    }
    
    return gR
}

func getAllRecords() -> Process<[SomeRecord]> {
    return getUIDs()>>=getRecords
}


(getAllRecords()) { records in
    print(records)
}


let proc = unit([SomeUID(uid:"X"), SomeUID(uid:"Y")]) >>= getRecords
proc {records in
    print(records)
}


/*
// Environment Monad

typealias Environment<E,T> = (E)->T

func unit<E,T>(_ t:T) -> Environment<E,T> {
    
    let environment = {(e:E) -> T in
        return t
    }
    
    return environment
}

func >>=<E,T,U>(left:@escaping Environment<E,T>, right:@escaping (T)->Environment<E,U>) -> Environment<E,U> {
    let environment = {(e:E) -> U in
        
        let t = left(e)
        let env = right(t)
        let u = env(e)
        return u
    }
    
    return environment
}

func ask<E>(e:E) -> E {
    return e
}

func local<E,T>(modify:@escaping ((E)->E), env:@escaping Environment<E,T>) -> Environment<E,T> {
    let environment = {(e:E) -> T in
        env(modify(e))
    }
    
    return environment
}


let count:Int = 0

func hello(x:String)->Environment<Int,String> {
    let env = {(e:Int) -> String in
        
        switch e {
        case 0:
            return "hello, \(x)."
        case 1:
            return "hi."
        default:
            return "..."
        }
    }
    
    return env
}

func math(input:String)->Environment<Int,Int> {
    let env = {(e:Int) -> Int in
        switch e {
        case 0:
            return input.lengthOfBytes(using: .utf8)
        case 1:
            return input.lengthOfBytes(using: .utf8) * 5
        default:
            return 0
        }
    }
    
    return env
}


let helloEnv = hello(x: "poi")
let mathEnv = math(input: "hoge")

let result = hello(x: "poi") >>= math
let result2 = local(modify: {e in 0},env: hello(x: "poi")) >>= math


print("helloEnv(0) == \(helloEnv(0))")
print("helloEnv(1) == \(helloEnv(1))")
print("helloEnv(2) == \(helloEnv(2))")

print("mathEnv(0) == \(mathEnv(0))")
print("mathEnv(1) == \(mathEnv(1))")
print("mathEnv(2) == \(mathEnv(2))")

print("result(0) == \(result(0))")
print("result(1) == \(result(1))")
print("result(2) == \(result(2))")

print("result2(0) == \(result2(0))")
print("result2(1) == \(result2(1))")
print("result2(2) == \(result2(2))")



// Maybe Monad

enum Maybe<T> {
    case just(T)
    case nothing
}

func >>=<T,U>(left:Maybe<T>, right:(T)->Maybe<U>) -> Maybe<U> {
    switch left {
    case .nothing:
        return .nothing
    case let .just(t):
        return right(t)
    }
}

func add(_ str:Maybe<String>, _ str2:Maybe<String>) -> Maybe<String> {
    
    if case .just(let t1) = str, case .just(let t2) = str2 {
        let res = t1 + t2
        if res.lengthOfBytes(using: .utf8) > 10 {
            return .nothing
        } else {
            return .just(res)
        }
    }
    
    return .nothing
}

func oddNumber(x:Int) -> Maybe<Int> {
    if x % 2 == 1 {
        return .just(x)
    } else {
        return .nothing
    }
}

let m = Maybe.just(1000) >>= oddNumber
let m2 = Maybe.just(1001) >>= oddNumber

print("1000 = \(m)")
print("1001 = \(m2)")



// State Monad


typealias State<S,T> = (S) -> (T,S)

func unit<S,T>(_ t:T) -> State<S,T> {
    return {(s:S)->(T,S) in (t,s)}
}

func >>=<S,T,U>(left:@escaping State<S,T>, right:@escaping (T) -> State<S,U>) -> State<S,U> {
    
    return {s in
        let (t,ss) = left(s)
        let stateMon = right(t)
        let ret = stateMon(ss)
        return ret
    }
}

func add1(x:Int) -> State<Int,Int> {
    return {(s:Int) in
        let xx = x + s
        let ss = s + 1
        return (xx,ss)
    }
}

var state:State<Int,Int> = unit(0) // value

print(state(2)) // state 2
print(state(5)) // state 5

let re = state >>= add1

print("re(1) = \(re(1))")
print("re(2) = \(re(2))")
print("re(3) = \(re(3))")

let re2 = (state >>= add1) >>= add1

print("re2(1) = \(re2(1))")
print("re2(2) = \(re2(2))")
print("re2(3) = \(re2(3))")




import Foundation

typealias CPSCallBack<R> = (R)->Void
typealias CPSFunction<R> = (@escaping CPSCallBack<R>)->Void


class ContMonad<R> {
    
    let cps: CPSFunction<R>
    
    init(cps:@escaping CPSFunction<R>) {
        self.cps = cps
    }
    
    func run(callBack:@escaping CPSCallBack<R>)->Void {
        return cps(callBack)
    }
    
    func fmap<T>(_ f:@escaping (R)->T) -> ContMonad<T>{
        return self >>= {(r:R) in unit(f(r))}
    }
}

class ContMonadCancel<R,S>: ContMonad<R> {
    
}


func >>=<R,T>(left:ContMonad<R>, right:@escaping (R)->ContMonad<T>) -> ContMonad<T> {
    
    
    let f = {(cb:@escaping CPSCallBack<T>) -> Void in
        left.run(callBack:{r in
            let c:ContMonad<T> = right(r)
            c.run(callBack:{t in
                cb(t)
            })
        })
    }
    
    return ContMonad<T>(cps:f)
}

func unit<R>(_ x:R) -> ContMonad<R> {
    
    let cps:(CPSCallBack<R>)->Void = {(cb:CPSCallBack<R>)->Void in
        return cb(x)
    }
    
    return ContMonad<R>(cps:cps)
}


func fmap<R,T>(f:@escaping (R) -> T, m:ContMonad<R>) -> ContMonad<T> {
    
    return m >>= {(r:R) in unit(f(r))}
}

func fmap<R,T>(f:@escaping (R)->T) -> (ContMonad<R>) -> ContMonad<T> {
    return {m in fmap(f:f, m:m)}
}


enum CPSResult<X>{
    case just(X)
    case error(Error)
}




func getRecordCont(uid:SomeUID?) -> ContMonad<CPSResult<SomeRecord>> {
    return ContMonad{cb in
        let cb_ = cb
        DispatchQueue.global().async {
            let r = SomeRecord(title: "\(uid?.uid) - record")
            cb_(CPSResult.just(r))
        }
    }
}

func getUIDsCont()->ContMonad<CPSResult<SomeUID>> {
    return ContMonad { cb in
        DispatchQueue.global().async {
            let r = SomeUID(uid: "PO")
            cb(CPSResult.just(r))
        }
    }
}

func uidFromResult(_ r:CPSResult<SomeUID>) -> SomeUID? {
    switch r {
    case let .just(uid):
        return uid
    default:
        return nil
    }
}


var b = getUIDsCont().fmap(uidFromResult)
let c = b >>= getRecordCont

c.run { r in
    print("ContMonad result = \(r)")
}

sleep(1000)

*/













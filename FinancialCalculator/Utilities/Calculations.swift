//
//  Calculations.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/8/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation

class Calculations: NSObject {
    
    // MARK: - Compound calculations
    
    //     presentValue = P
    //     futureValue = A
    //     interest = R
    //     payment = PMT
    //     noOfPayments(time) = t
    //     compoundsPerYear = n
    
//    var FutureAmount =  P * pow(1 + (R / n), n * t)
//    var PrincipalAmount = A / pow(1 + (R / n), n * t)
//    var InterstRate = n * pow((A / P), 1 / (n * t) ) - 1
//    var Time = log(A / P) / n * log(1 + R / n)
//    var PMT =  (A * R) / ((pow((1 + R), t) - 1) * (1 + R * 0)) last 0 is default 1 if begin
    
    static func calFutureValue(P:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = P * pow(1 + (R / n), n * t)
        return answer
    }
    
    static func calPrincipalValue(A:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = A / pow(1 + (R / n), n * t)
        return answer
    }
    
    static func calInterestRate(A:Double, P:Double, n:Double, t:Double) -> Double{
        let answer: Double = n * (pow((A / P), 1 / (n * t) ) - 1)
        return answer
    }
    
    static func calTimesValue(A:Double, P:Double, R:Double, n:Double) -> Double{
        let answer: Double = log(A / P) / (n * log(1 + R / n))
        return answer
    }
    
    static func calEndPMTValue(A:Double, R:Double, t:Double) -> Double{
        let answer: Double =  (A * R) / ((pow((1 + R), t) - 1) * (1 + R * 0))
        return answer
    }
    
    static func calBeginPMTValue(A:Double, R:Double, t:Double) -> Double{
        let answer: Double =  (A * R) / ((pow((1 + R), t) - 1) * (1 + R * 1))
        return answer
    }
    
    // MARK: - Savings calculations
    
//    calculations ref -https://www.calculatorsoup.com/calculators/financial/simple-interest-plus-principal-calculator.php
    
    //     presentValue = P
    //     futureValue = A
    //     annual interest = R
    //     payment = PMT
    //     noOfPayments = t
    //     compoundsperyear = n = 12 by defult
    //     totalValue = Tot
    //     InterestValue = I
    
//    let FutureValue = PMT * ((pow((1 + R / n) , (n * t) ) - 1) / (R / n))
//    let FutureValue  = P(1 + rt)
//    let TotalValue = FV + P
//    let PresentValue = P = A / (1 + rt)
//    let Interest Rate = (1/t)(A/P - 1)
//    let Time = (1/r)(A/P - 1)
    
    static func calSavingsFutureValue(P:Double, R:Double, t:Double) -> Double{
        let answer: Double =  P * (1 + R * t)
        return answer
    }
    
    static func calSavingsPresentValue(A: Double, R:Double, t:Double) -> Double{
        let answer: Double = A / (1 + R * t)
        return answer
    }
    
    static func calSavingsInterestRate(A: Double, P:Double, t:Double) -> Double{
        let answer: Double = ( 1 / t ) * ( A / P - 1 )
        return answer
    }
    
    static func calSavingsTime(A: Double, P:Double, R:Double) -> Double{
        let answer: Double = ( 1 / R ) * ( A / P - 1 )
        return answer
    }
    
    static func calSavingsTotalValue(P:Double, A:Double) -> Double{
        let answer: Double =  A + P
        return answer
    }
    
    // MARK: - Mortgage calculations
    
    //     presentValue = P
    //     interest = R
    //     payment = PMT
    //     noOfPayments = n
    //    compoundsperyear = t = 12 by defult
    
//   payment = (P * ( R/t * pow((1 + R/t), (n*t)))) / ( pow((1 + R/t), (n*t)) - 1 )
//    var Present  = (PMT * ( pow((1 + R/t), (n*t)) - 1 )) / ( R/t * pow((1 + R/t), (n*t)))
    
    static func calPMTValue(P:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = (P * ( R/t * pow((1 + R/t), (n*t)))) / ( pow((1 + R/t), (n*t)) - 1 )
        return answer
    }
    
    static func calMortgagePresentValue(PMT:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = (PMT * ( pow((1 + R/t), (n*t)) - 1 )) / ( R/t * pow((1 + R/t), (n*t)))
        return answer
    }
    
}

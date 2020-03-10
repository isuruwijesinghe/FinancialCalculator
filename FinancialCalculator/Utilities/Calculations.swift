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
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calPrincipalValue(A:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = A / pow(1 + (R / n), n * t)
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calInterestRate(A:Double, P:Double, n:Double, t:Double) -> Double{
        let answer: Double = n * (pow((A / P), 1 / (n * t) ) - 1)
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calTimesValue(A:Double, P:Double, R:Double, n:Double) -> Double{
        let answer: Double = log(A / P) / (n * log(1 + R / n))
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calEndPMTValue(A:Double, R:Double, t:Double) -> Double{
        let answer: Double =  (A * R) / ((pow((1 + R), t) - 1) * (1 + R * 0))
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calBeginPMTValue(A:Double, R:Double, t:Double) -> Double{
        let answer: Double =  (A * R) / ((pow((1 + R), t) - 1) * (1 + R * 1))
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
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
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calSavingsPresentValue(A: Double, R:Double, t:Double) -> Double{
        let answer: Double = A / (1 + R * t)
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calSavingsInterestRate(A: Double, P:Double, t:Double) -> Double{
        let answer: Double = ( 1 / t ) * ( A / P - 1 )
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calSavingsTime(A: Double, P:Double, R:Double) -> Double{
        let answer: Double = ( 1 / R ) * ( A / P - 1 )
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calSavingsTotalValue(P:Double, A:Double) -> Double{
        let answer: Double =  A + P
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
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
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calMortgagePresentValue(PMT:Double, R:Double, n:Double, t:Double) -> Double{
        let answer: Double = (PMT * ( pow((1 + R/t), (n*t)) - 1 )) / ( R/t * pow((1 + R/t), (n*t)))
        
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calMortgageNumberOfPaymentsValue(PMT:Double, R:Double, P:Double, t:Double) -> Double{
        let i : Double = (R / 100) / 12
        let answer: Double = (log(PMT / i) - log((PMT / i) - P)) / log(1 + i)
        let noOfYears : Double = (answer / 12)
        
        if noOfYears.isNaN || noOfYears.isInfinite || noOfYears < 0 {
            return 0.0;
        } else {
            // this may return a value more than 100% for cases such as
            // where payment = 2000, terms = 12, amount = 10000  <--- unreal figures
            return noOfYears
        }
    }
    
    static func calMortgageInterestValue(P: Double, PMT: Double, n: Double) -> Double {
        
        var x = 1 + (((PMT*n/P) - 1) / 12) // initial guess
        // var x = 0.1;
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
        
        func F(_ x: Double) -> Double { // f(x)
            // (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
            return Double(P * x * pow(1 + x, n) / (pow(1+x, n) - 1) - PMT);
        }
        
        func FPrime(_ x: Double) -> Double { // f'(x)
            // (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
            let c_derivative = pow(x+1, n)
            return Double(P * pow(x+1, n-1) *
                (x * c_derivative + c_derivative - (n*x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
            x = x - F(x) / FPrime(x)
        }
        
        // Convert to yearly interest & Return as a percentage
        // with two decimal fraction digits
        
        let I = Double(12 * x * 100)
        
        print("DEBUG", I)
        
        // if the found value for I is inf or less than zero
        // there's no interest applied
        if I.isNaN || I.isInfinite || I < 0 {
            return 0.0;
        } else {
            // this may return a value more than 100% for cases such as
            // where payment = 2000, terms = 12, amount = 10000  <--- unreal figures
            return I
        }
        
    }
    
    // MARK: - Loan calculations
    
    //     presentValue = P
    //     interest = R
    //     payment = PMT
    //     noOfPayments = n
    //    compoundsperyear = t = 12 by defult
    
    static func calLoanPMTValue(P:Double, R:Double, n:Double) -> Double{
        let i = (R / 12)
        let answer: Double = (P * i * (pow(1+i, n))) / ((pow(1+i, n)) - 1)
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calLoanPresentValue(PMT:Double, R:Double, n:Double) -> Double{
        let i = (R / 12)
        let answer: Double = PMT / i * ( 1 - (1 / (pow(1 + i, n))))
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calLoanNumberOfPaymentsValue(P:Double, R:Double, PMT:Double) -> Double{
        let i = (R / 12)
        let answer: Double = log((PMT/i) / ((PMT/i) - P)) / log(1 + i)
        if answer.isNaN || answer.isInfinite || answer < 0 {
            return 0.0;
        } else {
            return answer
        }
    }
    
    static func calLoanInterestValue(P: Double, PMT: Double, n: Double) -> Double {
        
        var x = 1 + (((PMT*n/P) - 1) / 12) // initial guess
        // var x = 0.1;
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
        
        func F(_ x: Double) -> Double { // f(x)
            // (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
            return Double(P * x * pow(1 + x, n) / (pow(1+x, n) - 1) - PMT);
        }
        
        func FPrime(_ x: Double) -> Double { // f'(x)
            // (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
            let c_derivative = pow(x+1, n)
            return Double(P * pow(x+1, n-1) *
                (x * c_derivative + c_derivative - (n*x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
            x = x - F(x) / FPrime(x)
        }
        
        // Convert to yearly interest & Return as a percentage
        // with two decimal fraction digits
        
        let I = Double(12 * x * 100)
        
        //        print("DEBUG", I)
        
        // if the found value for I is inf or less than zero
        // there's no interest applied
        if I.isNaN || I.isInfinite || I < 0 {
            return 0.0;
        } else {
            // this may return a value more than 100% for cases such as
            // where payment = 2000, terms = 12, amount = 10000  <--- unreal figures
            return I
        }
        
    }
    
}

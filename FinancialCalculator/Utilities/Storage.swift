//
//  Storage.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/10/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation

//Class to manage data storage and retrival of data
class Storage: NSObject {
    
    
    //saving data
    static func storeData(key:String, value:String){
        var storage :[String] = []
        
        if(UserDefaults.standard.object(forKey: key) != nil) {
            storage = UserDefaults.standard.object(forKey: key) as! [String]
            if(storage.count == 5){
                storage = Array(storage.dropLast())
            }
            storage = [value] + storage
        }else{
            storage.append(value)
        }
         UserDefaults.standard.set(storage, forKey: key)
    }
    
    //recieve data
    static func getData(key:String) -> [String] {
        if(UserDefaults.standard.object(forKey: key) != nil){
            return UserDefaults.standard.object(forKey: key) as! [String]
        }else{
            return []
        }
    }
}

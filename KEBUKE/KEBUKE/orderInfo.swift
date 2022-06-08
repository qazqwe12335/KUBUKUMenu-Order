//
//  orderInfo.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/22.
//

import Foundation

struct order {
    var name:String
    var team:String
    var drinkName:String
    var radioOption:[String]
    var size:String
    var price:Int
    var remark:String?
    var bubbleOption:Bool?
}

struct orderInfo : Codable{
    let records:[records]
    
    struct records : Codable {
        let createdTime:String
        let fields:fields
        
        struct fields : Codable {
            let name:String
            let team:String
            let drinkName:String
            let radioOption:[String]
            let size:String
            let price:Int
            let remark:String?
            let bubbleOption:Bool?
        }
    }
}

struct uploadOrderInfo : Codable{
    let records:[records]
    
    struct records : Codable {
        let fields:fields
        
        struct fields : Codable {
            let name:String
            let team:String
            let drinkName:String
            let radioOption:[String]
            let size:String
            let price:Int
            let remark:String?
            let bubbleOption:Bool?
        }
    }
}

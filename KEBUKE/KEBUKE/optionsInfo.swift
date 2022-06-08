//
//  optionsInfo.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/17.
//

import Foundation

struct optionsInfo : Codable{
    let fields:options
    
    struct options : Codable{
        let ice:Array<String>
        let sugar:[String]
        let bubble:Int
    }
}

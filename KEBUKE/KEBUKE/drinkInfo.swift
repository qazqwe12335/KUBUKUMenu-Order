//
//  drinkInfo.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/17.
//

import Foundation

struct drinkInfo:Codable{
    let records:[fields]
    
    struct fields:Codable{
        let fields:results
        
        struct results : Codable {
            let teaname:String
            let mediumCup:Int
            let largeCup:Int?
            let image:[thumbnails]
            
            struct thumbnails : Codable {
                let thumbnails:imageUrl
                
                struct imageUrl : Codable {
                    let large:largeImageUrl
                    
                    struct largeImageUrl : Codable {
                        let url:URL
                    }
                }
            }
        }
    }
}

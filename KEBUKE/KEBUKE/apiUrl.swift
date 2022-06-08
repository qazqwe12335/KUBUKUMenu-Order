//
//  apiUrl.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/17.
//

import Foundation
import Alamofire

class api{
    static let httpHeaders:HTTPHeaders = [.authorization(apiKey)]
    static let apiKey:String = "Bearer keyclk0SwmpOrWySw"
    static let menuApi:String = "https://api.airtable.com/v0/appMoyzcN5p6rI7Oh/Imported%20table?view=menu"
    static let optionsApi:String = "https://api.airtable.com/v0/appMoyzcN5p6rI7Oh/Imported%20table%202/recdvbdUOCnde4buj"
    static let orderApi:String = "https://api.airtable.com/v0/appMoyzcN5p6rI7Oh/order?maxRecords=3&view=Grid%20view"
    static let createOrderApi:String = "https://api.airtable.com/v0/appMoyzcN5p6rI7Oh/order"
}

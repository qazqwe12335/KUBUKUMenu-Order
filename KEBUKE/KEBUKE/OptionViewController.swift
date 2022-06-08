//
//  OptionViewController.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/18.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftUI

class OptionViewController: UIViewController {
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var sugarPicker: UITextField!
    @IBOutlet weak var icePicker: UITextField!
    @IBOutlet weak var sizePicker: UITextField!
    @IBOutlet weak var teamPicker: UITextField!
    @IBOutlet weak var remark: UITextField!
    
    @IBOutlet weak var bubbleSwitch: UISwitch!
    
    @IBOutlet weak var userNameEditText: UITextField!
    
    var info:drinkInfo.fields
    let bubblePrice:Int!
    var bubbleState = false
    var team = ["文組班","程式班"]
    var sugarOption:[String]!
    var iceOption:[String]!
    var sizeOption:[String] = []
    var sizePrice:[Int] = []
    
    var sugarselect = 0
    var iceselect = 0
    var sizeselect = 0
    var price = 0
    var teamselect = 0
    
    var sugarPickerView = UIPickerView()
    var icePickerView = UIPickerView()
    var sizePickerView = UIPickerView()
    var teamPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkNameLabel.text = info.fields.teaname
        drinkImage.kf.setImage(with:info.fields.image[0].thumbnails.large.url)
        
        if info.fields.largeCup != nil{
            sizeOption.append("大杯 \(info.fields.largeCup!)元")
            sizePrice.append(info.fields.largeCup!)
        }
        if info.fields.mediumCup != nil{
            sizeOption.append("中杯 \(info.fields.mediumCup)元")
            sizePrice.append(info.fields.mediumCup)
        }
        
        sugarPickerView.dataSource = self
        sugarPickerView.delegate = self
        icePickerView.dataSource = self
        icePickerView.delegate = self
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        
        teamPickerView.dataSource = self
        teamPickerView.delegate = self
        teamPicker.inputView = teamPickerView
        
        sugarPicker.inputView = sugarPickerView
        icePicker.inputView = icePickerView
        sizePicker.inputView = sizePickerView
        teamPicker.inputView = teamPickerView
        
        sugarPickerView.tag = 1
        icePickerView.tag = 2
        sizePickerView.tag = 3
        teamPickerView.tag = 4
        
        sugarPicker.text = sugarOption[0]
        icePicker.text = iceOption[0]
        sizePicker.text = sizeOption[0]
        teamPicker.text = team[0]
        
        sugarPicker.textAlignment = .center
        icePicker.textAlignment = .center
        sizePicker.textAlignment = .center
        teamPicker.textAlignment = .center
        
        price = sizePrice[0]
    }
    
    init?(Coder:NSCoder, info: drinkInfo.fields, option: optionsInfo.options) {
        self.info = info
        self.sugarOption = option.sugar
        self.iceOption = option.ice
        self.bubblePrice = option.bubble
        
        super.init(coder: Coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func check(_ sender: Any) {
        guard userNameEditText.text != "" else {
            showAlert(status:false)
            return
        }
        
        showAlert(status:true)
    }
    
    func showAlert(status:Bool){
        var controller = UIAlertController()
        if status{
            var bubblechoose = false
            var bubbleString = ""
            if bubbleSwitch.isOn {
                bubblechoose = true
                bubbleString = "加珍珠"
            }
            controller = UIAlertController(title: "訂餐確認"
                                           , message: "\(String(describing: drinkNameLabel.text!))\(bubbleString)\n\(sugarOption[sugarselect])\n\(iceOption[iceselect])"
                                           , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default) { _ in
                if bubblechoose{
                    self.price += self.bubblePrice
                }
                self.createOrderRequest(total: self.price, bubble: bubblechoose)
            }
            controller.addAction(okAction)
        }else{
            controller = UIAlertController(title: "訂餐確認"
                                           , message: "姓名為輸入"
                                           , preferredStyle: .alert)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func createOrderRequest(total:Int,bubble:Bool){
        let httpHeaders:HTTPHeaders = [.authorization(api.apiKey)
                                       ,.contentType("application/json")]
        
        var createOrderInfo = order(
            name: userNameEditText.text!
            , team: team[teamselect]
            , drinkName: drinkNameLabel.text!
            , radioOption: ["\(sugarOption[sugarselect])","\(iceOption[iceselect])"]
            , size:sizeOption[sizeselect]
            , price: total
            , remark: remark.text!
            , bubbleOption:bubble)
        
        let orderbody = getOrderBody(order: createOrderInfo)
        
        var request = URLRequest(url: URL(string:api.createOrderApi)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = httpHeaders
        
        let encode = JSONEncoder()
        request.httpBody = try? encode.encode(orderbody)
        
        AF.request(request).responseData {[self] response in
            switch response.result{
            case let .success(data):
                if data != nil{
                    let a = String(data: data, encoding: .utf8)
                    print(a)
                }
                break
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
    func getOrderBody(order: order) -> uploadOrderInfo {
        let orderBody = uploadOrderInfo(
            records: [.init(fields: .init(
                name: order.name, team: order.team, drinkName: order.drinkName
                , radioOption: order.radioOption, size: order.size, price: order.price
                , remark: order.remark, bubbleOption: order.bubbleOption))])
        return orderBody
    }
}

extension OptionViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return sugarOption.count
        case 2:
            return iceOption.count
        case 3:
            return sizeOption.count
        case 4:
            return team.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return sugarOption[row]
        case 2:
            return iceOption[row]
        case 3:
            return sizeOption[row]
        case 4:
            return team[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            sugarPicker.text = sugarOption[row]
            sugarselect = row
            sugarPicker.resignFirstResponder()
        case 2:
            icePicker.text = iceOption[row]
            iceselect = row
            icePicker.resignFirstResponder()
        case 3:
            sizePicker.text = sizeOption[row]
            sizeselect = row
            price = sizePrice[sizeselect]
            sizePicker.resignFirstResponder()
        case 4:
            teamPicker.text = team[row]
            teamselect = row
            teamPicker.resignFirstResponder()
        default:
            return
        }
    }
    
}

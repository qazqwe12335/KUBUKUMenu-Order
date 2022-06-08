//
//  OrderTableViewController.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/22.
//

import UIKit
import Alamofire

class OrderTableViewController: UITableViewController {
    
    let orderApi = api.orderApi
    var orderinfo = [orderInfo.records]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    
    func request(){
        print("OK")
        let headers:HTTPHeaders = api.httpHeaders
        
        AF.request(orderApi, method: .get, headers:headers).responseData {[self] response in
            switch response.result{
            case let .success(data):
                print("OK")
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let order:orderInfo = try decoder.decode(orderInfo.self, from: data)
                    self.orderinfo = order.records
                    print(order.records)
                    
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }catch{
                    print(error)
                }
                break
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderinfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderTableViewCell.self)", for: indexPath) as! OrderTableViewCell
        cell.orderName.text = orderinfo[indexPath.row].fields.name
        cell.orderTeam.text = orderinfo[indexPath.row].fields.team
        cell.orderDrinkName.text = orderinfo[indexPath.row].fields.drinkName
        cell.orderDrinkSugar.text = orderinfo[indexPath.row].fields.radioOption[0]
        cell.orderDrinkIce.text = orderinfo[indexPath.row].fields.radioOption[1]
        cell.orderDrinkPrice.text = String(orderinfo[indexPath.row].fields.price)
        cell.orderDrinkSize.text = orderinfo[indexPath.row].fields.size
        
//        let isoDate = orderinfo[indexPath.row].createdTime
//        let dateFormatter = ISO8601DateFormatter()
//        let date = dateFormatter.date(from:isoDate)!
//
////        dateFormatter.dateFormat = "yyyy/MM/dddd HH:mm:ss"
////        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
//        let dateFormatString: String = dateFormatter.string(from: date)
//
//        print(dateFormatString)
        
        cell.orderDateTime.text = orderinfo[indexPath.row].createdTime
        
        if let bubble = orderinfo[indexPath.row].fields.bubbleOption {
            cell.bubble.isHidden = false
        }else{
            cell.bubble.isHidden = true
        }
        
        if let remark = orderinfo[indexPath.row].fields.remark {
            cell.Remark.text = remark
        }else{
            cell.Remark.text = ""
        }
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

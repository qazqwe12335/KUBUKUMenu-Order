//
//  MenuTableViewController.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/17.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftUI

class MenuTableViewController: UITableViewController {
    
    var menu = [drinkInfo.fields]()
    var optioninfo:optionsInfo.options!
    let drinkApi = api.menuApi
    let optionsApi = api.optionsApi
    let apiKey = api.apiKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request(requestUrl: drinkApi,code: 1)
        request(requestUrl: optionsApi,code: 2)
    }
    
    func requestMethod2(requestUrl:String,code:Int){
        let url = URL(string: requestUrl)!
        let headers:HTTPHeaders = [.authorization(apiKey)]
        var urlrequest = try! URLRequest(url: url, method: .get, headers: headers)
        
        URLSession.shared.dataTask(with: urlrequest) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               error == nil{
                
                let decord = JSONDecoder()
                
                if code == 1{
                    let drinkinfo:drinkInfo!
                    drinkinfo = try? decord.decode(drinkInfo.self, from: data)
                    
                    self.menu = drinkinfo.records
                }else if code == 2{
                    let optioninfo:optionsInfo!
                    optioninfo = try? decord.decode(optionsInfo.self, from: data)
                    self.optioninfo = optioninfo.fields
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                print(error)
            }
        }.resume()
    }
    
    func request(requestUrl:String,code:Int){
        let httpHeaders:HTTPHeaders = [.authorization(apiKey)]
        
        AF.request(requestUrl, method: .get, headers:httpHeaders).responseData {[self] response in
            switch response.result{
            case let .success(data):
                print("OK")
                do{
                    if code == 1 {
                        let drinkmenu:drinkInfo = try JSONDecoder().decode(drinkInfo.self, from: data)
                        menu = drinkmenu.records
                        print(drinkmenu)
                        DispatchQueue.main.async {
                            tableView.reloadData()
                        }
                    }else if code == 2 {
                        
                        let drinkOption:optionsInfo = try JSONDecoder().decode(optionsInfo.self, from: data)
                        optioninfo = drinkOption.fields
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuTableViewCell.self)", for: indexPath) as! MenuTableViewCell
        
        cell.nameLabel.text = menu[indexPath.row].fields.teaname
        if let largeCup = menu[indexPath.row].fields.largeCup {
            cell.largeCupPriceLabel.text = "大杯價格：\(largeCup) 元"
        }else{
            cell.largeCupPriceLabel.isHidden = true
        }
        cell.mediumCupLabel.text = "中杯價格：\(menu[indexPath.row].fields.mediumCup) 元"
        cell.drinkImageView?.kf.setImage(with:menu[indexPath.row].fields.image[0].thumbnails.large.url)
        return cell
    }
    
    @IBSegueAction func gotoOption(_ coder: NSCoder) -> OptionViewController? {
        if let row = tableView.indexPathForSelectedRow?.row {
            return OptionViewController(Coder: coder, info: menu[row], option: optioninfo)
        }else{
            return nil
        }
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

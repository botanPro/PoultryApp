//
//  CartVCViewController.swift
//  PoultryApp
//
//  Created by botan pro on 5/27/21.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import SCLAlertView
class CartVCViewController: UIViewController {

    @IBOutlet weak var Continue: Languagebutton!
    
    @IBOutlet weak var EmptyView: UIView!
    
    @IBOutlet weak var CartTableView: UITableView!

    @IBOutlet weak var TotalPrice: UILabel!
    var cards: Results<Cart> {
        get {
            let realm = try! Realm()
            return realm.objects(Cart.self)
        }
    }
    
    var TotalQuantity = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Continue.layer.cornerRadius = 12
        CartTableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        updateCart()
        setbadgate()
    }
    
    
    func setbadgate(){
        tabBarController?.tabBar.items?[2].badgeValue = String(cards.count)
    }
    
    func updateCart(){
        let sum = cards.map({ $0.cart_price * $0.cart_quantity }).reduce(0, +)
        self.TotalPrice.text = "\(sum) دينار"
        setbadgate()
        let sumQuantity = cards.map({$0.cart_quantity }).reduce(0, +)
        self.TotalQuantity = sumQuantity
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCart()
        print(cards)
        self.CartTableView.reloadData()
    }
    
    @objc func remove(sender: UIButton) {
        let realm = try! Realm()
        let result = realm.objects(Cart.self).filter("cart_product_id = '\(sender.accessibilityIdentifier!)'").first
        try! realm.write {
            realm.delete(result!)
        }
        updateCart()
        self.CartTableView.reloadData()
    }
    
    
    
    
    
    var titlee = ""
    var message = ""
    var Yes = ""
    var No = ""
    
    var cardarray = [String:Any]()
    @IBAction func Continue(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Logined") == true{
        if XLanguage.get() == .Kurdish {
            self.titlee = "تم الطلب بنجاح."
            self.message = "هل أنت متأكد؟"
            self.No =  "لا"
            self.Yes = "نعم"
        }else if XLanguage.get() == .Arabic{
            self.titlee = "بسەرکەفتیانە هاتە داخوازکرن."
            self.message = "تو یێ پشتراستی؟"
            self.No = "نەخێر"
            self.Yes = "بەڵێ"
        }
        let myAlert = UIAlertController(title:"", message: self.message, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: self.Yes, style: .default, handler: { (UIAlertAction) in
            for (i,item) in self.cards.enumerated(){
                print("jjj")
                self.cardarray.append(anotherDict:    [         "\(i)"        :        ["product_id" : "\(item.cart_product_id)", "qyt" : "\(item.cart_quantity)" , "price" : "\(item.cart_price)"]     ]    )
                print(JSON(self.cardarray))
                
            }
                
                guard let PhoneNumber = UserDefaults.standard.string(forKey: "PhoneNumber") else { return }
                guard let UserName = UserDefaults.standard.string(forKey: "UserName") else { return }
                guard let UserId = UserDefaults.standard.string(forKey: "UserId") else { return }
                guard let UserAddress = UserDefaults.standard.string(forKey: "UserAddress") else { return }
                guard let UserOrAdmin = UserDefaults.standard.string(forKey: "UserOrAdmin") else { return }
                let stringUrl = URL(string: API.URL);
            
            
                let param: [String: Any] = [
                    "key":API.key,
                    "addneworder": "Any",
                    "user_admin_id": UserOrAdmin,
                    "user_admin": UserId,
                    "orders_name": UserName,
                    "orders_phone": PhoneNumber,
                    "orders_address": UserAddress,
                    "orders_count": "\(self.TotalQuantity)",
                    "orders_total_price": self.TotalPrice.text!,
                    "cartData": JSON(self.cardarray)
                ]
                
                
                AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                    switch response.result
                    {
                    case .success(_):
                        let jsonData = JSON(response.data ?? "")
                        if(jsonData[0] != "error"){
                            SCLAlertView().showSuccess(API.APP_TITLE, subTitle: self.titlee)
                        }
                    case .failure(let error):
                        print(error);
                    }
                }
        }))
        myAlert.addAction(UIAlertAction(title:self.No, style: .cancel, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            myVC.modalPresentationStyle = .fullScreen
            myVC.IsFromNotifSwitch = true
            self.present(myVC, animated: true, completion: nil)
        }
    }
    
    
    
}




extension CartVCViewController : UITableViewDelegate , UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cards.count == 0 {
            self.EmptyView.alpha = 1
            return 0
        }else if cards.count != 0{
            self.EmptyView.alpha = 0
            return cards.count
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavTableViewCell
        if cards.count != 0{
            let card = cards[(indexPath as NSIndexPath).row]
            cell.Name.text = card.cart_product_name
            cell.Datee.text = "\(card.cart_price) دينار (\(card.cart_price_unit))"
            cell.quantitiy.text = "\(card.cart_quantity)"
            let urlString = "\(API.ImageURL)\(card.cart_product_imagLink)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let url = URL(string: urlString ?? "")
            cell.Imagee.sd_setImage(with: url, completed: nil)
            cell.Delete.accessibilityIdentifier = card.cart_product_id
            cell.Delete.addTarget(self, action: #selector(self.remove(sender:)), for:.touchUpInside)
        }
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callSegueFromProductCell(Name: self.cards[indexPath.row].cart_product_name, ImageUrl: self.cards[indexPath.row].cart_product_imagLink, Desc:self.cards[indexPath.row].cart_desc, Id : (self.cards[indexPath.row].cart_product_id as NSString).integerValue, phone: self.cards[indexPath.row].cart_phone , price : self.cards[indexPath.row].cart_price)
        
    }
    
    
    
    func callSegueFromProductCell(Name: String , ImageUrl : String, Desc : String , Id : Int , phone : String , price : Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "GoToProductVC") as! ProductVC
        myVC.name = Name
        myVC.ImageUrl = ImageUrl
        myVC.desc = Desc
        myVC.phone = phone
        myVC.price = price
        myVC.ProductId = Id
        print("product id is \(Id)")
        self.navigationController?.pushViewController(myVC, animated: true)
    }
}


extension Dictionary where Key == String, Value == Any {
    
    mutating func append(anotherDict:[String:Any]) {
        for (key, value) in anotherDict {
            self.updateValue(value, forKey: key)
        }
    }
}


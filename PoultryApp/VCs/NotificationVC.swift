//
//  NotificationVC.swift
//  AdamGroup
//
//  Created by Botan Amedi on 9/14/20.
//  Copyright © 2020 AdamGrouping. All rights reserved.
//

import UIKit
import CRRefresh
import Alamofire
import SwiftyJSON


class NotificationVC : UIViewController{

    
    var Notifications : [NotificationsObject] = []
    
    
    @IBOutlet weak var TableView : UITableView!{didSet{self.GetNotifications()}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 90
        TableView.register(UINib(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.TableView.cr.addHeadRefresh {
            self.GetNotifications()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarItem.badgeValue = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.GetNotifications()
        }
    }
    
    func GetNotifications(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.TableView.cr.endHeaderRefresh()
        }
        NotificationAPI.GetNotifications { (notifications) in
            self.Notifications = notifications
            self.TableView.reloadData()
        }
    }
}


extension NotificationVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Notifications.count == 0{
            return 0
        }
        return Notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationsTableViewCell
        if self.Notifications.count != 0{
            cell.Updatee(notif: self.Notifications[indexPath.row])
        }
        return  cell
    }
    
    
}





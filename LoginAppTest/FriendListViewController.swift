//
//  FriendListViewController.swift
//  LoginAppTest
//
//  Created by Sachin on 2/5/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

import FBSDKLoginKit
class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    var rowsWhichAreChecked = [NSIndexPath]() // it contains all selected row
    // Data model: These strings will be the data for the table view cells
    var friendListArr: [Any] = []
    
    
    // following are the fake user list
    var fakeF1 = [
        "id": "FB",
        "name": "John",
        "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpX6cWSHhI8wk1wMSRZDdzSyPYT6R7AOVUwTQiJIqVSlOtZwx8",
        ]
    
    var fakeF2 = [
        "id": "FB",
        "name": "Andrew",
        "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKoh_wxk-fkGGHm4pP_Mwe6v-P6weOYRpuchqAu0K0VYoDj4AVQg",
        ]
    
    var fakeF3 = [
        "id": "FB",
        "name": "Kate",
        "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg5_WGGYMQ9yAPiLwkW_zR3YFcmo0BIL70GkX4VCU90Pa2Ih2X",
        ]
    
    var fakeF4 = [
        "id": "FB",
        "name": "Monte",
        "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpnuovmIBkLQg-MV19LkwduFk7TmBDBa-0oZFo5FbCym2-eZYo",
        ]
    
    var fakeF5 = [
        "id": "FB",
        "name": "Dean",
        "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMbfJNt9MTVOAbSGh5eK0tiAbhFoxZt7WwZqb27mmv1qcUadYB",
        ]
    
    
    var fakeFriendList:[Any] = []
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.setHidesBackButton(true, animated:true);
        let rightButtonItem = UIBarButtonItem.init(
            title: "Logout",
            style: .done,
            target: self,
            action: #selector(logOutButtonAction)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem // set logout button
        self.fakeFriendList = [fakeF1,fakeF2,fakeF3,fakeF4,fakeF5]
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating()
        // shuff fake array friend list
        //print(self.fakeFriendList)
        self.fakeFriendList.shuffle()
        //print(self.fakeFriendList)
        
        // First you have to check that `user_friends` has associated with your `Access Token`, If you are getting false, please allow allow this field while you login through facebook.
        if FBSDKAccessToken.current().hasGranted("user_friends") {
            
            let params = ["fields": "id, name, email, picture"]
            let fbRequest = FBSDKGraphRequest(graphPath:"/me/taggable_friends?limit=5", parameters: params)
            
            fbRequest?.start(completionHandler: { (connection, result, error) in
                
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                 //Do further work with response
                if error != nil {
                    print(error!)
                }
                else {
                   // print(result!)
                    if let friendObjects = result as? [String:Any] {
                       // print("FB friends",friendObjects);
                     
                        if let fArr = friendObjects["data"] as? [[String:Any]] {
                           self.friendListArr = fArr
                            self.friendListArr.append(contentsOf:self.fakeFriendList)
                            self.friendListArr.shuffle()
                            
                           // print("friendlist==== ",self.friendListArr)
                            self.tableView.reloadData()
                        }
                    }
                }
            })
        }
    }
    
    
    
    @objc func logOutButtonAction(){
        
        FBSDKLoginManager().logOut()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TableView data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.friendListArr.count
        return numberOfRows
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomTableCellTableViewCell!
        
        
        let isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        
        if(isRowChecked == true)
        {
            cell?.chkBox.isChecked = true
            cell?.chkBox.buttonClicked(sender: (cell?.chkBox)!)
        }else{
            cell?.chkBox.isChecked = false
            cell?.chkBox.buttonClicked(sender: (cell?.chkBox)!)
        }
        
        // set the text from the data model
        let dataDict:NSDictionary =  self.friendListArr[indexPath.row] as! NSDictionary
        
         let name = dataDict["name"]! as! String
        let identifier = dataDict["id"] as! String
        var imageName = ""
        if identifier == "FB"{
             imageName = dataDict["url"] as! String
        }else{
            
            let picNameDic = dataDict["picture"] as! NSDictionary
            let imageDataDic = picNameDic["data"] as! NSDictionary
            imageName = imageDataDic["url"] as! String
        }

        let imgUrl = URL(string: imageName)
        let data = try? Data(contentsOf: imgUrl!)
        
        if let imageData = data {
            cell?.imgImageView?.image = UIImage(data: imageData)
        }
        cell?.nameLbl?.text = name
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("You tapped cell number \(indexPath.row).")
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomTableCellTableViewCell!
        
        if(rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
            cell?.chkBox.isChecked = true
            cell?.chkBox.buttonClicked(sender: (cell?.chkBox)!)
            rowsWhichAreChecked.append(indexPath as NSIndexPath)
            self.checkRealFriend()
        }else{
            cell?.chkBox.isChecked = false
            cell?.chkBox.buttonClicked(sender: (cell?.chkBox)!)
            // remove the indexPath from rowsWhichAreCheckedArray
            if let checkedItemIndex = rowsWhichAreChecked.index(of: indexPath as NSIndexPath){
                rowsWhichAreChecked.remove(at: checkedItemIndex)
            }
        }
         tableView .reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func checkRealFriend(){
        
        
        if rowsWhichAreChecked.count > 2{
            
            
            for var i in (0..<rowsWhichAreChecked.count)
            {
              // print("selected row",rowsWhichAreChecked)

                let checkedItemIndex = rowsWhichAreChecked[i].row
                let dict = self.friendListArr[checkedItemIndex] as! NSDictionary;
                let fbId = dict["id"] as! String;
                
                if fbId == "FB"{
                    
                    rowsWhichAreChecked.removeAll()
                    self.friendListArr.shuffle()
                    self.tableView.reloadData()
                    
                    let alert = UIAlertController(title: "Alert", message: "Sorry! You are selected wrong user", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    break;
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Congrates, You are selected your best friends", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

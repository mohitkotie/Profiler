//
//  ViewController.swift
//  Profiler
//
//  Created by mohit kotie on 18/11/17.
//  Copyright © 2017 mohit kotie mohit. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    let results = "SUCCESS"
    var imgUrl = ""
    var firstName = ""
    var lastName = ""
    let myUrl = "https://randomuser.me/api"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func getPersonTapped(_ sender: Any) {
        
        Alamofire.request(myUrl).responseJSON { (response) in
            let result = response.result
            if  self.results == "\(response.result)"{
                
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    if let mydict = (dict["results"]as! NSArray)[0] as? Dictionary<String,AnyObject>{
                        if let name = mydict["name"] as? Dictionary<String,AnyObject>{
                            
                            if let webFirst = name["first"] as? String{
                                self.firstName = webFirst
                            }
                            if let webLast = name["last"] as? String{
                                self.lastName = webLast
                            }
                            self.nameLabel.text = self.firstName + " " + self.lastName
                        }
                        if let email = mydict["email"] as? String{
                            self.emailLabel.text = email
                        }
                        
                        if let phone = mydict["phone"] as? String{
                            self.phoneLabel.text = phone
                        }
                    }
                }
                //                get imageurl
                
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    if let mydict = (dict["results"]as! NSArray)[0] as? Dictionary<String,AnyObject>{
                        if let photo = mydict["picture"] as? Dictionary<String,AnyObject>{
                            if let webPic = photo["large"] as? String{
                                self.imgUrl = webPic
                                print(self.imgUrl)
                            }
                        }
                    }
                }
                
                //             set image
                
                if let url = URL(string: self.imgUrl){
                    if let data = NSData(contentsOf: url){
                        self.imageView.image = UIImage(data: data as Data)
                        self.imageView.backgroundColor = UIColor.clear
                    }
                }
                
            }
            
            
        }
    }
}

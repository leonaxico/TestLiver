//
//  ViewController.swift
//  LiverSearch
//
//  Created by Axel Iván Solano González on 05/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func performSearch(_ sender: Any) {
        var request = URLRequest(url: URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp?search-string=Xbox")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let results:[String:Any]=json["plpResults"] as! [String:Any]
                let products:[Any]=results["records"] as! [Any]
                print(products)
            } catch {
                print("error")
            }
        })

        task.resume()
    }
    
}


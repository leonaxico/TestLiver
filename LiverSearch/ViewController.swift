//
//  ViewController.swift
//  LiverSearch
//
//  Created by Axel Iván Solano González on 05/07/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet weak var collectionProducts: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    var products:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func performSearch(_ sender: Any) {
        let searchParam=self.searchField.text
        var request = URLRequest(url: URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp?search-string=\(searchParam ?? "Xbox")")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type" )
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let results:[String:Any]=json["plpResults"] as! [String:Any]
                self.products=results["records"] as! [[String:Any]]
                print(self.products[1]["productDisplayName"] ?? "not foud")
                DispatchQueue.main.async {
                    self.collectionProducts.reloadData()
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ProductCellView
        print(self.products[indexPath.row]["productDisplayName"])
        cell.setData(
            name: products[indexPath.row]["productDisplayName"] as! String,
            price: products[indexPath.row]["listPrice"] as! Double ,
            imageString: products[indexPath.row]["smImage"] as! String  )
        return cell
    }
    
}


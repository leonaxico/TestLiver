//
//  ViewController.swift
//  LiverSearch
//
//  Created by Axel Iván Solano González on 05/07/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var searchField: UITextField!
    var products:[[String:Any]] = []
    private var productsView:UICollectionView?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.search(keyword: "nintendo")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsView!.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.configure(name: self.products[indexPath.row]["productDisplayName"] as! String,
                       price: self.products[indexPath.row]["listPrice"] as! Double,
                       image: self.products[indexPath.row]["smImage"] as! String )
        return cell
    }
    
    @IBAction func performSearch(_ sender: Any) {
        let searchParam=self.searchField.text ?? "Xbox"
        search(keyword: searchParam)
        productsView?.reloadData()
    }
    
    
    func search(keyword:String) {
        var request = URLRequest(url: URL(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp?search-string=\(keyword)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type" )
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let results:[String:Any]=json["plpResults"] as! [String:Any]
                self.products=results["records"] as! [[String:Any]]
                print(self.products[0]["productDisplayName"] ?? "not foud")
                DispatchQueue.main.async {
                    self.loadProductsView()
                }
            } catch {
                print("error")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func loadProductsView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (Double(view.frame.size.width)/2)-2, height: (Double(view.frame.size.width)/2)-2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        productsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let productsView = productsView else {
            return
        }
        productsView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        productsView.dataSource = self
        productsView.dataSource = self
        view.addSubview(productsView)
        productsView.frame = CGRect(x: 0, y: 0 , width: self.view.frame.width, height: self.view.frame.height * 0.8)
    }
    
}


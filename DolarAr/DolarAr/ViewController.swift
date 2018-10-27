//
//  ViewController.swift
//  DolarAr
//
//  Created by Marcelo Nardone on 17/10/2018.
//  Copyright © 2018 Marcelo Nardone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compraLabel: UILabel!
    
    
    @IBOutlet weak var ventaLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUSSfromWeb(completionHandler: {(compra: String, venta: String) in
            print(compra, venta)
        })
    }
    
    
    func getUSSfromWeb(completionHandler: @escaping (String, String) -> ()){
        let bnaURL = URL(string: "http://www.bna.com.ar")
        guard let url = bnaURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data else { return }
            guard let urlcontent = NSString(data: data , encoding: String.Encoding.utf8.rawValue) else { return }
            
            let aStatusRaw = urlcontent.components(separatedBy: "<td class=\"tit\">Dolar U.S.A</td>\r\n                            <td>")
            let compraArray = aStatusRaw[1].components(separatedBy: "</td>\r\n                            <td>")
            let ventaArray = compraArray[1].components(separatedBy: "</td>")
            
            let compra = compraArray[0]
            let venta = ventaArray[0]
            completionHandler(compra, venta)
            
            
            
            DispatchQueue.main.sync(execute: {
                
                self.compraLabel.text = compra
            })
            
            DispatchQueue.main.sync(execute: {
                
                self.ventaLabel.text = venta
            })
            
            
            
        }
        task.resume()
        
    }


}


//
//  ViewController.swift
//  Weather App Using API
//
//  Created by Reid Kostenuk on 2016-08-01.
//  Copyright © 2016 App Monkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submitButtonPressed(_ sender: AnyObject) {
    
        let city = cityTextField.text!.replacingOccurrences(of: " ", with: "%20")
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city),uk&appid=c3c7ae57f68a0af00690f6628554d1d5") {
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
                if error != nil {
                
                    print(error)
                
                } else {
                
                    if let urlContent = data {
                    
                        do {
                        
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                            print(jsonResult)
                        
                        
                            if let description = (((jsonResult as? NSDictionary)?["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                            
                                print(description)
                                    
                                DispatchQueue.main.sync(execute: {
                                    
                                    self.resultLabel.text = description
                                
                                })
                            
                            }
                        
                        } catch {
                        
                            print("JSON Processing Failed")
                        
                        }
                    
                    }
                
                }
                
            }
        
            task.resume()
        
        } else {
            
            resultLabel.text = "Couldn't find the weather for that city, please try another."
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


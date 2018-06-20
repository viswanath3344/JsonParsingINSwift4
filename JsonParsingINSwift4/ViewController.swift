//
//  ViewController.swift
//  JsonParsingINSwift4
//
//  Created by Ming-En Liu on 20/06/18.
//  Copyright © 2018 Vedas labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    struct WebSiteDescription:Decodable {
        let name:String?
        let description:String?
        let courses: [Courses]
    }
    
    struct Courses:Decodable {
        let id : Int?
        let name: String?
        let link:String?
        //let number_of_lessons: Int?  // With out keyDecodingStrategy
        let numberOfLessons :Int? //with  keyDecodingStrategy = .convertFromSnakeCase  replace _ with Required.
    }
    
    private func loadJsonDataFromUrl()
    {
        let jsonUrl  = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        guard let url  = URL(string: jsonUrl) else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else
            {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase  // replace _
                let webSiteDescriptionObject = try decoder.decode(WebSiteDescription.self, from: data)
                print(webSiteDescriptionObject.courses.last!.numberOfLessons! )
                
            }
            catch let jsonError
            {
                print("JsonParsing Error \(jsonError)")
                
            }
            
        }.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonDataFromUrl()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


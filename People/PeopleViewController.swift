//
//  ViewController.swift
//  People
//
//  Created by munira almallki on 11/03/1443 AH.
//

import UIKit

class PeopleViewController: UITableViewController {
var people = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://swapi.dev/api/people/?format=json")
              
                let session = URLSession.shared
                
                let task = session.dataTask(with: url!, completionHandler: {
                   
                    data, response, error in
                    
                    do {
                        
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            print(jsonResult)
                            if let  results = jsonResult["results"]{
                                let resultArray = results as! NSArray
                                for item in resultArray{
                                    let resultsDictionary  = item as! NSDictionary
                                    self.people.append(resultsDictionary["name"] as! String)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                })
      
        task.resume()

            }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }

}


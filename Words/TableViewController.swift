//
//  TableViewController.swift
//  Words
//
//  Created by Kevin McGill on 6/11/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController, WordDelegate {
    
    var phrases:[Phrase] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //Computed Variable
    var numberOfRowsInSection: Int {
        get { return phrases.count }
    }
    
    @IBAction func pressedRefresh(_ sender: Any) {
        getPhrase()
    }
    
    func getPhrase() {
        Alamofire.request("http://localhost:3000/").responseString { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value ?? "No response")")
            
            self.phrases = [Phrase(response: response.value!)] + self.phrases
        }
    }
    
    


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRowsInSection
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let phrase = phrases[indexPath.row]
        
//        cell.textLabel?.text = phrase.adjective
        cell.textLabel?.text = phrase.pretty

        return cell
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let navvc = segue.destination as? UINavigationController {
            if let vc = navvc.viewControllers.first as? ViewController {
                vc.delegate = self
            }
        }
        
    }
    
    func loadAnother() {
        print("delegate called")
        getPhrase()
    }
 
    
    override func didReceiveMemoryWarning() {
        phrases = []
    }

}

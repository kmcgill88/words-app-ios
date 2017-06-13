//
//  ViewController.swift
//  Words
//
//  Created by Kevin McGill on 6/11/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//

import UIKit
import McPicker
import KMKeys
import Alamofire
import PKHUD

protocol WordDelegate {
    func loadAnother() -> Void
}

class ViewController: UIViewController {
    
    var delegate:WordDelegate?

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pickWordTypeButton: UIButton!
    
    let endpoints = [
        "Adjective":"http://localhost:3000/adjective",
        "Noun":"http://localhost:3000/noun"
    ]
    
    @IBAction func pressedPickWordtype(_ sender: Any) {
        McPicker.show(data: [["Adjective", "Noun"]], doneHandler: { selections in
            if let word = selections[0] {
               self.pickWordTypeButton.setTitle(word, for: .normal)
            }
        })
    }
    
    @IBAction func pressedInputWord(_ sender: Any) {
        KMKeys.show() { text in
            self.wordLabel.text = text
        }
    }

    
    @IBAction func cancelPressed(_ sender: Any) {
        self.delegate?.loadAnother()

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
            if let wordToAdd = self.wordLabel.text {
                let endpoint = self.endpoints[(self.pickWordTypeButton.titleLabel?.text)!]
                
                let parameters: Parameters = ["word": wordToAdd]
                
                Alamofire.request(endpoint!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                    print("Successfully added: \(response.result.isSuccess)")
                    
                    let status = response.result.isSuccess ? HUDContentType.success : HUDContentType.error
                    HUD.flash(status, delay: 1.0)
                } 
            }
        })
    }
}

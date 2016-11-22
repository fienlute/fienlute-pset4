//
//  ViewController.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 20-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private let db = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if db == nil {
            print("Error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addAction(_ sender: Any) {
        do {
            try db!.addAction(task: userInput.text!)
        } catch {
            print(error)
        }
    }
    
}


//
//  ViewController.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 20-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!    
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var addButton: UIButton!
  
    private var NewTodos = [TodoList]()
    private var selectedNewTodo: Int?

    private let db = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if db == nil {
            print("Error")
        }
        
        NewTodos = DatabaseHelper.instance!.getTodo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            selectedNewTodo = indexPath.row
            db!.deleteTodo(cid: NewTodos[selectedNewTodo!].id!)
            NewTodos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    @IBAction func addAction(_ sender: Any) {

        do {
            try db!.addTodo(task: userInput.text!)
            NewTodos = DatabaseHelper.instance!.getTodo()
            tableView.reloadData()
            userInput.text = ""
        } catch {
            print(error)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedNewTodo = indexPath.row
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
    
        var labelTodo: UILabel?
        labelTodo = cell.viewWithTag(1) as? UILabel
        cell.labelTodo?.text = NewTodos[indexPath.row].task
        cell.checkMark.isOn = NewTodos[indexPath.row].check
        return cell
        }

    }


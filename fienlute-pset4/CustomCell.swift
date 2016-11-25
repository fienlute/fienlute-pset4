//
//  CustomCell.swift
//  fienlute-pset4
//
//  Created by Fien Lute on 22-11-16.
//  Copyright © 2016 Fien Lute. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    private let db = DatabaseHelper()
    
    @IBOutlet weak var checkMark: UISwitch!
    @IBOutlet weak var labelTodo: UILabel!
    
  
    @IBAction func actionSwitch(_ sender: Any) {
        try db!.updateSwitch(name: labelTodo.text!, newCheck: checkMark.isOn)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

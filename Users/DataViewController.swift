//
//  DataViewController.swift
//  Users
//
//  Created by Edgar Sargsyan on 20.07.23.
//

import UIKit

class DataViewController: UIViewController {
    @IBOutlet weak var labelString: UILabel!
    var testResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        labelString.text = testResult
    }
}


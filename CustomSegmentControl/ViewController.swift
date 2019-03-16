////
//ViewController.swift
//CustomSegmentControl
//
//Created by Basel Baragabah on 16/03/2019.
//Copyright © 2019 Basel Baragabah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func segmentValueChange(_ sender: CustomSegmentControl) {
        
        
        switch sender.selectedSegmentIndex{
            
            //eraser
        case 0:
            print("Selected Eraser")
            
            //highlighter
        case 1:
            print("Selected Highlighter")
            
            //pencil
        case 2:
            print("Selected Pencil")
            
            //pen
        case 3:
            print("Selected Pen")

        
        default:
            break
        }
        
        
    }
    
}


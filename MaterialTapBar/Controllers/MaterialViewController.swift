//
//  MaterialViewController.swift
//  MaterialTapBar
//
//  Created by Daniel Soto on 9/25/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class MaterialViewController: UIViewController {
    
    @IBInspectable var selectedImage: UIImage? = nil {
        didSet {
            // layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var idleImage: UIImage? = nil {
        didSet {
            // layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var tabTitle: String = "Tab" {
        didSet {
            // layer.cornerRadius = cornerRadius
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

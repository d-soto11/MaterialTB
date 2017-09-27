//
//  MaterialViewSegue.swift
//  MaterialTapBar
//
//  Created by Daniel Soto on 9/25/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class MaterialViewSegue: UIStoryboardSegue {
    override func perform() {
        if let material = source as? MaterialTB, let vc = destination as? MaterialViewController, MaterialTB.tapBarLoaded, let index = Int(identifier!) {
            material.addTapViewController(vc: vc, index: index-1)
        } else {
            print("Error setting view controller from segue. Please check that receiving view controller extends from MaterialViewController.")
        }
    }
}

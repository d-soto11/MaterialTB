//
//  MaterialViewSegue.swift
//  MaterialTapBar
//
//  Created by Daniel Soto on 9/25/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class MaterialViewSegue: UIStoryboardSegue {
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        
        if let material = source as? MaterialTB, let vc = destination as? (MaterialViewController & ReloadableViewController), MaterialTB.tapBarLoaded, let index = Int(identifier!) {
            material.addTapViewController(vc: vc, index: index)
        } else {
            print("Error setting view controller from segue. Check that receiving view controller extends from MaterialViewController and implements ReloadableViewController")
        }
    }
}

//
//  ViewController.swift
//  PaintApp
//
//  Created by Alex Kolovatov on 29/01/2019.
//  Copyright © 2019 Alex Kolovatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(canvas)
        canvas.frame = view.frame
        canvas.backgroundColor = .white
    }


}



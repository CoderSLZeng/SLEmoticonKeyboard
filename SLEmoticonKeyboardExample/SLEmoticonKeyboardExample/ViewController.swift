//
//  ViewController.swift
//  SLEmoticonKeyboardExample
//
//  Created by Anthony on 17/3/17.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private lazy var emoticonVc : EmoticonController = EmoticonController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputView = emoticonVc.view
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        textView.becomeFirstResponder()
    }


}


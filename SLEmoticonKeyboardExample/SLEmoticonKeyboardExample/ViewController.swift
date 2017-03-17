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
    
    private lazy var emoticonVc : EmoticonController = EmoticonController {[weak self] (emoticon) -> () in
        self?.insertEmoticonIntoTextView(emoticon)
    }
    
    private func insertEmoticonIntoTextView(emoticon : Emoticon) {
        // 1.空白表情
        if emoticon.isEmpty {
            return
        }
        
        // 2.删除按钮
        if emoticon.isRemove {
            textView.deleteBackward()
            return
        }
        
        // 3.emoji表情
        if emoticon.emojiCode != nil {
            // 3.1.获取光标所在的位置:UITextRange
            let textRange = textView.selectedTextRange!
            
            // 3.2.替换emoji表情
            textView.replaceRange(textRange, withText: emoticon.emojiCode!)
            
            return
        }
        
        // 4.普通表情:图文混排
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputView = emoticonVc.view
        
        let manager = EmoticonManager()
        
        for package in manager.packages {
            for emoticon in package.emoticons {
                print(emoticon)
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        textView.becomeFirstResponder()
    }


}


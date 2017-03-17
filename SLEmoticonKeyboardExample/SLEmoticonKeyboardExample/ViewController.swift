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
        // 4.1.根据图片路径创建属性字符串
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = textView.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        // 4.2.创建可变的属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 4.3.将图片属性字符串,替换到可变属性字符串的某一个位置
        // 4.3.1.获取光标所在的位置
        let range = textView.selectedRange
        
        // 4.3.2.替换属性字符串
        attrMStr.replaceCharactersInRange(range, withAttributedString: attrImageStr)
        
        // 显示属性字符串
        textView.attributedText = attrMStr
        
        // 将文字的大小重置
        textView.font = font
        
        // 将光标设置回原来位置 + 1
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
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


    @IBAction func sendItemClick(sender: AnyObject) {
        
        // 1.获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: textView.attributedText)
        
        // 2.遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length)
        attrMStr.enumerateAttributesInRange(range, options: []) { (dict, range, _) -> Void in
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                attrMStr.replaceCharactersInRange(range, withString: attachment.chs!)
            }
        }
        
        // 3.获取字符串
        print(attrMStr.string)
    }
}


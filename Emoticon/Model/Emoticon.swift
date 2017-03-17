//
//  Emoticon.swift
//  表情键盘
//
//  Created by Anthony on 17/3/17.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    // MARK:- 定义属性
    var code : String?      // emoji的code
    var png : String?       // 普通表情对应的图片名称
    var chs : String?       // 普通表情对应的文字
    
    // MARK:- 自定义构造函数
    init(dict : [String : String]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description : String {
        return dictionaryWithValuesForKeys(["code", "png", "chs"]).description
    }
}

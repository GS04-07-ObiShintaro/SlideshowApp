//
//  ViewController2.swift
//  SlideshowApp
//
//  Created by 小尾真太郎 on 2016/11/28.
//  Copyright © 2016年 小尾真太郎. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var imageView:UIImageView!
    var imgString = ""
    var imgSoeji = 0
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target:self, action: #selector(ViewController2.back(_:)))
        self.view.addGestureRecognizer(gesture)
        // Screen Size の取得
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        img_display(imgString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //前の画像に戻る関数
    func back(_ sender : AnyObject){
        let storyboard: UIStoryboard = self.storyboard!
        let nowView = storyboard.instantiateViewController(withIdentifier: "now") as! ViewController
        nowView.count = imgSoeji
        self.present(nowView, animated: true, completion: nil)
    }
    
    //画像を表示する関数
    func img_display(_ im : String){
        // UIImage インスタンスの生成
        let image = UIImage(named : im)
        
        // 画像の幅・高さの取得
        width = (image?.size.width)!
        height = (image?.size.height)!
        
        // UIImageView インスタンス生成
        imageView = UIImageView(image:image)
        
        // 画像サイズをスクリーン幅に合わせる
        scale = screenWidth / width
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        
        // 画像の中心をスクリーンの中心位置に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // view に ImageView を追加する
        self.view.addSubview(imageView)
        
        
    }
    
    
}

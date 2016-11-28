
//  SlideshowApp
//
//  Created by 小尾真太郎 on 2016/11/25.
//  Copyright © 2016年 小尾真太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView:UIImageView!
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    var count : Int = 0
    var imgArray = ["shoes.png","chibajazz1.jpg","seo_fes.JPG"]
    // ボタンを3つ生成
    let buttonPlus = UIButton()
    let buttonMinus = UIButton()
    let buttonPlay = UIButton()
    
    //ロード時に呼ぶ関数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Screen Size の取得
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        
        //画像を表示
        img_display(imgArray[count])
        
        //ボタンに丸みをつける
        buttonPlus.layer.cornerRadius = 8.0
        buttonMinus.layer.cornerRadius = 8.0
        buttonPlay.layer.cornerRadius = 8.0
        
        // ボタンの位置とサイズを設定
        buttonPlus.frame = CGRect(x:screenWidth/2 + screenWidth/5, y:screenHeight-50, width:screenWidth/5, height:35)
        buttonMinus.frame = CGRect(x:screenWidth/10, y:screenHeight-50, width:screenWidth/5, height:35)
        buttonPlay.frame = CGRect(x:screenWidth/2 - screenWidth/10, y:screenHeight-50, width:screenWidth/5, height:35)
        
        // ボタンのタイトルを設定
        buttonPlus.setTitle("+", for:UIControlState.normal)
        buttonMinus.setTitle("-", for:UIControlState.normal)
        buttonPlay.setTitle(">", for:UIControlState.normal)
        
        // タイトルの色
        buttonPlus.setTitleColor(UIColor.black, for: .normal)
        buttonMinus.setTitleColor(UIColor.black, for: .normal)
        buttonPlay.setTitleColor(UIColor.black, for: .normal)
        
        // 背景色
        buttonPlus.backgroundColor = UIColor.white
        buttonMinus.backgroundColor = UIColor.white
        buttonPlay.backgroundColor = UIColor.white
        
        // タップされたときのaction
        buttonPlus.addTarget(self, action: #selector(ViewController.plus(sender:)), for: .touchUpInside)
        buttonMinus.addTarget(self, action: #selector(ViewController.minus(sender:)), for: .touchUpInside)
        buttonPlay.addTarget(self, action: #selector(ViewController.slide_play(sender:)), for: .touchUpInside)
        
        // Viewにボタンを追加
        self.view.addSubview(buttonPlus)
        self.view.addSubview(buttonMinus)
        self.view.addSubview(buttonPlay)
        
        // 画面背景を明るいグレーに設定
        self.view.backgroundColor = UIColor.lightGray
        
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
        scale *= 0.8
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        
        // 画像の中心をスクリーンの中心位置に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        //画面タッチ
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target:self, action: #selector(ViewController.next(_:)))
        imageView.addGestureRecognizer(gesture)
        
        // view に ImageView を追加する
        self.view.addSubview(imageView)
        
        
    }
    
    //画像タッチ時に呼び出す関数
    func next(_ sender : UITapGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "next") as! ViewController2
        nextView.imgString = imgArray[count]
        nextView.imgSoeji = count
        self.present(nextView, animated: true, completion: nil)
    }
    
    // プラスボタンに対応する関数
    @IBAction func plus(sender: AnyObject) {
        imageView.removeFromSuperview()
        switch count {
        case 0 : img_display(imgArray[1])
        count = 1
        case 1 : img_display(imgArray[2])
        count = 2
        case 2 : img_display(imgArray[0])
        count = 0
        default : break
            
        }
    }
    
    
    // マイナスボタンに対応する関数
    @IBAction func minus(sender: AnyObject) {
        imageView.removeFromSuperview()
        switch count {
        case 0 : img_display(imgArray[2])
        count = 2
        case 2 : img_display(imgArray[1])
        count = 1
        case 1 : img_display(imgArray[0])
        count = 0
        default : break
            
        }
    }
    //スライドショーボタンに対応する関数
    var timer: Timer!
    var i : Int = 0
    @IBAction func slide_play(sender: AnyObject)
    {
        if(i == 0)
        {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onUpdate(_:)), userInfo: nil, repeats: true)
            buttonPlay.setTitle("||", for:UIControlState.normal)
            
            buttonPlus.isEnabled = false
            buttonMinus.isEnabled = false
            buttonPlus.setTitleColor(UIColor.gray, for: .normal)
            buttonMinus.setTitleColor(UIColor.gray, for: .normal)
            buttonPlus.backgroundColor = UIColor(red:1,green:1,blue:1,alpha:0.5)
            buttonMinus.backgroundColor = UIColor(red:1,green:1,blue:1,alpha:0.5)
            i = 1
        }
        else
        {
            timer.invalidate()
            buttonPlay.setTitle(">", for:UIControlState.normal)
            
            buttonPlus.isEnabled = true
            buttonMinus.isEnabled = true
            buttonPlus.setTitleColor(UIColor.black, for: .normal)
            buttonMinus.setTitleColor(UIColor.black, for: .normal)
            buttonPlus.backgroundColor = UIColor.white
            buttonMinus.backgroundColor = UIColor.white
            i = 0
        }
    }
    //Timer用の関数
    func onUpdate(_ timer : Timer){
        plus(sender : count as AnyObject)
    }
    
    //didReceibeMemoriyWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



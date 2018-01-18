//
//  ViewController.swift
//  swift 学习第9天
//
//  Created by kys-39 on 2018/1/15.
//  Copyright © 2018年 kys-39. All rights reserved.
//

import UIKit
//继承自videoBGViewController
class ViewController: VideoBgViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
        
        //在沙盒中寻找视频位置
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        //设置
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound =  true
        startTime = 2.0
        alpha = 0.8
        contentURL = url
        //交互关闭
        view.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //设置button
    func setUpUI()
    {
        let logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400*pix, height: 130*pix))
        logoImage.center = CGPoint(x: 375*pix, y: 300*pix)
        logoImage.image = UIImage(named: "login-secondary-logo")
        view.addSubview(logoImage)
        
        let loginBtn = UIButton(frame: CGRect(x: 40*pix, y: HEIGHT - 300*pix, width: WIDTH-80*pix, height: 80*pix))
        loginBtn.backgroundColor = UIColor.green
        loginBtn.setTitle("login", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.layer.cornerRadius = 3
        loginBtn.clipsToBounds = true
        view.addSubview(loginBtn)
        
        let signBtn = UIButton(frame: CGRect(x: 40*pix, y: HEIGHT - 180*pix, width: WIDTH-80*pix, height: 80*pix))
        signBtn.backgroundColor = UIColor.white
        signBtn.setTitleColor(UIColor.green, for: .normal)
        signBtn.setTitle("sign", for: .normal)
        signBtn.layer.cornerRadius = 3
        signBtn.clipsToBounds = true
        self.view.addSubview(signBtn)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


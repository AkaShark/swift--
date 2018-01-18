//
//  VideoBgViewController.swift
//  swift 学习第9天
//  Created by kys-39 on 2018/1/16.
//  Copyright © 2018年 kys-39. All rights reserved.
import UIKit
import AVKit
import MediaPlayer

//定义枚举类型 比例模式
public enum ScalingMode
{
    case resize
    case resizeAspect
    case resizeAspectFill
}
class VideoBgViewController: UIViewController {
    //文件内私有属性
    fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel = 1.0
    
    open var videoFrame: CGRect = CGRect()
    open var startTime: CGFloat = 0.0
    open var duration: CGFloat = 0.0
    open var sound: Bool = true{
        didSet{
            if sound {
                moviePlayerSoundLevel = 1.0
            }
            else
            {
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    open var alpha: CGFloat = 1.0{
        didSet
        {
            moviePlayer.view.alpha = alpha
        }
    }
    
    open var fillMode: ScalingMode = .resizeAspectFill{
        didSet
        {
            /*
             第1种模式AVLayerVideoGravityResizeAspect是按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑；
             第2种AVLayerVideoGravityResizeAspectFill是以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了；
             第3种AVLayerVideoGravityResize是拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了。
             */
            //选定videoGravity的模式
            switch fillMode
            {
            case .resize:
                moviePlayer.videoGravity = AVLayerVideoGravity.resize.rawValue
            case.resizeAspect:
               moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspect.rawValue
            case .resizeAspectFill:
                moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
            }
        }
    }
    //设置是否重复播放
    open var  alwaysRepeat: Bool = true
    {
        didSet
        {
            if alwaysRepeat {
                //添加一个监听 监听结束时
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
                
            }
        }
    }
    //监听到结束时执行的方法
  @objc func playerItemDidReachEnd()
    {
        //设置播放时间是零 从头播放
        moviePlayer.player?.seek(to: kCMTimeZero)
        moviePlayer.player?.play()
    }
    
    open var contentURL: URL = URL(string: "1")!{
        didSet{
            setMoviePlayerView(contentURL)
        }
    }
    fileprivate func setMoviePlayerView(_ url:URL){
       let videoCutter = VideoCutter()
        videoCutter.compressVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (path, error) in
            if let videoPath = path as URL?{
                self.moviePlayer.player = AVPlayer(url: videoPath)
                self.moviePlayer.player?.play()
                //设置player的音量为 将self.moviePlayerSoundLevel转为float类型
                self.moviePlayer.player?.volume = Float(self.moviePlayerSoundLevel)
            }
        }
        
    }
    //生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePlayer.view.frame  = view.frame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        //将moviePlayer.view放在最后
        view.sendSubview(toBack: moviePlayer.view)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

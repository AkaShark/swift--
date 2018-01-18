//
//  VideoCutter.swift
//  swift 学习第9天
//
//  Created by kys-39 on 2018/1/16.
//  Copyright © 2018年 kys-39. All rights reserved.
//
// 存在在子线程修改UI的动作
import UIKit
import AVFoundation
//对于字符串的拓展
extension String{
    var convert: String{
        return (self as String)
    }
}

/// 处理视频的类
class VideoCutter: NSObject
{

    //可以在文件外重写 但是这里没有必要外面并没有重写他只是访问了
    
    /// 压缩视频
    ///
    /// - Parameters:
    ///   - url: 视频的地址
    ///   - startTime: 开始的时间 
    ///   - duration: 持续时间
    ///   - completion: 完成后的回调
    open  func  compressVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion: ((_ videoPath:URL, _  error: NSError?)->Void)? ){
    DispatchQueue.global().async {
        //获取多媒体的信息
        let asset = AVURLAsset(url:url)
        //AVAssetExportPresetHighestQuality   压缩的质量 压缩视频
        let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
        //获取沙盒路径
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        //获取路径
        var outputUrl = paths.object(at: 0) as! String
        //定义文件管理
        let manager = FileManager.default
        //获取完整的视频路径
        outputUrl = outputUrl.convert.appending("/output.mp4")
        do
        {
            //将原文件删除
            try manager.removeItem(atPath: outputUrl)
        }
        catch _
        {
            
        }
        //如果原文件删除了
        if !manager.fileExists(atPath: outputUrl)
        {
            if let exportSession = exportSession as AVAssetExportSession?{
                //将压缩的视频文件存到原目录下
                exportSession.outputURL = URL(fileURLWithPath: outputUrl)
                //进行优化网络使用 方便快速启动 快速启动
                exportSession.shouldOptimizeForNetworkUse = true
                
                //导出类型
                exportSession.outputFileType = AVFileType.mp4
                //CMTimeMakeWithSeconds(a,b) a当前时间，b每秒钟多少帧
                //CMTimeMakeWithSeconds 专门是为视频设计的时间
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                print(duration)
                let range = CMTimeRangeMake(start,duration)
                exportSession.timeRange = range
//                异步导出
                exportSession.exportAsynchronously
                    {
                        //导出的状态
                    switch exportSession.status{
                        //完成
                    case AVAssetExportSessionStatus.completed:
                        completion?(exportSession.outputURL!, nil)
                        //失败
                    case AVAssetExportSessionStatus.failed:
                        print("Failed: \(exportSession.error)")
//                    取消
                    case
                    AVAssetExportSessionStatus.cancelled:
                        print("Failed:\(exportSession.error)")
                    default:
                        print("default case")
                    }
                    
                }
            }
        }
    
    }
    
    }
}

//
//  SHYUIKit.swift
//  ClockPro
//
//  Created by MrSui on 2020/10/22.
//


import Foundation
import UIKit


//OC 菊花
class ActivityView : UIViewController {

    var activityView = UIActivityIndicatorView()
    var vc = UIApplication.shared.windows.last?.rootViewController
    @objc func start(){
        
        activityView.center = vc?.view.center ?? CGPoint(x: 0, y: 0)
        // 停止后，隐藏菊花
        activityView.hidesWhenStopped = true
        //Style: whiteLarge比较大的白色环形进度条;white白色环形进度条;gray灰色环形进度条
        activityView.style = UIActivityIndicatorView.Style.large
        vc?.view.addSubview(self.activityView)
        activityView.startAnimating()
    }
    @objc  func stop(){
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
   
}

//OC 系统分享功能
class ActivityViewController : UIViewController {

    var uiImage:UIImage!

    @objc func shareImage() {
        let vc = UIActivityViewController(activityItems: [uiImage!], applicationActivities: [])
        vc.excludedActivityTypes =  [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
//        present(vc, animated: true,completion: nil)
//        vc.popoverPresentationController?.sourceView = self.view

        let viewCon = (UIApplication.shared.windows.first?.rootViewController)!
        viewCon.present(vc, animated: true, completion: nil)
    }
}


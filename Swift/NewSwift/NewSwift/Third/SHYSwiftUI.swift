//
//  SHYSwiftUI.swift
//  ClockPro
//
//  Created by MrSui on 2020/10/22.
//

import SwiftUI
import Foundation

//Swift 导航页面 配置信息
struct SwiftNavigationConfigure : UIViewControllerRepresentable {
    var configure : (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SwiftNavigationConfigure>) -> UIViewController {
        return UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SwiftNavigationConfigure>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}
struct DemoSwiftNavigationView : View {
    var body: some View {
        NavigationView(){
            List(){
                ForEach(0..<5){ index in
                    Text("第\(index)行")
                        .listRowBackground(Color.red)
                }
            }
            .navigationBarTitle(Text("NavigationConfigure"))
            .background( SwiftNavigationConfigure { vc in
                vc.navigationBar.barTintColor = .blue
                vc.navigationBar.backgroundColor = UIColor.yellow
                vc.navigationBar.titleTextAttributes =  [.foregroundColor:UIColor.red , .backgroundColor:UIColor.blue]
                vc.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.red , .backgroundColor:UIColor.blue]
            })
        }
    }
}

//Swift->UI 菊花
struct SwiftActivityView : UIViewControllerRepresentable {
    
    let activityView = ActivityView()
    
    func makeUIViewController(context: Context) -> ActivityView {
        activityView
    }
    func updateUIViewController(_ uiViewController: ActivityView, context: Context) {
        
    }
    func start() {
        activityView.start()
    }
    func stop() {
        activityView.stop()
    }
}
//Swift->UI 系统分享
struct SwiftUIActivityViewController : UIViewControllerRepresentable {
    
    let activityViewController = ActivityViewController()
    
    func makeUIViewController(context: Context) -> ActivityViewController {
        activityViewController
    }
    func updateUIViewController(_ uiViewController: ActivityViewController, context: Context) {
        //
    }
    func shareImage(uiImage: UIImage) {
        activityViewController.uiImage = uiImage
        activityViewController.shareImage()
    }
}

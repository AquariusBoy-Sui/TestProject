//
//  SHYPulic.swift
//  SuiDemo
//
//  Created by MrSui on 2020/10/13.
//

import Foundation
import SwiftUI
import UIKit

import WidgetKit

import CoreImage
import CoreImage.CIFilterBuiltins


let SHYScreen_W = UIScreen.main.bounds.size.width
let SHYScreen_H = UIScreen.main.bounds.size.height
let centSpace = SHYScreen_W/100

struct SHYPulic   {
    
    static func Log(string: String) {
        print("shyLog:\(string)")
    }
    // 通知小组件 重置 时间轴数据
    static  func reloadWidgetAllTimelines() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    // 十六进制颜色  转 UIColor
    static  func RGBColor(rgbValue:UInt) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0, blue:   CGFloat(rgbValue & 0xFF) / 255.0, alpha: 1)
    }
    
    
    static func stSecondsToHourMin(dbSeconds:Double)->String {
        var stHours = ""
        if dbSeconds >= 3600 {
            stHours = "\(Int(dbSeconds/(60*60)))小时"
        }
        
        var stMins = ""
        if Int(dbSeconds) % 3600 > 60 {
            stMins = "\(Int(Int(dbSeconds) % 3600 / 60))分钟"
        }
        return "\(stHours)\(stMins)"
    }
    
    // 修改图片颜色
    static func loadImage(image : String,color : UIColor) -> Image {
        let uiimage = UIImage(named: image)?.imageWithTintColor(color: color,blendMode: CGBlendMode.destinationIn)
        
        guard let inputImage = uiimage else { return Image(image) }
        // 将UIImage转换为CIImage
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 0
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return Image(image) }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            // and convert that to a SwiftUI image
            return Image(uiImage: uiImage)
        }
        return Image(image)
    }
    // 图片模糊效果
    static func loadGaussianBlurImage(image : String,inputRadius:Int) -> Image {
        let uiimage = UIImage(named: image)
        guard let inputImage = uiimage else { return Image(image) }
        // 将UIImage转换为CIImage
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = CIFilter.gaussianBlur()
        currentFilter.setValue(beginImage, forKey:kCIInputImageKey)
        currentFilter.setValue(inputRadius, forKey: kCIInputRadiusKey)
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return Image(image) }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            // and convert that to a SwiftUI image
            return Image(uiImage: uiImage)
        }
        return Image(image)
    }
    static func stDateString(_ dt:Date,stFormat:String)->String {
        let convert = DateFormatter()
        convert.dateFormat = stFormat
        let st = convert.string(from: dt)
        return st
    }
    
    static func stSubString(_ stOrigin:String , itFrom:Int , itTo:Int)->String {
        let indexFrom = stOrigin.index(stOrigin.startIndex, offsetBy: itFrom)
        let indexTo = stOrigin.index(stOrigin.startIndex, offsetBy:itTo)
        
        let stRt = "\(stOrigin[indexFrom..<indexTo])"
        return stRt
    }
    
    static func dateFromISOString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone.local
        let string2 = SHYPulic.stSubString(string , itFrom: 0, itTo: 18)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.date(from: string2)! as Date
    }
    static func stDateString(_ dt:Date)->String {
        let convert = DateFormatter()
        convert.dateFormat = "yyyy-MM-dd"
        let st = convert.string(from: dt)
        return st
    }
    static func stDateYMDHString(_ dt:Date)->String {
        let convert = DateFormatter()
        convert.dateFormat = "yyyy-MM-dd'T'HH:"
        let st = convert.string(from: dt)
        return st
    }
    static func loadGaussianBlurImage(image : String) -> Image {
        let uiimage = UIImage(named: image)?.imageWithGaussianBlur(blendMode: CGBlendMode.destinationIn)
        
        guard let inputImage = uiimage else { return Image(image) }
        // 将UIImage转换为CIImage
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 0
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return Image(image) }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            // and convert that to a SwiftUI image
            return Image(uiImage: uiImage)
        }
        return Image(image)
    }
    
    static func unbackground() -> Color{
        return Color("unbackground")
    }
    
    static func background() -> Color{
        return Color("background")
    }
    static func textColor() -> Color{
        return Color("textColor")
    }
    static func untextColor() -> Color{
        return Color("untextColor")
    }
    
}


extension Date {
    
    static func getCurrDateStr(date : Date,valueFormatter : NSString) -> String {
        let formatter=DateFormatter()
        formatter.dateStyle=DateFormatter.Style.full
        
        formatter.dateFormat="\(valueFormatter)"
        return formatter.string(from: date)
        
        
    }
    
    static func getHMS (component: Calendar.Component,  date: Date) -> Int {
        let calendar = Calendar.current
        let time = calendar.component(component, from: date)
        return time
        
    }
    
    
    
}

extension UIImage {
    public  func imageWithTintColor(color : UIColor,blendMode : CGBlendMode) ->UIImage{
        
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x:0, y:0, width:self.size.width, height:self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode:blendMode, alpha:1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
    
    
    public func imageWithGaussianBlur(blendMode : CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let bounds = CGRect.init(x:0, y:0, width:self.size.width, height:self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode:blendMode, alpha:1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        let  filter  =  CIFilter (name:  "CIGaussianBlur" )!
        filter.setValue(tintedImage, forKey:kCIInputImageKey)
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}

//-------------SHYBlock----

typealias ResBlock = ()->Void
class SHYBlock{
    // 请求闭包函数
    var resBlock:ResBlock?
    // TODO:初始化赋值,在A类中调用此方法赋值
    public func getResBlock(Block:ResBlock?){
        self.resBlock = Block
    }
    func setResBlock(){
        if(resBlock != nil){
            // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
            resBlock!()
        }
    }
}




//三角形
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

//弧形
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}
// 圆角
struct RoundedCorner: Shape {
    
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

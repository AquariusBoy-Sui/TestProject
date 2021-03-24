//
//  LHKit.swift
//  Estate
//
//  Created by cyz on 15/10/19.
//  Copyright (c) 2015年 cyz. All rights reserved.
//

import UIKit

class LHKit {
    
    static func stSecondsToHourMin(dbSeconds:Double)->String {
        var stHours = ""
        if dbSeconds >= 3600 {
            stHours = "\(Int(dbSeconds/(60*60)))小时"
        }
        
        var stMins = ""
        if Int(dbSeconds) % 3600 > 0 {
            stMins = "\(Int(Int(dbSeconds) % 3600 / 60))分钟"
        }
        if dbSeconds == 0  {
            stMins = "0分钟"
        }
        
        return "\(stHours)\(stMins)"
    }
    
    static func stDecimal(_ dbNumber:Double , itLong: Int)->String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.minimumFractionDigits = itLong
        let a1  = format.string(from: dbNumber as NSNumber )
        return a1!
    }
    static func isTimePassed(_ stTimeISOString:String)->Bool {
        return Date.init() > NSDate.dateFromISOString(string: stTimeISOString) as Date
    }
    
//    static func cellCheck(_ cell:UITableViewCell! , index:Int)->UITableViewCell {
//        var rtCell:UITableViewCell!
//        rtCell = cell
//        if rtCell == nil {
//            rtCell = UITableViewCell()
//            rtCell.backgroundColor = SHYMusic.ArClYellowRaw[index % 5 ]
//        }
//        return rtCell
//    }
//
//    static func cellCheck(_ cell:UITableViewCell! , ip:IndexPath)->UITableViewCell {
//        var rtCell:UITableViewCell!
//        rtCell = cell
//        if rtCell == nil {
//            rtCell = UITableViewCell()
//            rtCell.backgroundColor = SHYMusic.ArClYellowRaw[(ip.section + ip.row) % 5 ]
//        }
//        return rtCell
//    }
    
    static func stDealRidRest(_ st:String , itLength:Int)->String {
        let endindex = st.index(st.endIndex, offsetBy: -1*itLength )
        return  String(st[..<endindex])
    }
    
    static func stDealLast(_ st:String , itLength:Int)->String {
        return String( st.suffix(itLength))
    }
    static func statusBarBackgroundColor(_ color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    //    static func imgViewLoadNetPic(_ imageView:UIImageView, str:String? ) {
    //        //print("->>>>\(str!)")
    //        //        DispatchQueue.global().async {
    //        //            // 子线程下载数据
    //        //            let url = URL(string: str!)
    //        //            var data: Data?
    //        //            var image:UIImage?
    //        //            if url != nil {
    //        //                do {
    //        //                    data =  try Data(contentsOf: url!)
    //        //                } catch {
    //        //                    print("图不对!~~>\(String(describing: url))")
    //        //                    image = UIImage (named: "p0picerror.png")
    //        //                }
    //        //            }
    //        //            if data != nil {
    //        //                image = UIImage(data: data!)
    //        //            }
    //        //            DispatchQueue.main.async(execute: {
    //        //                if image != nil {
    //        //                    imageView.image = image;
    //        //                }
    //        //            })
    //        //        }
    //        //170502 大改!采用缓存技术.
    //        imageView.kf.setImage(with: URL.init(string: str!))
    //    }
    //
    //    static func imgViewLoadNetPic(_ imageView:UIImageView, str:String? , placeHold:UIImage ) {
    //        //imageView.kf.setImage(with: URL.init(string: str!))
    //        imageView.kf.setImage(with: URL.init(string: str!), placeholder: placeHold, options: nil, progressBlock: nil, completionHandler: nil )
    //    }
    //
    //    static func imgViewLoadNetPic(_ imageView:UIImageView, str:String?, contentMode: UIView.ContentMode ,itNumber:Int, overDoSt: ((String )->())? ) {
    //
    //        func haha(_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> () {
    //            overDoSt!(str!)
    //        }
    //
    //        imageView.kf.setImage(with: URL.init(string: str!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: haha )
    //
    //
    //    }
    
    //    static func applyRichText(lb:UILabel, flSize:CGFloat?,stAndCl:[(String,UIColor)]) {
    //        if flSize != nil {
    //            changFontSize(lb, fixedSize: flSize!)
    //        }
    //        var richText = "".lhColored(with: UIColor.white)
    //        
    //        func RichTextRest(ar:[(String,UIColor)])->NSAttributedString {
    //            var tempRichText: NSMutableAttributedString
    //            tempRichText = "".lhColored(with: UIColor.white)
    //            var arIn: [(String,UIColor)] = ar
    //            if (arIn.count == 1) {
    //                tempRichText.append( arIn[0].0.lhColored(with: arIn[0].1) )
    //            } else {
    //                tempRichText.append( arIn[0].0.lhColored(with: arIn[0].1) )
    //                arIn.removeFirst()
    //                tempRichText .append( RichTextRest(ar: arIn) )
    //            }
    //            return tempRichText
    //        }
    //        richText.append ( RichTextRest(ar: stAndCl) )
    //        lb.attributedText = richText
    //    }
    
    static func stDateString(_ dt:Date,stFormat:String)->String {
        let convert = DateFormatter()
        convert.dateFormat = stFormat
        let st = convert.string(from: dt)
        return st
    }
    static func stDateString(_ dt:Date)->String {
        let convert = DateFormatter()
        convert.dateFormat = "yyyy-MM-dd"
        let st = convert.string(from: dt)
        return st
    }
    
    static func stDateStringDayOver(_ dt:Date)->String {
        let convert = DateFormatter()
        convert.dateFormat = "yyyy-MM-dd"
        let st = convert.string(from: dt)
        return st + " 23:59:59"
    }
    
    
    static func stSubString(_ stOrigin:String , itFrom:Int , itTo:Int)->String {
        let indexFrom = stOrigin.index(stOrigin.startIndex, offsetBy: itFrom)
        let indexTo = stOrigin.index(stOrigin.startIndex, offsetBy:itTo)
        
        let stRt = "\(stOrigin[indexFrom..<indexTo])"
        return stRt
    }
    
    static func flCellExtraSize(_ flText:String, flFontSize:CGFloat, flLabelWide:CGFloat)->CGFloat {
        let lb = UILabel()
        lb.frame = CGRect(x: 0, y: 0, width: flLabelWide, height: 0)
        
        changFontSize(lb, fixedSize: flFontSize)
        lb.numberOfLines = 0
        lb.text = flText
        lb.sizeToFit()
        
        var flExtra = lb.bounds.size.height
        
        if flExtra < flFontSize {
            flExtra = flFontSize
        }
        return flExtra
    }
    
    static func reSizeImageView(_ ivPic:UIImageView ,szSize:CGSize )  {
        UIGraphicsBeginImageContextWithOptions( szSize , false, UIScreen.main.scale)
        let  imageRect:CGRect = CGRect.init(x: 0, y: 0, width: szSize.width, height: szSize.height)
        ivPic.image?.draw(in: imageRect)
        ivPic.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
    }
    
    
    static func popSheet(_ vc:UIViewController ,title:String?,Msg:String?,buttonTitle:[String], doSomethings:[((UIAlertAction)->())?] ){
        var nowTitle:String = "选择"
        var nowMSG:String = "选择内容"
        if (title != nil) {
            nowTitle = title!
        }
        if (Msg != nil) {
            nowMSG = Msg!
        }
        
        let alertConfirm = UIAlertController(title: nowTitle, message: nowMSG, preferredStyle: UIAlertController.Style.actionSheet)
        for (i,temp) in buttonTitle.enumerated() {
            var tempAction:UIAlertAction!
            if temp == "取消" {
                tempAction = UIAlertAction(title: temp, style: UIAlertAction.Style.cancel, handler: doSomethings[i])
            } else {
                tempAction = UIAlertAction(title: temp, style: UIAlertAction.Style.default, handler: doSomethings[i])
            }
            alertConfirm.addAction(tempAction)
        }
        vc.present(alertConfirm, animated: true, completion: nil)
    }
    
    static func createLhRtCell (Cell:UITableViewCell , itView:Int, itImg:Int,itLabel:Int)->([UIView],[UIImageView],[UILabel]) {
        
        let cent = UIScreen.main.bounds.width/100
        var arVwView1 = [UIView]()
        for index in 100..<(100+itView) {
            let vwTemp = UIView(frame: CGRect(x: cent*0, y: cent*0, width: cent*0, height: cent*0))
            vwTemp.tag = index
            arVwView1.append(vwTemp)
            Cell.contentView.addSubview(vwTemp)
        }
        
        var arImg2 = [UIImageView]()
        for index in 200..<(200+itImg) {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            img.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arImg2.append(img)
            Cell.contentView.addSubview(img)
        }
        
        var arLabel3 = [UILabel]()
        for index in 300..<(300+itLabel) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            label.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arLabel3.append(label)
            Cell.contentView.addSubview(label)
        }
        return (arVwView1,arImg2,arLabel3)
    }
    
    static func createLhRtCell (Cell:UITableViewCell , itView:Int, itImg:Int,itLabel:Int , itButton:Int)->([UIView],[UIImageView],[UILabel],[UIButton]) {
        
        let cent = UIScreen.main.bounds.width/100
        var arVwView1 = [UIView]()
        for index in 100..<(100+itView) {
            let vwTemp = UIView(frame: CGRect(x: cent*0, y: cent*0, width: cent*0, height: cent*0))
            vwTemp.tag = index
            arVwView1.append(vwTemp)
            Cell.contentView.addSubview(vwTemp)
        }
        
        var arImg2 = [UIImageView]()
        for index in 200..<(200+itImg) {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            img.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arImg2.append(img)
            Cell.contentView.addSubview(img)
        }
        
        var arLabel3 = [UILabel]()
        for index in 300..<(300+itLabel) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            label.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arLabel3.append(label)
            Cell.contentView.addSubview(label)
        }
        
        var arButton = [UIButton]()
        for index in 400..<(400+itButton) {
            let label = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            label.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arButton.append(label)
            Cell.contentView.addSubview(label)
        }
        
        return (arVwView1,arImg2,arLabel3,arButton)
    }
    
    
    
    //    static func getLhRtcellViews(Cell:UITableViewCell,itView:Int,itImg:Int,itLabel:Int ) -> ([UIView],[UIImageView],[UILabel]) {
    //        let ar1 = arVwCellViewsWithRange(Cell, rg: 100...100+itView)
    //        let ar2 = arVwCellViewsWithRange(Cell, rg: 200...200+itImg ) as! [UIImageView]
    //        let ar3 = arVwCellViewsWithRange(Cell, rg: 300...300+itLabel) as! [UILabel]
    //        
    //        return (ar1,ar2, ar3 )
    //    }
    
    static func getLhRtcellViews(Cell:UITableViewCell,itView:Int,itImg:Int,itLabel:Int, itButton:Int ) -> ([UIView],[UIImageView],[UILabel],[UIButton]) {
        let ar1 = arVwCellViewsWithRange(Cell, rg: 100...100+itView)
        let ar2 = arVwCellViewsWithRange(Cell, rg: 200...200+itImg ) as! [UIImageView]
        let ar3 = arVwCellViewsWithRange(Cell, rg: 300...300+itLabel) as! [UILabel]
        let ar4 = arVwCellViewsWithRange(Cell, rg: 400...400+itButton) as! [UIButton]
        
        
        return (ar1,ar2, ar3,ar4 )
    }
    
    static func getLhRtcellViews(Cell:UICollectionViewCell ,itView:Int,itImg:Int,itLabel:Int, itButton:Int ) -> ([UIView],[UIImageView],[UILabel],[UIButton]) {
        let ar1 = arVwCellViewsWithRange(Cell, rg: 100...100+itView)
        let ar2 = arVwCellViewsWithRange(Cell, rg: 200...200+itImg ) as! [UIImageView]
        let ar3 = arVwCellViewsWithRange(Cell, rg: 300...300+itLabel) as! [UILabel]
        let ar4 = arVwCellViewsWithRange(Cell, rg: 400...400+itButton) as! [UIButton]
        
        
        return (ar1,ar2, ar3,ar4 )
    }
    
    static func createLhRtCell (Cell:UICollectionViewCell , itView:Int, itImg:Int,itLabel:Int , itButton:Int)->([UIView],[UIImageView],[UILabel],[UIButton]) {
        
        let cent = UIScreen.main.bounds.width/100
        var arVwView1 = [UIView]()
        for index in 100..<(100+itView) {
            let vwTemp = UIView(frame: CGRect(x: cent*0, y: cent*0, width: cent*0, height: cent*0))
            vwTemp.tag = index
            arVwView1.append(vwTemp)
            Cell.contentView.addSubview(vwTemp)
        }
        
        var arImg2 = [UIImageView]()
        for index in 200..<(200+itImg) {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            img.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arImg2.append(img)
            Cell.contentView.addSubview(img)
        }
        
        var arLabel3 = [UILabel]()
        for index in 300..<(300+itLabel) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            label.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arLabel3.append(label)
            Cell.contentView.addSubview(label)
        }
        
        var arButton = [UIButton]()
        for index in 400..<(400+itButton) {
            let label = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0) )
            label.tag = index
            //label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            arButton.append(label)
            Cell.contentView.addSubview(label)
        }
        
        return (arVwView1,arImg2,arLabel3,arButton)
    }
    
    
    
    static func getLhRtcellViews(Cell:UITableViewCell ) -> ([UIView],[UIImageView],[UILabel],[UIButton]) {
        let rs = getLhRtcellViews(Cell: Cell, itView: 99, itImg: 99, itLabel: 99 , itButton:99)
        
        return (rs.0,rs.1, rs.2 , rs.3)
    }
    
    // swifterSwift
    
    
    static let screenBounds = UIScreen.main.bounds
    static let centSpace = screenBounds.width/100
    
    
    static func imfixOrientation(_ aImage:UIImage)->UIImage {
        if (aImage.imageOrientation == .up) {
            return aImage;
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform:CGAffineTransform  = CGAffineTransform.identity;
        
        switch (aImage.imageOrientation) {
        case .down,.downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height);
            transform = transform.rotated(by: CGFloat(Double.pi));
            break;
            
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(Double.pi/2));
            break;
            
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi/2));
            break;
        default:
            break
        }
        
        switch (aImage.imageOrientation) {
        case .upMirrored , .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            break;
            
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            break;
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx:CGContext  = CGContext(data: nil ,width: Int(aImage.size.width), height: Int(aImage.size.height), bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0, space: aImage.cgImage!.colorSpace!,bitmapInfo: (aImage.cgImage!.bitmapInfo).rawValue)!;
        
        ctx.concatenate(transform);
        switch (aImage.imageOrientation) {
        case .left,.leftMirrored,.right,.rightMirrored:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0,y: 0,width: aImage.size.height,height: aImage.size.width));
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0,y: 0,width: aImage.size.width,height: aImage.size.height));
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg:CGImage  = ctx.makeImage()!;
        let img: UIImage  = UIImage(cgImage: cgimg)
        return img;
    }
    
    
    static func rectMk(_ x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat)->CGRect {
        return CGRect(x: x*centSpace , y: y*centSpace, width: width*centSpace, height: height*centSpace)
    }
    
    static func rectMkST(_ x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,vc:UIViewController)->CGRect {
        return CGRect(x: x*centSpace , y: y*centSpace + stateNavSpace(vc), width: width*centSpace, height: height*centSpace)
    }
    
    
    static func imgViewLoadNetPic(_ imageView:UIImageView, str:String?, contentMode: UIView.ContentMode ,itNumber:Int, overDo: ((CGFloat,CGFloat,Int)->())? ) {
        //print("->>>>\(str!)")
        DispatchQueue.global().async {
            // 子线程下载数据
            let url = URL(string: str!)
            var data: Data?
            var image:UIImage?
            if url != nil {
                do {
                    data =  try Data(contentsOf: url!)
                } catch {
                    print("图不对!~~>\(String(describing: url))")
                    image = UIImage (named: "p0picerror.png")
                }
            }
            if data != nil {
                image = UIImage(data: data!)
            }
            DispatchQueue.main.async(execute: {
                if image != nil {
                    imageView.image = image;
                    imageView.contentMode = contentMode
                    if overDo != nil {
                        let imgRef :CGImage = image!.cgImage!;
                        
                        let width:CGFloat = CGFloat( imgRef.width)
                        let height:CGFloat = CGFloat ( imgRef.height)
                        overDo!(width,height,itNumber)
                    }
                }
            })
        }
        
    }
    
    static func delayToDo(_ delay:Double,doSomething: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: doSomething)
    }
    
    static func arVwCellViewsWithRange(_ cell:UITableViewCell,rg: CountableClosedRange<Int> ) ->[UIView] {
        var rtViews:[UIView] = [UIView]()
        for i in rg {
            let temp = cell.contentView.viewWithTag(i)
            if temp != nil {
                rtViews.append(temp!)
            }
        }
        return rtViews
    }
    
    static func arVwCellViewsWithRange(_ vw:UIView,rg:CountableClosedRange<Int> ) ->[UIView] {
        var rtViews:[UIView] = [UIView]()
        for i in rg {
            let temp = vw.viewWithTag(i)
            if temp != nil {
                rtViews.append(temp!)
            }
        }
        return rtViews
    }
    
    
    static func stateNavSpace (_ vc:UIViewController)->CGFloat {
        return stateSpace(vc) + navSpace(vc)
    }
    
    static func TopBottomSpace(_ vc:UIViewController)->CGFloat {
        var rt:CGFloat = 0
        let navs = navSpace(vc)
        let states = stateSpace(vc)
        let tabs = tabSpace(vc)
        rt = screenBounds.height - (navs + states + tabs)
        return rt
    }
    
    static func tabSpace(_ vc:UIViewController)->CGFloat {
        var rt:CGFloat = 0
        if vc.tabBarController != nil {
            rt = vc.tabBarController!.tabBar.frame.height
        }
        return rt
    }
    
    static func stateSpace (_ vc:UIViewController)->CGFloat {
        return UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0 as CGFloat
        //return UIApplication.shared.statusBarFrame.height
    }
    static func navSpace (_ vc:UIViewController)->CGFloat {
        var rt :CGFloat = 0
        if vc.navigationController?.navigationBar.frame.height != nil {
            rt = (vc.navigationController?.navigationBar.frame.height)!
        }
        return rt
    }
    
    static func changFontSize(_ bt:UIButton, fixedSize:CGFloat ) {
        bt.titleLabel?.font = UIFont(name: (bt.titleLabel?.font?.fontName)! , size: CGFloat(fixedSize) )
    }
    static func changFontSize(_ label:UITextField, fixedSize:CGFloat ) {
        label.font = UIFont(name: (label.font?.fontName)! , size: CGFloat(fixedSize) )
    }
    
    static func changFontSize(_ label:UITextView, fixedSize:CGFloat ) { // 这个好像用不了
        label.font = UIFont(name: (label.font?.fontName)! , size: CGFloat(fixedSize) )
    }
    
    static func changFontSize(_ label:UITextView,label2:UILabel , fixedSize:CGFloat ) { // 这个好像用不了
        label.font = UIFont(name: (label2.font?.fontName)! , size: CGFloat(fixedSize) )
    }
    
    static func changFontSize(_ label:UILabel, sizeChange:CGFloat ) {
        label.font = UIFont(name: label.font.fontName , size: (label.font?.pointSize)! + CGFloat(sizeChange) )
    }
    
    static func changFontSize(_ label:UILabel, sizeChange:Int ) {
        label.font = UIFont(name: label.font.fontName , size: (label.font?.pointSize)! + CGFloat(sizeChange) )
    }
    
    static func changFontSize(_ label:UILabel, fixedSize:Int ) {
        label.font = UIFont(name: label.font.fontName , size: CGFloat(fixedSize) )
    }
    static func changFontSize(_ label:UILabel, fixedSize:CGFloat ) {
        label.font = UIFont(name: label.font.fontName , size: CGFloat(fixedSize) )
    }
    
    
    static func popMsg(_ vc:UIViewController ,title:String?,Msg:String?,cancelButton:String?, doSomething:((UIAlertAction)->())?  ){
        var nowTitle:String = "通知"
        var nowMSG:String = "没有内容"
        if (title != nil) {
            nowTitle = title!
        }
        if (Msg != nil) {
            nowMSG = Msg!
        }
        
        let alertConfirm = UIAlertController(title: nowTitle, message: nowMSG, preferredStyle: UIAlertController.Style.alert)
        if(cancelButton != nil) {
            let cancelAction = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel, handler: nil)
            alertConfirm.addAction(cancelAction)
        }
        let okAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: doSomething)
        alertConfirm.addAction(okAction)
        
        vc.present(alertConfirm, animated: true, completion: nil)
        
        //        let appearance = SCLAlertView.SCLAppearance(
        //            kTitleFont: UIFont.systemFont(ofSize: 6*centSpace ) ,
        //            kTextFont: UIFont.systemFont(ofSize: 4.5*centSpace ),
        //            kButtonFont: UIFont.systemFont(ofSize: 5*centSpace ) ,
        //            showCloseButton: false,
        //            kTextAlign: .center
        //        )
        //        
        //        let alert = SCLAlertView(appearance: appearance)
        //        
        //        if(cancelButton != nil) {
        //            alert.addButton(( cancelButton! + " 🔙") , backgroundColor: UIColor.lightGray, textColor: UIColor.gray, showDurationStatus: false) {
        //                
        //            }
        //
        //        }
        //        
        //        alert.addButton("确定  ✔️") {
        //            if doSomething != nil {
        //                let haha:UIAlertAction = UIAlertAction()
        //                doSomething!(haha)
        //            }
        //        }
        //        
        //        
        //        alert.showInfo(nowTitle, subTitle: nowMSG)
        
        
    }
    static  func popMsg(_ vc:UIViewController) {
        popMsg(vc, title: nil, Msg: nil,cancelButton:nil,doSomething: nil  )
    }
    
    static  func popMsg(_ vc:UIViewController ,Msg:String? ) {
        popMsg(vc, title: nil, Msg: Msg,cancelButton:nil,doSomething: nil  )
    }
    
    static  func popMsg(_ vc:UIViewController ,title:String?,Msg:String? ) {
        popMsg(vc, title: title, Msg: Msg,cancelButton:nil,doSomething: nil  )
    }
    
    static  func popMsg(_ vc:UIViewController ,title:String?,Msg:String?,doSomething:((UIAlertAction)->())? ) {
        popMsg(vc, title: title, Msg: Msg,cancelButton:nil, doSomething:doSomething )
    }
    
    static func imScaleAndRotateImage (_ image :UIImage ,itMaxSize:Int )->UIImage {
        let kMaxResolution:CGFloat = CGFloat(itMaxSize) // Or whatever
        
        let imgRef :CGImage = image.cgImage!;
        
        let   width:CGFloat = CGFloat( imgRef.width)
        let height:CGFloat = CGFloat ( imgRef.height)
        
        var transform:CGAffineTransform = CGAffineTransform.identity;
        var  bounds:CGRect = CGRect(x: 0, y: 0, width: width, height: height);
        if (width > kMaxResolution || height > kMaxResolution) {
            let ratio:CGFloat = width/height;
            if (ratio > 1) {
                bounds.size.width = kMaxResolution;
                bounds.size.height = bounds.size.width / ratio;
            }
            else {
                bounds.size.height = kMaxResolution;
                bounds.size.width = bounds.size.height * ratio;
            }
        }
        
        let   scaleRatio:CGFloat = bounds.size.width / width;
        let  imageSize:CGSize = CGSize(width: CGFloat(imgRef.width),height: CGFloat( imgRef.height));
        let boundHeight:CGFloat;
        let orient:UIImage.Orientation  = image.imageOrientation;
        switch(orient) {
        
        case .up: //EXIF = 1
            transform = CGAffineTransform.identity;
            
        case .upMirrored: //EXIF = 2
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
            
        case .down: //EXIF = 3
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height);
            transform = transform.rotated(by: CGFloat(Double.pi) );
            
        case .downMirrored: //EXIF = 4
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.height);
            transform = transform.scaledBy(x: 1.0, y: -1.0);
            
        case .leftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0);
            
        case .left: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.width);
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0);
            
        case .rightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0);
            
        case .right: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransform(translationX: imageSize.height, y: 0.0);
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0);
            
        // default:
        //[NSException raise:NSInternalInconsistencyException format:"Invalid image orientation"];
        // break
        default:
            break
        }
        
        UIGraphicsBeginImageContext(bounds.size);
        
        let  context:CGContext = UIGraphicsGetCurrentContext()!;
        
        if (orient == .right || orient == .left) {
            context.scaleBy(x: -scaleRatio, y: scaleRatio);
            context.translateBy(x: -height, y: 0);
        }
        else {
            context.scaleBy(x: scaleRatio, y: -scaleRatio);
            context.translateBy(x: 0, y: -height);
        }
        
        context.concatenate(transform);
        
        UIGraphicsGetCurrentContext()?.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height));
        let imageCopy:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return imageCopy;
    }
}
//protocol NeedRefreashDelegate {
//    func lastPageRefreashGo(_ any:AnyObject?)
//}

public extension NSDate {
    
}
//extension String {
//    public func lhColored(with color: UIColor) -> NSMutableAttributedString {
//        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
//    }
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        //result.deinitialize()
//        
//        return String(format: hash as String)
//    }
//}

public extension NSDate {
    class func ISOStringFromDate(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")! as TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date as Date) + "Z"
    }
    
    class func dateFromISOString(string: String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone.local
        let string2 = LHKit.stSubString(string , itFrom: 0, itTo: 18)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.date(from: string2)! as NSDate
    }
    
     func getCurrDateStr(date : Date,valueFormatter : NSString) -> String {
        let formatter=DateFormatter()
        formatter.dateStyle=DateFormatter.Style.full
        
        formatter.dateFormat="\(valueFormatter)"
        return formatter.string(from: date)
        
        
    }
    
     func getHMS (component: Calendar.Component,  date: Date) -> Int {
        let calendar = Calendar.current
        let time = calendar.component(component, from: date)
        return time
        
    }
}

//
//  SharedMethod.swift
//  Crash
//
//  Created by gorilla on 2016/12/19.
//  Copyright © 2016年 crash. All rights reserved.
//

import Foundation
import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let RootVC = UIApplication.shared.keyWindow?.rootViewController

public func JJLog<T>(messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName) : [\(lineNum)] - \(messsage)")
    #endif
    
}


//struct Cell {
//    static let BingoID = ("\(BingoItem.self)", "BingoCellID")
//}

struct Cell {
    static let animationItem = (cellClass : "\(ItemCell.self)" , cellID : "ItemCellID")
    
}

class Vcs  {

    enum storyboardID : String
    {
        case LayerVC = "LayerVC"
        case TheBackingImageVC = "TheBackingImageVC"
        case LayerGeometryVC = "LayerGeometryVC"
        case VisualEffectsVC = "VisualEffectsVC"
        case TransformsVC = "TransformsVC"
        case SpecializedLayersVC = "SpecializedLayersVC"
        case ImplicitAnimationsVC = "ImplicitAnimationsVC"
        case ExplicitAnimationsVC = "ExplicitAnimationsVC"
        case LayerTimeVC = "LayerTimeVC"
            
    }
    
    static func getVC(vc : storyboardID) -> UIViewController
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: vc.rawValue)
        return vc
    }
}

class ShareMethod
{
    public static func getCurrentTime(format : String = "EEE, d MMM YYYY HH:mm:ss") -> String
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        dateformatter.locale = NSLocale(localeIdentifier: "en-US") as Locale?
        return dateformatter.string(from: Date())
    }
    
    public static func showAlertView(TipString tip:String ,title : String = "" ,  targetVC : UIViewController = (appDelegate.window?.rootViewController)! ) -> ()
    {
        let alert = UIAlertController(title: title, message: tip, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil))
        targetVC.present(alert, animated: true, completion: nil)
    //    return alert
    }
    

    public static func getAppVersion() -> String
    {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}




extension String
{
    func localizedString() -> String
    {
        return NSLocalizedString(self, comment: "")
    }
    
    func showAlertController() 
    {
        let alert = UIAlertController(title: "", message: self, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.visibleViewController?.present(alert, animated: true, completion: nil)
        
//        appDelegate.window?.rootViewController?.presentedViewController?.present(alert, animated: true, completion: nil)
    }
    
}
extension UIViewController {
    /// Notice : The visible view controller from a given view controller
    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
        
    }
}



extension UIButton
{
    func setupCornerRadiusWith(LocalizedTitleLabel : String)
    {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.setTitle(LocalizedTitleLabel.localizedString(), for: .normal)
    }
}



public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}



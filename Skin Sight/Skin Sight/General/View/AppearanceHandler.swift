import Foundation
import UIKit

struct AppearanceHandler {
    func headingText(withSize size: CGFloat) -> UIFont {
          return UIFont(name: "GlacialIndifference-Bold", size: size) ?? UIFont()
      }

    func headingBoldFont(withSize size: CGFloat) -> UIFont {
         return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }

    func subTitleFont(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }

    func descriptionFont(withSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
    }

    var subTitleColour: UIColor {
        return UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1.0)
    }
    
    var greyColourAlpha20: UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
    }
    
    var greyColour: UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
    }

    var whiteColour: UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }

    var primaryColour: UIColor {
        return UIColor(red: 15/255, green: 151/255, blue: 171/255, alpha: 1.0)
    }
    
    var primaryColourAlpha80: UIColor {
        return UIColor(red: 15/255, green: 151/255, blue: 171/255, alpha: 0.8)
    }
    
    var primaryColourAlpha20: UIColor {
        return UIColor(red: 15/255, green: 151/255, blue: 171/255, alpha: 0.2)
    }

    var secondaryColour: UIColor {
        return UIColor(red: 121/255, green: 189/255, blue: 154/255, alpha: 1.0)
    }
    
    var facebookBlueColour: UIColor {
        return UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1.0)
    }
}

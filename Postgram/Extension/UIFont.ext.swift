import Foundation
import UIKit

enum CinzerType : String {
    case regular = "Cinzel-Regular"
    case bold = "Cinzel-Bold"
    case black = "Cinzel-Black"
}

enum JimNightshadeType : String {
    case regular = "JimNightShade-Regular"
}

extension UIFont {
    static func getCinzelFont(fontType: CinzerType = .regular, fontSize: CGFloat = 16) -> UIFont {
        .init(name: fontType.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    static func getJimNightshadeFont(fontSize: CGFloat = 16) -> UIFont {
        .init(name: JimNightshadeType.regular.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

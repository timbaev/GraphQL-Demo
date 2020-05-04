//
//  UIColor+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: - Instance Properties

    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!

        if components.count == 2 {
            return (r: components[0], g: components[0], b: components[0], a: components[1])
        } else {
            return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }

    // MARK: - Initializers

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    convenience init(redByte: UInt8, greenByte: UInt8, blueByte: UInt8, alphaByte: UInt8) {
        self.init(red: CGFloat(redByte) / 255.0,
                  green: CGFloat(greenByte) / 255.0,
                  blue: CGFloat(blueByte) / 255.0,
                  alpha: CGFloat(alphaByte) / 255.0)
    }

    convenience init(redByte: UInt8, greenByte: UInt8, blueByte: UInt8, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(redByte) / 255.0,
                  green: CGFloat(greenByte) / 255.0,
                  blue: CGFloat(blueByte) / 255.0,
                  alpha: alpha)
    }

    convenience init(white: CGFloat) {
        self.init(white: white, alpha: 1.0)
    }

    convenience init(whiteByte: UInt, alphaByte: UInt8) {
        self.init(white: CGFloat(whiteByte) / 255.0, alpha: CGFloat(alphaByte) / 255.0)
    }

    convenience init(whiteByte: UInt, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(whiteByte) / 255.0, alpha: alpha)
    }

    convenience init?(rgbHexString hexString: String) {
        var hexFormatted = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        var rgbValue: UInt64 = 0

        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        switch hexFormatted.count {
        case 3:
            self.init(rgbHex3: UInt16(rgbValue))

        case 4:
            self.init(rgbHex4: UInt16(rgbValue))

        case 6:
            self.init(rgbHex6: UInt32(rgbValue))

        case 8:
            self.init(rgbHex8: rgbValue)

        default:
            return nil
        }
    }

    convenience init(rgbHex3 hex: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex & 0xF00) >> 8) / divisor
        let green = CGFloat((hex & 0x0F0) >> 4) / divisor
        let blue = CGFloat(hex & 0x00F) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(rgbHex4 hex: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex & 0xF000) >> 12) / divisor
        let green = CGFloat((hex & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex & 0x00F0) >> 4) / divisor
        let alpha = CGFloat(hex & 0x000F) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(rgbHex6 hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex & 0x0000FF) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(rgbHex8 hex: UInt64) {
        let r = CGFloat((hex & 0xff000000) >> 24) / 255
        let g = CGFloat((hex & 0x00ff0000) >> 16) / 255
        let b = CGFloat((hex & 0x0000ff00) >> 8) / 255
        let a = CGFloat(hex & 0x000000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    // MARK: - Type Methods

    static func interpolate(from fromColor: UIColor, to toColor: UIColor, with progress: CGFloat) -> UIColor {
        let fromComponents = fromColor.components
        let toComponents = toColor.components

        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

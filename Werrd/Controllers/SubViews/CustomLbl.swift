//
//  CustomLabel.swift
//  Werrd
//
//  Created by Jaron Grigsby on 3/23/22.
//

import UIKit

class CustomLbl: UILabel {

  static let fontName = "Merriweather-Bold"
  static let color = UIColor(named: "GambinoBlue")!

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(textAlignment: NSTextAlignment,
                   minimumFontScale: CGFloat,
                   lineBreakMode: NSLineBreakMode,
                   numberOfLines: Int,
                   textColor: UIColor,
                   adjustsFontSizeToFitWidth: Bool) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
    self.minimumScaleFactor = minimumFontScale
    self.lineBreakMode = lineBreakMode
    self.numberOfLines = numberOfLines
    self.textColor = textColor
    self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
  }

  convenience init(text: String?, tintColor: UIColor?, font: UIFont, minimumFontScale: CGFloat?) {
    self.init(frame: .zero)
    self.text = text
    self.tintColor = tintColor
    self.font = font
    self.minimumScaleFactor = minimumScaleFactor
  }

}

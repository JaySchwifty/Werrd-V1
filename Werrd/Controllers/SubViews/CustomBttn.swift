//
//  CustomButton.swift
//  Werrd
//
//  Created by Jaron Grigsby on 3/23/22.
//

import UIKit

class CustomBttn: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  convenience init(size: CGFloat, systemName: String, tintColor: UIColor) {
    self.init(frame: .zero)

    let config = UIImage.SymbolConfiguration(pointSize: size, weight: .semibold, scale: .default)
    let sfSymbol = UIImage(systemName: systemName, withConfiguration: config)
    self.setImage(sfSymbol, for: .normal)
    self.tintColor = tintColor
  }

  func toggleFavButton() {
    let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold, scale: .default)
    if isSelected {
        let heartSF = UIImage(systemName: "heart.fill", withConfiguration: config)
        setImage(heartSF, for: .selected)
        print("favButton is selcted")
    } else {
        let heartSF = UIImage(systemName: "heart", withConfiguration: config)
        setImage(heartSF, for: .normal)
        print("favButton is not selected")
    }
  }

}

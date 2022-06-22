//
//  FavListTVC.swift
//  Werrd
//
//  Created by Jaron Grigsby on 6/15/22.
//

import UIKit

class FavListTVC: UITableViewCell {

  private let subView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.layer.cornerRadius = 24
    view.layer.borderWidth = 2
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  private var word = CustomLbl(textAlignment: .left, minimumFontScale: 0.9, lineBreakMode: .byTruncatingTail, numberOfLines: 1, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private var posLbl = CustomLbl(textAlignment: .left, minimumFontScale: 0.65, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private var definition = CustomLbl(textAlignment: .left, minimumFontScale: 0.8, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)


  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    cellUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func cellUI() {
    contentView.addSubview(subView)
    subView.addSubview(word)
    subView.addSubview(posLbl)
    subView.addSubview(definition)

    word.font = UIFont(name: CustomLbl.fontName, size: 20)
    posLbl.font = UIFont(name: CustomLbl.fontName, size: 10)
    definition.font = UIFont(name: CustomLbl.fontName, size: 15)

    NSLayoutConstraint.activate([

      subView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      
      word.topAnchor.constraint(equalTo: subView.topAnchor, constant: 8),
      word.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20),

      posLbl.topAnchor.constraint(equalTo: word.topAnchor, constant: 6),
      posLbl.leadingAnchor.constraint(equalTo: word.trailingAnchor, constant: 8),
      posLbl.trailingAnchor.constraint(lessThanOrEqualTo: subView.trailingAnchor),

      definition.topAnchor.constraint(equalTo: word.bottomAnchor, constant: 5),
      definition.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20),
      definition.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -20),
      definition.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -18)
    ])
  }

  func updateCell(word: String, pos: String?, def: String?) {
    self.word.text = word
    self.posLbl.text = pos
    self.definition.text = def
  }

}

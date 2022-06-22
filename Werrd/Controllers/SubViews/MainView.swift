//
//  MainView.swift
//  Werrd
//
//  Created by Jaron Grigsby on 3/23/22.
//

import UIKit

class MainView: UIView {

  private let appTitle = CustomLbl(text: "Werrd", tintColor: .label, font: UIFont.systemFont(ofSize: 50), minimumFontScale: nil)

  private let subView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 30
    view.layer.borderWidth = 3
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.barStyle = .default
    sb.sizeToFit()
    sb.placeholder = "Search for word"
    sb.barTintColor = .lightGray
    sb.searchBarStyle = .minimal
    sb.isTranslucent = false
    return sb
  }()

  var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.layer.cornerRadius = 30
    table.separatorStyle = .none
    table.rowHeight = UITableView.automaticDimension
    table.backgroundColor = .clear
    table.register(CustomTVC.self, forCellReuseIdentifier: "cell")
    table.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: TableHeaderView.id)
    return table
  }()

  let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()

  let favButton = CustomBttn(size: 42, systemName: "heart.text.square", tintColor: CustomLbl.color)

  var word = CustomLbl(textAlignment: .left, minimumFontScale: 0.4, lineBreakMode: .byWordWrapping, numberOfLines: 1, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  var posLbl = CustomLbl(textAlignment: .left, minimumFontScale: 0.65, lineBreakMode: .byTruncatingTail, numberOfLines: 1, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  var definition = CustomLbl(textAlignment: .left, minimumFontScale: 0.90, lineBreakMode: .byTruncatingTail, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  let refreshButton = CustomBttn(size: 28, systemName: "arrow.clockwise", tintColor: .lightGray)

  private let cellID = "cell"

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground

    UIConfig()
    UIConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: - UI Methods

  private func UIConfig() {

    addSubview(appTitle)
    addSubview(favButton)
    addSubview(subView)
    addSubview(tableView)
    subView.addSubview(spinner)
    subView.addSubview(word)
    subView.addSubview(posLbl)
    subView.addSubview(definition)
    subView.addSubview(refreshButton)
    tableView.addSubview(spinner)

    word.font = UIFont(name: CustomLbl.fontName, size: 30)
    posLbl.font = UIFont(name: CustomLbl.fontName, size: 15)
    definition.font = UIFont(name: CustomLbl.fontName, size: 17)

  }

  // MARK: - UI Constraints Method

  private func UIConstraints() {

    NSLayoutConstraint.activate([
      appTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      appTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      appTitle.trailingAnchor.constraint(lessThanOrEqualTo: favButton.trailingAnchor),
      appTitle.heightAnchor.constraint(equalToConstant: 100),

      favButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      favButton.heightAnchor.constraint(equalToConstant: 110),

      subView.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 10),
      subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      subView.heightAnchor.constraint(equalToConstant: 200),

      spinner.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: subView.centerYAnchor),

      word.topAnchor.constraint(equalTo: subView.topAnchor, constant: 20),
      word.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20),
      word.heightAnchor.constraint(equalToConstant: 40),
      word.widthAnchor.constraint(equalToConstant: 250),

      posLbl.topAnchor.constraint(equalTo: word.topAnchor, constant: 14),
      posLbl.leadingAnchor.constraint(equalTo: word.trailingAnchor, constant: 8),
      posLbl.trailingAnchor.constraint(lessThanOrEqualTo: subView.trailingAnchor),

      definition.topAnchor.constraint(equalTo: word.bottomAnchor, constant: 5),
      definition.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20),
      definition.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -20),
      definition.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -10),
//      definition.heightAnchor.constraint(equalToConstant: 50),

      refreshButton.widthAnchor.constraint(equalToConstant: 50),
      refreshButton.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
      refreshButton.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -6),
      refreshButton.heightAnchor.constraint(equalToConstant: 40),

      tableView.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 40),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}




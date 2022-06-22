//
//  FavListView.swift
//  Werrd
//
//  Created by Jaron Grigsby on 6/15/22.
//

import UIKit

class FavListView: UIView {

  var wordTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 37)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 30
    label.textColor = .label
    label.text = "Favorites"
    return label
  }()

  var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.layer.cornerRadius = 30
    table.separatorStyle = .none
    table.rowHeight = UITableView.automaticDimension
    table.backgroundColor = .clear
    table.register(FavListTVC.self, forCellReuseIdentifier: "cell")
    return table
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    config()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func config() {
    addSubview(tableView)
    backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

}

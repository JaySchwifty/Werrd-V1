//
//  TableHeaderView.swift
//  Werrd
//
//  Created by Jaron Grigsby on 5/17/22.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {

  static let id = "header"

  var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.translatesAutoresizingMaskIntoConstraints = false
    sb.placeholder = "Search Word"
    sb.searchBarStyle = .minimal
    sb.sizeToFit()
    return sb
  }()

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUI() {
    contentView.addSubview(searchBar)

    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: contentView.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
      searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
      searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}

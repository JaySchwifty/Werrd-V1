//
//  ViewController.swift
//  Werrd
//
//  Created by Jaron Grigsby on 3/23/22.
//

import UIKit

class ViewController: UIViewController {

  var mainView = MainView()
  private var favButton = UIButton()
  private var button = UIButton()
  var tableView: UITableView!
  private var searchBar: UISearchBar!
  var wordArray = [WordArray]()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)

    if let index = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRow(at: index, animated: true)
    }
  }

  override func loadView() {
    view = mainView
    button = mainView.refreshButton
    favButton =  mainView.favButton
    buttonConfig()
    tableView = mainView.tableView
    tableView.dataSource = self
    tableView.delegate = self
    fetchRandomWord()
  }

  private func buttonConfig() {
    button.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
    favButton.addTarget(self, action: #selector(goToFavList), for: .touchUpInside)
  }

  // MARK: - Button Action Mehtods

  @objc func goToFavList() {
    navigationController?.pushViewController(FavListVC(), animated: true)
  }

  @objc func refreshAction() {
    fetchRandomWord()
  }
}

extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    wordArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTVC else {return UITableViewCell()}

    let werrdArray = wordArray[indexPath.row]

    cell.updateCell(word: werrdArray.word, pos: werrdArray.results?.partOfSpeech ?? "", def: werrdArray.results?.definition ?? "")
    
    let image = UIImage(systemName: "chevron.right")
    let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!))
    accessory.image = image
    accessory.tintColor = UIColor.label

    cell.accessoryView = accessory
    cell.backgroundColor = .clear
    return cell
  }
}

extension ViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let werrdArray = wordArray[indexPath.row]
    let nav = DetailViewVC(selectedWord: werrdArray, passedFavWord: nil)

    navigationController?.pushViewController(nav, animated: true)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.id) as? TableHeaderView else {return nil}
    searchBar = header.searchBar
    searchBar.delegate = self
    return header
  }
}

extension ViewController: UISearchBarDelegate {

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
    searchBar.text = ""
    wordArray.removeAll()
    tableView.reloadData()
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.endEditing(true)
    searchBar.setShowsCancelButton(false, animated: true)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
    guard let searchedWord = searchBar.searchTextField.text else {
      return
    }
    fetchSearchedWord(with: searchedWord)
  }
}

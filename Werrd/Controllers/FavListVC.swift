//
//  FavListVC.swift
//  Werrd
//
//  Created by Jaron Grigsby on 6/15/22.
//

import UIKit

class FavListVC: UIViewController {

  private let favView = FavListView()
  private var favWord: FavWord?
  private var favWords = [FavWord]()
  private var tableview: UITableView!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.tintColor = .label
    navigationItem.largeTitleDisplayMode = .always
    navigationItem.titleView = favView.wordTitle

    // MARK: - load the favwords from data

    DataManager.fetchFavWords { wordList in
      if let wordList = wordList {
        favWords = wordList

        DispatchQueue.main.async { [weak self] in
          self?.tableview.reloadData()
        }
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = favView
    tableview = favView.tableView
    tableview.delegate = self
    tableview.dataSource = self
  }
}

extension FavListVC: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    favWords.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavListTVC else {return UITableViewCell()}

    let favArray = favWords[indexPath.row]
    cell.updateCell(word: favArray.word, pos: favArray.partOfSpeech, def: favArray.definition)

    return cell
  }
}

extension FavListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let wordArray = favWords[indexPath.row]
    
    let dVC = DetailViewVC(selectedWord: nil, passedFavWord: wordArray)
    //    dVC.wordTitle.text = ww.word
    //    dVC.definition.text = ww.definition
    //    dVC.partOfSpeech.text = ww.partOfSpeech
    //    dVC.synonym.text = ww.synonyms?.joined(separator: ", ")
    //    dVC.antonym.text = ww.antonyms?.joined(separator: ", ")
    //    dVC.exapmle.text = ww.examples?.joined(separator: ", ")
    //    dVC.synonym.text =
    //    dVC.antonym.text = wordArray.results?.antonyms?.joined(separator: ", ")
    //    dVC.synonym.text = wordArray.results?.synonyms?.joined(separator: ", ")
    //    dVC.example.text = wordArray.results?.examples?.joined(separator: ", ")

    navigationController?.pushViewController(dVC, animated: true)
  }

}

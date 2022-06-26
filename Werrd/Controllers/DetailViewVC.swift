//
//  DetailViewVC.swift
//  Werrd
//
//  Created by Jaron Grigsby on 4/10/22.
//

import UIKit

class DetailViewVC: UIViewController {
  
  var wordTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 37)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 30
    return label
  }()

  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 30
    stack.distribution = .fillProportionally
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  private let definitionView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.layer.cornerRadius = 24
    view.layer.borderWidth = 2
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  private let synonymView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.layer.cornerRadius = 24
    view.layer.borderWidth = 2
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  private let antonymsView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.layer.cornerRadius = 24
    view.layer.borderWidth = 2
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  private let exampleView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.layer.cornerRadius = 24
    view.layer.borderWidth = 2
    view.layer.borderColor = CustomLbl.color.cgColor
    return view
  }()

  let definition = CustomLbl(textAlignment: .left, minimumFontScale: 19, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private let definitionLbl = CustomLbl(text: "Definition", tintColor: .white, font: UIFont.systemFont(ofSize: 20, weight: .medium), minimumFontScale: 20)

  let synonym = CustomLbl(textAlignment: .left, minimumFontScale: 19, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private let synonymlbl = CustomLbl(text: "Synonym", tintColor: .white, font: UIFont.systemFont(ofSize: 20, weight: .medium), minimumFontScale: 20)

  let antonym = CustomLbl(textAlignment: .left, minimumFontScale: 19, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private let antonymLbl = CustomLbl(text: "Antonym", tintColor: .white, font: UIFont.systemFont(ofSize: 20, weight: .medium), minimumFontScale: 20)

  let exapmle = CustomLbl(textAlignment: .left, minimumFontScale: 19, lineBreakMode: .byWordWrapping, numberOfLines: 0, textColor: CustomLbl.color, adjustsFontSizeToFitWidth: true)

  private let exampleLbl = CustomLbl(text: "Example", tintColor: .white, font: UIFont.systemFont(ofSize: 20, weight: .medium), minimumFontScale: 20)

  var favButton = CustomBttn(size: 30, systemName: "heart", tintColor: .systemBlue)

  private var selectedWord: WordArray?
  private var passedFavWord: FavWord?

  override func loadView() {
    super.loadView()
    view.backgroundColor = .systemBackground
    setLabels()
    configureUI()
    configSubViews()
    favButtonAction()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.backBarButtonItem?.tintColor = .label
    navigationItem.largeTitleDisplayMode = .always
    navigationItem.titleView = wordTitle
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favButton)
  }

  init(selectedWord: WordArray?, passedFavWord: FavWord?) {
    self.selectedWord = selectedWord
    self.passedFavWord = passedFavWord
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setLabels() {
    if let selectedWord = selectedWord {

      wordTitle.text = selectedWord.word
      definition.text = selectedWord.results?.definition
      synonym.text = selectedWord.results?.synonyms?.joined(separator: ", ")
      antonym.text = selectedWord.results?.antonyms?.joined(separator: ", ")
      exapmle.text = selectedWord.results?.examples?.joined(separator: ", ")
    } else if let passedFavWord = passedFavWord {

      favButton.isSelected = true
      favButton.toggleFavButton()
      
      wordTitle.text = passedFavWord.word
      definition.text = passedFavWord.definition
      synonym.text = passedFavWord.synonyms?.joined(separator: ", ")
      antonym.text = passedFavWord.antonyms?.joined(separator: ", ")
      exapmle.text = passedFavWord.examples?.joined(separator: ", ")
    }
  }

  func favButtonAction() {
    favButton.addTarget(self, action: #selector(favPressed), for: .touchUpInside)
  }

  @objc func favPressed() {
    favButton.isSelected = !favButton.isSelected
    favButton.toggleFavButton()

    if let selectedWord = selectedWord {
      if favButton.isSelected {
        DataManager.addFavWord(word: selectedWord.word, definition: selectedWord.results?.definition, partOfSpeech: selectedWord.results?.partOfSpeech, synonyms: selectedWord.results?.synonyms, antonyms: selectedWord.results?.antonyms, examples: selectedWord.results?.examples)
      }
    } else if let passedFavWord = passedFavWord {
      if favButton.isSelected {

        DataManager.addFavWord(word: passedFavWord.word, definition: passedFavWord.definition, partOfSpeech: passedFavWord.partOfSpeech, synonyms: passedFavWord.synonyms, antonyms: passedFavWord.antonyms, examples: passedFavWord.examples)

      } else {
        DataManager.unFavWord(word: passedFavWord)
      }
    }
  }

  func configureUI() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(definitionView)
    stackView.addArrangedSubview(synonymView)
    stackView.addArrangedSubview(antonymsView)
    stackView.addArrangedSubview(exampleView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }

  func configSubViews() {

    definitionView.addSubview(definition)
    definitionView.addSubview(definitionLbl)

    synonymView.addSubview(synonym)
    synonymView.addSubview(synonymlbl)

    antonymsView.addSubview(antonym)
    antonymsView.addSubview(antonymLbl)

    exampleView.addSubview(exapmle)
    exampleView.addSubview(exampleLbl)

    NSLayoutConstraint.activate([

      definition.topAnchor.constraint(equalTo: definitionView.topAnchor, constant: 20),
      definition.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      definition.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      definition.bottomAnchor.constraint(equalTo: definitionLbl.topAnchor, constant: -10),

      definitionLbl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      definitionLbl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      definitionLbl.bottomAnchor.constraint(equalTo: definitionView.bottomAnchor, constant: -10),

      synonym.topAnchor.constraint(equalTo: synonymView.topAnchor, constant: 20),
      synonym.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      synonym.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      synonym.bottomAnchor.constraint(equalTo: synonymlbl.topAnchor, constant: -10),

      synonymlbl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      synonymlbl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      synonymlbl.bottomAnchor.constraint(equalTo: synonymView.bottomAnchor, constant: -15),

      antonym.topAnchor.constraint(equalTo: antonymsView.topAnchor, constant: 20),
      antonym.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      antonym.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      antonym.bottomAnchor.constraint(equalTo: antonymLbl.topAnchor, constant: -10),

      antonymLbl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      antonymLbl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      antonymLbl.bottomAnchor.constraint(equalTo: antonymsView.bottomAnchor),

      exapmle.topAnchor.constraint(equalTo: exampleView.topAnchor, constant:20),
      exapmle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      exapmle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      exapmle.bottomAnchor.constraint(equalTo: exampleLbl.topAnchor, constant: -10),

      exampleLbl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
      exampleLbl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
      exampleLbl.bottomAnchor.constraint(equalTo: exampleView.bottomAnchor, constant: -15)
    ])
  }
}

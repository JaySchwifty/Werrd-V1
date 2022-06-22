//
//  ViewController+Ext.swift
//  Werrd
//
//  Created by Jaron Grigsby on 6/13/22.
//

import Foundation

extension ViewController {

  func fetchRandomWord() {
    guard let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetail=definitions") else {
      print("invalid URL")
      return
    }
    let headers = [
      "X-RapidAPI-Key": "API KEY",
      "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com"
    ]

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = headers

    mainView.spinner.startAnimating()

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard let data = data, error == nil else {
        return
      }

      do {
        let word = try JSONDecoder().decode(Word.self, from: data)

        DispatchQueue.main.async {
          if let result = word.results {
            for result in result {
              self.mainView.word.text = word.word
              self.mainView.definition.text = result.definition
              self.mainView.posLbl.text = result.partOfSpeech
            }
          }
          self.mainView.spinner.stopAnimating()
        }
        
        print(word)
      } catch {
        print("Failed to convert \(error.localizedDescription)")
      }

    }.resume()
  }

  func fetchSearchedWord(with word: String) {
    wordArray = [WordArray]()
    let whiteSpace = word.trimmingCharacters(in: .whitespacesAndNewlines)
    let searchedWord = whiteSpace.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    
    guard let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(searchedWord)") else {
      print("invalid URL")
      return
    }

    let headers = [
      "X-RapidAPI-Key": "API KEY",
      "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com"
    ]

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = headers

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard let data = data, error == nil else {
        return
      }

      do {
        let word = try JSONDecoder().decode(Word.self, from: data)

        DispatchQueue.main.async {
          if let result = word.results {
            for result in result {
              self.wordArray.append(WordArray(word: word.word, results: result))
            }
          } else {
            self.wordArray.append(WordArray(word: word.word, results: nil))
          }
          self.tableView.reloadData()
        }
        //        print(word)
      } catch {
        print("Failed to convert \(error.localizedDescription)")
      }

    }.resume()
  }
}

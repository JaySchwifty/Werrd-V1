//
//  Word.swift
//  Werrd
//
//  Created by Jaron Grigsby on 5/1/22.
//

import Foundation

struct Word: Codable {
  var word: String
  var results: [Results]?
}

struct WordArray {
  var word: String
  var results: Results?
}

struct Results: Codable {
  var definition: String?
  var partOfSpeech: String?
  var synonyms: [String]?
  var antonyms: [String]?
  var examples: [String]?
}

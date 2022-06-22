//
//  DataManager.swift
//  Werrd
//
//  Created by Jaron Grigsby on 6/19/22.
//

import UIKit
import CoreData


class DataManager {

  static let managedObjectContext: NSManagedObjectContext = {
    let appleDelegate = UIApplication.shared.delegate as! AppDelegate
    return appleDelegate.persistentContainer.viewContext
  }()

  // MARK: - Create

  static func addFavWord(word: String, definition: String?, partOfSpeech: String?, synonyms: [String]?, antonyms: [String]?, examples: [String]?) {
    let favWord = FavWord(context: managedObjectContext)
    favWord.word = word
    favWord.definition = definition
    favWord.partOfSpeech = partOfSpeech
    favWord.synonyms = synonyms
    favWord.antonyms = antonyms
    favWord.examples = examples

    do {
      try managedObjectContext.save()
      print("Ssuccessfully saved word")
    } catch {
      print("Error saving context")
    }
  }

  static func fetchFavWords(completion: ([FavWord]?) -> Void) {
    do {
      let favWords = try managedObjectContext.fetch(FavWord.fetchRequest())
      completion(favWords)
    } catch {
      print("There was an error fetching favWords \(error.localizedDescription)")
    }

    completion(nil)
  }

  static func fetchFavWord(usingWord word: String, completion: (FavWord?) -> Void) {
    let fetchRequest = NSFetchRequest<FavWord>(entityName: "FavWord")
    fetchRequest.predicate = NSPredicate(format: "word == %@", word)

    do {
      let favWord = try managedObjectContext.fetch(FavWord.fetchRequest())
      completion(favWord.first)
    } catch {
      print("There was an errror fetching data \(error.localizedDescription)")
    }

    completion(nil)
  }

  static func unFavWord(word: FavWord) {
    managedObjectContext.delete(word)

    do {
      try managedObjectContext.save()
      print("Data was successfully deleted.")
    } catch {
      print("There was an error trying to delete data \(error.localizedDescription)")
    }
  }

}

//
//  MainCollection.swift
//  JsonParsing
//
//  Created by 19543442 on 17.09.2022.
//

import UIKit

enum Link: String {
    case heroes = "https://api.opendota.com/api/heroes"
    case apod = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1"
}

enum UserAction: String, CaseIterable {
    case goToHeroes = "Heroes"
    case goToFoto = "Apods"
}

class MainCollection: UICollectionViewController {

    private let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func getHero() {
        guard let url = URL(string: Link.heroes.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
            print(error?.localizedDescription ?? "No error description")
            return
            }
        
            let jsonDecoder = JSONDecoder()
        
            do {
                let _ = try jsonDecoder.decode(Hero.self, from: data)
                self.successAlert()
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
        .resume()
    }
    private func getApod() {
        guard let url = URL(string: Link.apod.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
            print(error?.localizedDescription ?? "No error description")
            return
            }
        
            let jsonDecoder = JSONDecoder()
        
            do {
                let _ = try jsonDecoder.decode([Apod].self, from: data)
                self.successAlert()
                
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
        .resume()
    }
    
    
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MainCell else { return UICollectionViewCell() }
    
        let userAction = userActions[indexPath.item]
        cell.cellLabel.text = userAction.rawValue
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .goToHeroes: getHero()
        case .goToFoto: getApod()
        }
    }

        
}

extension MainCollection {
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failed", message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

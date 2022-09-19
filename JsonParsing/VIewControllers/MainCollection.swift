//
//  MainCollection.swift
//  JsonParsing
//
//  Created by 19543442 on 17.09.2022.
//

import UIKit

enum Link: String {
    case heroes = "https://api.opendota.com/api/heroes"
    case teams = "https://api.opendota.com/api/teams/id=1"
}

enum UserAction: String, CaseIterable {
    case goToHeroes = "Heroes"
    case goToTeams = "Teams"
}

class MainCollection: UICollectionViewController {

    private let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

   //     // Register cell classes
   //     self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
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
    private func getTeam() {
        guard let url = URL(string: Link.teams.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
            print(error?.localizedDescription ?? "No error description")
            return
            }
        
            let jsonDecoder = JSONDecoder()
        
            do {
                let _ = try jsonDecoder.decode(Team.self, from: data)
                self.successAlert()
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }
        .resume()
    }
    
    
    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        3
//    }


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
        case .goToTeams: getTeam()
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

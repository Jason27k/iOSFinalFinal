//
//  ArtistsViewController.swift
//  MusicDiscovery
//
//  Created by Jason Morales on 11/14/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import Nuke

class ArtistsViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell

        let artist = artists[indexPath.row]
        if let imageURL = URL(string: artist.imageURL) {
            Nuke.loadImage(with: imageURL, into: cell.artistImageView)
        } else {
            cell.artistImageView.image = UIImage(named: "placeholder")
        }
        
        cell.artistName.text = artist.name
        cell.artistRank.text = artist.id

        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    private var artists = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchArtists()
    }
    
    func fetchArtists() {
        print("In here 😇")
        let db = Firestore.firestore()
        db.collection("Artists").getDocuments() { (snapshot, error) in
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    let artistDictionary = document.data()
                    if (artistDictionary.isEmpty) {
                        continue
                    }
                    let _id = artistDictionary["id"] as! String
                    let name = artistDictionary["name"] as! String
                    let imageURL = artistDictionary["imageUrl"] as! String
                    let artist = Artist(id: _id, name: name, imageURL: imageURL)
                    self.artists.append(artist)
                }
            }
            self.artists.sort { Int($0.id) ?? 0 < Int($1.id) ?? 0 }
            self.tableView.reloadData()
            print(self.artists)
            print("Over here 😇")
        }
        
    }
}

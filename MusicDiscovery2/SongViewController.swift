//
//  ViewController.swift
//  MusicDiscovery2
//
//  Created by Jason Morales on 11/11/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import Nuke

class SongViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        
        let song = songs[indexPath.row]
        if let imageURL = URL(string: song.imageURL) {
            Nuke.loadImage(with: imageURL, into: cell.songImageView)
        } else {
            cell.songImageView.image = UIImage(named: "placeholder")
        }
        
        cell.labelView.text = song.name
        cell.artistView.text = song.artists
        cell.rankView.text = song.id
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let selectedSong = songs[selectedIndexPath.row]
        
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.song = selectedSong
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    private var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSongs()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        
    }
    
    func fetchSongs() {
        print("In here 😇")
        let db = Firestore.firestore()
        db.collection("Songs").getDocuments() { (snapshot, error) in
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    let songDictionary = document.data()
                    if (songDictionary.isEmpty) {
                        continue
                    }
                    let _id = songDictionary["id"] as! String
                    let name = songDictionary["name"] as! String
                    let artists = songDictionary["artists"] as! String
                    let imageURL = songDictionary["imageUrl"] as! String
                    let songID = songDictionary["songID"] as! String
                    let songURI = songDictionary["songURI"] as! String
                    let songURL = songDictionary["songURL"] as! String
                    
                    let song = Song(id: _id, name: name, artists: artists, imageURL: imageURL, songID: songID, songURI: songURI, songURL: songURL)
                    
                    self.songs.append(song)
                }
            }
            self.songs.sort { Int($0.id) ?? 0 < Int($1.id) ?? 0 }
            self.tableView.reloadData()
            print(self.songs)
            print("Over here 😇")
        }
        
    }
}


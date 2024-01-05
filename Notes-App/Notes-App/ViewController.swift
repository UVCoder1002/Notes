//
//  ViewController.swift
//  Notes-App
//
//  Created by Urvashi Gupta on 03/01/24.
//

import UIKit

protocol DataDelegate {
    func updateNote(newArray: String)
}
class ViewController: UIViewController, UITableViewDelegate{
    
    //Variables
    @IBOutlet weak var notesTableView: UITableView!
    private lazy var tableViewDataSource: UITableViewDiffableDataSource<Int,String> = {
        let dataSource = UITableViewDiffableDataSource<Int,String>(tableView: notesTableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as? NotePrototypeCell else {return UITableViewCell()}
            cell.title.text = self.notesArray[indexPath.row].title
            cell.note.text = self.notesArray[indexPath.row].note
            cell.date.text = self.notesArray[indexPath.row].date
            return cell
        }
        return dataSource
    }()
    var notesArray = [Note]()
    var selectedId : String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? NoteUpdateViewController
        if segue.identifier == "UpdateNoteSegue" {
            selectedId = notesArray[notesTableView.indexPathForSelectedRow!.row]._id
            vc?.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc?.update = true
        }
       
    }
    func configureInitialDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int,String>()
        snapshot.appendSections([0])
        let ids = notesArray.map { $0._id }
        snapshot.appendItems(ids, toSection: 0)
        tableViewDataSource.apply(snapshot,animatingDifferences: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService.functions.fetchNotes()
       
    }
    
    func reloadCell(id: String){
        var snapshot = tableViewDataSource.snapshot()
        let ids = notesArray.map { $0._id }
        if ids.contains(where: { noteId in
            noteId == id
        }){
            
            snapshot.reloadItems([id])
           
        }
        else{
            snapshot.deleteItems([id])
        }
        tableViewDataSource.apply(snapshot,animatingDifferences: false)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.functions.delegate = self
        NetworkService.functions.fetchNotes()
        configureInitialDiffableSnapshot()
        print(notesArray)
        notesTableView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: DataDelegate {
    func updateNote(newArray:String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self,from: newArray.data(using: .utf8)!)
            if let id = selectedId{
                reloadCell(id: id)
                selectedId = nil
            }
            else{
              configureInitialDiffableSnapshot()
            }
        }
        catch{
            
            print("Failed Decoding")
            
        }
    }
}

//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let albumVM = AlbumViewModel()
    private var collectionView: UICollectionView?
    private var tableView: UITableView?
    private var datasource: UITableViewDiffableDataSource<Int, Album>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDatasource()
    }
}

// MARK: - helper function
extension ViewController {
    private func setup() {
        title = "Album sans e"
        navigationController?.view.backgroundColor = .systemBackground
        albumVM.delegate = self
        
        let tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 66
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8)
        ])
        
        tableView.delegate = self

        self.tableView = tableView
    }
    
    func setupDatasource(){
        guard let tableView = tableView else { return }
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
        datasource = UITableViewDiffableDataSource<Int, Album>(
            tableView: tableView
        ){ (collectionView, indexPath, album) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else { return nil }
            cell.setCell(album)
            cell.selectionStyle = .none
            return cell
        }
    }    
}

extension ViewController: ListViewModelDelegate {
    func onUpdate() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Album>()
        snapshot.appendSections([0])
        snapshot.appendItems(albumVM.albums)
        datasource?.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albumVM.albums[indexPath.row]
        let albumVC = AlbumViewController()
        albumVC.createViewModel(album.id)
        albumVC.title = album.title
        navigationController?.pushViewController(albumVC, animated: true)
    }
}
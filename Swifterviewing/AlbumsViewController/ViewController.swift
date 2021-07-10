//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {
   
    //MARK: - Outlets
    
    @IBOutlet weak var tblAlbums: UITableView!
    //Albums viewmodel
    var viewModel = AlbumViewModel()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        
        // Register TableviewCell
        
        tblAlbums.register(UINib(nibName: "AlbumsTableCell", bundle: nil), forCellReuseIdentifier: "AlbumsTableCell")
        
//        tblAlbums.tableFooterView = UIView()
//        tblAlbums.separatorInset = .zero
//        tblAlbums.layoutMargins = .zero
        
        // Removing tableview separator
        tblAlbums.separatorStyle = .none
        
        //MARK: - fetchAlbumsData
        
        KRProgressHUD.show()
        viewModel.fetchAlbumsData {
            self.viewModel.fetchPhotosData {
                KRProgressHUD.dismiss()
                self.tblAlbums.reloadData()
            }
        }
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - TableViewDataSource Methods

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsTableCell") as? AlbumsTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        prepareCellItem(cellForRowAt: indexPath, cell: cell)
        return cell
    }
}

//MARK- TableViewDelegates

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.cellDataAt(indexPath: indexPath) else {return}
        let arrPhotos = viewModel.getPhotosFromAlbumId(albumId: item.id)
        guard let photosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotosViewController") as? PhotosViewController else {return}
        photosVC.arrPhotos = arrPhotos
        photosVC.element = item
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  350.0
    }
}

extension ViewController
{
    // Calculating tableview cell title height
    private func calculateHeight(inString:String) -> CGFloat {
          let messageString = inString
         let attributes = [NSAttributedString.Key.font : UIFont.boldStyle(size: 16.0)]

          let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)

          let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

           let requredSize:CGRect = rect
           return requredSize.height
     }
}

//MARK: - preparingCellItem
extension ViewController
{
    private func prepareCellItem(cellForRowAt indexPath : IndexPath, cell : AlbumsTableCell)
    {
        
        guard let item = viewModel.cellDataAt(indexPath: indexPath) else {return}
        var title = item.title ?? ""
        title = title.replacingOccurrences(of: "e", with: "")
        cell.lblAlbumTitle.text = title
        cell.imgvwAlbum.image = UIImage(named: "placeholder")
        
        let arrPhotos = viewModel.getPhotosFromAlbumId(albumId: item.id)
        
        if arrPhotos.count > 0
        {
            let element = arrPhotos[0]
            downloadImage(from:  URL(string: "\(element.thumbnailUrl ?? "")")!, imageView: cell.imgvwAlbum)
            cell.arrImages = arrPhotos
            cell.awakeFromNib()
        }
    }
}

//MARK:- dowloading Image
extension ViewController
{
    func downloadImage(from url: URL, imageView : UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data) ?? UIImage(named: "placeholder")
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

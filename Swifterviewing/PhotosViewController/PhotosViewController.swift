//
//  PhotosViewController.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var arrPhotos : [Photos]?
    var element : Album?
    @IBOutlet weak var tblPhotos: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Assigning album title to navigation header
        
        var strTitle = element?.title ?? ""
        strTitle = strTitle.replacingOccurrences(of: "e", with: "")
        self.title = strTitle
        
        //Registe tableview cell
        tblPhotos.register(UINib(nibName: "PhotoTableCell", bundle: nil), forCellReuseIdentifier: "PhotoTableCell")
//        tblPhotos.tableFooterView = UIView()
//        tblPhotos.separatorInset = .zero
//        tblPhotos.layoutMargins = .zero
        // Removing tableview separator
        tblPhotos.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

//MARK: - UITableViewDelegates and Datasources

extension PhotosViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPhotos?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableCell") as? PhotoTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        if arrPhotos?.count ?? 0 > 0
        {
            cell.vwContainer.isHidden = false
            cell.lblPhotoTitle.isHidden = false
            cell.imgvwPhoto.isHidden = false
            cell.textLabel?.text = ""
            prepareCellItem(cellForRowAt: indexPath, cell: cell)
        }else
        {
            cell.vwContainer.isHidden = true
            cell.lblPhotoTitle.isHidden = true
            cell.imgvwPhoto.isHidden = true
            cell.textLabel?.text = "No photos are available."
            cell.textLabel?.applyStyle(font: UIFont.boldStyle(size: 16.0), textColor: .black)
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}

//MARK: - preparingCellItem

extension PhotosViewController
{
    private func prepareCellItem(cellForRowAt indexPath : IndexPath, cell : PhotoTableCell)
    {
        
        let item = arrPhotos?[indexPath.row]
        var title = item?.title ?? ""
        title = title.replacingOccurrences(of: "e", with: "")
        cell.lblPhotoTitle.text = title
        cell.imgvwPhoto.image = UIImage(named: "placeholder")
        downloadImage(from:  URL(string: "\(item?.thumbnailUrl ?? "")")!, imageView: cell.imgvwPhoto)
    }
    
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


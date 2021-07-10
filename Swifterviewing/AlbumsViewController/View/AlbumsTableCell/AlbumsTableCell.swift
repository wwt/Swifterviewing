//
//  AlbumsTableCell.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumsTableCell: UITableViewCell
{
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet var lblAlbumTitle: UILabel!
    @IBOutlet weak var imgvwAlbum: UIImageView!
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    var arrImages : [Photos]?
    var count = 0;
    
    //MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vwContainer.clipsToBounds = true
        vwContainer.makeCardView()
        vwContainer.layer.cornerRadius = 15.0
        lblAlbumTitle.applyStyle(font: UIFont.boldStyle(size: 16.0), textColor: .red)
        
        collectionViewPhotos.register(UINib(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionCell")
        collectionViewPhotos.delegate = self
        collectionViewPhotos.dataSource = self
        collectionViewPhotos.reloadData()
        
        if arrImages != nil
        {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
                Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector( self.runTimedCode), userInfo: nil, repeats: true)
            })
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Auto Scroll CollectionView Cells
    @objc func runTimedCode()
    {
        if count < arrImages?.count ?? 0
        {
            let indexPath = IndexPath(item: count, section: 0)
            self.collectionViewPhotos.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            count += 1
        }else{
            count = 0
            let indexPath = IndexPath(item: count, section: 0)
            self.collectionViewPhotos.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            count = 1
        }
    }
    
}


//MARK: - CollectionViewDelegates and DataSources

extension AlbumsTableCell : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionCell", for: indexPath) as? PhotosCollectionCell else {return UICollectionViewCell()}
        guard let element = arrImages?[indexPath.row] else {return cell}
        var title = element.title ?? ""
        // Removing occurrences, if not required please comment below line
        title = title.replacingOccurrences(of: "e", with: "")
        cell.lblTitle.text = title
        downloadImage(from: URL(string: element.thumbnailUrl ?? "")!, imageView: cell.imgvwPhoto)
        return cell
    }
}

extension AlbumsTableCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width/3, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - dowloadImageFromURL
extension AlbumsTableCell
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

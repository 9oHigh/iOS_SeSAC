//
//  BookViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/19.
//

import UIKit

class BookViewController: UIViewController {
    
    var bookList = myMediaInfo()
    var myPosterList : [String] = [
        "squid_game",
        "maid",
        "the_five_juana",
        "sex_education",
        "alice_in_borderland",
        "kastanjemanden",
        "hometown_cha_cha_cha",
        "paw_pastrol",
        "the_baby_sitter_club",
        "a_tale_dark_grimm",
        "greys_anatomy",
        "house_of_secrets",
        "the_kings_affection",
        "nevertheless",
        "the_bilion_dollar_code"
    ]
    var myColorList : [UIColor] = [
        UIColor.orange,
        UIColor.brown,
        UIColor.yellow,
        UIColor.blue,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.green,
        UIColor.label,
        UIColor.link,
        UIColor.magenta,
        UIColor.purple,
        UIColor.lightGray,
        UIColor.red,
        UIColor.black,
        UIColor.orange
    ]
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //present로 열었음..
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        title = "나의 미디어"
        //datasource + delegate
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        //XIB파일 연결
        let nibName = UINib(nibName: bookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: bookCollectionViewCell.identifier)
        
        //Layout 설정하기
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        bookCollectionView.collectionViewLayout = layout
    }
    @objc func closeButtonClicked(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
extension BookViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCollectionViewCell.identifier, for: indexPath) as? bookCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = bookList.tvShow[indexPath.row].title
        cell.rateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.bookImageView.image = UIImage(named: myPosterList[indexPath.row])!
        
        cell.rateLabel.text = String(bookList.tvShow[indexPath.row].rate)
        cell.rateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        cell.backgroundColor = myColorList[indexPath.row]
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    
}

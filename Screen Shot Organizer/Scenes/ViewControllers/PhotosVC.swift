//
//  ViewController.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/24/1400 AP.
//

import UIKit
import Photos

class PhotosVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var items: [CategoryModel] = DataManager.standard.items{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let imageManager: ImageManager = ImageManager()
    let refreshControl = UIRefreshControl()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        checkPhotoAccessPermision()
        
        self.navigationItem.title = "Screenshots"
    }
    
    deinit {
        print("🚮 Deinit describing ####\(String(describing: self))")
    }
    
    //MARK: - functions
    
    ///Fetch New Images
    func getImageData() {
        imageManager.fetchPhotos { [weak self] in
            guard let self = self else { return }
            self.refreshCollectionView()
        }
    }
    
    ///Check for Photo Galery access Permission
    func checkPhotoAccessPermision() {
        imageManager.getPermissionIfNecessary { [unowned self] granted in
            guard granted else { return }
            getImageData()
        }
    }
    
    @objc func refreshCollectionView() {
        items = DataManager.standard.items
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }
    
}

//MARK: - CollectionView Delegate and DataSource
extension PhotosVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// CollectionView Initializer
    func setupCollectionView() {
        setupRefreshControll()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.register(ImageCollectionViewCell.self)
        collectionView.registerReusableView(CollectionViewSectionHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.reloadData()
    }
    
    func setupRefreshControll() {
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    /// number of items and sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items[section].photos.count
    }
    
    /// cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ImageCollectionViewCell.self, indexPath: indexPath)
        cell.setImage(image: items[indexPath.section].photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableView(CollectionViewSectionHeader.self,
                                                                   ofKind: kind,
                                                                   indexPath: indexPath)
            sectionHeader.setTitle(self.items[indexPath.section].name)
            return sectionHeader
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    ///Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryVC = UIStoryboard.main.instantiate(viewController: CategoryVC.self)
        categoryVC.initWith(currentCategory: self.items[indexPath.section].id)
        categoryVC.didSelectRow = { [weak self] (selectedCategoryId) in
            guard let self = self, let categoryID = selectedCategoryId else { return }
            let photo = self.items[indexPath.section].photos[indexPath.item]
            let currentCategoryID = self.items[indexPath.section].id
            DataManager.standard.addPhotosToCategory(catId: categoryID,
                                                     photo: photo,
                                                     prevCatid: currentCategoryID)
            self.items = DataManager.standard.items
        }

        let categoryNC = UINavigationController(rootViewController: categoryVC)
        self.present(categoryNC, animated: true)
    }
}

//MARK: - CollectionView Flow Layout
extension PhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// pin headers to top on scrolling
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        let width = collectionView.bounds.width / 3.29
        return CGSize(width: width  , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}


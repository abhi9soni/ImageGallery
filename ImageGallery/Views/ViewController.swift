//
//  ViewController.swift
//  ImageGallery
//
//  Created by Abhinav Soni on 12/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = ImageListViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchImageData()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set delegates and register the custom collection view cell
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: Constants.Cell.ImageCVC, bundle: nil),
            forCellWithReuseIdentifier: Constants.Cell.ImageCVC
        )
    }
    
    // MARK: - Data Fetching
    private func fetchImageData() {
        Task {
            do {
                // Asynchronously fetch the image list from ViewModel
                try await viewModel.getImageList()
                
                // Reload the collection view on the main thread
                await MainActor.run {
                    collectionView.reloadData()
                }
                
                print("Fetched Movies:", viewModel.images)
                
            } catch {
                print("Error fetching image list:", error)
            }
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Cell.ImageCVC,
            for: indexPath
        ) as? ImageCVC else {
            fatalError("Failed to dequeue ImageCVC")
        }
        
        let movie = viewModel.images[indexPath.item]
        cell.displayMovieData(movie)
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let width = UIScreen.main.bounds.width / 2 - padding
        return CGSize(width: width, height: 330)
    }
}

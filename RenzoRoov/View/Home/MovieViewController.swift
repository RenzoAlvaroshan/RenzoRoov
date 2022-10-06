//
//  MovieViewController.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 04/10/22.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MovieViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumLineSpacing = 4
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observableMovies()
        itemSelected()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieCollectionView.frame = view.bounds
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Popular Movies"
        
        view.addSubview(movieCollectionView)
    }
}

extension MovieViewController {
    private func observableMovies() {
        let observableMovies = viewModel.movies.asObservable()
        observableMovies.bind(to: movieCollectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { [weak self] (index, element, cell) in
            if let cellViewModel = self?.viewModel.viewModelForCell(at: index) {
                cell.configure(viewModel: cellViewModel)
            }
        }.disposed(by: disposeBag)
    }
    
    private func itemSelected() {
        movieCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.movieCollectionView.deselectItem(at: indexPath, animated: true)
            
            let movie = self.viewModel.moviesNotDriver[indexPath.row]
            
            let vc = MoviePreviewViewController()
            vc.configure(with: movie)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
    }
}

//
//  MovieListViewController.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 05/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MovieViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycles
    
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
        asObservable()
        itemSelected()
        
        movieTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieTableView.frame = view.bounds
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Popular Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(movieTableView)
    }
}

extension MovieListViewController {
    private func asObservable() {
        let observableMovies = viewModel.movies.asObservable()
        observableMovies.bind(to: movieTableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { [weak self] (index, element, cell) in
            if let cellViewModel = self?.viewModel.viewModelForCell(at: index) {
                cell.configure(viewModel: cellViewModel)
            }
        }.disposed(by: disposeBag)
    }
    
    private func itemSelected() {
        movieTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.movieTableView.deselectRow(at: indexPath, animated: true)
            
            let movie = self.viewModel.moviesNotDriver[indexPath.row]
            
            let vc = MoviePreviewViewController()
            vc.configure(with: movie)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

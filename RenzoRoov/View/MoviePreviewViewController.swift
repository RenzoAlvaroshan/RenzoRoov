//
//  MoviePreviewViewController.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 05/10/22.
//

import UIKit
import SnapKit
import Kingfisher

final class MoviePreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "This is the best movie in the world!"
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var watchListButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.setTitle("Add to Watch List", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addToWatchList), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func addToWatchList() {
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(posterImageView)
        view.addSubview(movieLabel)
        view.addSubview(overviewLabel)
        view.addSubview(watchListButton)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        watchListButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
    }
    
    func configure(with model: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath ?? "")") else { return }
        self.posterImageView.kf.setImage(with: url)

        self.movieLabel.text = model.title
        self.overviewLabel.text = model.overview
    }
}


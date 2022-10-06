//
//  MovieTableViewCell.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 05/10/22.
//

import UIKit
import SnapKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieTableViewCell"
    
    private lazy var moviePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var playMovieButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - Lifecycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(moviePosterUIImageView)
        contentView.addSubview(movieLabel)
        contentView.addSubview(playMovieButton)
        
        moviePosterUIImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
            make.width.equalTo(100)
        }

        movieLabel.snp.makeConstraints { make in
            make.leading.equalTo(moviePosterUIImageView.snp.trailing).offset(20)
            make.width.equalTo(210)
            make.centerY.equalTo(self)
        }
        
        playMovieButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(self)
        }
    }
    
    func configure(viewModel: CellMovieViewModel) {
        self.moviePosterUIImageView.kf.setImage(with: viewModel.imageURL)
        self.movieLabel.text = viewModel.movieTitle
    }
}

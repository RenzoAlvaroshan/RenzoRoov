//
//  MovieCollectionViewCell.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 04/10/22.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(viewModel: CellMovieViewModel) {
        self.posterImageView.kf.setImage(with: viewModel.imageURL)
    }
    
}

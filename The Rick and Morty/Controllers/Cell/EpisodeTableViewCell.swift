//
//  EpisodeTableViewCell.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var containerView = UIView.containerView()

    private lazy var nameEpisodeLabel = UILabel(font: .avenirHeavy19())
    private lazy var dateLabel = UILabel(font: .avenirMedium13())
    private lazy var episodeLabel = UILabel(font: .avenirMedium13())
    
    private lazy var detailEpisodesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dateLabel, episodeLabel],
                               axis: .vertical,
                               spacing: CGFloat.smallSpacing)
        return view
    }()
    
    private lazy var episodesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameEpisodeLabel, detailEpisodesStackView],
                               axis: .vertical,
                               spacing: CGFloat.spacing)
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with episode: Episode?) {
        nameEpisodeLabel.text = episode?.name
        dateLabel.text = "air date: \(episode?.air_date ?? "No Data")"
        episodeLabel.text = "episode: \(episode?.episode ?? "No Data")"
        }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(containerView)
        addSubview(episodesStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor,
                                               constant: CGFloat.smallOffset),
            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: CGFloat.offset),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: CGFloat.inset),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: CGFloat.smallInset),
            
            episodesStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                       constant: CGFloat.offset),
            episodesStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                        constant: CGFloat.inset),
            episodesStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

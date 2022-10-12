//
//  CharacterTableViewCell.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private lazy var containerView = UIView.containerView()
    private lazy var characterImage = UIImageView.characterImage()

    private lazy var nameLabel = UILabel(font: .avenirHeavy19())
    private lazy var genderLabel = UILabel(font: .avenirMedium13())
    private lazy var speciesLabel = UILabel(font: .avenirMedium13())
    private lazy var locationLabel = UILabel(font: .avenirMedium13())
    
    private lazy var detailCharacterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [genderLabel, speciesLabel],
                               axis: .vertical,
                               spacing: CGFloat.smallSpacing)
        return view
    }()
    private lazy var characterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, detailCharacterStackView],
                               axis: .vertical,
                               spacing: CGFloat.spacing)
        return view
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: Public Methods
    
    func configure(with character: Character?) {
        guard let character = character else { return }
        guard let image = character.img else { return }
        
        nameLabel.text = character.name ?? "No Data"
        genderLabel.text = R.string.titles.gender(character.gender ?? "No Data")
        speciesLabel.text = R.string.titles.species(character.species ?? "No Data")
        characterImage.image = UIImage(data: image)
        }
       
    // MARK: Private Methods
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(containerView)
        addSubview(characterImage)
        addSubview(characterStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor,
                                               constant: CGFloat.smallOffset),
            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: CGFloat.offset),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: CGFloat.smallInset),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: CGFloat.smallInset),
            
            characterImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            characterImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            characterImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            characterImage.widthAnchor.constraint(equalToConstant: CGFloat.widthImage),
            
            characterStackView.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor,
                                                        constant: CGFloat.offset),
            characterStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                         constant: CGFloat.inset),
            characterStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

//
//  CharacterTableViewCell.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "picture"))
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var containerView = UIView.containerView()
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func configure(with character: Character?) {
        nameLabel.text = character?.name ?? "No Data"
        genderLabel.text = "gender: \(character?.gender ?? "No Data")"
        speciesLabel.text = "species: \(character?.species ?? "No Data")"
        DispatchQueue.global().async {
            guard let url = URL(string: character?.image ?? "") else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: data)
            }
        }
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

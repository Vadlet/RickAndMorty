//
//  DebugMenuController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 06.10.2022.
//

import UIKit

final class DebugMenuController: UIViewController {
    
    private lazy var containerView = UIView.containerView()
    private lazy var numberOfCellsLabel = UILabel()
    private lazy var sizeCoreDataLabel = UILabel()

    private lazy var switchForURL = UISwitch()
    private lazy var switchLabel = UILabel()
    
    var viewModel: DebugMenuViewModelProtocol! {
        didSet {
            guard let infoLabel = viewModel else { return }
            numberOfCellsLabel.text = infoLabel.numberOfCellsLabel
            sizeCoreDataLabel.text = infoLabel.sizeCoreDataLabel
            switchLabel.text = infoLabel.switchLabel
        }
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Public Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        setupConstraints()
        fetchSwitchFlag()
        switchForURL.addTarget(self, action: #selector(saveSwitchFlag), for: .valueChanged)
    }
    
    @objc func saveSwitchFlag() {
        UserDefaults.standard.set(switchForURL.isOn, forKey: "switcher")
    }
    
    // MARK: - Private Methods
    
    private func fetchSwitchFlag() {
        let switchIsOn = UserDefaults.standard.bool(forKey: "switcher")
        switchForURL.isOn = switchIsOn
    }
    
    private func setupConstraints() {
        let switchStackView = UIStackView(arrangedSubviews: [switchLabel, switchForURL])
        switchStackView.axis = .horizontal
        switchStackView.distribution = .fill
        
        let labelStackView = UIStackView(arrangedSubviews: [sizeCoreDataLabel, numberOfCellsLabel, switchStackView],
                                         axis: .vertical,
                                         spacing: .smallSpacing)
        
        view.addSubview(containerView)
        view.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: .offset),
            containerView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: .offset),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .offset),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .inset),
            
            switchStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .offset),
            switchStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .inset),
            
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .offset),
            labelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .offset)
        ])
    }
}

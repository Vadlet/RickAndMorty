//
//  DebugMenuController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 06.10.2022.
//

import UIKit

final class DebugMenuController: UIViewController {
    
    private lazy var containerView = UIView.containerView()
    
    private lazy var sizeCoreDataLabel = UILabel(font: .avenirHeavy19(), text: "Total data size: 12443мб")
    private lazy var numberOfCellsLabel = UILabel(font: .avenirHeavy19())
    
    private lazy var switchForURL = UISwitch()
    private lazy var switchLabel = UILabel(font: .avenirHeavy19(), text: "Is on test API")
    
    private lazy var warningLabel = UILabel(font: .avenirHeavy19())
    
    var viewModel: DebugMenuViewModelProtocol! {
        didSet {
            guard let infoLabel = viewModel.setDebugInfoLabel else { return }
            numberOfCellsLabel.text = infoLabel
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
        warningLabel.text = "The changes will take effect after the application is restarted."
    }
    
    // MARK: - Private Methods
    
    private func fetchSwitchFlag() {
        let switchIsOn = UserDefaults.standard.bool(forKey: R.string.userDefaultsKey.switcher())
        switchForURL.isOn = switchIsOn
        viewModel.saveURLFlag(switchIsOn)
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
        view.addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: .offset),
            containerView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: .offset),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .offset),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .inset),
            
            switchStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .offset),
            switchStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .inset),
            
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .offset),
            labelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .offset),
            
            warningLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: .offset),
            warningLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .offset),
            warningLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: .inset)
        ])
    }
}

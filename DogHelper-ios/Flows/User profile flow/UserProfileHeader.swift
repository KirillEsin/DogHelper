//
//  UserProfileHeader.swift
//  DogHelper-ios
//
//  Created by Кирилл on 25.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class UserProfileHeader: UIView {
    
    var didTapOnSelectBreed: (() -> Void)?
    
    var viewModel: ProfileHeaderProtocol? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupViewModel(viewModel)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = ColorPalette.mainGrayColor
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 100 / 2;
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let dateRegistrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    let dogTypeView: UIView = {
        let dogTypeView = UIView()
        dogTypeView.translatesAutoresizingMaskIntoConstraints = false
        dogTypeView.layer.cornerRadius = 16
        dogTypeView.layer.masksToBounds = true
        dogTypeView.backgroundColor = ColorPalette.addDogTypeViewColor
        return dogTypeView
    }()
    
    let dogTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = ColorPalette.mainColor
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.text = "Add your breed of dog"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        let dogTypeViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleDogTypeViewSelected))
        dogTypeView.addGestureRecognizer(dogTypeViewGesture)
    }
    
    @objc func handleDogTypeViewSelected() {
        didTapOnSelectBreed?()
    }
    
    func setupViewModel(_ viewModel: ProfileHeaderProtocol) {
        imageView.sd_setImage(with: viewModel.imageUrl) {[weak self] (_ , _ , _ , _ ) in
            self?.activityIndicator.stopAnimating()
        }
        
        usernameLabel.text = viewModel.username
        dateRegistrationLabel.text = viewModel.dateString
        dogTypeLabel.text = viewModel.dogTypeString
        
        if let _ = viewModel.dogBreed {
            dogTypeView.backgroundColor = ColorPalette.mainColor
            dogTypeLabel.textColor = .white
        }
    }
    
    private func setupViews() {
        addSubview(imageView)
        backgroundColor = ColorPalette.mainGrayColor
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constraints.padding2x).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding2x).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        imageView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Constraints.padding2x).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constraints.padding2x).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(dateRegistrationLabel)
        dateRegistrationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: Constraints.padding).isActive = true
        dateRegistrationLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Constraints.padding2x).isActive = true
        dateRegistrationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constraints.padding2x).isActive = true
        dateRegistrationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(dogTypeView)
        dogTypeView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraints.padding).isActive = true
        dogTypeView.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        dogTypeView.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor).isActive = true
        dogTypeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        //dogTypeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dogTypeView.addSubview(dogTypeLabel)
        dogTypeLabel.anchorCenterSuperview()
    }
    
}

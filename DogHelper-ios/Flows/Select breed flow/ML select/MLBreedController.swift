//
//  MLBreedController.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import EmptyKit

protocol MLBreedView: BaseView {
    var didSelectBreed: ((String) -> Void)? { get set }
}

class MLBreedController: BaseViewController, MLBreedView {
    
    var didSelectBreed: ((String) -> Void)?
    
    private let classifier = ImageClassifier()
    var results: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var probability: [String] = []
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "dog"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.alpha = 0.3
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.ept.dataSource = self
        tableView.ept.delegate = self
        tableView.registerClass(UITableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
    }
    
    private func setupGesture() {
        let tapImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap))
        imageView.addGestureRecognizer(tapImageViewGesture)
    }
    
    @objc func handleImageViewTap() {
        openImagePicker(sourceType: .photoLibrary)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: Constraints.padding2x).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constraints.padding2x).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constraints.padding2x).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraints.padding2x).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MLBreedController: UITableViewDataSource, UITableViewDelegate, EmptyDelegate, EmptyDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row): \(results[indexPath.row]) \(probability[indexPath.row])"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !results.isEmpty {
            return "Choose your dog breed"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedName = results[indexPath.row]
        didSelectBreed?(breedName)
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "row_up")
    }
    
    func imageTintColorForEmpty(in view: UIView) -> UIColor? {
        return ColorPalette.mainColor
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        let title = "Choose your favorite photo of your dog"
        let font = UIFont.systemFont(ofSize: 18)
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: UIColor.black, .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat {
        return -100.0
    }
}

extension MLBreedController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage, let cgImage = image.cgImage {
            changeImage(image)
            classifier.classifyImageWithVision(image: cgImage) {[weak self] (results) in
                DispatchQueue.main.async { [weak self] in
                    self?.results = results.0
                    self?.probability = results.1
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    
    func openImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func changeImage(_ image: UIImage) {
        imageView.alpha = 1.0
        imageView.backgroundColor = nil
        imageView.layer.cornerRadius = 0
        imageView.image = image
    }
}

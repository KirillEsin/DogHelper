//
//  ChatViewController.swift
//  Lets swap
//
//  Created by Кирилл on 13.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import Photos

protocol ChatView: BaseView {
}

class ChatViewController: UICollectionViewController, ChatView, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    lazy var inputContainerView: ChatInputContainerView = {
        let chatInputContainerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        chatInputContainerView.chatController = self
        return chatInputContainerView
    }()
    
    var viewModel: ChatViewModel!
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
    }
    
    
//    func setupNavigationButton() {
//        let rightButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(showMoreAlertSheet))
//        navigationItem.rightBarButtonItem = rightButton
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        navigationController?.navigationBar.isTranslucent = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.showKeyboard(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboard(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func sendMessage(text: String?) {
        viewModel.sendMessage(text: text)
    }
    
    @objc func showKeyboard(notification: Notification) {
        if viewModel.messagesCount > 0 {
            let indexPath = IndexPath(item: viewModel.messagesCount - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc func keyboard(notification: Notification) {
        hideKeyboard()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.messagesCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatMessageCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.chatController = self
        cell.delegate = self
        cell.message = viewModel.message(at: indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.2, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        let width = UIScreen.main.bounds.width
        
        guard let message = viewModel.message(at: indexPath.item) else { return CGSize(width: width, height: height) }
        
        height = estimateFrameForText(message.text).height + 20
        return CGSize(width: width, height: height)
    }
    
    func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
}

extension ChatViewController: MessageContentCellDelegate {
    private func setupCollectionView() {
        //collectionView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = ColorPalette.mainGrayColor
        collectionView?.registerClass(ChatMessageCell.self)
        collectionView?.keyboardDismissMode = .interactive
    }
    
    @objc func hideKeyboard() {
        inputContainerView.inputTextField.resignFirstResponder()
    }
    
    func bindViewModel() {
        viewModel.didUpdate = {[weak self] in
            self?.collectionView?.reloadData()
            if let viewModel = self?.viewModel, viewModel.messagesCount > 0 {
                let indexPath = IndexPath(item: viewModel.messagesCount - 1, section: 0)
                self?.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
}

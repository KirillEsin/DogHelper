//
//  ChatMessageCell.swift
//  Lets swap
//
//  Created by Кирилл on 13.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol MessageContentCellDelegate {
}

class ChatMessageCell: UICollectionViewCell {
    
    var message: Message? {
        didSet {
            guard let message = message else {
                return
            }
            setupViewModel(message)
        }
    }
    
    var chatController: ChatViewController?
    var delegate: MessageContentCellDelegate?
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.isUserInteractionEnabled = false
        tv.textColor = .white
        tv.isEditable = false
        return tv
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.mainColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private func setupViewModel(_ message: Message) {
        
        guard let chatController = chatController else { return }
        
        switch message.messageType {
        case .question:
            bubbleViewRightAnchor?.isActive = true
            bubbleViewLeftAnchor?.isActive = false
            bubbleView.backgroundColor = ColorPalette.mainColor
            textView.textColor = .white
        case .answer:
            bubbleViewRightAnchor?.isActive = false
            bubbleViewLeftAnchor?.isActive = true
            bubbleView.backgroundColor = ColorPalette.addDogTypeViewColor
            textView.textColor = ColorPalette.mainColor
        }
        configureText(text: message.text, chatController: chatController)
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    private func configureText(text: String, chatController: ChatViewController) {
        bubbleWidthAnchor?.constant = chatController.estimateFrameForText(text).width + 32
        textView.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
    
        let padding: CGFloat = 8.0
    
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
        
        bubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

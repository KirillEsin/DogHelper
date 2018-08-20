//
//  ChatInputContainerView.swift
//  Lets swap
//
//  Created by Кирилл on 13.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

class ChatInputContainerView: UIView, UITextViewDelegate {
    
    weak var chatController: ChatViewController? {
        didSet {
            sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    lazy var inputTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.cornerRadius = 16
        textView.layer.borderWidth = 1
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        textView.layer.borderColor = UIColor(r: 220, g: 220, b: 220).cgColor
        textView.tintColor = ColorPalette.mainColor
        textView.clipsToBounds = true
        return textView
    }()
    
    let sendButton = UIButton(type: .system)
    var baseHeight: CGFloat = 50.0
    
    @objc func sendMessage() {
        chatController?.sendMessage(text: inputTextField.text)
        inputTextField.text = ""
        
        constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = baseHeight
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let padding: CGFloat = 8.0
        backgroundColor = ColorPalette.mainGrayColor
        
        sendButton.setTitle("Send".localized(), for: UIControlState())
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLineView)
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //chatController?.handleSend()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                guard estimatedSize.height < 100 else {
                    return
                }
                constraint.constant = textView.contentSize.height + 21
            }
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
}

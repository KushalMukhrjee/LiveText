//
//  ViewController.swift
//  LiveText
//
//  Created by Kushal Mukherjee on 16/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var giftCardNumberTextField = { () -> UITextField in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Gift Card Number*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.autocorrectionType = .no
        return textField
        
    }()
    
    lazy var giftCardTextFieldUnderline = { () -> UIView in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
        
    }()
    
    lazy var giftCardNumberCameraIconButton = { () -> UIButton in
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .black
        return button
    }()
    
    lazy var saveButton = { () -> UIButton in
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .gray
        button.isEnabled = false
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if giftCardNumberTextField.canPerformAction(#selector(captureTextFromCamera(_:)), withSender: giftCardNumberTextField) {
            giftCardNumberCameraIconButton.isHidden = false
        } else {
            giftCardNumberCameraIconButton.isHidden = true
        }
        
    }
    
    func setupView() {
        self.navigationItem.title = "Save a Gift Card"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.view.backgroundColor = .white
        
        self.view.addSubview(giftCardNumberTextField)
        self.view.addSubview(giftCardTextFieldUnderline)
        self.view.addSubview(giftCardNumberCameraIconButton)
        self.view.addSubview(saveButton)
        addDoneButtonOnKeyboard()
        
        giftCardNumberTextField.addAction(UIAction(handler: { [weak self] _ in
            if self?.giftCardNumberTextField.text?.isEmpty ?? true {
                self?.saveButton.isEnabled = false
                self?.saveButton.backgroundColor = .gray
            } else {
                self?.saveButton.isEnabled = true
                self?.saveButton.backgroundColor = .black
            }
        }), for: .editingChanged)
        
        giftCardNumberCameraIconButton.addAction(UIAction(handler: { [weak self] _ in
            self?.giftCardNumberTextField.becomeFirstResponder()
        }), for: .touchDown)
        
        
        giftCardNumberCameraIconButton.addAction(UIAction.captureTextFromCamera(responder: giftCardNumberTextField, identifier: nil), for: .touchUpInside)
        
        saveButton.addAction(UIAction(handler: { [weak self] _ in
            self?.saveGiftCard()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            giftCardNumberTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
            giftCardNumberTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -78),
            giftCardNumberTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            giftCardNumberTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120),
            giftCardNumberTextField.heightAnchor.constraint(equalToConstant: 32),
            
            giftCardTextFieldUnderline.leadingAnchor.constraint(equalTo: giftCardNumberTextField.leadingAnchor),
            giftCardTextFieldUnderline.trailingAnchor.constraint(equalTo: giftCardNumberTextField.trailingAnchor, constant: 30),
            giftCardTextFieldUnderline.heightAnchor.constraint(equalToConstant: 1),
            giftCardTextFieldUnderline.topAnchor.constraint(equalTo: giftCardNumberTextField.bottomAnchor, constant: 8),
            
            giftCardNumberCameraIconButton.centerYAnchor.constraint(equalTo: giftCardNumberTextField.centerYAnchor),
            giftCardNumberCameraIconButton.trailingAnchor.constraint(equalTo: giftCardNumberTextField.trailingAnchor, constant: 30),
            giftCardNumberCameraIconButton.heightAnchor.constraint(equalToConstant: 32),
            giftCardNumberCameraIconButton.widthAnchor.constraint(equalToConstant: 32),
            
            saveButton.leadingAnchor.constraint(equalTo: giftCardTextFieldUnderline.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: giftCardTextFieldUnderline.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.topAnchor.constraint(equalTo: giftCardTextFieldUnderline.bottomAnchor, constant: 32)
        ])
        
        
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        giftCardNumberTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        giftCardNumberTextField.resignFirstResponder()
    }
    
    func saveGiftCard() {
        let alert = UIAlertController(title: "Gift card saved.", message: "Your gift card was successfully saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
}




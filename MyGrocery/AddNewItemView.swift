//
//  AddNewItemView.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import UIKit

protocol AddNewItemViewDelegate: class {
    func addNewItemViewDidAddNewText(text: String)
}

class AddNewItemView: UIView, UITextFieldDelegate {
    var placeholder: String!
    weak var delegate: AddNewItemViewDelegate!
    
    init(controller: UIViewController, placeholder: String) {
        super.init(frame: controller.view.frame)
        self.placeholder = placeholder
        
        setUp()
    }
    
    private func setUp() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        headerView.backgroundColor = .lightText
        
        let textField = UITextField(frame: headerView.frame)
        textField.placeholder = self.placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        
        headerView.addSubview(textField)
        self.addSubview(headerView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text, !text.isEmpty {
            delegate.addNewItemViewDidAddNewText(text: text)
            textField.text = ""
        }
        
        return textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

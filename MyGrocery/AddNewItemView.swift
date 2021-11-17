//
//  AddNewItemView.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import UIKit

class AddNewItemView: UIView, UITextFieldDelegate {
    var placeholder: String!
    var addNewItemClosure: (String) -> Void
    
    init(controller: UIViewController, placeholder: String, addNewItemClosure: @escaping (String) -> Void) {
        self.addNewItemClosure = addNewItemClosure
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
            addNewItemClosure(text)
            textField.text = ""
        }
        
        return textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

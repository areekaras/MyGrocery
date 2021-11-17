//
//  AddNewItemView.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import UIKit

class AddNewItemView: UIView {
    let placeholder: String
    
    init(controller: UIViewController, placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: controller.view.frame)
        
        setUp()
    }
    
    private func setUp() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        headerView.backgroundColor = .lightText
        
        let textField = UITextField(frame: headerView.frame)
        textField.placeholder = self.placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
//        textField.delegate = self
        
        headerView.addSubview(textField)
        self.addSubview(headerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

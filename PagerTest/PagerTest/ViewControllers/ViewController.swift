//
//  ViewController.swift
//  
//
//  Created by Vitaliy Yarkun on 11.07.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import AsyncDisplayKit


final class ViewController: ASDKViewController<ViewNode> {
    
    // MARK: Lifecycle
    
    override init() {
        super.init(node: ViewNode())
        
        node.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        node.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - ViewNodeDelegate

extension ViewController: ViewNodeDelegate {
    
    func didPressOkButton() {
   
    }
    
    func didPressCancelButton() {
       
    }
}

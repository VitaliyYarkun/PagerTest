//
//  PagerCellNode.swift
//
//
//  Created by Vitaliy Yarkun on 19.08.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import AsyncDisplayKit

// MARK: - Helpers

private enum Attributes {
    
    static let title: [NSAttributedString.Key: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
       
        return [.font: FontBook.Poppins.font(.SemiBold, 24.0),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle]
    }()
    
    static let description: [NSAttributedString.Key: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        return [.font: FontBook.SFProText.font(.Regular, 14.0),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle]
    }()
}

// MARK: - Class implementation

final class PagerCellNode: ASCellNode {
    
    // MARK: - Properties
    
    private let whiteZoneSize: CGSize
    
    // MARK: Nodes
    
    private let imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let bottomContainerNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.white
        node.cornerRadius = 16.0
        return node
    }()
    
    private let titleNode: ASTextNode = ASTextNode()
    
    private let descriptionNode: ASTextNode = ASTextNode()
    
    // MARK: - Lifecycle
    
    init(page: PageModel, whiteZoneSize: CGSize) {
        self.whiteZoneSize = whiteZoneSize
        
        super.init()
        
        automaticallyManagesSubnodes = true
        bottomContainerNode.automaticallyManagesSubnodes = true
        
        setupContent(from: page)
        
        setupContainerLayout()
    }
    
    // MARK: - Methods
    
    private func setupContent(from model: PageModel) {
        imageNode.image = model.image
        
        titleNode.attributedText = model.title.attributed(with: Attributes.title)
        
        descriptionNode.attributedText = model.description.attributed(with: Attributes.description)
    }
    
    private func setupContainerLayout() {
        bottomContainerNode.layoutSpecBlock = { node, constrainedSize in
            
            let descriptionInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 40.0, bottom: 0.0, right: 40.0), child: self.descriptionNode)
            let stack = ASStackLayoutSpec(direction: .vertical, spacing: 10.0, justifyContent: .start, alignItems: .center, children: [self.titleNode, descriptionInset])
            let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0), child: stack)
            
            return inset
        }
    }
    
    // MARK: Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        bottomContainerNode.style.preferredSize = whiteZoneSize

        let stack = ASStackLayoutSpec(direction: .vertical, spacing: -20.0, justifyContent: .end, alignItems: .center, children: [imageNode, bottomContainerNode])
        
        return stack
    }
}

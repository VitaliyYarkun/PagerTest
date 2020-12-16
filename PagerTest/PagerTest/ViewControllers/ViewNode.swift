//
//  ViewNode.swift
//
//
//  Created by Vitaliy Yarkun on 11.07.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import AsyncDisplayKit

// MARK: - Helpers

enum FontBook: String {
    
    // MARK: Family
    
    case Poppins = "Poppins"
        
    case SFProText = "SFProText"
    
    // MARK: Weight
    
    enum Weight: String {
        
        case Bold = "Bold"
        
        case SemiBold = "SemiBold"
        
        case Regular = "Regular"
        
        case Medium = "Medium"
    }
    
    // MARK: Methods
    
    func font(_ weight: Weight, _ size: CGFloat) -> UIFont {
        let name = self.rawValue + "-" + weight.rawValue
        return UIFont(name: name, size: size)!
    }
}

extension String {
    
    func attributed(with attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}

extension UIApplication {
    
    static var hasTopNotch: Bool {
        if #available(iOS 13.0,  *) {
            return shared.windows.filter({ $0.isKeyWindow }).first?.safeAreaInsets.top ?? 0 > 20
        } else{
            return shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
    }
}

extension CGSize {
    
    static let screen: CGSize = UIScreen.main.bounds.size
}


extension UIButton {
    
    enum Default {
        
        static let height: CGFloat = {
            if UIApplication.hasTopNotch {
                return CGSize.screen.height * 0.075
            } else {
                return CGSize.screen.height * 0.09
            }
        }()
    }
}

private enum Size {

    static let whiteZone: CGSize = {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height: screenSize.height * 0.4)
    }()
}

private enum Attributes {
    
    static let okButton: [NSAttributedString.Key: Any] = [.font: FontBook.SFProText.font(.SemiBold, 14.0),
                                                          .foregroundColor: UIColor.black]
    static let cancelButton: [NSAttributedString.Key: Any] = [.font: FontBook.SFProText.font(.SemiBold, 14.0),
                                                              .foregroundColor: UIColor.white]
}

// MARK: - Delegates

protocol ViewNodeDelegate: class {
    
    func didPressOkButton()
    func didPressCancelButton()
}

// MARK: - Class implementation

final class ViewNode: ASDisplayNode {
    
    // MARK: Properties
    
    weak var delegate: ViewNodeDelegate?
    
    // MARK: Nodes
    
    private let pagerNode: PagerNode = PagerNode(whiteZoneSize: Size.whiteZone)
    
    private let okButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSLocalizedString("Ok", comment: "").attributed(with: Attributes.okButton), for: .normal)
        node.backgroundColor = .gray
        return node
    }()
    
    private let cancelButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSLocalizedString("Cancel", comment: "").attributed(with: Attributes.cancelButton), for: .normal)
        node.backgroundColor = .black
        return node
    }()
    
    // MARK: Lifecycle
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        
        okButtonNode.addTarget(self, action: #selector(okAction), forControlEvents: .touchUpInside)
        cancelButtonNode.addTarget(self, action: #selector(cancelAction), forControlEvents: .touchUpInside)
    }
    
    // MARK: Methods
    
    @objc private func okAction() {
        delegate?.didPressOkButton()
    }
    
    @objc private func cancelAction() {
        delegate?.didPressCancelButton()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Pager
        let wrapper = ASWrapperLayoutSpec(layoutElement: pagerNode)
        wrapper.style.flexGrow = 1.0
        wrapper.style.flexShrink = 1.0

        // Bottom buttons
        let buttons = [okButtonNode, cancelButtonNode]
        buttons.forEach {
            $0.style.preferredSize = CGSize(width: Size.whiteZone.width * 0.42, height: UIButton.Default.height) 
            $0.cornerRadius = 16.0
            $0.zPosition = 1.0
        }
        
        let buttonsStack = ASStackLayoutSpec(direction: .horizontal, spacing: 20.0, justifyContent: .spaceBetween, alignItems: .center, children: buttons)
        
        let buttonsStackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 10.0, bottom: 20.0, right: 10.0), child: buttonsStack)
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: -(Size.whiteZone.height * 0.4), justifyContent: .end, alignItems: .center, children: [wrapper, buttonsStackInset])
        
        return stack
    }
}

//
//  PagerNode.swift
//  
//
//  Created by Vitaliy Yarkun on 19.08.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import AsyncDisplayKit

extension UIColor {
    
    func toImage(size: CGSize = CGSize(width: 300, height: 450)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

final class PagerNode: ASPagerNode {
    
    // MARK: Properties
    
    fileprivate let pages: [PageModel]
    
    fileprivate let whiteZoneSize: CGSize
    
    // MARK: Lifecycle
    
    init(whiteZoneSize: CGSize) {
        self.whiteZoneSize = whiteZoneSize
        
        self.pages = [PageModel(title: NSLocalizedString("Title One", comment: ""),
                                     description: NSLocalizedString("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", comment: ""),
                                     image: UIColor.yellow.toImage()),
                      PageModel(title: NSLocalizedString("Title Two", comment: ""),
                                     description: NSLocalizedString("It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", comment: ""),
                                     image: UIColor.red.toImage()),
                      PageModel(title: NSLocalizedString("Title Three", comment: ""),
                                     description: NSLocalizedString("It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", comment: ""),
                                     image: UIColor.green.toImage())]
        
        let layout = ASPagerFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout, layoutFacilitator: nil)
    }
    
    override func didLoad() {
        super.didLoad()
        
        setupNode()
    }
    
    // MARK: Methods
    
    private func setupNode() {
        backgroundColor = .clear
        allowsSelection = false
        setDataSource(self)
    }
}

// MARK: - ASPagerDataSource

extension PagerNode: ASPagerDataSource {
    
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return pages.count
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let model = pages[index]
        let cell = PagerCellNode(page: model, whiteZoneSize: whiteZoneSize)
        return cell
    }
}

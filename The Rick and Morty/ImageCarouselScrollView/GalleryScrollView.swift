//
//  GalleryScrollView.swift
//  The Rick and Morty
//
//  Created by Vadlet on 22.09.2022.
//

import UIKit

final class GalleryScrollView: UIView {
    
    private lazy var imageScrollView = UIScrollView()
    
    private lazy var viewOne: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .gray
        return contentView
    }()
    
    private lazy var viewTwo: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .green
        return contentView
    }()
    
    private lazy var viewThree: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .blue
        return contentView
    }()
  
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageScrollView.delegate = self
        imageScrollView.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        addSubview(imageScrollView)
        setupScrollView()
        let imageViews: [UIView] = [viewOne, viewTwo, viewThree]
        imageViews.forEach(imageScrollView.addSubview)
    }
    
    private func setupScrollView() {
        
        imageScrollView.decelerationRate = .fast
        imageScrollView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let scrollViewRect = frame
        
        let horizontalItemOffsetFromSuperView: CGFloat = 16.0
        let spaceBetweenItems: CGFloat = 16.0
        let itemWidth = frame.width - horizontalItemOffsetFromSuperView * 2
        let itemHeight: CGFloat = scrollViewRect.height
        
        var startX: CGFloat = 0.0
        
        let imageViews = [viewOne, viewTwo, viewThree]
        imageViews.forEach { view in
            view.frame.origin = CGPoint(x: startX, y: 0.0)
            view.frame.size = CGSize(width: itemWidth, height: itemHeight)
            startX += itemWidth + spaceBetweenItems
        }
        
        let viewsCount: CGFloat = 3.0
        let contentWidth: CGFloat = itemWidth * viewsCount + spaceBetweenItems * (viewsCount - 1.0)
        
        imageScrollView.frame = scrollViewRect
        imageScrollView.contentSize = CGSize(width: contentWidth, height: frame.height)
    }
}

extension GalleryScrollView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let gap: CGFloat = viewTwo.frame.width / 3
        let targetRightOffsetX = targetContentOffset.pointee.x + frame.width
        
        if (viewThree.frame.minX + gap) < targetRightOffsetX {
            targetContentOffset.pointee.x = viewThree.frame.midX - frame.midX
        } else if (viewOne.frame.maxX - gap) > targetContentOffset.pointee.x {
            targetContentOffset.pointee.x = viewOne.frame.midX - frame.midX
        } else {
            targetContentOffset.pointee.x = viewTwo.frame.midX - frame.midX
        }
    }
}

//
//  CollectionViewCell.swift
//  FR3
//
//  Created by Michael Brewington on 3/31/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var Bubble: UITextView!
    
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //setNeedsLayout()
        //layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    var name: String = "" {
        didSet {
            Bubble.text = name
            
         //   Bubble.textColor = UIColor.white
         //   Bubble.backgroundColor = UIColor.gray
         //   Bubble.layer.cornerRadius = 10
          //  let frame = Bubble.sizeThatFits(CGSize(width: 290, height: CGFloat.greatestFiniteMagnitude))
          //  Bubble.frame.size = CGSize(width: frame.width, height: frame.height)
        }
    }
    
    var value: Bool? = nil{
        didSet{
            test = value
        }
    }
    
    var BubbleValue: NSLayoutConstraint? = nil{
        didSet {
            BubbleWidthAnchor = BubbleValue
        }
    }
    
    var BubbleWidthAnchor: NSLayoutConstraint?
    var test: Bool?
    var constant: CGFloat?
    var BubbleViewRightAnchor: NSLayoutConstraint?
    var BubbleViewLeftAnchor: NSLayoutConstraint?
    
    //var test: Bool?
    /*
    func modify(){
        if test == true {
            
            Bubble.translatesAutoresizingMaskIntoConstraints = false
            BubbleViewRightAnchor = Bubble.rightAnchor.constraint(equalTo: self.rightAnchor)
            BubbleViewRightAnchor?.isActive = true
            
            BubbleViewLeftAnchor = Bubble.leftAnchor.constraint(equalTo: self.leftAnchor)
        //     BubbleViewLeftAnchor?.isActive = false
            
            //Bubble.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            Bubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            
            BubbleWidthAnchor = Bubble.widthAnchor.constraint(equalToConstant: 200)
            BubbleWidthAnchor?.isActive = true
            Bubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        } else {
            
        }
        
        if test == false {
            Bubble.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -8).isActive = true
            Bubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            BubbleWidthAnchor = Bubble.widthAnchor.constraint(equalToConstant: 200)
            BubbleWidthAnchor?.isActive = true
            Bubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        } else {
            
        }
    }
    */
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Bubble.translatesAutoresizingMaskIntoConstraints = false
        
        BubbleViewRightAnchor = Bubble.rightAnchor.constraint(equalTo: self.rightAnchor,constant:-8)
        BubbleViewRightAnchor?.isActive = true
        
        BubbleViewLeftAnchor = Bubble.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8)
        //     BubbleViewLeftAnchor?.isActive = false
        
        //Bubble.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        Bubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        BubbleWidthAnchor = Bubble.widthAnchor.constraint(equalToConstant: 200)
        BubbleWidthAnchor?.isActive = true
        
        Bubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        
        Bubble.textColor = UIColor.white
     //   Bubble.backgroundColor = UIColor.gray
        Bubble.layer.cornerRadius = 10
        //Bubble.layer.masksToBounds = true
        // Initialization code
    }

}

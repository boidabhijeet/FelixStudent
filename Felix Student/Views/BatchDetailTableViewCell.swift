//
//  BatchDetailTableViewCell.swift
//  Felix Student
//
//  Created by Mac on 12/05/21.
//

import UIKit

class BatchDetailTableViewCell: UITableViewCell {
    
    let imgUser = UIImageView()
    let labUserName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUser.backgroundColor = UIColor.blue
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUserName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labTime.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(labUserName)
        contentView.addSubview(labMessage)
        contentView.addSubview(labTime)
        
        let viewsDict = [
            "image": imgUser,
            "username": labUserName,
            "message": labMessage,
            "labTime": labTime,
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

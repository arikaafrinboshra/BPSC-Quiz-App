//
//  ProfileTableViewCell.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 4/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var progressLabel: UIProgressView!
    @IBOutlet weak var markInPercentage: UILabel!
    @IBOutlet weak var markComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
       // self.progressLabel.progress = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        contentView.layer.cornerRadius = 8
        
    }
    

}

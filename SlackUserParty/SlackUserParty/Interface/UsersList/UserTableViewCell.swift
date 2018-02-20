//
//  UserTableViewCell.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

struct UserTableViewCellData {
    let userName: String
    let userNameTextColor: UIColor
    let userImageURL: String
    let ascentColor: UIColor
    let isAscentUpOriented: Bool
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var data: UserTableViewCellData?
    
    static let name = String(describing: UserTableViewCell.self)
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let data = data else { return }
        
        let lengthOfSlant: CGFloat = 50
        let startOfSlant = rect.origin.x + 0.5 * rect.width
        let endOfSlant = startOfSlant + lengthOfSlant
        let maxX = rect.origin.x + rect.width
        let maxY = rect.origin.y + rect.height
        
        context.beginPath()
        context.move(to: CGPoint(x: data.isAscentUpOriented ? startOfSlant : endOfSlant, y: maxY))
        context.addLine(to: CGPoint(x: data.isAscentUpOriented ? endOfSlant : startOfSlant, y: rect.origin.y))
        context.addLine(to: CGPoint(x: maxX, y: rect.origin.y))
        context.addLine(to: CGPoint(x: maxX, y: maxY))
        context.closePath()

        context.setFillColor(data.ascentColor.cgColor)
        context.fillPath()
    }
    
    func configure(with data: UserTableViewCellData) {
        self.data = data 
        userImage.asyncImage(with: data.userImageURL)
        userName.text = data.userName
        userName.textColor = data.userNameTextColor
        
        // we must display to update our color ascent 
        setNeedsDisplay()
    }
}

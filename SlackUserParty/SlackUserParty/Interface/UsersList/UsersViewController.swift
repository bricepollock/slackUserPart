//
//  ViewController.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    // Placing strings up here will help when we create a unified localization strategy later and need to pull them out
    let homeNavTitle = "Slack User List"
    
    @IBOutlet weak var tableView: UITableView!
    
    let userService = SlackUserService()
    let processor = UsersViewProcessor()
    var userResponse: UserListResponse?
    var usersViewData = [UserTableViewCellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = homeNavTitle
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .singleLine
        
        UserTableViewCell.register(in: tableView)
        
        // Leave dispatch logic in the VC for now until we see reason to create:
        //      1. Middle tier services to handle parallel / serial api calls
        //      2. Create an abstract framework to handle parallel / serial api calls safely (or use rxSwift)
        //
        // When these get too large I throw them in an extension so they are not distracting from layout code
        DispatchQueue.global().async { [weak self] in
            self?.userService.users { [weak self] (response) in
                guard let `self` = self else { return }
                guard let response = response else { return }
                
                self.userResponse = response
                self.usersViewData = self.processor.createUsersData(from: response)
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    // The slack API currently only returns 8 responses, but I expected pagination would be necessary.
    // We'll use this method in the future to add pagination. I left in here just to discuss but normally
    // I would remove unused methods
    func loadMoreUsers() {    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.name, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        guard let data = usersViewData[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(with: data)
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard let user = userResponse?.members[safe: indexPath.row] else { return }
        let nextVC = UserProfileViewController.create(for: user)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


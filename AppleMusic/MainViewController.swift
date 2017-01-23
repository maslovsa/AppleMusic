//
//  ViewController.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    fileprivate var tableView = UITableView()
    var data: [SearchItem] = [SearchItem.JJ1(), SearchItem.JJ1()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        AppleMusicManager().search(query: "jack johnson") { items in
            if let items = items {
                DispatchQueue.main.async {
                    self.data = items
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        
        tableView.register(SearchItemCell.self, forCellReuseIdentifier: SearchItemCell.Identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: - Public functions
    func launchInfo(with cell: SearchItemCell) {
        let vc = DetailItemViewController()
        vc.searchItem = cell.searchItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let identifier = SearchItemCell.Identifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as? SearchItemCell {
            cell.configure(item)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(SearchItemCell.CellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchItemCell {
            launchInfo(with: cell)
        }
    }
}

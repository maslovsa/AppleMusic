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
    fileprivate var buttonSearch = UIButton(type: .system)
    fileprivate var editQuery = UITextField()
    fileprivate var effectView = UIVisualEffectView(effect: UIBlurEffect())
    
    var data: [SearchItem] = [SearchItem.JJ1(), SearchItem.JJ1()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
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
    
    private func initSearch() {
        
        view.addSubview(effectView)
        effectView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.right.left.equalTo(view)
            make.height.equalTo(50)
        }
        
        buttonSearch.tintColor = UIColor.lightGray
        buttonSearch.setTitle("Search", for: .normal)
        buttonSearch.addTarget(self, action: #selector(MainViewController.clickSearch), for: .touchUpInside)
        view.addSubview(buttonSearch)
        buttonSearch.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(18)
            make.right.equalTo(view).offset(-8)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        editQuery.placeholder = "Search"
        editQuery.textColor = UIColor.white
        editQuery.background = UIImage.stubImage
        editQuery.delegate = self
        view.addSubview(editQuery)
        editQuery.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(18)
            make.left.equalTo(view).offset(8)
            make.right.equalTo(view).offset(-60)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - Public functions
    func launchInfo(with cell: SearchItemCell) {
        let vc = DetailItemViewController()
        vc.searchItem = cell.searchItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func clickSearch() {
        guard let query = editQuery.text else {
            return
        }
        
        AppleMusicManager().search(query: query) { items in
            if let items = items {
                DispatchQueue.main.async {
                    self.data = items
                    self.tableView.reloadData()
                }
            }
        }
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

extension MainViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clickSearch()
        view.endEditing(true)
        return false
    }
}

//
//  LikedListTableViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class LikedListTableViewController: UITableViewController {

    // いいね」された名前の一覧
    var likedName: [String] = []
    // 「いいね」された人の職業
    var likedJob: [String] = []
    // 「いいね」された人の出身
    var likedTown: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セルを登録
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }

    // MARK: - Table view data source

    // 必須:セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedName.count
    }
    
    // セルの高さを75に変更
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    // 必須:セルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        // 画像の設定
        cell.faceImage?.image = UIImage(named: likedName[indexPath.row])
        // 名前の設定
        cell.nameLabel.text = likedName[indexPath.row]
        // 職業の設定
        cell.jobLabel.text = likedJob[indexPath.row]
        // 出身の設定
        cell.townLabel.text = likedTown[indexPath.row]
        return cell
    }

}

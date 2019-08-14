//
//  ViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // viewの動作をコントロールする
    @IBOutlet weak var baseCard: UIView!
    // スワイプ中にgood or bad の表示
    @IBOutlet weak var likeImage: UIImageView!
    
    // ユーザーカード1の情報
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var personImage1: UIImageView!
    @IBOutlet weak var personName1: UILabel!
    @IBOutlet weak var personJob1: UILabel!
    @IBOutlet weak var personOrigin1: UILabel!
    
    // ユーザーカード2の情報
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var personImage2: UIImageView!
    @IBOutlet weak var personName2: UILabel!
    @IBOutlet weak var personJob2: UILabel!
    @IBOutlet weak var personOrigin2: UILabel!
    
    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    // どちらビューを表示させるか
    var selectedCardCount: Int = 0
    // 次に表示させるユーザーリストの番目
    var nextShowViewCount: Int = 2
    // 現在表示させているユーザーリストの番目
    var showViewCount: Int = 0
    
    /// ユーザーリスト
    let userList: [UserData] = [
        UserData(name: "津田梅子", image: #imageLiteral(resourceName: "津田梅子"), job: "教師", homeTown: "千葉", backColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)),
        UserData(name: "ジョージワシントン", image: #imageLiteral(resourceName: "ジョージワシントン"), job: "大統領", homeTown: "アメリカ", backColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
        UserData(name: "ガリレオガリレイ", image: #imageLiteral(resourceName: "ガリレオガリレイ"), job: "物理学者", homeTown: "イタリア", backColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
        UserData(name: "板垣退助", image: #imageLiteral(resourceName: "板垣退助"), job: "議員", homeTown: "高知", backColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
        UserData(name: "ジョン万次郎", image: #imageLiteral(resourceName: "ジョン万次郎"), job: "冒険家", homeTown: "アメリカ", backColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    ]

    // 「いいね」をされた名前の配列
    var likedName: [String] = []
    
    // viewのレイアウト処理が完了した時に呼ばれる
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    // ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        personList.append(person1)
        personList.append(person2)
        
    }
    
    // セグエによる遷移前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedListTableViewController
            
            // LikedListTableViewControllerのlikedName(左)にViewCountrollewのLikedName(右)を代入
            vc.likedName = likedName
        }
    }
    
    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
    override func viewDidDisappear(_ animated: Bool) {
        // カウント初期化
        selectedCardCount = 0
        showViewCount = 0
        nextShowViewCount = 2
        // リスト初期化
        likedName = []
        
        // ビューを整理
        self.view.sendSubviewToBack(person2)
        // alpha値を元に戻す
        person2.alpha = 1
        
        // 二枚のビューを初期化
        // 前面のビュー
        let user1 = userList[showViewCount]
        // ビューの背景に色をつける
        person1.backgroundColor = user1.backColor
        // ラベルに名前を表示
        personName1.text = user1.name
        // ラベルに職業を表示
        personJob1.text = user1.job
        // ラベルに出身地を表示
        personOrigin1.text = user1.homeTown
        // 画像を表示
        personImage1.image = user1.image
        
        // 背面のビュー
        let user2 = userList[showViewCount + 1]
        // ビューの背景に色をつける
        person2.backgroundColor = user2.backColor
        // ラベルに名前を表示
        personName2.text = user2.name
        // ラベルに職業を表示
        personJob2.text = user2.job
        // ラベルに出身地を表示
        personOrigin2.text = user2.homeTown
        // 画像を表示
        personImage2.image = user2.image
    }
    
    func resetPersonList() {
        // 5人の飛んで行ったビューを元の位置に戻す
        for person in personList {
            // 元に戻す処理
            person.center = self.centerOfCard
            person.transform = .identity
        }
    }
    
    // ベースカードを元に戻す
    func resetCard() {
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
    }
    
    // ユーザーカードを次に進める処理
    func nextUserView() {
        // ユーザーカードを元に戻す
        // 背面に持っていく
        self.view.sendSubviewToBack(personList[selectedCardCount])
        // 中央に戻す
        personList[selectedCardCount].center = centerOfCard
        personList[selectedCardCount].transform = .identity
        
        // ビューがすべての人物を描画し終わったら、ビューを真っ白にするようにする
        if nextShowViewCount < userList.count {
            checkUserCard()
        } else {
            // 背面のビューを見えなくする
            person2.alpha = 0
        }
        
        // 次のカードへ
        nextShowViewCount += 1
        showViewCount += 1
        
        if showViewCount >= userList.count {
            // 遷移処理
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
        
        
        
        selectedCardCount = showViewCount % 2
    }
    
    //
    func checkUserCard() {
        // 表示されているカードの名前を保管
        let user = userList[nextShowViewCount]
        // 表示するビューを管理する
        if selectedCardCount == 0 {
            // ビューの背景に色をつける
            person1.backgroundColor = user.backColor
            // ラベルに名前を表示
            personName1.text = user.name
            // ラベルに職業を表示
            personJob1.text = user.job
            // ラベルに出身地を表示
            personOrigin1.text = user.homeTown
            // 画像を表示
            personImage1.image = user.image
        } else {
            // ビューの背景に色をつける
            person2.backgroundColor = user.backColor
            // ラベルに名前を表示
            personName2.text = user.name
            // ラベルに職業を表示
            personJob2.text = user.job
            // ラベルに出身地を表示
            personOrigin2.text = user.homeTown
            // 画像を表示
            personImage2.image = user.image
        }
    }
    
    // スワイプ処理
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        
        // ベースカード
        let card = sender.view!
        // 動いた距離
        let point = sender.translation(in: view)
        // 取得できた距離をcard.centerに加算
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        // ユーザーカードにも同じ動きをさせる
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        // 元々の位置と移動先との差
        let xfromCenter = card.center.x - view.center.x
        // 角度をつける処理
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        // ユーザーカードに角度をつける
        personList[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        // likeImageの表示のコントロール
        if xfromCenter > 0 {
            // goodを表示
            likeImage.image = #imageLiteral(resourceName: "いいね")
            likeImage.isHidden = false
        } else if xfromCenter < 0 {
            // badを表示
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            likeImage.isHidden = false
        }
        
        // 元の位置に戻す処理
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.5, animations: {
                    // 左へ飛ばす場合
                    // X座標を左に500とばす(-500)
                    self.personList[self.selectedCardCount].center = CGPoint(x: self.personList[self.selectedCardCount].center.x - 500, y :self.personList[self.selectedCardCount].center.y)
                    
                })
                // ベースカードの角度と位置を戻す
                resetCard()
                // likeImageを隠す
                likeImage.isHidden = true
                // ユーザーカードを元に戻す
                nextUserView()
            } else if card.center.x > self.view.frame.width - 50 {
                // 右に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.5, animations: {
                    // 右へ飛ばす場合
                    // X座標を右に500とばす(+500)
                    self.personList[self.selectedCardCount].center = CGPoint(x: self.personList[self.selectedCardCount].center.x + 500, y :self.personList[self.selectedCardCount].center.y)
                    
                })
                // ベースカードの角度と位置を戻す
                resetCard()
                // likeImageを隠す
                likeImage.isHidden = true
                // いいねリストに追加
                likedName.append(userList[showViewCount].name)
                
                // ユーザーカードを元に戻す
                nextUserView()
            } else {
                // アニメーションをつける
                UIView.animate(withDuration: 0.5, animations: {
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードの角度を元の位置に戻す
                    self.personList[self.selectedCardCount].transform = .identity
                    // ベースカードの角度と位置を戻す
                    self.resetCard()
                    // likeImageを隠す
                    self.likeImage.isHidden = true
                })
            }
        }
    }
    
    // よくないねボタン
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            // ベースカードをリセット
            self.resetCard()
            // ユーザーカードを左にとばす
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y:self.personList[self.selectedCardCount].center.y)
        })
        
        // ボタンを選択できなくする(連打防止)
        sender.isEnabled = false
        // 0.5秒後に次のカードを表示させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            // 次のユーザーカードを表示させる
            self.nextUserView()
            // ボタンを元に戻す
            sender.isEnabled = true
        })
    }
    
    // いいねボタン
    @IBAction func likeButtonTaped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.resetCard()
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y:self.personList[self.selectedCardCount].center.y)
        })
        
        // いいねリストに追加
        likedName.append(userList[showViewCount].name)
        
        // ボタンを選択できなくする(連打防止)
        sender.isEnabled = false
        // 0.5秒後に次のカードを表示させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            // 次のユーザーカードを表示させる
            self.nextUserView()
            // ボタンを元に戻す
            sender.isEnabled = true
        })
    }
}


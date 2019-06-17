//
//  ViewController.swift
//  TableViewCell3
//
//  Created by ouyou on 2019/06/17.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var item1: NSMutableArray = ["老虎","狮子","蛇","熊猫","狼"]
    var item2: NSMutableArray = ["白菜","茼蒿菜","小松菜"]
    var item3: NSMutableArray = ["吉普车","跑车","公交车","货车","轿车","面包车","三轮车"]
    var sections:Array = [Dictionary<String,NSMutableArray>]()
    
    var isFolden1 : Bool = false
    var isFolden2 : Bool = false
    var isFolden3 : Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let section1: Dictionary = ["动物":item1]
        let section2: Dictionary = ["蔬菜":item2]
        let section3: Dictionary = ["汽车":item3]
        sections = [section1,section2,section3]
      
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        for key in sections[section].keys{
            title = key
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // セクションのヘッダとなるビューを作成する。
        let myView: UIView = UIView()
        let label:UILabel = UILabel()
        for (key) in sections[section].keys
        {
            label.text = key
        }
        label.sizeToFit()
        label.textColor = UIColor.black
        myView.addSubview(label)
        myView.backgroundColor = UIColor.lightGray
        
        // セクションのビューに対応する番号を設定する。
        myView.tag = section
        // セクションのビューにタップジェスチャーを設定する。
        myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(gestureRecognizer:))))
        
        return myView
    }
    
    @objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        print("hahaha")
        // タップされたセクションを取得する。
        guard let section = gestureRecognizer.view?.tag as Int? else {
            return
        }
        
        // フラグを設定する。
        switch section {
        case 0:
            isFolden1 = isFolden1 ? false : true
        case 1:
            isFolden2 = isFolden2 ? false : true
        case 2:
            isFolden3 = isFolden3 ? false : true
        default:
            break
        }
        // タップされたセクションを再読込する。
       tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return isFolden1 ? 0 : item1.count
        case 1:
            return isFolden2 ? 0 : item2.count
        case 2:
            return isFolden3 ? 0 : item3.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for:indexPath as IndexPath)
        for value in sections[indexPath.section].values {
            cell.textLabel?.text = value[indexPath.row] as? String
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    // テーブルビューをスワイプしてデータを削除する。
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            for (value) in self.sections[indexPath.section].values
            {
                value.removeObject(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
    }
    
    // 選択したセルの値を出力する。
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // タップしたセルのテキストを取得する。
        var selectText = ""
        for (value) in self.sections[indexPath.section].values
        {
            selectText = value[indexPath.row] as! String
        }
        
        // アラートを生成する。
        let alert: UIAlertController = UIAlertController(title: selectText, message: "\(selectText)を選択しました。", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alert.addAction(defaultAction)
        
        // アラートを表示する。
        present(alert, animated: true, completion: nil)
    }
    

    
}

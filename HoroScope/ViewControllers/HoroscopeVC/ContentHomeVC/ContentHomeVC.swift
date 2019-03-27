//
//  TodayVC.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/25/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class ContentHomeVC: BaseVC {
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lbName: KHLabel!
    @IBOutlet weak var lbDate: KHLabel!
    @IBOutlet weak var tableView: UITableView!
    
    var zodiac: ZodiacObj = ZodiacObj()
    var type: TimeType = .general
    let fontDefault = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 17))
    
    init(type: TimeType, zodiac: ZodiacObj) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        self.zodiac = zodiac
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GCDCommon.mainQueue {
            self.tableView.setContentOffset(.zero, animated: false)
        }
    }

    @IBAction func action_tapImage(_ sender: Any) {
        Common.postNotificationCenter(key: NotificationCenterKey.ShowZodiacsVC, object: nil)
    }
    
}

extension ContentHomeVC {
    func initUI() {
        self.lbName.text = zodiac.name
        self.lbDate.text = zodiac.date
        imgMain.image = zodiac.img
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isIPad ? 70 : 44, right: 0)
        tableView.register(CellContent.self)
    }
    
    func initData() {
        
    }
}

extension ContentHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type == .general ? zodiac.content.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellContent
        switch type {
        case .general:
            cell.config(content: zodiac.content[indexPath.item])
            break
        case .today:
            cell.config(content: zodiac.today)
            break
        case .week:
            cell.config(content: zodiac.week)
            break
        case .month:
            cell.config(content: zodiac.month)
            break
        case .year:
            cell.config(content: zodiac.year)
            break
        }
        return cell
    }
    
    
}

extension ContentHomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

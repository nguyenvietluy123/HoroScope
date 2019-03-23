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
    @IBOutlet weak var textView: KHTextView!
    
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
            self.textView.setContentOffset(.zero, animated: false)
        }
    }

    @IBAction func action_tapImage(_ sender: Any) {
        Common.postNotificationCenter(key: NotificationCenterKey.ShowZodiacsVC, object: nil)
//        self.present(vc, animated: true, completion: nil)/
    }
    
}

extension ContentHomeVC {
    func initUI() {
        self.lbName.text = zodiac.name
        self.lbDate.text = zodiac.date
        imgMain.image = zodiac.img
    }
    
    func initData() {
        switch type {
        case .general:
            let attributeString = NSMutableAttributedString()
            for i in zodiac.content.indices {
                attributeString.append(NSAttributedString(string: zodiac.content[i].title + "\n\n", attributes: [NSAttributedString.Key.font : Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.boldSystemFont(ofSize: 18)), NSAttributedString.Key.foregroundColor : (i%2 == 0) ? UIColor.green : UIColor.red]))
                attributeString.append(NSAttributedString(string: zodiac.content[i].content + "\n\n", attributes: [NSAttributedString.Key.font : fontDefault]))
            }
            self.textView.attributedText = attributeString
            break
        case .today:
            self.textView.text = zodiac.today
            break
        case .week:
            self.textView.text = zodiac.week
            break
        case .month:
            self.textView.text = zodiac.month
            break
        case .year:
            self.textView.text = zodiac.year
            break
        }
        
    }
}

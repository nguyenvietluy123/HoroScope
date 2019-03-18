//
//  AppDelegate.swift
//  HoroScope
//
//  Created by Luy Nguyen on 2/19/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import CoreData

//let kAdmobAppID         = "ca-app-pub-1947012962477196~8459063867"
//let kAdmobBanner        = "ca-app-pub-1947012962477196/2412530261"
//let kAdmobInterstitial  = "ca-app-pub-1947012962477196/2272929463"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabVC: UITabBarController?
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        GADMobileAds.configure(withApplicationID: kAdmobAppID)
//        initMainVC()
        initTabVC(2)
        return true
    }
    
    func initMainVC() {
        let vc = AnalysisScanVC.init(nibName: "AnalysisScanVC", bundle: nil)
        let navi = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
    
    func initTabVC(_ index: Int){
        tabVC = UITabBarController()
        tabVC?.tabBar.backgroundImage = nil
        tabVC?.tabBar.shadowImage = nil
        tabVC?.tabBar.layer.borderWidth = 0.0
        tabVC?.tabBar.clipsToBounds = true
        tabVC?.tabBar.contentMode = .scaleToFill
        tabVC?.tabBar.isTranslucent = false
        
        let tabHome = HomeVC(nibName:"HomeVC",bundle: nil)
        tabHome.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "tabbar_horoscope").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_horoscope").withRenderingMode(.alwaysOriginal))
        let navHome = UINavigationController(rootViewController: tabHome)
        navHome.isNavigationBarHidden = true
        let tabLove = LoveVC(nibName:"LoveVC",bundle: nil)
        tabLove.tabBarItem = UITabBarItem(title: "Love", image: #imageLiteral(resourceName: "tabbar_competition").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_competition").withRenderingMode(.alwaysOriginal))
        let navLove = UINavigationController(rootViewController: tabLove)
        navLove.isNavigationBarHidden = true
        let tabCompetition = BeautyVC(nibName:"BeautyVC",bundle: nil)
        tabCompetition.tabBarItem = UITabBarItem(title: "BeautyVC", image: #imageLiteral(resourceName: "tabbar_competition").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_competition").withRenderingMode(.alwaysOriginal))
        let navCompetition = UINavigationController(rootViewController: tabCompetition)
        navCompetition.isNavigationBarHidden = true
        let tabSetting = SettingVC(nibName:"SettingVC",bundle: nil)
        tabSetting.tabBarItem = UITabBarItem(title: "Setting", image: #imageLiteral(resourceName: "tabbar_setting").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tabbar_setting").withRenderingMode(.alwaysOriginal))
        let navSetting = UINavigationController(rootViewController: tabSetting)
        navSetting.isNavigationBarHidden = true
        tabVC?.viewControllers = [navHome, navLove, navCompetition, navSetting]
        tabVC?.selectedIndex = index
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FakeWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


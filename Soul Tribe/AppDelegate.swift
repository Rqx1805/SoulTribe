//
//  AppDelegate.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 31/05/21.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import UserNotifications
import GoogleMaps
import GooglePlaces

import FirebaseMessaging
import Firebase
import GoogleSignIn
import FBSDKCoreKit

//import FirebaseInstanceID

//import Firebase
//import FirebaseMessaging

var RId = ""
var lid = ""

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate  {
    var bc = 0
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 0.7)
        
        GMSServices.provideAPIKey(Config().googleApiKey)
        GMSPlacesClient.provideAPIKey(Config().placesApiKey)
        
        FirebaseApp.configure()
                                                                                                                     
        GIDSignIn.sharedInstance.restorePreviousSignIn()
        
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
            )
        
        if #available(iOS 10.0, *) {
                   // For iOS 10 display notification (sent via APNS)
                   UNUserNotificationCenter.current().delegate = self
                   let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                   UNUserNotificationCenter.current().requestAuthorization(
                       options: authOptions,
                       completionHandler: {__, _   in })
                   Messaging.messaging().delegate = self
               }else{
                   let settings: UIUserNotificationSettings =
                       UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                   application.registerUserNotificationSettings(settings)
                   Messaging.messaging().delegate = self
               }
               application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        let bedgeCount = UserDefaults.standard.integer(forKey: "bedgeCount")
        application.applicationIconBadgeNumber = bedgeCount
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          Messaging.messaging().apnsToken = deviceToken
          Messaging.messaging().isAutoInitEnabled = true
      }
          
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          print("token: \(String(describing: fcmToken))")
          let myDeviceToken = fcmToken
        UserDefaults.standard.setValue(myDeviceToken, forKey: "dvcTocken")
        print(DataManager.getVal(Config().AppUserDefaults.object(forKey: "dvcTocken")) as? String ?? "")
      }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "Soul_Tribe")
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
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let chat = Config().AppUserDefaults.value(forKey: "chat") as? String ?? ""
            if chat == "on" {
                print("chat is on")
            } else {
                completionHandler([.alert, .badge, .sound])
                
                let userInfo = notification.request.content.userInfo
                let data_json = DataManager.getVal(userInfo["gcm.notification.data"]) as? String ?? ""
                print(data_json)
                let dict = Config().convertToDictionary(text: data_json)
                let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                var newCount = UserDefaults.standard.value(forKey: "bedgeCount") as? Int ?? 0
                newCount += 1
                UserDefaults.standard.set(newCount, forKey: "bedgeCount")
                if newCount == 0 {
                   // UIApplication.shared.applicationIconBadgeNumber = 0
                    UserDefaults.standard.removeObject(forKey: "bedgeCount")
                } else {
                    //UIApplication.shared.applicationIconBadgeNumber = newCount
                    UserDefaults.standard.removeObject(forKey: "bedgeCount")
                }
        //
              //  let userInfo = response.notification.request.content.userInfo
               // print(userInfo)
               // let data_json = DataManager.getVal(userInfo["gcm.notification.data"]) as? String ?? ""
               // print(data_json)
              //  let dict = Config().convertToDictionary(text: data_json)
                //let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                print(type)
                if NotificationUSERvibe.contains("Mini Tribes") {
                              let ra = "Mini Tribes"
                              let newVibe = NotificationUSERvibe.replacingOccurrences(of: ra, with: "Mini")
                              if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
                                  
                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                                  let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                                  let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                                  slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                                  let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                                  if type == "like" {
                                      
                                  }else if type == "mini_tribe_post"{
                                     
                                  }else if type == "mini_tribe_invitation"{
                                     
                                  }else if type == "" {
                                      let chatViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                                      navigate.navigationController?.pushViewController(chatViewController, animated: true)
                                      UIApplication.shared.windows.first?.rootViewController = slideMenuController
                                      UIApplication.shared.windows.first?.makeKeyAndVisible()
                                  }
                                  else{
                                     
                                  }
                              }else {
                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                                  let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                                  let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                                  slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                                  let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                                  if type == "like" {
                                     
                                  }else if type == "matched"{
                                     
                                      NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                                  }else if type == "chat"{
                                     
                                      NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                                  }else if type == "" {
                                      let chatViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                                      navigate.navigationController?.pushViewController(chatViewController, animated: true)
                                      UIApplication.shared.windows.first?.rootViewController = slideMenuController
                                      UIApplication.shared.windows.first?.makeKeyAndVisible()
                                  }
                                  else if type == "mini_tribe_invitation"{
                                     
                                  }
                                  else if type == "mini_tribe_post"{
                                     
                                  }else{
                                     
                                  }
                              }
                          }else{
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                              let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                              let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                              if type == "like" {
                                
                              }else if type == "chat"{
                                 
                                  NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                              }
                              else if type == "matched"{
                                 
                                  NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                              }else{
                                 
                              }

                              if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                                  SELECT_VIBE = "Soul Love"
                              }
                              if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                                  SELECT_VIBE = "Tribe"
                              }
              //
                  }
                
                
        //        if type == "chat" {
        //            if NotificationUSERvibe.contains("Mini Tribes") {
        //                          let ra = "Mini Tribes"
        //                          let newVibe = NotificationUSERvibe.replacingOccurrences(of: ra, with: "Mini")
        //                          if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
        ////                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
        ////                              let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
        //                          }else{
        //                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                              let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
        //                              navigate.selectedIndex = 1
        //                              Config().addRedDotAtTabBarItemIndex(index: 1, tabbarController: navigate)
        //                              let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        //                              let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
        //                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
        //                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
        //                              UIApplication.shared.windows.first?.makeKeyAndVisible()
        //                          }
        //                      }else{
        //                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                          let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
        //                          Config().addRedDotAtTabBarItemIndex(index: 1, tabbarController: navigate)
        //                          let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        //                          let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
        //                          slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
        //                          UIApplication.shared.windows.first?.rootViewController = slideMenuController
        //                          UIApplication.shared.windows.first?.makeKeyAndVisible()
        //              }
        //        }

            }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("app active")
        let bedgeCount = UserDefaults.standard.integer(forKey: "bedgeCount")
        application.applicationIconBadgeNumber = bedgeCount
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        var newCount = UserDefaults.standard.value(forKey: "bedgeCount") as? Int ?? 0
        newCount += 1
        UserDefaults.standard.set(newCount, forKey: "bedgeCount")
        if newCount == 0 {
            UserDefaults.standard.removeObject(forKey: "bedgeCount")
           // UIApplication.shared.applicationIconBadgeNumber = 0
        } else {
           // UIApplication.shared.applicationIconBadgeNumber = newCount
            UserDefaults.standard.removeObject(forKey: "bedgeCount")
        }
        
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        let data_json = DataManager.getVal(userInfo["gcm.notification.data"]) as? String ?? ""
        print(data_json)
        let dict = Config().convertToDictionary(text: data_json)
        let type = DataManager.getVal(dict?["type"]) as? String ?? ""
        print(type)
        
        if NotificationUSERvibe.contains("Mini Tribes") {
                      let ra = "Mini Tribes"
                      let newVibe = NotificationUSERvibe.replacingOccurrences(of: ra, with: "Mini")
                      if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
                          
                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                          let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                          let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                          let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                          slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                          let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                          if type == "like" {
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }else if type == "mini_tribe_post"{
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }else if type == "mini_tribe_invitation"{
                              navigate.selectedIndex = 3
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }else if type == "" || type == "Ads Accepted" {
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                          else{
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              UserDefaults.standard.set("yes", forKey: "NotificationSend")
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                      }else {
                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                          let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                          let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                          let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                          slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                          let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                          if type == "like" {
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                          else if type == "matched"{
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "MessageTabVC") as! MessageTabVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                              NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                          }else if type == "chat"{
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                              NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                          }else if type == "" || type == "Ads Accepted" {
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                          else if type == "mini_tribe_invitation"{
                              navigate.selectedIndex = 3
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                          else if type == "mini_tribe_post"{
                              let chatViewController = storyboard.instantiateViewController(withIdentifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
                              chatViewController.isComeFromPushNotitfication = "yes"
                              chatViewController.notitficatioData = dict ?? [:]
                              navigate.navigationController?.pushViewController(chatViewController, animated: true)
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }else{
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              UserDefaults.standard.set("yes", forKey: "NotificationSend")
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                          }
                      }
                  }else{
                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                      let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                      let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                      slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                      let type = DataManager.getVal(dict?["type"]) as? String ?? ""
                      if type == "like" {
                          let chatViewController = storyboard.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
                          chatViewController.isComeFromPushNotitfication = "yes"
                          chatViewController.notitficatioData = dict ?? [:]
                          navigate.navigationController?.pushViewController(chatViewController, animated: true)
                          UIApplication.shared.windows.first?.rootViewController = slideMenuController
                          UIApplication.shared.windows.first?.makeKeyAndVisible()
                      }else if type == "chat"{
                          let chatViewController = storyboard.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
                          chatViewController.isComeFromPushNotitfication = "yes"
                          chatViewController.notitficatioData = dict ?? [:]
                          navigate.navigationController?.pushViewController(chatViewController, animated: true)
                          UIApplication.shared.windows.first?.rootViewController = slideMenuController
                          UIApplication.shared.windows.first?.makeKeyAndVisible()
                          NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                      }
                      else if type == "matched"{
                          let chatViewController = storyboard.instantiateViewController(withIdentifier: "MessageTabVC") as! MessageTabVC
                          chatViewController.isComeFromPushNotitfication = "yes"
                          chatViewController.notitficatioData = dict ?? [:]
                          navigate.navigationController?.pushViewController(chatViewController, animated: true)
                          UIApplication.shared.windows.first?.rootViewController = slideMenuController
                          UIApplication.shared.windows.first?.makeKeyAndVisible()
                          NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
                      }else{
                          slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                          UserDefaults.standard.set("yes", forKey: "NotificationSend")
                          UIApplication.shared.windows.first?.rootViewController = slideMenuController
                          UIApplication.shared.windows.first?.makeKeyAndVisible()
                      }

                      if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                          SELECT_VIBE = "Soul Love"
                      }
                      if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                          SELECT_VIBE = "Tribe"
                      }
      //
          }

      /* Change root view controller to a specific viewcontroller */
      // let storyboard = UIStoryboard(name: "Main", bundle: nil)
      // let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerStoryboardID") as? ViewController
      // self.window?.rootViewController = vc
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        let userInfo = userInfo as! [String: Any]
        
       
//        let data_json = DataManager.getVal(userInfo["data"]) as? String ?? ""
//        let result = self.convertToDictionary(text: data_json)
//
//        let body_dictionary = DataManager.getVal(result?["body"]) as! [String:Any]
//        let type = body_dictionary["type"] as? String ?? ""
        

    }
}


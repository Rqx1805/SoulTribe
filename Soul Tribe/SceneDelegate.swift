//
//  SceneDelegate.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 31/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        let LoginVal = Config().AppUserDefaults.object(forKey: "Login") as? String ?? ""
        let walkthroughValue = Config().AppUserDefaults.value(forKey: "WalkthroughCompleted") as? String ?? ""
        let userVibe = Config().AppUserDefaults.value(forKey: "userVibe") as? String ?? ""
    
        UserUIimagString = UserDefaults.standard.value(forKey: "user_image") as? String
        
//        DispatchQueue.global(qos: .userInitiated).async {
            if UserUIimagString?.count == 0 || UserUIimagString?.count == nil {
                
            }else{
                let urll = URL(string: Config().baseImageUrl + UserUIimagString!)!
                
                let dataimg = try! Data(contentsOf: urll)
                UserUIimageData = UIImage(data: dataimg)!
            }
//        }
        
        
        forIntentionHide = false
        USER_VIBE = userVibe
        NotificationUSERvibe = userVibe
        
        if LoginVal == "yes" && walkthroughValue == "1"{
            
            if userVibe.contains("Mini Tribes") {
                          let ra = "Mini Tribes"
                          let newVibe = userVibe.replacingOccurrences(of: ra, with: "Mini")
                          if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
          //                        if let tabBarController = self.tabBarController {
          //                            let indexToRemove = 2
          //                            if indexToRemove < tabBarController.viewControllers!.count {
          //                                var viewControllers = tabBarController.viewControllers
          //                                viewControllers?.remove(at: indexToRemove)
          //                                tabBarController.viewControllers = viewControllers
          //                            }
          //                        }
                              
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                              navigate.selectedIndex = 2
                              let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                              let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                              SELECT_VIBE = ""
                          }else {
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                              let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                              let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                              
                              
                              if userVibe.contains("Mini Tribes") {
                                            let ra = "Mini Tribes"
                                            let newVibe = userVibe.replacingOccurrences(of: ra, with: "Mini")
                                  if !newVibe.contains("Mini") &&  newVibe.contains("Soul Love") && !newVibe.contains("Tribe") {
                                      SELECT_VIBE = "Soul Love"
                                  }
                                  if !newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && newVibe.contains("Tribe") {
                                      SELECT_VIBE = "Tribe"
                                  }
                                  if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && newVibe.contains("Tribe") {
                                      SELECT_VIBE = "Mini Tribes, Tribe"
                                  }
                                  if newVibe.contains("Mini") &&  newVibe.contains("Soul Love") && !newVibe.contains("Tribe") {
                                      SELECT_VIBE = "Mini Tribes, Soul Love"
                                  }
                              }
                          }
                      }else{
                          
                          print(userVibe)
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                              let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                              let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                              slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                              UIApplication.shared.windows.first?.rootViewController = slideMenuController
                              UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
          //
                          if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                              SELECT_VIBE = "Soul Love"
                          }
                          if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                              SELECT_VIBE = "Tribe"
                          }
                          
                      }
        }
        else if LoginVal == "no" && walkthroughValue != "1"{
//            let story = UIStoryboard(name: "Main", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "firstNavBar")
//            UIApplication.shared.windows.first?.rootViewController = vc
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        else if LoginVal == "no" && walkthroughValue == "1"{
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "startupNavBar")

            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()

        }else if LoginVal == "" && walkthroughValue == "1"{
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "startupNavBar")

            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()

        }
        else if LoginVal == nil && walkthroughValue == "1"{

            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "startupNavBar")

            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        else {
            
            let nav1 = UINavigationController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigate = storyboard.instantiateViewController(withIdentifier: "WalkPageVC") as! WalkPageVC
            nav1.navigationBar.isHidden = true
            nav1.viewControllers = [navigate]
            UIApplication.shared.windows.first?.rootViewController = nav1
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            
//           let langStr : String = Locale.current.languageCode ?? "en"
//           basicFunctions.setLanguage(languageCode: langStr)

//           if langStr == "ar" {
//               UIView.appearance().semanticContentAttribute = .forceRightToLeft
//           }
//           else {
//               UIView.appearance().semanticContentAttribute = .forceLeftToRight
//           }

//            let story = UIStoryboard(name: "Main", bundle:nil)
//            let vc = story.instantiateViewController(withIdentifier: "firstNavBar")
//            UIApplication.shared.windows.first?.rootViewController = vc
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
       }
   
        
//
//
//
//        let nav1 = UINavigationController()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let navigate = storyboard.instantiateViewController(withIdentifier: "WalkPageVC") as! WalkPageVC
//        nav1.navigationBar.isHidden = true
//        nav1.viewControllers = [navigate]
//        UIApplication.shared.windows.first?.rootViewController = nav1
//        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

extension UIImage {
    func resized1(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

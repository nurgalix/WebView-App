//
//  UserTabBarController.swift
//  WebView App
//
//  Created by Nurgali on 28.05.2025.
//

import UIKit

class UserTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
    }
    
    private func configureTabs() {
        let charactersVC = CharactersViewController()
        let locationsVC = LocationsViewController()
        let episodesVC = EpisodesViewController()
        let settingsVC = SettingsViewController()
        
        charactersVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        locationsVC.tabBarItem.image = UIImage(systemName: "map")
        episodesVC.tabBarItem.image = UIImage(systemName: "film")
        settingsVC.tabBarItem.image = UIImage(systemName: "gearshape")
        
        charactersVC.title = "Characters"
        locationsVC.title = "Locations"
        episodesVC.title = "Episodes"
        settingsVC.title = "Settings"
        
        let navController = UINavigationController(rootViewController: charactersVC)
        
        tabBar.backgroundColor = .white
//        tabBar.selectedItem?.badgeColor = .systemBlue
        tabBar.unselectedItemTintColor = .secondaryLabel
//        tabBar.barTintColor = .systemBlue
        
        setViewControllers([navController, locationsVC, episodesVC, settingsVC], animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

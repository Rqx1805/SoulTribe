//
//  showMoreImagesVC.swift
//  Soul Tribe
//
//  Created by MAC-30 on 08/01/22.
//

import UIKit

class showImageCell: UITableViewCell{
    @IBOutlet weak var img: UIImageView!
}
class showMoreImagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var tablView: UITableView!
    var arrImg = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    @IBAction func backMenu(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImg.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showImageCell", for: indexPath) as! showImageCell
        let dict = arrImg[indexPath.row]
        let img = DataManager.getVal(dict["images"]) as? String ?? ""
        cell.img.contentMode = .scaleAspectFit
        Config().setimage(image_url: Config().baseImageUrl + img, image_name: cell.img)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrImg[indexPath.row]
        let img = DataManager.getVal(dict["images"]) as? String ?? ""
        
       let vc = storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
           vc.urlStr = img
           vc.shouldPrefix = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

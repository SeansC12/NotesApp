//
//  TaskTableViewCell.swift
//  NotesApp
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 16/11/21.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func checkBoxButtonPressed(indexPath: IndexPath)
}

class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "TaskTableViewCell"
    weak var delegate: TaskTableViewCellDelegate?
    private var _indexPath: IndexPath!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static func nib() -> UINib {
        return UINib(nibName: "TaskTableViewCell",
                     bundle: nil)
    }
    
//    func imageWith(newSize: CGSize) -> UIImage {
//        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
//            draw(CGRect(origin: .zero, size: newSize))
//        }
//
//        return image.withRenderingMode(RenderingMode)
//    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func resizedImage(imageName: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(named: imageName) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    @IBOutlet var taskSubjectLabel: UILabel!
    @IBOutlet var checkBoxButton: UIButton!
    
    @IBAction func didTapCheckBoxButton(_ sender: Any) {
        delegate?.checkBoxButtonPressed(indexPath: _indexPath)
    }
    
    func configureItems(indexPath: IndexPath) {
        self._indexPath = indexPath
        if _indexPath.section == 0 {
            let selectedIndexOfArray = appDelegate.arrayOfOutstandingTasks[indexPath.row]
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: selectedIndexOfArray.taskSubject)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, 0))
            taskSubjectLabel.attributedText = attributeString
            
            var checkBoxUncheckedImage = UIImage()
            checkBoxUncheckedImage = resizedImage(imageName: "checkBoxUnchecked", for: CGSize(width: 100, height: 60))!
            
            checkBoxButton.setImage(checkBoxUncheckedImage, for: .normal)
        } else {
            let selectedIndexOfArray = appDelegate.arrayOfCompletedTasks[indexPath.row]
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: selectedIndexOfArray.taskSubject)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1.5, range: NSMakeRange(0, attributeString.length))
            taskSubjectLabel.attributedText = attributeString
            
            var checkBoxUncheckedImage = UIImage()
            checkBoxUncheckedImage = resizedImage(imageName: "checkBoxChecked", for: CGSize(width: 100, height: 60))!
            
            checkBoxButton.setImage(checkBoxUncheckedImage, for: .normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.setTitle("", for: .normal)
    }
    
    
    


//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}

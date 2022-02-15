//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 15.02.2022.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    @IBOutlet weak var imageOfPlace: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // убрать линии ниже 4 секций
        tableView.tableFooterView = UIView()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            // создаем сам контроллер
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
                // создаем кнопку "камера"
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            // создаем кнопку "фото"
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            // создаем кнопку "отмена"
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                // добавляем кнопки в контроллер
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
                // показываем сам контроллер
            present(actionSheet, animated: true, completion: nil)
        } else {
            // закрытие клавиатуры при тапе на любую секцию кроме первой, тк там фото
            view.endEditing(true)
        }
    }
}
// MARK: text field delegate
    extension NewPlaceViewController: UITextFieldDelegate {
        //  Скрываем клавиатуру по нажатию  done
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
// MARK: word with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
       // проверка доступности метода перед добавлением
        if
             UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            // разрешаем изменение изображения, например масштабирование перед добавлением
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    // работа с полученным отредактированным из камеры или из галереи изображение
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // присваивание значения аутлету, editedImage - отредактированное изображение
        imageOfPlace.image = info[.editedImage] as? UIImage
        //масштабирование под размер
        imageOfPlace.contentMode = .scaleAspectFill
        //обрезка по границе imageView
        imageOfPlace.clipsToBounds = true
        dismiss(animated: true)
    }
}

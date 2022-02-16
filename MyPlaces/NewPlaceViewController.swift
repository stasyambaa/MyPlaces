//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 15.02.2022.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    var newPlace: Place?
    
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // отключение кнопки save со старту, пока мы не введем название заведения
        saveButton.isEnabled = false
        // убрать линии ниже 4 секций
        tableView.tableFooterView = UIView()
        // метод для наблюдением за изменением текста в строке placeName
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
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
    
    
    
    func saveNewPlace() {
        newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, image: placeImage.image , restaurantImage: <#T##String?#>)
    }
}






// MARK: text field delegate
    extension NewPlaceViewController: UITextFieldDelegate {
        //  Скрываем клавиатуру по нажатию  done
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        // objc метод слежения за пустотой placeName и включением кнопки save
        @objc func textFieldChanged() {
            if placeName.text?.isEmpty == false {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
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
        placeImage.image = info[.editedImage] as? UIImage
        //масштабирование под размер
        placeImage.contentMode = .scaleAspectFill
        //обрезка по границе imageView
        placeImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

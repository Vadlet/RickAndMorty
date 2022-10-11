## Краткое описание
- Проект написан на **UIKit**
- Использована архитектура **MVP** + **MVVM** ( был **MVC** )
- iOS >=13
- Core Data
- UserDefaults
- Использованны различные патерны проектирования
- CocoaPods(R.swift, Swiftlint, FireBase(Analytics))
- Local Notification
- Debug Menu
- DI
- Splash Screen
- Адаптивная верстка интерфейса **кодом**. Проверна на **iPhoneSE (2st generation)**
- Работа с сетью **Alamofire** ( был **URLSession** )
- Добавлена обработка ошибок при работе с NetworkManager, ImageManager. Ошибки отображаются пользователю через UIAlerController.
- Бесконечный скролл картинок ( **UICollectionView** )
- Добавлен поисковик ( **UISearchController** )
- Поддерживает **IPad**
- Поддерживает горизонтальный режим
## Презентация
![Видеопрезентация](./presentation/1.gif)
![Экран с персонажами](./presentation/2.png)
## Задание
- Необходимо написать приложение, которое загружает с сервера JSON-файл,
разбирает его и выводит на экран информацию в категориях: 
> Персонажи:
```
 - Имя
 - Пол
 - Вид
 - Картинка персонажа
 ```
> Локации:
```
 - Название локации
 - Тип
 - Измерение
 ```
> Эпизоды:
```
 - Название эпизода
 - Дата выпуска
 - Номер эпизода
```
## Будет добавлено
- Unit testing
- Кеширование данных
- Core Data

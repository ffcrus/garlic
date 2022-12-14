# Скрипт для изменения раскладки уже набранного текста
![Action preview](/screenshots/garlic_preview.gif)
# Оглавление

1. [Совместимость](#совместимость)
2. [Зачем я это сделал](#зачем-я-это-сделал)
3. [Как установить и пользоваться](#как-установить-и-пользоваться)
4. [Полезности](#полезности)
    1. [Звук переключения](#звук-переключения)
5. [Полезные ссылки](#полезные-ссылки)

## Совместимость
+ kUbuntu 20.04
+ Linux Mint 21 Cinnamon
+ Ubuntu Mate 22.04.1

> Пожалуйста, создавайте тикет в **Discussions** или **Issues** с обратной связью: где скрипты работают, а где нет. Я буду обновлять этот раздел.
## Зачем я это сделал
Когда-то моей операционной системой была Windows. И там я пользовался очень популярной программой [Punto Switcher](https://yandex.ru/soft/punto/), 
которая переключала раскладку уже набранного текста. Она умеет многое другое, но от этого многого другого больше вреда, чем пользы, на мой субъективный
взгляд. Потом я перешёл на [kUbuntu](https://kubuntu.org/) и захотел себе этого же функционала. К сожалению, готовых решений очень мало и ни одно из них меня не устраивало. 

Самое известное - это [XNeur](https://github.com/AndrewCrewKuznetsov/xneur-devel). Оно не поддерживается с 2016 года и под KDE нормально не работает. 

Ещё есть [switcher](https://github.com/ds-voix/xswitcher), но он развивается не туда, куда мне нужно и [не может](https://github.com/ds-voix/xswitcher/issues/5#issuecomment-1139833292) перевести выделенный текст в другую раскладку.

Ещё есть [тема на форуме](https://forum.ubuntu.ru/index.php?topic=271377.0) со скриптами, которые не удовлетворяют моим желаниям. Но оттуда я взял идею.

Есть ещё решения для Гнома, но их мы не будем рассматривать. Больше сегодня ничего нет на просторах Интернета.

Я поставил себе задачу так:
1. Решение должно работать в KDE, т.к. мне нужно для kUbuntu 20.04.5 LTS
2. Решение должно быть на чистом Bash (уже есть неплохие реализации на Python3)
3. По любой, назначаемой мной, комбинации клавиш, изменяется раскладка выделенного в этот момент текста.
4. По любой, назначаемой мной, комбинации клавиш, изменяется раскладка текста от текущего положения курсора и до начала строки.
5. После изменения раскладки должен измениться системный язык ввода, чтобы дальше удобно было продолжать писать уже на правильной раскладке.
6. Безопасность: никакие данные никуда не отправляются. Ставить себе кейлоггер своими же руками в систему я не хочу.
7. Стабильность работы.
   - Даже если пользователь будет нажимать или держать нажатыми любые клавиши на клавиатуре, должно работать корректно
   - После изменение системного языка ввода не должно ломаться системное переключение языков ввода.
## Как установить и пользоваться
Скрипты работают с использованием `xdotool`, `xsel` и `sed`. Соответственно, сначала устанавливаем их:
```
sudo apt install xdotool xsel sed
```
Необходимо скачать файлы из папки `/bin/` и положить в какой-нибудь локальный каталог. Я рекомендую использовать `$HOME/bin/`. Должно получиться так:
```
/home/$USER/bin/layout_changing_selected.sh
/home/$USER/bin/layout_changing_previous.sh
/home/$USER/bin/notification.wav
```
Делаем скрипты исполняемыми:
```
chmod +x $HOME/bin/layout_changing_selected.sh
chmod +x $HOME/bin/layout_changing_previous.sh
```
Идём в **Параметры системы** -> **Рабочая среда** -> **Комбинации клавиш** -> **Специальные действия** и создаём группу для наших скриптов:

![Создание группы для скриптов](/screenshots/1_create_group.jpg)

Вписываем комментарий:
```
Пользовательские скрипты для перевода уже набранного текста в другие раскладки
```
![Добавление комментария](/screenshots/2_making_description.jpg)

Создаём действие в группе: **Новый** -> **Глобальная комбинация клавиш** -> **Команда или адрес**:

![Создание нового действия](/screenshots/3_create_hotkey.jpg)

Добавляем комментарий к действию:
```
Этот скрипт позволяет менять раскладку выделенного текста, например, по нажатию Shift+Pause
```
![Добавление комментария к действию](/screenshots/4_making_hotkey_description.jpg)

Назначаем комбинацию клавиш (в моём примере это Shift+Pause):

![Назначение комбинации клавиш](/screenshots/5_making_keyboard_shortcut.jpg)

Настраиваем действие для комбинации клавиш (в моём примере это `$HOME/bin/layout_changing_selected.sh`):

![Назначение действия на комбинацию клавиш](/screenshots/6_making_action.jpg)

Аналогично добавляем скрипт `layout_changing_previous.sh` с комментарием
```
Этот скрипт позволяет менять раскладку текста от текущего положения курсора и до начала текущей строки, например, по нажатию Pause
```
и действием `$HOME/bin/layout_changing_previous.sh`.

Если положили скрипты и звук уведомления в другое место, необходимо в каждом скрипте в начале поправить значение переменной `SCRIPT_DIR`.

## Полезности

#### Звук переключения

Если хотите, чтобы переключение сопровождалось звуком, необходимо раскомментировать строки в конце файла, чтобы они выглядели так (удалить решётку в начале строк):
```
SCRIPT_DIR=$HOME/bin/
paplay $SCRIPT_DIR/notification.wav
```

**Готово. Работать начнёт сразу, без перезагрузки!**
## Полезные ссылки
* Проект [xkblayout-state](https://github.com/nonpop/xkblayout-state) позволит [настроить звук](https://forum.ubuntu.ru/index.php?topic=271377.msg2475753#msg2475753) на каждую раскладку. Нужно сохранить себе проект и добавить в конец скрипта:
```
QQ=$(~/.src/xkblayout-state/xkblayout-state print '%n'|sed "s:Russian:ru:;s:English:us:;s:Ukrainian:ua:")
sleep 0.5
aplay  ~/.zFront_Right$QQ.wav
```

#!/bin/sh
## Этот скрипт позволяет менять раскладку выделенного текста
## https://github.com/ffcrus/garlic
## v0.3 2022.11.21

## Сохраняем текущий буфер обмена
SAVED_CLIPBOARD=$(xsel -ob)

## Обрабарываем ситуацию, когда пользователь не успел отпустить клавишу Insert
xdotool keyup Insert

## Выделяем текст от курсора и до начала строки
xdotool key --clearmodifiers Shift+Home

## Принудительно отключаем модификаторы (Ctrl, Alt, Shift, etc) и копируем текст комбинацией клавиш
xdotool key --clearmodifiers Control_L+Insert

## Выбираем скопированное из буфера обмена и скармливаем текстовому редактору (скорее текстовому процессору) sed.
## При помощи функции тренслитерации (y/) происходит замена символов. После этого записываем результат в буфер обмена обратно.
xsel -bo | sed "y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.\/<>?@#\$^&\`~фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбюБЮ№ёЁ/фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбю.БЮ,\"№;:?ёЁabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.<>#\`~/" | xsel -bi

## Меняем активную раскладку клавиатуры
xdotool key Mode_switch

## Вставляем результат обратно, не забывая про модификаторы
xdotool key --clearmodifiers Shift+Insert

## Восстанавливаем буфер обмена
echo -n $SAVED_CLIPBOARD | xsel -bi

## Отпускаем залипшие модификаторы Ctrl и Shift
xdotool keyup Shift_L Shift_R Control_L Control_R Alt_L Alt_R

## Если хотим воспроизводить звук, раскомментируем следующие строки (SCRIPT_DIR - каталог с воспроизводимым звуком, notification.wav - имя файла со звуком):
#SCRIPT_DIR=$HOME/bin/
#paplay $SCRIPT_DIR/notification.wav

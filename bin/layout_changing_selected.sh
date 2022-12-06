#!/bin/sh
## Этот скрипт позволяет менять раскладку выделенного текста
## https://github.com/ffcrus/garlic
## v0.5.1 2022.12.06

## Сохраняем текущий буфер обмена
SAVED_CLIPBOARD=$(xsel -ob)

## Если не работает смена раскладки, попробуйте увеличить значение в следующей строке до 0.3, 0.4 или 0.5
sleep 0.2s

## Берём выделенное и скармливаем текстовому процессору sed. При помощи функции тренслитерации (y/) происходит замена символов. 
## После этого записываем результат в буфер обмена. Это самый быстрый и стабильный способ вернуть результат обратно пользователю.
## К сожалению, после этого в буфере останется исправленный текст.
xsel -op | sed "y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.\/<>?@#\$^&\`~фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбюБЮ№ёЁ/фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбю.БЮ,\"№;:?ёЁabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.<>#\`~/" | xsel -ib

## Меняем активную раскладку клавиатуры
xdotool key Mode_switch

## Принудительно отключаем Insert, модификаторы (Ctrl, Alt, Shift, etc) и вставляем результат обратно комбинацией клавиш Shift+Insert
xdotool keyup Insert
xdotool key --clearmodifiers Shift+Insert

## Очищаем из буфера обмена исправленную фразу (не у всех работает эта функция)
xsel --clear

## Восстанавливаем буфер обмена
echo -n $SAVED_CLIPBOARD | xsel -ib

## Отпускаем возможно залипшие модификаторы Ctrl, Alt, Shift и Insert
xdotool keyup Shift_L Shift_R Control_L Control_R Alt_L Alt_R Insert

## Если хотим воспроизводить звук, раскомментируем следующие строки (SCRIPT_DIR - каталог с воспроизводимым звуком, notification.wav - имя файла со звуком):
#SCRIPT_DIR=$HOME/bin/
#paplay $SCRIPT_DIR/notification.wav

﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Город") Тогда
		
		ЭтаФорма.Заголовок = Параметры.Город;
		
	КонецЕсли;
	
	Если Параметры.Свойство("Адрес") Тогда
		
		НоваяСтрока = Контакты.Добавить();
		НоваяСтрока.Вид = Перечисления.ВидыКонтактнойИнформации.Адрес;
		НоваяСтрока.Значение = Параметры.Адрес;
		НоваяСтрока.КартинкаСтроки = 12;
			
	КонецЕсли;
	
	Если Параметры.Свойство("Долгота") Тогда
		
		Попытка
		
			Долгота = Число(Параметры.Долгота);
		
		Исключение		
		КонецПопытки;	
		
	КонецЕсли;
	
	Если Параметры.Свойство("Широта") Тогда
		
		Попытка
		
			Широта = Число(Параметры.Широта);
		
		Исключение		
		КонецПопытки;	
		
	КонецЕсли;
	
	Если Параметры.Свойство("Email") Тогда
		
		НоваяСтрока = Контакты.Добавить();
		НоваяСтрока.Вид = Перечисления.ВидыКонтактнойИнформации.EMail;
		НоваяСтрока.Значение = Параметры.Email;
		НоваяСтрока.КартинкаСтроки = 8;
			
	КонецЕсли;
	
	Если Параметры.Свойство("Телефон") Тогда
		
		МассивТелефонов = СтрРазделить(Параметры.Телефон, ",");
		
		Для Каждого Телефон Из МассивТелефонов Цикл
			
			НоваяСтрока = Контакты.Добавить();
			НоваяСтрока.Вид = Перечисления.ВидыКонтактнойИнформации.Телефон;
			НоваяСтрока.Значение = СтрЗаменить(Телефон, " ", "");
			НоваяСтрока.КартинкаСтроки = 7;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если Параметры.Свойство("Расписание") Тогда
		
		Если ТипЗнч(Параметры.Расписание) = Тип("Строка") Тогда
			
			ПараметрРасписание = Параметры.Расписание;
			
			Если Прав(ПараметрРасписание, 1) = "-" Тогда
				
				ПараметрРасписание = Лев(ПараметрРасписание, СтрДлина(ПараметрРасписание) - 1);
				
			КонецЕсли;
			
			МассивРасписание = Новый Массив;
			
			Счетчик = 1;
			
			Пока СтрДлина(ПараметрРасписание) > 11 Цикл
				
				МассивРасписание.Добавить(Лев(ПараметрРасписание, 11));
				
				ПараметрРасписание = Прав(ПараметрРасписание, СтрДлина(ПараметрРасписание) - 11);
				
				Если СтрДлина(ПараметрРасписание) <= 11 Тогда
					МассивРасписание.Добавить(ПараметрРасписание);
					ПараметрРасписание = "";
				КонецЕсли;
				
			КонецЦикла;		
			
			Для Счетчик = 1 По 7 Цикл
				
				НоваяСтрока = Расписание.Добавить();
				
				НоваяСтрока.ДеньНедели = ПолучитьДеньНеделиПоИндексу(Счетчик);
				НоваяСтрока.РабочееВремя = ?(Счетчик <= МассивРасписание.Количество(), МассивРасписание[Счетчик - 1], "Выходной");
				
			КонецЦикла;
			
		ИначеЕсли ТипЗнч(Параметры.Расписание) = Тип("Соответствие") Тогда
			
			Для Счетчик = 1 По 7 Цикл
				
				НоваяСтрока = Расписание.Добавить();
				
				НоваяСтрока.ДеньНедели = ПолучитьДеньНеделиПоИндексу(Счетчик);
				
				ДеньНеделиАнг = ПолучитьАнгДеньНеделиПоИндексу(Счетчик);
				
				НоваяСтрока.РабочееВремя = ?(Параметры.Расписание.Получить(ДеньНеделиАнг) <> Неопределено И СтрДлина(Параметры.Расписание.Получить(ДеньНеделиАнг)) > 5, 
					Параметры.Расписание.Получить(ДеньНеделиАнг), 
					"Выходной");
								
			КонецЦикла;
			
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьАнгДеньНеделиПоИндексу(Индекс)
	
	Если Индекс = 1 Тогда
		Возврат "monday";
	ИначеЕсли Индекс = 2 Тогда
		Возврат "tuesday";
	ИначеЕсли Индекс = 3 Тогда
		Возврат "wednesday";
	ИначеЕсли Индекс = 4 Тогда
		Возврат "thursday";
	ИначеЕсли Индекс = 5 Тогда
		Возврат "friday";
	ИначеЕсли Индекс = 6 Тогда
		Возврат "saturday";
	ИначеЕсли Индекс = 7 Тогда
		Возврат "sunday";
	КонецЕсли;
	
	Возврат "";

КонецФункции

&НаСервере
Функция ПолучитьДеньНеделиПоИндексу(Индекс)
	
	Если Индекс = 1 Тогда
		Возврат "Пн";
	ИначеЕсли Индекс = 2 Тогда
		Возврат "Вт";
	ИначеЕсли Индекс = 3 Тогда
		Возврат "Ср";
	ИначеЕсли Индекс = 4 Тогда
		Возврат "Чт";
	ИначеЕсли Индекс = 5 Тогда
		Возврат "Пт";
	ИначеЕсли Индекс = 6 Тогда
		Возврат "Сб";
	ИначеЕсли Индекс = 7 Тогда
		Возврат "Вс";
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПоддерживаетсяEmail = СредстваПочты.ПоддерживаетсяОтправка();
	ПоддерживаетсяТелефония = СредстваТелефонии.ПоддерживаетсяНаборНомера() ИЛИ СредстваТелефонии.ПоддерживаетсяОтправкаSMS(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Контакты.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Вид = ПредопределенноеЗначение("Перечисление.ВидыКонтактнойИнформации.EMail") Тогда
		
		ЗапуститьПриложение("mailto:" + СокрЛП(ТекущиеДанные.Значение));
		
	ИначеЕсли ТекущиеДанные.Вид = ПредопределенноеЗначение("Перечисление.ВидыКонтактнойИнформации.Адрес") Тогда
		
		Координаты = ПолучитьКоординатыКлиента();  
		
		Если Координаты <> Неопределено Тогда
			
			ДопПараметры = Новый Структура("Координаты", Координаты);
			
			Оповещение = Новый ОписаниеОповещения("ВыборДействияКоординаты", ЭтаФорма, ДопПараметры);
			
			СписокКнопок = Новый СписокЗначений;
						
			СписокКнопок.Добавить("Показать на карте", "Показать на карте");
			СписокКнопок.Добавить("Проложить маршрут", "Проложить маршрут");
			СписокКнопок.Добавить("Отмена", "Отмена");
			
			ПоказатьВопрос(Оповещение, "Какое действие Вы хотите совершить?", СписокКнопок,,, "Вопрос");
			
		КонецЕсли;
		
	ИначеЕсли ТекущиеДанные.Вид = ПредопределенноеЗначение("Перечисление.ВидыКонтактнойИнформации.Телефон") Тогда
		
		ДопПараметры = Новый Структура("НомерТелефона", ТекущиеДанные.Значение);
		
		Оповещение = Новый ОписаниеОповещения("ВыборДействияТелефон", ЭтаФорма, ДопПараметры);
		
		СписокКнопок = Новый СписокЗначений;
		
		СписокКнопок.Добавить("Отмена", "Отмена");
		
		Если СредстваТелефонии.ПоддерживаетсяНаборНомера() Тогда
		
			СписокКнопок.Добавить("Позвонить", "Позвонить");
			
		КонецЕсли;
		
		Если СредстваТелефонии.ПоддерживаетсяОтправкаSMS(Истина) Тогда
		
			СписокКнопок.Добавить("SMS", "SMS");
			
		КонецЕсли;
		
		ПоказатьВопрос(Оповещение, "Какое действие Вы хотите совершить?", СписокКнопок,,, "Вопрос");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборДействияТелефон(Результат, ДопПараметры) Экспорт
	
	Если Результат = Неопределено ИЛИ Результат = "Отмена" Тогда
		
		Возврат;
		
	ИначеЕсли Результат = "Позвонить" Тогда
		
		ЗапуститьПриложение("tel:" + ДопПараметры.НомерТелефона);
	
	ИначеЕсли Результат = "SMS" Тогда	
	
		ЗапуститьПриложение("sms:" + ДопПараметры.НомерТелефона);
			
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьКоординатыКлиента()
	
	Координаты = Неопределено;
	Если Широта <> 0 ИЛИ Долгота <> 0 Тогда
		Координаты = Новый ГеографическиеКоординаты(Широта, Долгота);		
	КонецЕсли;
	
	Возврат Координаты;
	
КонецФункции

&НаКлиенте
Процедура ВыборДействияКоординаты(Результат, ДопПараметры) Экспорт
	
	Если Результат = Неопределено ИЛИ Результат = "Отмена" Тогда
		
		Возврат;
		
	ИначеЕсли Результат = "Показать на карте" Тогда
		
		ПоказатьНаКарте(ДопПараметры.Координаты);
	
	ИначеЕсли Результат = "Проложить маршрут" Тогда	
	
		ДанныеМестоположения = Неопределено;
		
		Провайдер = СредстваГеопозиционирования.ПолучитьСамогоЭнергоЭкономичногоПровайдера();
		
		Если Провайдер = Неопределено Тогда
			САТ.СообщитьПользователю("Не удалось получить данные от провайдера геопозиционирования!");
			Возврат;
		КонецЕсли;
		
		Если СредстваГеопозиционирования.ОбновитьМестоположение(Провайдер.Имя, 60) Тогда
			ДанныеМестоположения = СредстваГеопозиционирования.ПолучитьПоследнееМестоположение(Провайдер.Имя);			
		КонецЕсли;
		
		Если ДанныеМестоположения = Неопределено Тогда
			САТ.СообщитьПользователю("Не удалось установить текущее местоположение! Возможно, у Вас не отключено использование геоданных в настройках. Проверьте и повторите попытку.");
			Возврат;                                  			
		КонецЕсли;
		
		КоординатыКлиента = ДопПараметры.Координаты;
		
		Запуск = Новый ЗапускПриложенияМобильногоУстройства("android.intent.action.VIEW", "http://maps.google.com/maps?saddr=" + XMLСтрока(ДанныеМестоположения.Координаты.Широта) + "," + XMLСтрока(ДанныеМестоположения.Координаты.Долгота) + "&daddr=" + XMLСтрока(КоординатыКлиента.Широта) + "," + XMLСтрока(КоординатыКлиента.Долгота));
		Запуск.Запустить(Ложь);
			
	КонецЕсли;
	
КонецПроцедуры

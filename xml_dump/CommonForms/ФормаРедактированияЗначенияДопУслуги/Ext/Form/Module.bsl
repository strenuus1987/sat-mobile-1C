﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ДопУслуга") Тогда
		Значение = Параметры.ДопУслуга;
	КонецЕсли;
	
	Если Параметры.Свойство("ДопУслуга") И Параметры.ДопУслуга = "Выезд за грузом к складу отправителя" Тогда
		
		Элементы.Тариф.СписокВыбора.Добавить("5211f93e-4ba2-4406-bd2d-0f021f1987e3", "Стандарт");
		Элементы.Тариф.СписокВыбора.Добавить("b8782ec5-c07a-4b26-9844-de3aedd53772", "Экспрес");
		Элементы.Тариф.СписокВыбора.Добавить("44c01960-8164-4316-b31f-378d6a4a0513", "Точное время");
		Элементы.Тариф.СписокВыбора.Добавить("64590fa9-19ac-4caf-aad5-0df11478fa6f", "Ночное время");
		
		Элементы.Количество.Видимость = Ложь;
		
	ИначеЕсли Параметры.Свойство("ДопУслуга") И Параметры.ДопУслуга = "Доставка груза к дверям получателя" Тогда
		
		Элементы.Тариф.СписокВыбора.Добавить("8a810b11-6184-4be5-b199-9d6285b6d4a1", "Стандарт");
		Элементы.Тариф.СписокВыбора.Добавить("c9a0bfc5-9039-4453-9391-57c0cbffc1fe", "Экспрес");
		Элементы.Тариф.СписокВыбора.Добавить("d71b1869-c419-4a2b-8981-5aaa2f50a6b4", "Точное время");
		Элементы.Тариф.СписокВыбора.Добавить("dd8e2bef-1def-4c67-853c-f7beb0c11724", "Ночное время");
		
		Элементы.Количество.Видимость = Ложь;
		
	Иначе
		
		Элементы.Тариф.Видимость = Ложь;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ДопУслугаИД") Тогда
		Тариф = Параметры.ЗначениеИД;
	КонецЕсли;
	
	Если Параметры.Свойство("Значение") Тогда
		Количество = Параметры.Значение;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	ПараметрыОповещения = Новый Структура;
	
	Если Элементы.Количество.Видимость Тогда
		ПараметрыОповещения.Вставить("Значение", Количество);
	Иначе
		ПараметрыОповещения.Вставить("ЗначениеИД", Тариф);
		ПараметрыОповещения.Вставить("Значение", Элементы.Тариф.СписокВыбора.НайтиПоЗначению(Тариф).Представление);		
	КонецЕсли;                                                                       
	
	ОповеститьОВыборе(ПараметрыОповещения);
	
КонецПроцедуры

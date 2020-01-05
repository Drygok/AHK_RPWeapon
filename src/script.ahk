#Persistent
#CommentFlag //

// Автор сего скрипта: vk.com/idDrygok
// При копировании и распространении просьба указывать автора


global processName := "grand_theft_auto_san_andreas.dll" // Имя процесса для CR:MP 0.3e - если Вы используете скрипт в других играх, тут нужно указать заголовок процесса. Например, для SA-MP это gta_sa.exe

global texts := [] // Список текстов для воспроизведения при переключении на новое оружие
current := -1 // Текущее (последнее) оружие, которое было в руках

start:
{
	texts.Push(["/me сжал кулаки"])
	texts.Push(["/me надел кастет", "/do Кастет готов к применению"])
	texts.Push(["/do Клюшка за спиной", "/me взял клюшку в руки"])
	texts.Push(["/do Дубинка висит на поясе", "/me снял дубинку с пояса"])
	texts.Push(["/me достал нож", "/do На лице видны ярость и отчаяние"])
	texts.Push(["/me легким замахом достал биту из-за спины"])
	texts.Push(["/do Лопата висит за спиной", "/me снял лопату и взял ее за черенок"])
	texts.Push(["/do Кий висит за спиной", "/me снял кий и взял его в руку"])
	texts.Push(["/me вытащил огромный тесак из-за спины"])
	texts.Push(["/me взял бензопилу и завел ее", "/do Слышен скрежет мусора, попадающего под цепь"])
	texts.Push(["/me достал двухсторонний дилдо и приготовился к его применению"])
	texts.Push(["/do Короткий вибратор в кармане", "/me достал короткий вибратор и включил его"])
	texts.Push(["/do Длинный вибратор в кармане", "/me достал длинный вибратор и включил его"])
	texts.Push(["/me достал белый дилдо и приготовился к его применению"])
	texts.Push(["/me взял цветы в руки"])
	texts.Push(["/do Топор висит за спиной", "/me снял топор и взял его в правую руку"])
	texts.Push(["/do Граната закреплена на поясе", "/me взял гранату в руки"])
	texts.Push(["/do Дымовая граната закреплена на поясе", "/me взял дымовую гранату в руки"])
	texts.Push(["/do Коктейль Молотова закреплен на поясе", "/me взял коктейль Молотова в руки"])
	texts.Push(["/me достал неизвестное оружие"])
	texts.Push(["/me достал неизвестное оружие"])
	texts.Push(["/me достал неизвестное оружие"])
	texts.Push(["/do Пистолет закреплен на поясе", "/me схватил пистолет в правую руку"])
	texts.Push(["/do Пистолет с глушителем закреплен на поясе", "/me схватил пистолет с глушителем в правую руку"])
	texts.Push(["/do Пистолет 'Пустынный орел' закреплен на поясе", "/me взял в руки пистолет 'Пустынный орел' и приготовился стрелять"])
	texts.Push(["/do Дробовик 'Shotgun' висит за спиной", "/me быстрым движением схватил дробовик 'Shotgun' и приготовился стрелять"])
	texts.Push(["/do Двуствольный дробовик висит за спиной", "/me быстрым движением схватил дробовик и приготовился стрелять"])
	texts.Push(["/do Боевой дробовик висит за спиной", "/me быстрым движением схватил дробовик и приготовился стрелять"])
	texts.Push(["/do Полуавтомат 'UZI' закреплен на поясе", "/me выхватил полуавтомат 'UZI' и приготовился к бою"])
	texts.Push(["/do Полуавтомат 'MP5' закреплен на поясе", "/me выхватил полуавтомат 'MP5' и приготовился к бою"])
	texts.Push(["/do Автомат 'AK-47' висит за спиной", "/me снял автомат 'AK-47' и взял его в обе руки"])
	texts.Push(["/do Автомат 'Винторез' висит за спиной", "/me снял автомат 'Винторез' и взял его в обе руки"])
	texts.Push(["/do Пистолет-пулемет 'TEC9' закреплен на поясе", "/me взял пистолет-пулемет 'TEC9' в правую руку"])
	texts.Push(["/do Винтовка висит за спиной", "/me взял винтовку в руки"])
	texts.Push(["/do Снайперская винтовка висит за спиной", "/me взял снайперскую винтовку в руки"])
	texts.Push(["/do РПГ закрелен висит за спиной", "/me взял РПГ в руки"])
	texts.Push(["/do Самонаводящаяся ракетница висит за спиной", "/me взял самонаводящуюся ракетницу в руки"])
	texts.Push(["/do Огнемет висит за спиной", "/me взял огнемет в руки"])
	texts.Push(["/do Тяжелый пулемет висит за спиной", "/me снял тяжелый пулемет и приготовился к бою"])
	texts.Push(["/do Пакет со взрывчаткой закреплен на поясе", "/me снял пакет со взрывчаткой и взял его в руку"])
	texts.Push(["/do Детонатор лежит в кармане", "/me сунул руку в карман и достал детонатор"])
	texts.Push(["/do Балончик краски закреплен на поясе", "/me взял балончик краски в руки"])
	texts.Push(["/do Огнетушитель висит за спиной", "/me взял огнетушитель в руки"])
	texts.Push(["/do Фотоаппарат висит на поясе", "/me взял фотоаппарат в руки"])
	SetTimer, cw, 100
}

cw:
{
	weapon := getWeaponId()
	
	if ((weapon == -1) || (weapon == current) || (getStatus() == 0))
		return
	
	if (current > 0)
		sendChat("/me освободил руки")
	
	current := weapon
	
	array := texts[weapon + 1] // В AHK массивы начинаются 1, поэтому тексты для нулевого оружия будут с индексом 1
	for t in array
	{
		sleep 3500 // Время задержки между отыгровкой каждого из оружий в мс (стандартные 3500мс - 3.5с), целое число, больше нуля
		sendChat(texts[weapon + 1][t])
	}
}

sendChat(text) {
	WinGet, WIN, ProcessName, A
	if (WIN != processName)
		return
	SendMessage, 0x50,, 0x4190419,, A
	SendInput {F6}%text%{Enter}
}

getWeaponId() {
   return ProcessReadMemory(0xBAA410, processName)
}

getStatus() {
	return ProcessReadMemory(ProcessReadMemory(0xB6F5F0, processName) + 0x15C, processName)
}

ProcessReadMemory(address, processIDorName, type := "Int", numBytes := 4) {
    VarSetCapacity(buf, numBytes, 0)
    Process Exist, %processIDorName%
    if !processID := ErrorLevel
        return -1
    if !processHandle := DllCall("OpenProcess", "Int", 24, "UInt", 0, "UInt", processID, "Ptr")
        return -1
    result := DllCall("ReadProcessMemory", "Ptr", processHandle, "Ptr", address, "Ptr", &buf, "Ptr", numBytes, "PtrP", numBytesRead, "UInt")
    if !DllCall("CloseHandle", "Ptr", processHandle, "UInt") && !result
        return -1
    if !result
        return -1
    if !numBytesRead
        return -1
    return (type = "Str")
        ? StrGet(&buf, numBytes)
        : NumGet(buf, type)
}
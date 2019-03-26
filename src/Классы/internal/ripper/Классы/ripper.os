
Функция Разобрать(Исходник) Экспорт
	Возврат Parse(Исходник);
КонецФункции // Разобрать()

Function Parse(Src, Pos = 1) Export
	List = New Array;
	Pos = Pos + 1;
	Chr = Mid(Src, Pos, 1);
	If Chr = Chars.LF Then
		Pos = Pos + 1;
		Chr = Mid(Src, Pos, 1);
	EndIf;
	Beg = Pos;
	While Chr <> "" Do
		If Chr = "{" Then
			List.Add(Parse(Src, Pos));
			Pos = Pos + 1;
			Chr = Mid(Src, Pos, 1);
			If Chr = Chars.LF Then
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndIf;
			Beg = Pos;
		ElsIf Chr = "," Then
			If Beg < Pos Then
				List.Add(Mid(Src, Beg, Pos - Beg));
			EndIf;
			Pos = Pos + 1;
			Chr = Mid(Src, Pos, 1);
			If Chr = Chars.LF Then
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndIf;
			Beg = Pos;
		ElsIf Chr = "}" Then
			If Beg < Pos Then
				List.Add(Mid(Src, Beg, Pos - Beg));
			EndIf;
			Break;
		ElsIf Chr = """" Then
			While Chr = """" Do
				Pos = Pos + 1;
				While Mid(Src, Pos, 1) <> """" Do
					Pos = Pos + 1;
				EndDo;
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndDo;
		Else
			Pos = Pos + 1;
			Chr = Mid(Src, Pos, 1);
		EndIf;
	EndDo;
	Return List;
EndFunction // Parse()

Function ParseLimited(Src, Limit = 10, Pos = 1, Level = 0) Export
	List = New Array;
	Pos = Pos + 1;
	Chr = Mid(Src, Pos, 1);
	If Chr = Chars.LF Then
		Pos = Pos + 1;
		Chr = Mid(Src, Pos, 1);
	EndIf;
	Beg = Pos;
	While Chr <> "" Do
		If Chr = "{" Then
			If Level < Limit Then
				List.Add(ParseLimited(Src, Limit, Pos, Level + 1));
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
				If Chr = Chars.LF Then
					Pos = Pos + 1;
					Chr = Mid(Src, Pos, 1);
				EndIf;
				Beg = Pos;
			Else
				Level = Level + 1;
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndIf;
		ElsIf Chr = "," Then
			If Level < Limit Then
				If Beg < Pos Then
					List.Add(Mid(Src, Beg, Pos - Beg));
				EndIf;
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
				If Chr = Chars.LF Then
					Pos = Pos + 1;
					Chr = Mid(Src, Pos, 1);
				EndIf;
				Beg = Pos;
			Else
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndIf;
		ElsIf Chr = "}" Then
			Level = Level - 1;
			If Level < Limit Then
				If Beg < Pos Then
					List.Add(Mid(Src, Beg, Pos - Beg));
				EndIf;
				Break;
			Else
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndIf;
		ElsIf Chr = """" Then
			While Chr = """" Do
				Pos = Pos + 1;
				While Mid(Src, Pos, 1) <> """" Do
					Pos = Pos + 1;
				EndDo;
				Pos = Pos + 1;
				Chr = Mid(Src, Pos, 1);
			EndDo;
		Else
			Pos = Pos + 1;
			Chr = Mid(Src, Pos, 1);
		EndIf;
	EndDo;
	Return List;
EndFunction // ParseLimited()
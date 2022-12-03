{
Copyright 2006-2022 John T. Haller of PortableApps.com

Website: https://PortableApps.com/

This software is OSI Certified Open Source Software.
OSI Certified is a certification mark of the Open Source Initiative.

Please see the included license file for the full details on
all included components.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


An exception to the GPL is granted to link this code to
non-GPLed DLLs published by PortableApps.com to enable advanced
functionality.
}

unit functions;

interface

uses Windows, Graphics, SysUtils, Classes, Forms, ShellAPI, dialog, TlHelp32,
  Dialogs, Messages, ProcessList, StrUtils, Registry, Variables, INIFiles;

  procedure OpenURL (strURL: string);
  function processExists(exeFileName: string): Boolean;
	function HexColorToTColor (strHexColor: string) : TColor;
  function TColorToHexColor (Color: TColor): string;
	procedure ShowDesktopIcons (boolShow: boolean);
	procedure SplitString (strInput: string; charDelimiter: char; var strlResult: TStringList);
	function CompareVersions (strVersion1: string; strVersion2: string): integer;
  function DeleteDirectoryTree(const BaseDirectory: string): boolean;
  procedure LoadPortableFonts();
  procedure UnLoadPortableFonts();
  function FilesTheSame(Filename1, Filename2: string): boolean;
  procedure CloseAppByProcess(intProcessID: integer);
  function EnumWindowsProc(Wnd: HWND; TargetProcessId: integer): BOOL; stdcall;
  function GetFileDetails(strFilePath: string; strFileInfoQuery: string): string;
  function MakePathIntoINIKey(strINIKey: string): string;
  procedure TerminateAppByProcess(ProcessID: Cardinal);
  procedure CloseAppByName(strWindowName: PWideChar);
  procedure SetPlatformEnvironmentVariables();
  procedure UnSetPlatformEnvironmentVariables();
  function PixelsAdjusted(intPixels: integer): integer;
  procedure CheckDotNetVersions();
  function IsDotNetVersionAvailable(strDotNetRegKey: String; strDotNetValueName: String): Boolean;
  function GetDotNetVersion(strDotNetRegKey: String; strDotNetValueName: String): String;
  procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
  function ExpandEnvStrings(const AString: String): String;
  Function IsASLREnabled(): boolean;
  function GetMouseWheelLines(): integer;
  function GetDotNetReleaseFromVersion(strDotNetVersion: string): integer;
  function ValidateDotNetVersion(strDotNetVersion: string): string;
  function BooleanToString(bolInput: boolean): string;
  function StringToBoolean(strInput: string): boolean;
  function DoesNetCorePathExist(strInput: string): boolean;

implementation

procedure CheckDotNetVersions();
var
  strWindowsDir, strCurrentDirectory, strCombinedVersion: string;
  intCombinedVersion: integer;
  bolIsInteger: boolean;
  regDotNet4Release: TRegistry;
  tsrchDirectory: TSearchRec;
begin
  // 1.0
  strDotNet1:=GetDotNetVersion('Software\Microsoft\.NETFramework\policy\v1.0','3705');
  if strDotNet1='NONE' then
    bolDotNet1:=false
  else
  begin
    bolDotNet1:=true;
    strDotNet1:='1.0.3705';
  end;

  // 1.1
  bolDotNet1_1:=IsDotNetVersionAvailable('Software\Microsoft\NET Framework Setup\NDP\v1.1.4322','Install');
  if bolDotNet1_1 then
    strDotNet1_1:='1.1.4322'
  else
    strDotNet1_1:='NONE';

  //2.0
  bolDotNet2:=IsDotNetVersionAvailable('Software\Microsoft\NET Framework Setup\NDP\v2.0.50727','Install');
  if bolDotNet2 then
    strDotNet2:=GetDotNetVersion('Software\Microsoft\NET Framework Setup\NDP\v2.0.50727','Version')
  else
    strDotNet2:='NONE';

  //3.0
  bolDotNet3:=IsDotNetVersionAvailable('Software\Microsoft\NET Framework Setup\NDP\v3.0\Setup','InstallSuccess');
  if bolDotNet3 then
    strDotNet3:=GetDotNetVersion('Software\Microsoft\NET Framework Setup\NDP\v3.0\Setup','Version')
  else
    strDotNet3:='NONE';

  //3.5
  bolDotNet3_5:=IsDotNetVersionAvailable('Software\Microsoft\NET Framework Setup\NDP\v3.5','Install');
  if bolDotNet3_5 then
    strDotNet3_5:=GetDotNetVersion('Software\Microsoft\NET Framework Setup\NDP\v3.5','Version')
  else
    strDotNet3_5:='NONE';

  //4.0
  bolDotNet4:=IsDotNetVersionAvailable('Software\Microsoft\NET Framework Setup\NDP\v4\Full','Install');
  if bolDotNet4 then
    begin
      strDotNet4:=GetDotNetVersion('Software\Microsoft\NET Framework Setup\NDP\v4\Full','Version');


      regDotNet4Release:= TRegistry.Create(KEY_READ);
      try
        regDotNet4Release.RootKey:= HKEY_LOCAL_MACHINE;
        if regDotNet4Release.KeyExists('SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full') then
        begin
          regDotNet4Release.OpenKey('SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', False);
          if regDotNet4Release.ValueExists('Release') then
            intDotNet4Release:= regDotNet4Release.ReadInteger('Release')
          else
            intDotNet4Release:=0;
          regDotNet4Release.CloseKey;
        end
        else
          intDotNet4Release:=0;
      finally
        FreeAndNil(regDotNet4Release);
      end;
    end
  else
    strDotNet4:='NONE';

  //5bundle,6bundle,7bundle
  if bolRunningUnderWin8_1 or bolRunningUnderWin10 then
    bolDotNetBundle:=true
  else
  begin
    strWindowsDir := GetEnvironmentVariable('WINDIR');
    if ((FileExists(PChar(strWindowsDir + '\servicing\Packages\Microsoft-Windows-PlatformUpdate-Win7-SRV08R2-Package-TopLevel~31bf3856ad364e35~x86~~7.1.7601.16492.cat'))) or (FileExists(PChar(strWindowsDir + '\servicing\Packages\Microsoft-Windows-PlatformUpdate-Win7-SRV08R2-Package-TopLevel~31bf3856ad364e35~amd64~~7.1.7601.16492.cat')))) then
      bolDotNetBundle:=true
    else
      bolDotNetBundle:=false;
  end;

  //Core and .Net >=5
  bolDotNetCore1:=false;
  bolDotNetCore1_1:=false;
  bolDotNetCore2:=false;
  bolDotNetCore2_1:=false;
  bolDotNetCore2_2:=false;
  bolDotNetCore3:=false;
  bolDotNetCore3_1:=false;
  bolDotNet5:=false;
  bolDotNet6:=false;
  bolDotNet7:=false;

  if FindFirst(strProgramFilesPath + '\dotnet\shared\Microsoft.WindowsDesktop.App\*',faDirectory,tsrchDirectory)=0 then
  begin
    repeat
      strCurrentDirectory:= tsrchDirectory.FindData.cFileName;
      if ((strCurrentDirectory <> '.') and (strCurrentDirectory <> '..')) then
      begin
        strCombinedVersion:=StringReplace(LeftStr(strCurrentDirectory,3),'.','',[rfReplaceAll, rfIgnoreCase]);
        bolIsInteger:=TryStrToInt(strCombinedVersion,intCombinedVersion);
        if bolIsInteger then
        case intCombinedVersion of
          10: bolDotNetCore1:=true;
          11: bolDotNetCore1_1:=true;
          20: bolDotNetCore2:=true;
          21: bolDotNetCore2_1:=true;
          22: bolDotNetCore2_2:=true;
          30: bolDotNetCore3:=true;
          31: bolDotNetCore3_1:=true;
          50: bolDotNet5:=true;
          60: bolDotNet6:=true;
          70: bolDotNet7:=true;
        end;
      end;
    Until FindNext(tsrchDirectory)<>0;
    FindClose(tsrchDirectory);

    if bolDotNetCore1_1 then bolDotNetCore1:=true;
    if bolDotNetCore2_1 then bolDotNetCore2:=true;
    if bolDotNetCore2_2 then
    begin
     bolDotNetCore2:=true;
     bolDotNetCore2_1:=true;
    end;
    if bolDotNetCore3_1 then bolDotNetCore3:=true;
  end;
end;

function DoesNetCorePathExist(strInput: string): boolean;
begin
  if (DirectoryExists(PChar(strProgramFilesPath + '\dotnet\shared\Microsoft.WindowsDesktop.App\'+ strInput))) or (DirectoryExists(PChar(strProgramFilesx86Path + '\dotnet\shared\Microsoft.WindowsDesktop.App\'+ strInput))) then
    Result:=true
  else
    Result:=false;
end;

function IsDotNetVersionAvailable(strDotNetRegKey: string; strDotNetValueName: string): boolean;
var
  regDotNet: TRegistry;
  strValue: integer;
begin
  regDotNet:= TRegistry.Create(KEY_READ);
  try
    regDotNet.RootKey:= HKEY_LOCAL_MACHINE;
    if regDotNet.KeyExists(strDotNetRegKey) then
    begin
      regDotNet.OpenKey(strDotNetRegKey, False);
      if regDotNet.ValueExists(strDotNetValueName) then
        strValue:= regDotNet.ReadInteger(strDotNetValueName)
      else
        strValue:=0;
      regDotNet.CloseKey;
    end
    else
      strValue:=0;
  finally
    FreeAndNil(regDotNet);
  end;
  if strValue=1 then
    Result:=true
  else
    Result:=false;
end;

function GetDotNetVersion(strDotNetRegKey: string; strDotNetValueName: string): string;
var
  regDotNet: TRegistry;
begin
  regDotNet:= TRegistry.Create(KEY_READ);
  try
    regDotNet.RootKey:= HKEY_LOCAL_MACHINE;
    if regDotNet.KeyExists(strDotNetRegKey) then
    begin
      regDotNet.OpenKey(strDotNetRegKey, False);
      if regDotNet.ValueExists(strDotNetValueName) then
        Result:= regDotNet.ReadString(strDotNetValueName)
      else
        Result:='NONE';
      regDotNet.CloseKey;
    end
    else
      Result:='NONE';
  finally
    FreeAndNil(regDotNet);
  end
end;

function GetMouseWheelLines(): integer;
const
  WheelKey = '\Control Panel\Desktop';
var
  Reg: TRegistry;
  intLines: integer;
begin
  intLines:=1;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(WheelKey) then
      if Reg.OpenKey(WheelKey, False) then begin
        intLines:=StrToInt(Reg.ReadString('WheelScrollLines'));
        Reg.CloseKey;
      end;
  finally
  FreeAndNil(Reg);
  end;
  Result:=intLines;
end;

procedure OpenURL (strURL: String);
// opens a web address
var
  strExecute: string;
begin
  strURL:=StringReplace(strURL,' ','%20',[rfReplaceAll, rfIgnoreCase]);
  if FileExists(ExtractFileDir(ExtractFileDir(Application.ExeName)) + '\FirefoxPortable\FirefoxPortable.exe') then
    if processExists('firefox.exe') and not processExists('firefoxportable.exe') then
      strExecute:='shell'
    else
      strExecute:='\FirefoxPortable\FirefoxPortable.exe'
  else if FileExists(ExtractFileDir(ExtractFileDir(Application.ExeName)) + '\GoogleChromePortable\GoogleChromePortable.exe') then
    if processExists('chrome.exe') and not processExists('googlechromeportable.exe') then
      strExecute:='shell'
    else
      strExecute:='\GoogleChromePortable\GoogleChromePortable.exe'
  else if FileExists(ExtractFileDir(ExtractFileDir(Application.ExeName)) + '\OperaPortable\OperaPortable.exe') then
    if processExists('opera.exe') and not processExists('operaportable.exe') then
      strExecute:='shell'
    else
      strExecute:='\OperaPortable\OperaPortable.exe'
  else if FileExists(ExtractFileDir(ExtractFileDir(Application.ExeName)) + '\MaxthonPortable\MaxthonPortable.exe') then
    if processExists('maxthon.exe') and not processExists('maxthonportable.exe') then
      strExecute:='shell'
    else
      strExecute:='\MaxthonPortable\MaxthonPortable.exe'
  else
  	 strExecute:='shell';

  if strExecute='shell' then
    ShellExecute(0,'open',PChar(strURL),nil,nil, SW_SHOWNORMAL)
  else
    ShellExecute(0,'open',PChar(ExtractFileDir(ExtractFileDir(Application.ExeName)) + strExecute), PChar(strURL), Nil, SW_SHOWNORMAL);
end;

function processExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function HexColorToTColor (strHexColor: string): TColor;
begin
	Result:=RGB(
      StrToInt('$'+Copy(strHexColor, 1, 2)),
      StrToInt('$'+Copy(strHexColor, 3, 2)),
      StrToInt('$'+Copy(strHexColor, 5, 2)));
end;

function TColorToHexColor (Color: TColor): string;
begin
	Result:=IntToHex(GetRValue(Color), 2) + IntToHex(GetGValue(Color), 2) +  IntToHex(GetBValue(Color), 2);
end;

procedure ShowDesktopIcons (boolShow: boolean);
var
  hndProgramManager, hndListView, hndListIcons: THandle;
  intHideDesktopIcons: integer;

begin
  intHideDesktopIcons:=0;
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced') then
      begin
        if ValueExists('HideIcons') then begin
          intHideDesktopIcons := ReadInteger('HideIcons');
        end;
        CloseKey;
      end;
    finally
      Free;
  end;

  if (intHideDesktopIcons = 0) then begin
    hndProgramManager:= FindWindow('ProgMan', nil);
    hndListView:= FindWindowEx(hndProgramManager, 0, PChar('SHELLDLL_DefView'), nil);
    hndListIcons:= FindWindowEx(hndListView, 0, PChar('SysListView32'), nil);
    if boolShow = True then
      ShowWindow(hndListIcons, SW_SHOW)
    else
      ShowWindow(hndListIcons, SW_HIDE);
  end;
end;

procedure LoadPortableFonts();
var
  tsrchRefFonts: TSearchRec;
  strFontsPath: string;
    //result: DWORD;
begin
  strFontsPath:= ExtractFileDir(Application.ExeName)+'\Data\Fonts\';
  if FindFirst(strFontsPath+'*.*',faAnyFile,tsrchRefFonts)=0 then
  begin
    repeat
      If ((tsrchRefFonts.Attr And faDirectory)<>faDirectory) Then
      begin
        If (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fon') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fnt') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.ttf') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.ttc') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fot') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.otf') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.mmm') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.pfb') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.pfm') then
          AddFontResource(PChar(strFontsPath + tsrchRefFonts.FindData.cFileName));
      end;
    until FindNext(tsrchRefFonts)<>0;
  end;
  SendNotifyMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
  //SendMessageTimeout(HWND_BROADCAST, WM_FONTCHANGE, 0, 0, SMTO_NORMAL or SMTO_ABORTIFHUNG, 15, result);
end;

procedure UnLoadPortableFonts();
var
  tsrchRefFonts: TSearchRec;
  strFontsPath: string;
  //result: DWORD;
begin
  strFontsPath:= ExtractFileDir(Application.ExeName)+'\Data\Fonts\';
  if FindFirst(strFontsPath+'*.*',faAnyFile,tsrchRefFonts)=0 then
  begin
    repeat
      If ((tsrchRefFonts.Attr And faDirectory)<>faDirectory) Then
      begin
        If (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fon') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fnt') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.ttf') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.ttc') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.fot') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.otf') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.mmm') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.pfb') Or (SysUtils.LowerCase(ExtractFileExt(tsrchRefFonts.FindData.cFileName)) = '.pfm') then
          RemoveFontResource(PChar(strFontsPath + tsrchRefFonts.FindData.cFileName));
      end;
    until FindNext(tsrchRefFonts)<>0;
  end;
  SendNotifyMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
  //SendMessageTimeout(HWND_BROADCAST, WM_FONTCHANGE, 0, 0, SMTO_NORMAL or SMTO_ABORTIFHUNG, 15, result);
end;

procedure SplitString (strInput: string; charDelimiter: char; var strlResult: TStringList);
begin
	Assert(Assigned(strlResult));
	strlResult.Clear;
	strlResult.Delimiter := charDelimiter;
	strlResult.DelimitedText := strInput;
end;

function CompareVersions (strVersion1: string; strVersion2: string): integer;
// 0 for equal, 1 for string1, 2 for string2, -1 for error
var
	strlVersion1, strlVersion2: TStringList;
begin
	try
		strlVersion1:= TStringList.Create;
		strlVersion2:= TStringList.Create;
		SplitString(strVersion1, '.', strlVersion1);
		SplitString(strVersion2, '.', strlVersion2);

    if strlVersion1.Count > strlVersion2.Count then
      strlVersion2.Add('0')
    else if strlVersion1.Count < strlVersion2.Count then
      strlVersion1.Add('0');

    if strlVersion1.Count > strlVersion2.Count then
      strlVersion2.Add('0')
    else if strlVersion1.Count < strlVersion2.Count then
      strlVersion1.Add('0');

    if strlVersion1.Count > strlVersion2.Count then
      strlVersion2.Add('0')
    else if strlVersion1.Count < strlVersion2.Count then
      strlVersion1.Add('0');

		if StrToInt(strlVersion1[0]) > StrToInt(strlVersion2[0]) then
			result:=1
		else
			if StrToInt(strlVersion1[0]) = StrToInt(strlVersion2[0]) then
				if StrToInt(strlVersion1[1]) > StrToInt(strlVersion2[1]) then
					result:=1
				else
					if StrToInt(strlVersion1[1]) = StrToInt(strlVersion2[1]) then
						if StrToInt(strlVersion1[2]) > StrToInt(strlVersion2[2]) then
							result:=1
						else
							if StrToInt(strlVersion1[2]) = StrToInt(strlVersion2[2]) then
								if StrToInt(strlVersion1[3]) > StrToInt(strlVersion2[3]) then
									result:=1
								else
									if StrToInt(strlVersion1[3]) = StrToInt(strlVersion2[3]) then
										result:=0
									else
										result:=2
							else
								result:=2
					else
						result:=2
			else
				result:=2
	except
		result:=-1
	end;
	FreeAndNil(strlVersion1);
	FreeAndNil(strlVersion2);
end;

function DeleteDirectoryTree(const BaseDirectory: string): boolean;
var
   tsrchFiles: TSearchRec;
begin
  if DirectoryExists(BaseDirectory) then
  begin

    if FindFirst(BaseDirectory + '\*.*',faAnyFile,tsrchFiles)=0 then
    begin
      //if Not SysUtils.DeleteFile(BaseDirectory + '\' + tsrchFiles.Name) then
      //begin
      //  Result:=False;
      //  Exit;
      //end;

      while FindNext(tsrchFiles)=0 do
      begin
        if (tsrchFiles.Name<>'.') and (tsrchFiles.Name<>'..') then
        begin
          if (tsrchFiles.Attr AND faDirectory)=faDirectory then
          begin

            DeleteDirectoryTree(BaseDirectory + '\' + tsrchFiles.Name);
            if frmDialog.Visible then
            begin
              //frmDialog.lblMessage2.Caption:=(BaseDirectory + '\' + tsrchFiles.Name);
              //frmDialog.lblMessage.Update;
              //frmDialog.lblMessage2.Update;
              //frmDialog.imgIconWarning.Update;
              //frmDialog.imgIconWait.Update;
              frmDialog.Update;
              Application.ProcessMessages;
            end;
          end;

          SysUtils.DeleteFile(BaseDirectory + '\' + tsrchFiles.Name);
        end;
      end;
    end;

    SysUtils.FindClose(tsrchFiles);

    // Try the base removedir to see if it's empty and can be removed
    if not RemoveDir(BaseDirectory) then
      Result:=False
    else
      Result:=True;
  end
  else
  begin
    // If it doesn't exist, just pass back a true result
    Result:=True;
  end;
end;

function FilesTheSame(Filename1, Filename2: string): boolean;
var
  File1, File2: TextFile;
  String1, String2: string;
  bolComplete, bolTheSame: boolean;
begin
  bolComplete:=false;
  bolTheSame:=false;
  if FileExists(PChar(Filename1)) and FileExists(PChar(Filename2)) then
  begin
    AssignFile(File1, Filename1);
    Reset(File1);
    AssignFile(File2, Filename2);
    Reset(File2);
    while not EOF(File1) do
    begin
      if EOF(File2) then
      begin
        bolTheSame:=false;
        bolComplete:=true;
        Break;
      end;
      Readln(File1,String1);
      Readln(File2,String2);
      if CompareStr(String1, String2)<>0 then
      begin
        bolTheSame:=false;
        bolComplete:=true;
        Break;
      end;
    end;
    if not bolComplete then
      if not EOF(File2) then
        bolTheSame:=false
      else
        bolTheSame:=true;
    Close(File1);
    Close(File2);
  end
  else if not FileExists(PChar(Filename1)) and not FileExists(PChar(Filename2)) then
      bolTheSame:=true
    else
      bolTheSame:=false;
  Result:=bolTheSame;
end;

procedure CloseAppByProcess(intProcessID: integer);
begin
  //ShowMessage(IntToStr(intProcessID));
  EnumWindows(@EnumWindowsProc,intProcessID);
end;

function EnumWindowsProc(Wnd: HWND; TargetProcessId: integer): BOOL; stdcall;
var
  ProcessId: integer;
begin
  Result := True;
  GetWindowThreadProcessID(Wnd,@ProcessId);
  if ProcessId = TargetProcessId then
  begin
    //ShowMessage(IntToStr(Wnd));
    //PostMessage(Wnd, WM_CLOSE,0,0);
    if IsWindowVisible(Wnd) or IsIconic(Wnd) then
      SendNotifyMessage(Wnd, WM_CLOSE, 0, 0);
  end;
end;

function GetFileDetails(strFilePath: string; strFileInfoQuery: string): string;
// strFileInfoQuery is one of ProductName, CompanyName, etc
var
  ptrFileInfo: pointer;
	lngFileInfoSize: Longint;
	dwdFileInfoLength: DWORD;
	ptrFileInfoLanguage : Pointer;
	ptrFileInfoData: Pointer;
	uintFileInfoDataLength: Uint;
  strFileDetailString: string;
begin
  if FileExists(strFilePath) then
  begin
    lngFileInfoSize:=GetFileVersionInfoSize(PChar(strFilePath), dwdFileInfoLength);
    if (lngFileInfoSize > 0) then
    begin
      GetMem(ptrFileInfo, lngFileInfoSize);
      try
      // Check if the current app has a ProductName
      if GetFileVersionInfo(PChar(strFilePath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
      begin
        if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
          strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
          HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
        if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
          strFileDetailString:=strPas(PChar(ptrFileInfoData));
      end;
      finally
        FreeMem(ptrFileInfo, lngFileInfoSize);
      end;
    end;
  end
  else
    strFileDetailString:='FILENOTFOUND';
  Result:=strFileDetailString;
end;

function MakePathIntoINIKey(strINIKey: string): string;
begin
  if LeftStr(strINIKey,1)='[' then
    Result:=StringReplace(ansiLowerCase(strINIKey), '[', '-BeginBracket-', [rfReplaceAll,rfIgnoreCase])
  else
    Result:=ansiLowerCase(strINIKey);
end;

procedure TerminateAppByProcess(ProcessID: Cardinal);
var
  hProcess : THandle;
begin
  hProcess := OpenProcess(PROCESS_TERMINATE,False,ProcessID);
  if hProcess > 0 then
  try
    Win32Check(Windows.TerminateProcess(hProcess,0));
  finally
    CloseHandle(hProcess);
  end;
end;

procedure CloseAppByName(strWindowName: PWideChar);
var
  hndWindow: HWND;
  bolResult: boolean;
begin
  ShowMessage(strWindowName);
  hndWindow := FindWindow(strWindowName, nil);
  if IsWindow(hndWindow) then
  begin
    ShowMessage(strWindowName);
    bolResult := PostMessage(hndWindow, WM_CLOSE, 0, 0);
    if not bolResult then
      PostMessage(hndWindow, WM_QUIT, 0, 0);
    if not bolResult then
      ShowMessage('failed');
    end;
end;

procedure SetPlatformEnvironmentVariables();
var
  regEnvironment: TRegistry;
  dwordReturn: DWORD_PTR;
  iniSettingsFile: TINIFile;
  stringsEnvVars: TStringList;
  intCounter: Integer;
begin
  stringsEnvVars := TStringList.Create;
  iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  try
    if iniSettingsFile.SectionExists('Environment') then
    begin
      iniSettingsFile.ReadSectionValues('Environment', stringsEnvVars);
    end;
  finally
    FreeAndNil(iniSettingsFile);
  end;

  if bolSystemWideEnvironmentVariables then
  begin
    regEnvironment:=TRegistry.Create;
    try
      regEnvironment.RootKey:=HKEY_CURRENT_USER;
      if regEnvironment.OpenKey('Environment', true) then begin
        try
          regEnvironment.WriteString('PortableApps.comRoot', strPortableAppsRootPath);
          regEnvironment.WriteString('PortableApps.comApps', strPortableAppsPath);
          regEnvironment.WriteString('PortableApps.comDocuments', strPortableAppsRootPath + '\Documents');
          regEnvironment.WriteString('PortableApps.comPictures', strPortableAppsRootPath + '\Documents\Pictures');
          regEnvironment.WriteString('PortableApps.comMusic', strPortableAppsRootPath + '\Documents\Music');
          regEnvironment.WriteString('PortableApps.comVideos', strPortableAppsRootPath + '\Documents\Videos');
          regEnvironment.WriteString('PortableApps.comPlatformVersion', APPVERSION);
        finally
          regEnvironment.CloseKey;
        end;
      end;
    finally
      regEnvironment.Free;
    end;

    SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LPARAM(PChar('Environment')), SMTO_ABORTIFHUNG, 1, @dwordReturn);
  end;

  SetEnvironmentVariable(PChar('PortableApps.comRoot'), PChar(strPortableAppsRootPath));
  SetEnvironmentVariable(PChar('PortableApps.comApps'), PChar(strPortableAppsPath));
  SetEnvironmentVariable(PChar('PortableApps.comDocuments'), PChar(strPortableAppsRootPath + '\Documents'));
  SetEnvironmentVariable(PChar('PortableApps.comPictures'), PChar(strPortableAppsRootPath + '\Documents\Pictures'));
  SetEnvironmentVariable(PChar('PortableApps.comMusic'), PChar(strPortableAppsRootPath + '\Documents\Music'));
  SetEnvironmentVariable(PChar('PortableApps.comVideos'), PChar(strPortableAppsRootPath + '\Documents\Videos'));
  SetEnvironmentVariable(PChar('PortableApps.comPlatformVersion'), PChar(APPVERSION));

  for intCounter := 0 to stringsEnvVars.Count-1 do
  begin
    SetEnvironmentVariable(PChar(stringsEnvVars.Names[intCounter]), PChar(ExpandEnvStrings(stringsEnvVars.ValueFromIndex[intCounter])));
  end;

  FreeAndNil(stringsEnvVars);
end;

procedure UnSetPlatformEnvironmentVariables();
var
  regEnvironment: TRegistry;
  dwordReturn: DWORD_PTR;
begin
  if bolSystemWideEnvironmentVariables then
  begin
    regEnvironment:=TRegistry.Create;
    try
      regEnvironment.RootKey:=HKEY_CURRENT_USER;
      if regEnvironment.OpenKey('Environment', true) then begin
        try
          regEnvironment.DeleteValue('PortableApps.comRoot');
          regEnvironment.DeleteValue('PortableApps.comApps');
          regEnvironment.DeleteValue('PortableApps.comDocuments');
          regEnvironment.DeleteValue('PortableApps.comPictures');
          regEnvironment.DeleteValue('PortableApps.comMusic');
          regEnvironment.DeleteValue('PortableApps.comVideos');
          regEnvironment.DeleteValue('PortableApps.comPlatformVersion');
        finally
          regEnvironment.CloseKey;
        end;
      end;
    finally
      regEnvironment.Free;
    end;

    //  SendNotifyMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
    SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LPARAM(PChar('Environment')), SMTO_ABORTIFHUNG, 1, @dwordReturn);
  end;
end;

function PixelsAdjusted(intPixels: integer): integer;
begin
  Result:=MulDiv(intPixels, Screen.PixelsPerInch, 96);
end;

procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
var
  FileName: string;
  LogFile: TextFile;
begin
  if bolLogging then
  begin
    Filename:= ChangeFileExt (Application.Exename, '.log');
    AssignFile (LogFile, Filename);
    if FileExists (FileName) then
      Append (LogFile) // open existing file
    else
      Rewrite (LogFile); // create a new one
    try
      // write to the file and show error
      Writeln (LogFile, DateTimeToStr (Now) + ', ' + LogType + ', ' + LogFrom + ', "' + LogMessage + '"');
    finally
      // close the file
      CloseFile (LogFile);
    end;
  end;
end;

function ExpandEnvStrings(const AString: String): String;
var
  bufsize: Integer;
begin
  bufsize := ExpandEnvironmentStrings(PChar(AString), nil, 0);
  SetLength(result, bufsize);
  ExpandEnvironmentStrings(PChar(AString), PChar(result), bufsize);
  result := TrimRight(result);
end;

function IsASLREnabled(): boolean;
var
  pansiBuffer, pansiValue: PAnsiChar;
  intBufferLength: Integer;
  regKernel: TRegistry;
  strValue: string;
begin
  //pansiBuffer:=nil;
  //pansiValue:=nil;
  //intBufferLength:=0;

  regKernel:=TRegistry.Create;
  try
    regKernel.RootKey:=HKEY_LOCAL_MACHINE;
    if regKernel.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Control\Session Manager\kernel') then begin
      intBufferLength:=regKernel.GetDataSize('MitigationOptions');
      GetMem(pansiBuffer, intBufferLength);
      GetMem(pansiValue, intBufferLength * 2);
      try
        regKernel.ReadBinaryData('MitigationOptions', pansiBuffer^, intBufferLength);
        BinToHex(pansiBuffer, pansiValue, intBufferLength);
        strValue:=String(pansiValue);
        if strValue.Substring(3,1) = '1' then
          Result:=true
        else
          Result:=false;

      finally
        FreeMem(pansiValue);
        FreeMem(pansiBuffer);
        regKernel.CloseKey;
      end;
    end else begin
      Result:=false;
    end;
  finally
    regKernel.Free;
  end;
end;

function GetDotNetReleaseFromVersion(strDotNetVersion: string): integer;
begin
  Result:=0;
  if strDotNetVersion='4.5' then Result:=DOTNET_4_5_RELEASEVALUE;
  if strDotNetVersion='4.5.1' then Result:=DOTNET_4_5_1_RELEASEVALUE;
  if strDotNetVersion='4.5.2' then Result:=DOTNET_4_5_2_RELEASEVALUE;
  if strDotNetVersion='4.6' then Result:=DOTNET_4_6_RELEASEVALUE;
  if strDotNetVersion='4.6.1' then Result:=DOTNET_4_6_1_RELEASEVALUE;
  if strDotNetVersion='4.6.2' then Result:=DOTNET_4_6_2_RELEASEVALUE;
  if strDotNetVersion='4.7' then Result:=DOTNET_4_7_RELEASEVALUE;
  if strDotNetVersion='4.7.2' then Result:=DOTNET_4_7_2_RELEASEVALUE;
  if strDotNetVersion='4.8' then Result:=DOTNET_4_8_RELEASEVALUE;
end;

function ValidateDotNetVersion(strDotNetVersion: string): string;
const
  arrDelphiVersions: TArray<string> = ['7bundle', '6bundle', '5bundle', '4or3.5', '4or3', '4or2',
    '4.5', '4.5.1', '4.5.2', '4.6', '4.6.1', '4.6.2', '4.7', '4.7.1', '4.7.2', '4.8',
    '4', '3.5', '3', '2', '1.1', '1', '7', '6', '5', '3.1core', '3core', '2.2core', '2.1core',
    '2core', '1.1core', '1core'];
begin
  // Adjust deprecated values
  if strDotNetVersion = '2-4' then strDotNetVersion:='4or2';
  if strDotNetVersion = '3-4' then strDotNetVersion:='4or3';
  if strDotNetVersion = '3.5-4' then strDotNetVersion:='4or3.5';

  if MatchStr(strDotNetVersion, arrDelphiVersions) then
    Result:=strDotNetVersion
  else
    Result:='';
end;

function BooleanToString(bolInput: boolean): string;
begin
  if bolInput then
    Result:='True'
  else
    Result:='False';
end;

function StringToBoolean(strInput: string): boolean;
begin
  if ansiLowerCase(strInput) = 'true' then
    Result:=true
  else
    Result:=false;
end;

end.

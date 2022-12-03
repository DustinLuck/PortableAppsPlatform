{
ProcessList.pas

Released under MIT and GPL courtesy of Luthfi Harahap at the request of
John T. Haller of PortableApps.com in 2013

Details: http://forum.codecall.net/topic/72604-getting-running-processes-list/

Copyright 2012-2013 Luthfi Harahap
	
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
}

unit ProcessList;

interface

uses
  Windows
  , TlHelp32
  , Classes
  , SysUtils
  ;

type
  ESystemError=class(Exception)
  public
    constructor Create(const AMsg: string=''); reintroduce;
  end;

  TProcess=class
  private
    FID: Cardinal;
    FPath: string;
    FName: string;
    FUser: string;
    FDomain: string;
    function GetFullname: string;
  protected
    procedure GetPath;
    procedure GetUserInformation;
  public
    constructor Create(const AID: Cardinal; const AName: string);

    // Retrieve more information about the process, using the process ID already
    // supplied
    procedure Query;

    // Process ID, assigned by Windows system
    property ID: Cardinal read FID;
    // Path to the executable of the process
    property Path: string read FPath;
    // Name of the process, usually the name of the executable
    property Name: string read FName;
    // combination of the path and the name
    property Fullname: string read GetFullname;
    // Username of the user who creates the process (executes its executable)
    property User: string read FUser;
    // Domain of the user
    property Domain: string read FDomain;
  end;

  TProcesses=class
  private
    FList: TStrings;
    function GetItem(Index: Integer): TProcess;
    function GetCount: Integer;
  protected
    function DoAdd(const AID:Cardinal; const AName: string): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ReadSystem;

    procedure Clear;
    function Add(const AID:Cardinal; const AName: string): Integer;
    function Find(const AProcessID: Cardinal; var AProcess: TProcess): Boolean; overload;
    function Find(AName: string; var AProcess: TProcess): Boolean; overload;
    function IndexOf(const AProcessID: Cardinal): Integer; overload;
    function IndexOf(AName: string): Integer; overload;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TProcess read GetItem; default;
  end;

  function IsRunning(AProcessName: string): Boolean;

implementation

function IsRunning(AProcessName: string): Boolean;
var
  S: string;
  vSnapshot: THandle;
  vProcessEntry: TProcessEntry32;
begin
  Result := False;
  AProcessName := UpperCase(AProcessName);

  vSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    vProcessEntry.dwSize := SizeOf(TProcessEntry32);

    if not Process32First(vSnapshot, vProcessEntry) then Exit;
    repeat
      S := UpperCase(vProcessEntry.szExeFile);
      Result := S=AProcessName;
      if Result then Exit;
    until not Process32Next(vSnapshot, vProcessEntry);

  finally
    CloseHandle(vSnapshot);
  end;
end;

{ TProcess }

constructor TProcess.Create(const AID: Cardinal; const AName: string);
begin
  FID := AID;
  FName := AName;
  Query;
end;

function TProcess.GetFullname: string;
begin
  if FPath = '' then
    Result := FName
  else
    Result := FPath + '\' + FName;
end;

procedure TProcess.GetPath;
var
  vSnapshot: THandle;
  vModuleEntry: TModuleEntry32;
begin
  FPath := '';
  vSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, FID);
  if (vSnapShot=0) or (vSnapshot=INVALID_HANDLE_VALUE) then Exit;
  try
    vModuleEntry.dwSize := SizeOf(TModuleEntry32);
    if not Module32First(vSnapshot, vModuleEntry) then
      raise ESystemError.Create;

    FPath := vModuleEntry.szExePath;
  finally
    CloseHandle(vSnapshot);
  end;
end;

procedure TProcess.GetUserInformation;
type
  PTokenUser = ^TTokenUser;
  TTokenUser = record
    User: TSIDAndAttributes;
  end;
const
  PROCESS_QUERY_LIMITED_INFORMATION = $1000;

var
  vHandle: THandle;
  vToken : THandle;
  vUserName: array[0..255] of char;
  vDomainName: array[0..255] of char;
  vUserNameSize: DWORD;
  vDomainNameSize: DWORD;
  vTokenUser: PTokenUser;
  vInfoSize: Cardinal;
  vUse: SID_NAME_USE;
begin
  FUser := '';
  FDomain := '';

  vHandle := OpenProcess(PROCESS_QUERY_INFORMATION, False, FID);
  if vHandle > 0 then
  try
    if OpenProcessToken(vHandle, TOKEN_QUERY, vToken) then
    try
      GetTokenInformation(vToken, TokenUser, nil, 0, vInfoSize);
      vUserNameSize := SizeOf(vUserName);
      vDomainNameSize := SizeOf(vDomainName);
      vUse := SidTypeUser;
      GetMem(vTokenUser, vInfoSize);
      try
        if not GetTokenInformation(vToken, TokenUser, vTokenUser, vInfoSize, vInfoSize) then
          raise ESystemError.Create;
        LookupAccountSid(nil, vTokenUser.User.Sid, @vUserName, vUserNameSize, @vDomainName, vDomainNameSize, vUse);
        FUser := vUserName;
        FDomain := vDomainName;
      finally
        FreeMem(vTokenUser);
      end;
    finally
      CloseHandle(vToken);
    end;
  finally
    CloseHandle(vHandle);
  end;
end;

procedure TProcess.Query;
begin
  GetPath;
  GetUserInformation;
end;

{ TProcesses }

function TProcesses.Add(const AID: Cardinal; const AName: string): Integer;
begin
  Result := IndexOf(AID);
  if Result < 0 then
    Result := DoAdd(AID, AName);
end;

procedure TProcesses.Clear;
var
  i: Integer;
begin
  for i := 0 to FList.Count-1 do
    FList.Objects[i].Free;

  FList.Clear;
end;

constructor TProcesses.Create;
begin
  FList := TStringList.Create;
end;

destructor TProcesses.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TProcesses.DoAdd(const AID: Cardinal;
  const AName: string): Integer;
var
  P: TProcess;
begin
  P := TProcess.Create(AID, AName);
  Result := FList.AddObject(IntToStr(AID)+'='+AName, P);
end;

function TProcesses.Find(const AProcessID: Cardinal;
  var AProcess: TProcess): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FList.Count-1 do
  begin
    Result := TProcess(FList.Objects[i]).ID = AProcessID;
    if Result then
    begin
      AProcess := TProcess(FList.Objects[i]);
      Exit;
    end;
  end;
end;

function TProcesses.Find(AName: string; var AProcess: TProcess): Boolean;
var
  i: Integer;
begin
  Result := False;
  AName := UpperCase(AName);
  for i := 0 to FList.Count-1 do
  begin
    Result := TProcess(FList.Objects[i]).Name = AName;
    if Result then
    begin
      AProcess := TProcess(FList.Objects[i]);
      Exit;
    end;
  end;
end;

function TProcesses.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TProcesses.GetItem(Index: Integer): TProcess;
begin
  Result := TProcess(FList.Objects[Index]);
end;

function TProcesses.IndexOf(const AProcessID: Cardinal): Integer;
begin
  for Result := 0 to FList.Count-1 do
    if TProcess(FList.Objects[Result]).ID=AProcessID then
      Exit;

  Result := -1;
end;

function TProcesses.IndexOf(AName: string): Integer;
begin
  AName := UpperCase(AName);
  for Result := 0 to FList.Count-1 do
    if TProcess(FList.Objects[Result]).Name=AName then
      Exit;

  Result := -1;
end;

procedure TProcesses.ReadSystem;
var
  vSnapshot: THandle;              // to store the tool help snapshot handle
  vProcessEntry: TProcessEntry32;  // temporarily store process information
begin
  // Erase all stored TProcess instances
  Clear;

  // Get the snapshot of the current state
  vSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    // setting up the structure size information
    vProcessEntry.dwSize := SizeOf(TProcessEntry32);

    // make call to get first process information
    if not Process32First(vSnapshot, vProcessEntry) then Exit;

    // Loop to read and store the process information
    repeat
      // add new instance of TProcess storing the supplied process information
      Add(vProcessEntry.th32ProcessID, vProcessEntry.szExeFile);
      
      // try to retrieve next process information. When this fails, the loop
      // will be stopped
    until not Process32Next(vSnapshot, vProcessEntry);
              
  finally
    // clean up the snapshot
    CloseHandle(vSnapshot);
  end;
end;

{ ESystemError }

constructor ESystemError.Create(const AMsg: string);
begin
  if AMsg='' then
    inherited Create(SysErrorMessage(GetLastError))
  else
    inherited Create(AMsg + #13#10'System giving message: ' + SysErrorMessage(GetLastError));
end;

end.

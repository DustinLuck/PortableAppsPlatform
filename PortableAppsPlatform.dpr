{
Copyright 2006-2012 John T. Haller of PortableApps.com

Website: http://PortableApps.com/

This software is OSI Certified Open Source Software.
OSI Certified is a certification mark of the Open Source Initiative.

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


An exception to the GPL is granted to link this code to specific
non-GPLed DLLs published by PortableApps.com to enable advanced
functionality.
}

program PortableAppsPlatform;

uses
  Windows,
  Dialogs,
  Forms,
  Sysutils,
  main in 'main.pas' {frmMenu},
  about in 'about.pas' {frmAbout},
  variables in 'variables.pas',
  functions in 'functions.pas',
  objects in 'objects.pas',
  renamemenuitem in 'renamemenuitem.pas' {frmRenameMenuItem},
  dialog in 'dialog.pas' {frmDialog},
  options in 'options.pas' {frmOptions},
  Vcl.Themes,
  Vcl.Styles,
  ProcessList in 'ProcessList.pas';

{$R *.RES}

begin
  // Define our unique ID based on a long string and our path (we add the path so multiple launchers on multiple USBs still work)
	intWindowsMessageRecallInstance:=RegisterWindowMessage(PChar('PortableApps.comPlatformWindowMessageToRecallInstance'+Application.ExeName));
	intWindowsMessageRefresh:=RegisterWindowMessage(PChar('PortableApps.comPlatformWindowMessageToRefresh'+Application.ExeName));
  intWindowsMessageCloseForUpdate:=RegisterWindowMessage(PChar('PortableApps.comPlatformWindowMessageToCloseForUpdate'+Application.ExeName));

  // Check for previous instance via exceedingly long mutex.
	CreateMutex(nil, false, PChar('PortableApps.comPlatformMutexToRecallInstance'+IntToStr(intWindowsMessageRecallInstance)));
	if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    // Tell our original window to reappear and quit our duplicate one
    hwndOtherInstance:=FindWindow('PortableApps.com Menu', nil);
    if hwndOtherInstance<>0 then
      SetForegroundWindow(hwndOtherInstance);

    PostMessage(HWND_BROADCAST, intWindowsMessageRecallInstance, 0, 0);
    Application.Terminate();
    exit;
  end;
  //UniqueMessageID:=RegisterWindowMessage(PAnsiChar('PortableApps.comPlatformWindowMessageToRefresh'+Application.ExeName));
  //ShowMessage('PortableApps.comPlatformWindowMessageToRefresh'+Application.ExeName);

  // Work around a bug in COMSPEC on some Windows systems by setting the current directory as the working directory
  SetCurrentDir(ExtractFileDir(Application.ExeName));

  Application.Initialize;
  Application.MainFormOnTaskBar:=false;
  Application.Title := 'PortableApps.com Platform';
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmRenameMenuItem, frmRenameMenuItem);
  Application.CreateForm(TfrmDialog, frmDialog);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
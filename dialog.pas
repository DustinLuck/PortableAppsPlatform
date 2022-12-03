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


An exception to the GPL is granted to PortableApps.com to link this code with closed
source code published by PortableApps.com to enable additional functionality.
}

unit dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, Variables;

type
  TfrmDialog = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    lblMessage: TLabel;
    imgIcon: TImage;

    lblMessage2: TLabel;
    progProgress: TProgressBar;
    procedure lblMessage2Click(Sender: TObject);
    procedure lblMessageClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strTitle: string;
    strMessage: string;
    strButton: string;
    bolButtons: boolean;
    bolOKOnly: boolean;
    strIconType: string;
    strButtonOK: string;
    strButtonCancel: string;
    bolOKDefault: boolean;
  end;

var
  frmDialog: TfrmDialog;

implementation

{$R *.dfm}

procedure TfrmDialog.btnCancelClick(Sender: TObject);
begin
  strButton:='CANCEL';
  self.Close;
  bolOKOnly:=false;
end;

procedure TfrmDialog.btnOKClick(Sender: TObject);
begin
  strButton:='OK';
  self.Close;
  bolOKOnly:=false;
end;

procedure TfrmDialog.FormShow(Sender: TObject);
begin
    if strLocaleDirection = 'LTR' then
      frmDialog.BiDiMode:=bdLeftToRight
    else
      frmDialog.BiDiMode:=bdRightToLeft;

  if FileExists(ExtractFileDir(Application.ExeName) + '\App\Graphics\Dialogs\icon_' + strIconType + '.png') then
  begin
    imgIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Dialogs\icon_' + strIconType + '.png');
    imgIcon.Visible:=true;
  end
  else
    imgIcon.Visible:=false;

  if bolOKDefault then
  begin
    btnCancel.Default:=false;
    btnOK.Default:=true;
    btnOK.TabOrder:=0;
    btnCancel.TabOrder:=1;
  end
  else
  begin
    btnOK.Default:=false;
    btnCancel.Default:=true;
    btnOK.TabOrder:=1;
    btnCancel.TabOrder:=0;
  end;

  if strButtonCancel='' then
    strButtonCancel:='&Cancel';
  if strButtonOK='' then
    strButtonOK:='&OK';
  lblMessage.caption:=strMessage;
  lblMessage2.caption:='';
  btnOK.Caption:=strButtonOK;
  btnCancel.Caption:=strButtonCancel;
  frmDialog.Caption:=strTitle;
  if bolButtons then
  begin
    if bolOKOnly then
    begin
      btnOK.Visible:=true;
      btnCancel.Visible:=false;
      btnOK.Left:=MulDiv(384, Screen.PixelsPerInch, 96);
    end
    else
    begin
      btnOK.Visible:=true;
      btnCancel.Visible:=true;
      btnOK.Left:=MulDiv(309, Screen.PixelsPerInch, 96);
    end;
  end
  else
  begin
    btnOK.Visible:=false;
    btnCancel.Visible:=false;
  end;
  if (strIconType='WAIT') or (strIconType='UNINSTALL') then
      begin
        frmDialog.Cursor:=crHourGlass;
        progProgress.Visible:=true;
      end
  else
      begin
        frmDialog.Cursor:=crDefault;
        progProgress.Visible:=false;
      end;
    //frmDialog.SetFocus;
end;

procedure TfrmDialog.FormClick(Sender: TObject);
begin
  frmDialog.refresh;
end;

procedure TfrmDialog.lblMessage2Click(Sender: TObject);
begin
beep;
  frmDialog.refresh;
end;

procedure TfrmDialog.lblMessageClick(Sender: TObject);
begin
beep;
  frmDialog.refresh;
end;

end.

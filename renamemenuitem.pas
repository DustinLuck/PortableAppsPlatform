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

unit renamemenuitem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, pngimage, ExtCtrls, main;

type
  TfrmRenameMenuItem = class(TForm)
    btnOK: TButton;
    edtCustomName: TEdit;
    imgArrow: TImage;
    edtOriginalName: TEdit;
    btnCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
  	strOriginalName: string;
    strCustomName:string;
    bolAddCategory: boolean;
    { Public declarations }
  end;

var
  frmRenameMenuItem: TfrmRenameMenuItem;

implementation

{$R *.dfm}

procedure TfrmRenameMenuItem.btnCancelClick(Sender: TObject);
begin
	//strCustomName:=strOriginalName;
  frmRenameMenuItem.close;
end;

procedure TfrmRenameMenuItem.btnOKClick(Sender: TObject);
begin
	strCustomName:=Trim(edtCustomName.Text);
  frmRenameMenuItem.close;
end;


procedure TfrmRenameMenuItem.FormActivate(Sender: TObject);
begin
	edtOriginalName.Text:=strOriginalName;
	edtCustomName.Text:=strCustomName;
  if bolAddCategory then
  begin
    edtOriginalName.Visible:=false;
    imgArrow.Visible:=false;
  end
  else
  begin
    edtOriginalName.Visible:=true;
    imgArrow.Visible:=true;
    frmRenameMenuItem.Caption:=frmMenu.strRenameMenuItem;
  end;
end;

end.

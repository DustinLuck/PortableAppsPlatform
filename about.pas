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

unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Functions, ComCtrls, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, variables, pngimage, INIFiles, Vcl.ImgList,
  System.ImageList;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    btnDonate: TButton;
    pageAbout: TPageControl;
    tabsheetPlatform: TTabSheet;
    tabsheetSponsors: TTabSheet;
    tabsheetApps: TTabSheet;
    imgLogo: TImage;
    lblCopyright: TLabel;
    lblVersion: TLabel;
    lblWindowsInformation: TLabel;
    lblBronzeSupporters: TLabel;
    lblSupporters: TLabel;
    memoInstalledApps: TMemo;
    imagelistTabs: TImageList;
    lblBronzeSponsorsHeader: TLabel;
    lblSupportersHeader: TLabel;
    lblFun: TLabel;
    tabsheetWhatsNew: TTabSheet;
    lblWhatsNewHeader: TLabel;
    lblPortableAppsHelpHeader: TLabel;
    lblPortableAppsHelpDetail: TLabel;
    btnFirefoxAddOn: TButton;
    lblSilverSponsorsHeader: TLabel;
    lblSilverSponsors: TLabel;
    lblSupporters2: TLabel;
    memoWhatsNewDetails: TMemo;
    lblNetVersions: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnDonateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    procedure LoadLocale();

  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;
  strNoThanks: string;

implementation

uses main;

{$R *.dfm}

procedure TfrmAbout.btnDonateClick(Sender: TObject);
begin
  OpenURL('http://portableapps.com/donate');
  Close
end;

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
  Close
end;

procedure TfrmAbout.LoadLocale;
var
	iniLocaleFile: TINIFile;
begin
	// Check for locale test file
	// Temporary addition to allow testing of .locale files for translations
	if FileExists(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale') then
	begin
		iniLocaleFile:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale');
    frmAbout.Caption:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HELP_ABOUT', '&About'), '&', '', [rfReplaceAll, rfIgnoreCase]);
    btnOK.Caption:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_OK', '&Ok');
    tabsheetPlatform.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'TAB_PLATFORM', 'Platform');
    tabsheetSponsors.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'TAB_SPONSORS', 'Sponsors');
    tabsheetApps.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'TAB_APPS', 'Apps');
    strNoThanks:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_CLOSE', '&Close');
    tabsheetWhatsNew.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'TAB_WHATS_NEW', 'What''s New');
    lblSupportersHeader.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'HEADER_SUPPORTERS', 'Supporters')+':';
    lblBronzeSponsorsHeader.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'HEADER_BRONZE_SPONSORS', 'Bronze Sponsors')+':';
    lblSilverSponsorsHeader.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'HEADER_SILVER_SPONSORS', 'Silver Sponsors')+':';
    btnDonate.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HELP_DONATE', 'Donate to PortableApps.com');
    lblWhatsNewHeader.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'WHATS_NEW_HEADER', 'What''s New In The PortableApps.com Platform (English)')+':';
    lblPortableAppsHelpHeader.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'DONATION_ASK_HEADER', '');
    lblPortableAppsHelpDetail.Caption:=iniLocaleFile.ReadString('FORM_ABOUT', 'DONATION_ASK', 'PortableApps.com needs your help to keep bringing you great software for free. You can help just by making a small donation to PortableApps.com using your credit card, bank account, or PayPal.' + ' You can even use bitcoin, litecoin, and dogecoin. Won''t you please help support PortableApps.com?');
    FreeAndNil(iniLocaleFile);

    if strLocaleDirection = 'LTR' then
      frmAbout.BiDiMode:=bdLeftToRight
    else
      frmAbout.BiDiMode:=bdRightToLeft;
	end;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
	strWindowsName: string;
  fileWhatsNew: TextFile;
  strWhatsNew: string;

begin
  if FileExists(ExtractFileDir(Application.ExeName)+'\WhatsNew.txt') then
	  begin
      AssignFile(fileWhatsNew, ExtractFileDir(Application.ExeName)+'\WhatsNew.txt');
      Reset(fileWhatsNew);

      memoWhatsNewDetails.Text:='';
      while not Eof(fileWhatsNew) do
      begin
        ReadLn(fileWhatsNew, strWhatsNew);
        memoWhatsNewDetails.Text:=memoWhatsNewDetails.Text + strWhatsNew + #13#10;
      end;

      CloseFile(fileWhatsNew);
    end
  else
    memoWhatsNewDetails.Text:='File not found: ' +  ExtractFileDir(Application.ExeName)+'\WhatsNew.txt';

  case Win32MajorVersion of
    3:
      strWindowsName:='Windows NT';
    4:
      strWindowsName:='Windows NT';
    5:
      case Win32MinorVersion of
        0:
          strWindowsName:='Windows 2000';
        1:
          strWindowsName:='Windows XP';
        2:
          strWindowsName:='Windows 2003';
        end;
    6:
      case Win32MinorVersion of
        0:
          strWindowsName:='Windows Vista';
        1:
          strWindowsName:='Windows 7';
        2:
          strWindowsName:='Windows 8';
        3:
          strWindowsName:='Windows 8.1';
        end;
    10:
      if (Win32BuildNumber>21900) then
        strWindowsName:='Windows 11'
      else
        strWindowsName:='Windows 10';
    else
      strWindowsName:='Unknown OS';
    end;

  if Win32CSDVersion <> '' then
    strWindowsName:=strWindowsName + ' ' + Win32CSDVersion;

  strWindowsName:=strWindowsName + ' (Version ' + IntToStr(Win32MajorVersion) + '.' + IntToStr(Win32MinorVersion) + ', Build: '+IntToStr(Win32BuildNumber)+', ';

  if SysUtils.TOSVersion.Architecture = arIntelX64 then
    strWindowsName:=strWindowsName + '64-bit Edition'
  else
    strWindowsName:=strWindowsName + '32-bit Edition';

  strWindowsName:=strWindowsName + ')';

  strWindowsName:=TOSVersion.ToString;

  if (Win32MajorVersion=10) and (Win32BuildNumber>21900) then
    strWindowsName:=stringreplace(strWindowsName, 'Windows 10', 'Windows 11', [rfReplaceAll, rfIgnoreCase]);


	lblWindowsInformation.Caption:=strWindowsName;
  lblVersion.Caption:=APPVERSIONFRIENDLY;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
var
  intCounter: integer;
  intSlogan: integer;
  strSlogan: string;
  strNetFrameworkDetails, strNetCoreDetails, strNetDetails: string;
  strlDotNet4: TStringList;
begin
  LoadLocale();
  strlstFullAppReportPAF.Sort;
  strlstFullAppReportNonPAF.Sort;

  memoInstalledApps.Text := '';

  for intCounter := 0 to strlstFullAppReportPAF.Count-1 do
    memoInstalledApps.Text := memoInstalledApps.Text + strlstFullAppReportPAF[intCounter] + #13#10;

  memoInstalledApps.Text := memoInstalledApps.Text + #13#10;

  for intCounter := 0 to strlstFullAppReportNonPAF.Count-1 do
    memoInstalledApps.Text := memoInstalledApps.Text + strlstFullAppReportNonPAF[intCounter] + #13#10;

  // Fun slogans
  if ((strOEM = '') and ((UpperCase(strLocale) = 'ENGLISH') or (UpperCase(strLocale) = 'ENGLISHGB'))) then
  begin
    intSlogan := 1 + Random(29);

    case intSlogan of
      1:
        strSlogan:='coded in an office that contains nuts';
      2:
        strSlogan:='full of stars';
      3:
        strSlogan:='you''ve reached the bonus level!';
      4:
        strSlogan:='wow, have you been working out?';
      5:
        strSlogan:='you''re awesome!';
      6:
        strSlogan:='that''s no moon';
      7:
        strSlogan:='make life take the lemons back!';
      8:
        strSlogan:='you must construct additional pylons';
      9:
        strSlogan:='hats for clowns';
      10:
        strSlogan:='draw a more different S';
      11:
        strSlogan:='prolonged eye contact';
      12:
        strSlogan:='unscheduled off-world activation';
      13:
        strSlogan:='darmok and jalad at tanagra';
      14:
        strSlogan:='show me what you got';
      15:
        strSlogan:='how do you type with boxing gloves on';
      16:
        strSlogan:='give him the stick, don''t give him the stick';
      17:
        strSlogan:='#hashtag';
      18:
        strSlogan:='post no bills';
      19:
        strSlogan:='literally can''t even';
      20:
        strSlogan:='this space intentionally left blank';
      21:
        strSlogan:='iddqd';
      22:
        strSlogan:='look behind you';
      23:
        strSlogan:='people like grapes';
      24:
        strSlogan:='how about a nice game of chess?';
      25:
        strSlogan:='kuzco''s about box';
      26:
        strSlogan:='inspired by true events';
      27:
        strSlogan:='closest guess 10/14/72';
      28:
        strSlogan:='burninate';
      29:
        strSlogan:='main b bus undervolt';
      else
        strSlogan:='divide by zero, universe over';
    end;
    lblFun.Caption:=strSlogan + ' ';
    end
  else
    lblFun.Caption:='';

  if bolHelpWhatsNew then
  begin
    lblPortableAppsHelpHeader.Visible:=true;
    lblPortableAppsHelpDetail.Visible:=true;
    btnFirefoxAddOn.Visible:=false;
    btnOK.Caption:=strNoThanks;
    pageAbout.ActivePage:=tabsheetWhatsNew;
    bolHelpWhatsNew:= false;
  end
  else
  begin
    lblPortableAppsHelpHeader.Visible:=false;
    lblPortableAppsHelpDetail.Visible:=false;
    btnFirefoxAddOn.Visible:=false;
    pageAbout.ActivePage:=tabsheetPlatform;
  end;

    strNetFrameworkDetails:='';

   if bolDotNet1 then
    strNetFrameworkDetails:=strNetFrameworkDetails+'1.0, ';

  if bolDotNet1_1 then
    strNetFrameworkDetails:=strNetFrameworkDetails+'1.1, ';

  if bolDotNet2 then
    strNetFrameworkDetails:=strNetFrameworkDetails+'2.0, ';

  if bolDotNet3 then
    strNetFrameworkDetails:=strNetFrameworkDetails+'3.0, ';

  if bolDotNet3_5 then
    strNetFrameworkDetails:=strNetFrameworkDetails+'3.5, ';

  if bolDotNet4 then
  begin
    strlDotNet4:= TStringList.Create;
		SplitString(strDotNet4, '.', strlDotNet4);
    if strlDotNet4.Count > 1 then
       strNetFrameworkDetails:=strNetFrameworkDetails+strlDotNet4[0]+'.'+strlDotNet4[1]+', '
    else
      strNetFrameworkDetails:=strNetFrameworkDetails+'4.0, ';
  end;

  strNetCoreDetails:='';

  if bolDotNetCore1_1 then
    strNetCoreDetails:=strNetCoreDetails+'1.1, '
  else if bolDotNetCore1 then
    strNetCoreDetails:=strNetCoreDetails+'1.0, ';

  if bolDotNetCore2_2 then
    strNetCoreDetails:=strNetCoreDetails+'2.2, '
  else if bolDotNetCore2_1 then
    strNetCoreDetails:=strNetCoreDetails+'2.1, '
  else if bolDotNetCore2 then
    strNetCoreDetails:=strNetCoreDetails+'2.0, ';

  if bolDotNetCore3_1 then
    strNetCoreDetails:=strNetCoreDetails+'3.1, '
  else if bolDotNetCore3 then
    strNetCoreDetails:=strNetCoreDetails+'3.0, ';

  strNetDetails:='';

  if bolDotNet5 then
    strNetDetails:=strNetDetails+'5, ';
  if bolDotNet6 then
    strNetDetails:=strNetDetails+'6, ';
  if bolDotNet7 then
    strNetDetails:=strNetDetails+'7, ';

  if strNetFrameworkDetails<>'' then
    lblNetVersions.Caption:='.NET Framework: ' + strNetFrameworkDetails.Substring(0,strNetFrameworkDetails.Length-2)
  else
    lblNetVersions.Caption:='.NET Framework: -';

  if strNetCoreDetails<>'' then
    lblNetVersions.Caption:=lblNetVersions.Caption+' / .NET Core: ' + strNetCoreDetails.Substring(0,strNetCoreDetails.Length-2)
  else
    lblNetVersions.Caption:=lblNetVersions.Caption+' / .NET Core: -';

  if strNetDetails<>'' then
    lblNetVersions.Caption:=lblNetVersions.Caption+' / .NET: ' + strNetDetails.Substring(0,strNetDetails.Length-2)
  else
    lblNetVersions.Caption:=lblNetVersions.Caption+' / .NET: -'

end;
end.

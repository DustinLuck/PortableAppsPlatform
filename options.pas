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

unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, functions, StrUtils,
  Dialogs, ComCtrls, StdCtrls, pngimage, ExtCtrls, ImgList, INIFiles, variables, Registry,
  System.ImageList;

type
  TfrmOptions = class(TForm)
    pageOptions: TPageControl;
    tabsheetGeneral: TTabSheet;
    tabsheetThemes: TTabSheet;
    tabsheetAdvanced: TTabSheet;
    listboxThemes: TListBox;
    btnAddTheme: TButton;
    comboThemeColors: TComboBox;
    btnRemoveTheme: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    btnGetThemes: TButton;
    ImageList1: TImageList;
    grpDisplayOptions: TGroupBox;
    chkLargeFonts: TCheckBox;
    lblMenuTransparency: TLabel;
    grpLanguage: TGroupBox;
    chkUseLanguageForAllApps: TCheckBox;
    comboLanguage: TComboBox;
    comboTransparency: TComboBox;
    pnlColorPreview: TPanel;
    imgPreviewBackground: TImage;
    imgPreviewChrome: TImage;
    imgPreviewDocuments: TImage;
    imgPreviewMusic: TImage;
    imgPreviewPictures: TImage;
    imgPreviewVideos: TImage;
    chkExpandCategoriesByDefault: TCheckBox;
    imgPreviewMatte: TImage;
    chkDisableAppSplashScreens: TCheckBox;
    chkHideDesktopIcons: TCheckBox;
    chkCollapseOtherFoldersOnExpand: TCheckBox;
    chkKeyboardFriendly: TCheckBox;
    tabsheetConnection: TTabSheet;
    grpConnectionType: TGroupBox;
    radioConnectionTypeAutomatic: TRadioButton;
    radioConnectionTypeDirect: TRadioButton;
    radioConnectionTypeProxy: TRadioButton;
    edtProxyIP: TEdit;
    lblProxyIP: TLabel;
    lblProxyPort: TLabel;
    edtProxyPort: TEdit;
    chkCollapseCategoriesOnMinimize: TCheckBox;
    chkCloseAppsOnPlatformExit: TCheckBox;
    chkSearchWithinAppDescriptions: TCheckBox;
    tabSheetUpdater: TTabSheet;
    grpUpdater: TGroupBox;
    chkUpdateAutomatically: TCheckBox;
    chkBetaPlatformReleases: TCheckBox;
    tabsheetAppStore: TTabSheet;
    grpAppDirectory: TGroupBox;
    chkAppDirectoryShowOpenSourceOnly: TCheckBox;
    chkAppDirectoryShowAdvancedApps: TCheckBox;
    chkShowInstalledApps: TCheckBox;
    tabsheetOrganization: TTabSheet;
    grpAppListOrganization: TGroupBox;
    radioAllAlphabetical: TRadioButton;
    radioAllCategories: TRadioButton;
    radioSmartAlphabetical: TRadioButton;
    radioSmartCategories: TRadioButton;
    chkBoldFolderNames: TCheckBox;
    chkBoldFavorites: TCheckBox;
    chkDisableScrollbar: TCheckBox;
    chkHidePortableInAppNames: TCheckBox;
    chkEnableLogging: TCheckBox;
    chkShowAppPathsInTooltips: TCheckBox;
    chkShowAppPublisherInTooltips: TCheckBox;
    chkKeepMenuVisible: TCheckBox;
    chkStartMinimized: TCheckBox;
    chkShowUpdaterStartupErrors: TCheckBox;
    chkHideTaskbarIcon: TCheckBox;
    chkHideSearchWhenNotInUse: TCheckBox;
    chkAutorunProtection: TCheckBox;
    chkFadeMenu: TCheckBox;
    chkHideLogoDecorations: TCheckBox;
    grpShow64BitOnlyApps: TGroupBox;
    radio64BitAutomatic: TRadioButton;
    radio64BitAlways: TRadioButton;
    radio64BitNever: TRadioButton;
    lblTaskbarIcon: TLabel;
    comboTaskbarIcon: TComboBox;
    imgTaskbarIcon: TImage;

    procedure btnCancelClick(Sender: TObject);
    procedure pageOptionsDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure listboxThemesClick(Sender: TObject);
    procedure comboThemeColorsClick(Sender: TObject);
    procedure radioConnectionTypeAutomaticClick(Sender: TObject);
    procedure radioConnectionTypeDirectClick(Sender: TObject);
    procedure radioConnectionTypeProxyClick(Sender: TObject);
    procedure comboTaskbarIconClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadLocale();
    procedure SetupMenus();
    procedure ThemeSelected();
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;
  strTranslatedTransparencyOff: string;
  strOEMTheme: string;
  strPADefaultTheme: string;
  strPADefaultDarkTheme: string;
  strPAClassicTheme: string;
  strPAClassicDarkTheme: string;
  strPAFlatTheme: string;
  strPAFlatThemeDark: string;
  strPAGlassyTheme: string;
  strPAGlassyThemeDark: string;
  strPAModernTheme: string;
  strPAModernThemeDark: string;
  strPARetroTheme: string;
  strPARetroThemeDark: string;
  strPASmoothTheme: string;
  strPASmoothThemeDark: string;
  strOptionsThemeSelected: string;
  strOptionsThemeColorSelected: string;
  strOptionsThemeCustomColorSelected: string;
  strTaskbarIconSelected: string;
  strTransPink: string;
  strTransRed: string;
  strTransOrange: string;
  strTransYellow: string;
  strTransGreen: string;
  strTransBlue: string;
  strTransPurple, strTransViolet, strTransBlack, strTransWhite, strTransGray, strTransSilver, strTransBronze, strTransGold, strTransBrown: string;
  strTransDefault: string;
  intHideDesktopIcons: integer;
implementation

{$R *.dfm}

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmOptions.pageOptionsDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
  var ARect : TRect;
begin
   ARect := Rect;
  //clear complete

  control.Canvas.FillRect(ARect);
  InflateRect(ARect,-2,-2);
  //decide the color
  if active then
    control.Canvas.brush.Color := clBtnHighlight
  else
    control.Canvas.brush.Color := clBtnFace;
  //paint the tab
  control.Canvas.FillRect(ARect);
  control.Canvas.TextRect(ARect,ARect.Left+50,ARect.top+25,
                         TPageControl(Control).Pages[TabIndex].Caption);
 // Control.Canvas.StretchDraw(rect,Application.icon);//this paints the app.icon on every tab. If you use a appropriate bitmap you can have a nice effect
  control.Canvas.draw(   ARect.Left+50,ARect.top+5,Application.icon);
  end;

procedure TfrmOptions.radioConnectionTypeAutomaticClick(Sender: TObject);
begin
  edtProxyIP.Enabled:=false;
  edtProxyPort.Enabled:=false;
end;

procedure TfrmOptions.radioConnectionTypeDirectClick(Sender: TObject);
begin
  edtProxyIP.Enabled:=false;
  edtProxyPort.Enabled:=false;
end;

procedure TfrmOptions.radioConnectionTypeProxyClick(Sender: TObject);
begin
  edtProxyIP.Enabled:=true;
  edtProxyPort.Enabled:=true;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
 strLocale:=LeftStr(comboLanguage.Text, (Pos(' / ', comboLanguage.Text)-1));
  bolLargeFonts:=chkLargeFonts.Checked;

  case comboTransparency.ItemIndex of
    0: intAlphaBlendMain:=255;
    1: intAlphaBlendMain:=230;
    2: intAlphaBlendMain:=204;
    3: intAlphaBlendMain:=179;
    4: intAlphaBlendMain:=153;
    5: intAlphaBlendMain:=128;
    6: intAlphaBlendMain:=102;
    7: intAlphaBlendMain:=77;
    8: intAlphaBlendMain:=51;
    9: intAlphaBlendMain:=26;
    else intAlphaBlendMain:=255;
  end;

  if radioAllCategories.Checked then
  begin
    bolShowAllApps:=true;
    bolUseCategories:=true;
  end;

  if radioAllAlphabetical.Checked then
  begin
    bolShowAllApps:=true;
    bolUseCategories:=false;
  end;

  if radioSmartCategories.Checked then
  begin
    bolShowAllApps:=false;
    bolUseCategories:=true;
  end;

  if radioSmartAlphabetical.Checked then
  begin
    bolShowAllApps:=false;
    bolUseCategories:=false;
  end;

  if chkUseLanguageForAllApps.Checked then
    bolDisableAppLanguageSwitching:=false
  else
    bolDisableAppLanguageSwitching:=true;
  bolKeyboardFriendly:=chkKeyboardFriendly.Checked;
  bolBoldFavorites:=chkBoldFavorites.Checked;
  bolShowInstalledApps:=chkShowInstalledApps.Checked;
  bolHideDesktopIcons:=chkHideDesktopIcons.Checked;
  bolBetaPlatformReleases:=chkBetaPlatformReleases.Checked;
  bolBoldFolderNames:=chkBoldFolderNames.Checked;
  bolExpandCategoriesByDefault:=chkExpandCategoriesByDefault.Checked;
  bolUpdateAutomatically:=chkUpdateAutomatically.Checked;
  bolDisableScrollbar:=chkDisableScrollbar.Checked;
  bolDisableSplashScreens:=chkDisableAppSplashScreens.Checked;
  bolHidePortableInAppNames:=chkHidePortableInAppNames.Checked;
  bolAppDirectoryShowOpenSourceOnly:=chkAppDirectoryShowOpenSourceOnly.Checked;
  bolAppDirectoryShowAdvancedApps:=chkAppDirectoryShowAdvancedApps.Checked;
  bolCollapseOtherFoldersOnExpand:=chkCollapseOtherFoldersOnExpand.Checked;
  bolCollapseCategoriesOnMinimize:=chkCollapseCategoriesOnMinimize.Checked;
  bolCloseAppsOnPlatformExit:=chkCloseAppsOnPlatformExit.Checked;
  bolSearchWithinAppDescriptions:=chkSearchWithinAppDescriptions.Checked;
  bolLogging:=chkEnableLogging.Checked;
  bolShowAppPathsInToolTips:=chkShowAppPathsInTooltips.Checked;
  bolShowAppPublishersInToolTips:=chkShowAppPublisherInTooltips.Checked;
  bolRemainVisible:=chkKeepMenuVisible.Checked;
  bolStartMinimized:=chkStartMinimized.Checked;
  bolShowUpdaterStarupErrors:=chkShowUpdaterStartupErrors.Checked;
  bolWindows7TaskbarIconNextLaunch:=not chkHideTaskbarIcon.Checked;
  bolHideSearchWhenNotInUse:=chkHideSearchWhenNotInUse.Checked;
  bolAutoRunProtection:=chkAutoRunProtection.Checked;
  bolFadeMenu:=chkFadeMenu.Checked;
  bolHideLogoDecorations:=chkHideLogoDecorations.Checked;

  if strOptionsThemeSelected<>'' then
  begin
    strCurrentTheme:=strOptionsThemeSelected;
    strCurrentThemeColor:=RightStr(comboThemeColors.Text, Length(comboThemeColors.Text)-(Pos(' / ', comboThemeColors.Text)+2));
    strThemeCustomColor:=strOptionsThemeCustomColorSelected;
    if strOptionsThemeSelected='OEM' then
      strThemePath:='OEM\Theme'
    else
      strThemePath:='App\Graphics\Themes\'+strCurrentTheme;
  end;

  strTaskbarIcon:=strTaskbarIconSelected;

  strConnectionProxyPort:=Trim(edtProxyPort.Text);
  strConnectionProxyIP:=Trim(edtProxyIP.Text);

  if radioConnectionTypeAutomatic.Checked then
    strConnectionType:='Automatic';
  if radioConnectionTypeDirect.Checked then
    strConnectionType:='Direct';
  if radioConnectionTypeProxy.Checked then
    strConnectionType:='Proxy';

  if radio64BitAutomatic.Checked then
    strShow64BitOnlyApps:='Automatic';
  if radio64BitAlways.Checked then
    strShow64BitOnlyApps:='Always';
  if radio64BitNever.Checked then
    strShow64BitOnlyApps:='Never';

  self.Close;
end;

procedure TfrmOptions.comboTaskbarIconClick(Sender: TObject);
begin
  strTaskbarIconSelected:=RightStr(comboTaskbarIcon.Text, Length(comboTaskbarIcon.Text)-(Pos(' / ', comboTaskbarIcon.Text)+2));
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIconSelected + '.ico')) then
    begin
      imgTaskbarIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIconSelected + '.ico');
    end;
end;

procedure TfrmOptions.comboThemeColorsClick(Sender: TObject);
begin
  strOptionsThemeColorSelected:=comboThemeColors.Text;
  ThemeSelected();
end;

procedure TfrmOptions.FormShow(Sender: TObject);
begin
   LoadLocale();
  SetupMenus();
  ThemeSelected();
  strTaskbarIconSelected:=strTaskbarIcon;
  chkKeyboardFriendly.Checked:=bolKeyboardFriendly;
  chkCollapseOtherFoldersOnExpand.Checked:=bolCollapseOtherFoldersOnExpand;
  chkBoldFavorites.Checked:=bolBoldFavorites;
  chkShowInstalledApps.Checked:=bolShowInstalledApps;
  chkHideDesktopIcons.Checked:=bolHideDesktopIcons;
  chkLargeFonts.Checked:=bolLargeFonts;
  chkExpandCategoriesByDefault.Checked:=bolExpandCategoriesByDefault;
  chkUpdateAutomatically.Checked:=bolUpdateAutomatically;
  chkDisableScrollbar.Checked:=bolDisableScrollbar;
  chkDisableAppSplashScreens.Checked:=bolDisableSplashScreens;
  chkSearchWithinAppDescriptions.Checked:=bolSearchWithinAppDescriptions;
  chkHidePortableInAppNames.Checked:=bolHidePortableInAppNames;
  chkAppDirectoryShowOpenSourceOnly.Checked:=bolAppDirectoryShowOpenSourceOnly;
  chkAppDirectoryShowAdvancedApps.Checked:=bolAppDirectoryShowAdvancedApps;
  chkBoldFolderNames.Checked:=bolBoldFolderNames;
  chkBetaPlatformReleases.Checked:=bolBetaPlatformReleases;
  chkEnableLogging.Checked:=bolLogging;
  chkShowAppPathsInTooltips.Checked:=bolShowAppPathsInToolTips;
  chkShowAppPublisherInTooltips.Checked:=bolShowAppPublishersInToolTips;
  chkKeepMenuVisible.Checked:=bolRemainVisible;
  chkStartMinimized.Checked:=bolStartMinimized;
  chkShowUpdaterStartupErrors.Checked:=bolShowUpdaterStarupErrors;
  chkHideTaskbarIcon.Checked:=not bolWindows7TaskbarIconNextLaunch;
  chkHideSearchWhenNotInUse.Checked:=bolHideSearchWhenNotInUse;
  chkKeepMenuVisible.Checked:=bolRemainVisible;
  chkAutoRunProtection.Checked:=bolAutoRunProtection;
  chkFadeMenu.Checked:=bolFadeMenu;
  chkHideLogoDecorations.Checked:=bolHideLogoDecorations;
  edtProxyPort.Text:=strConnectionProxyPort;
  edtProxyIP.Text:=strConnectionProxyIP;
  if strConnectionType='Automatic' then
    radioConnectionTypeAutomatic.Checked:=true;
  if strConnectionType='Direct' then
    radioConnectionTypeDirect.Checked:=true;
  if strConnectionType='Proxy' then
  begin
    radioConnectionTypeProxy.Checked:=true;
    edtProxyIP.Enabled:=true;
    edtProxyPort.Enabled:=true;
  end;

   if   Screen.PixelsPerInch > 100 then
    chkLargeFonts.Enabled:=False;

  if BOLRUNNINGBETA then
    chkBetaPlatformReleases.Enabled:=false;

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

  if (intHideDesktopIcons = 1) then
    chkHideDesktopIcons.Enabled:=false
  else
    chkHideDesktopIcons.Enabled:=true;

  if strShow64BitOnlyApps='Automatic' then
    radio64BitAutomatic.Checked:=true;
  if strShow64BitOnlyApps='Always' then
    radio64BitAlways.Checked:=true;
  if strShow64BitOnlyApps='Never' then
    radio64BitNever.Checked:=true;

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico')) then
    begin
      imgTaskbarIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico');
    end;
end;

procedure TfrmOptions.listboxThemesClick(Sender: TObject);
begin
  ThemeSelected();
end;

procedure TfrmOptions.LoadLocale();
var
	iniLocaleFile: TINIFile;
  strTempDark: string;
  strTempLight: string;
  strTempClassic: string;
  strTempDefault: string;
  strTempFlat: string;
  strTempGlassy: string;
  strTempModern: string;
  strTempRetro: string;
  strTempSmooth: string;
begin
	// Check for locale test file
	// Temporary addition to allow testing of .locale files for translations
	if FileExists(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale') then
	begin
		iniLocaleFile:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale');
    btnOK.Caption:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_OK', '&Ok');
    btnCancel.Caption:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_CANCEL', '&Cancel');
		frmOptions.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'FORM_NAME', 'Options');
		tabsheetGeneral.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_GENERAL', 'General');
 		tabsheetThemes.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_THEMES', 'Themes');
 		tabsheetConnection.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_CONNECTION', 'Connection');
 		//tabsheetFileAssociations.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_FILE_ASSOCIATIONS', 'File Associations');
    tabsheetAdvanced.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_ADVANCED', 'Advanced');
    tabsheetThemes.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_THEMES', 'Themes');
    tabsheetUpdater.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_UPDATER', 'Updater');
    tabsheetOrganization.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_ORGANIZATION', 'Organization');
    tabsheetAppStore.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'TAB_APP_STORE', 'App Store');
    grpConnectionType.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_CONNECTION_TYPE', 'Connection Type');
    radioConnectionTypeAutomatic.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_TYPE_AUTOMATIC', 'Automatic (Recommended)');
    radioConnectionTypeDirect.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_TYPE_DIRECT', 'Direct Connection (No Proxy)');
    radioConnectionTypeProxy.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_TYPE_PROXY', 'Manual Proxy Configuration')+':';
    lblProxyIP.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_PROXY_IP', 'HTTP Proxy IP')+':';
    lblProxyPort.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_PROXY_PORT', 'Port')+':';
    grpDisplayOptions.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_DISPLAY_OPTIONS', 'Display Options');
    lblTaskbarIcon.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'FILE_ASSOCIATIONS_ICON', 'Icon');

    strLocaleDirection:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'Direction', 'LTR');

    if strLocaleDirection = 'LTR' then
      frmOptions.BiDiMode:=bdLeftToRight
    else
      frmOptions.BiDiMode:=bdRightToLeft;



    chkLargeFonts.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_USE_LARGE_FONTS', 'Use Large Fonts');
    lblMenuTransparency.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_MENU_TRANSPARENCY', 'Menu Transparency');
    grpLanguage.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_LANGUAGE', 'Language');
    chkUseLanguageForAllApps.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_LANGUAGE_USE_FOR_ALL', 'Use this language for all portable apps');
    grpAppListOrganization.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_APP_LIST_ORGANIZATION', 'App List Organization');
    radioSmartCategories.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_SMART_WITH_CATEGORIES', 'Smart with Categories - Favorites and recent apps on first screen.  All apps by category on second.');
    radioSmartAlphabetical.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_SMART_ALPHA', 'Smart Alphabetical - Favorites and recent apps on first screen.  All apps alphabetically on second.');
    radioAllCategories.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_SHOW_ALL_CATEGORIES', 'Show All with Categories - Favorites listed first then all other apps grouped by category.');
    radioAllAlphabetical.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_SHOW_ALL_ALPHABETICALLY', 'Show All Alphabetically - Favorites listed first then all other apps listed alphabetically.');
    btnAddTheme.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_ADD_THEME', 'Add Theme');
    btnGetThemes.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_GET_THEMES', 'Get Themes');
    //btnUseTheme.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_USE_THEME', 'Use Theme');
    btnRemoveTheme.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_REMOVE_THEME', 'Remove Theme');
    strTranslatedTransparencyOff:=iniLocaleFile.ReadString('FORM_OPTIONS', 'GENERAL_MENU_TRANSPARENCY_OFF', 'Off (100% Opaque)');

    chkHideDesktopIcons.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_HIDE_DESKTOP_ICONS', 'Hide Desktop Icons');
    chkBetaPlatformReleases.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_BETA_PLATFORM_RELEASES', 'Update to Beta platform releases');
    chkBoldFolderNames.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_BOLD_FOLDER_NAMES', 'Bold Category Names');
    chkBoldFavorites.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_BOLD_FAVORITES', 'Bold Favorites');
    chkShowInstalledApps.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_SHOW_INSTALLED_APPS', 'Show Installed Apps');
    chkExpandCategoriesByDefault.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_EXPAND_CATEGORIES', 'Expand Categories By Default');
    chkCollapseCategoriesOnMinimize.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_COLLAPSE_CATEGORIES_ON_MINIMIZE', 'Collapse Categories On Minimize');
    chkCollapseOtherFoldersOnExpand.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_COLLAPSE_OTHER_CATEGORIES_ON_EXPAND', 'Collapse Other Categories When One Is Expanded');
    chkUpdateAutomatically.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_UPDATER_STARTUP', 'On platform startup');
    chkDisableAppSplashScreens.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_DISABLE_SPLASH_SCREENS', 'Disable App Splash Screens');
    chkCloseAppsOnPlatformExit.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_CLOSE_APPS_ON_PLATFORM_EXIT', 'Close Apps On Platform Exit');
    chkDisableScrollBar.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_DISABLE_SCROLLBAR', 'Disable Scrollbar');
    chkEnableLogging.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_LOGGING', 'Log platform events to a text file');
    chkShowAppPathsInTooltips.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_APP_PATHS_TOOLTIPS', 'Show app paths in tooltips');
    chkShowAppPublisherInTooltips.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_APP_PUBLISHER_TOOLTIPS', 'Show publisher in tooltips');
    chkKeepMenuVisible.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_KEEP_MENU_VISIBLE', 'Keep menu visible after starting apps');
    chkStartMinimized.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_START_MINIMIZED', 'Start the menu minimized');
    chkShowUpdaterStartupErrors.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'SHOW_UPDATER_STARTUP_ERRORS', 'Show updater startup errors');
    chkHideTaskbarIcon.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'HIDE_TASKBAR_ICON', 'Hide taskbar icon (takes effect on next launch)');
    chkHideSearchWhenNotInUse.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'HIDE_SEARCH_WHEN_NOT_IN_USE', 'Hide search bar when not in use');
    chkAutorunProtection.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_AUTORUN_PROTECTION', 'Monitor autorun.inf for changes');
    chkFadeMenu.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_FADE_MENU', 'Fade the menu in and out');
    chkHideLogoDecorations.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_HIDE_LOGO_DECORATIONS', 'Hide holiday logo decorations');

    chkHidePortableInAppNames.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_HIDE_PORTABLE_IN_APP_NAMES', 'Hide "Portable" in App Names');
    grpUpdater.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_UPDATER_FREQUENCY', 'Check for updates...');
    grpAppDirectory.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_APP_DIRECTORY_SETTINGS', 'App Directory Settings');
    chkAppDirectoryShowOpenSourceOnly.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_APP_DIRECTORY_SHOW_OPEN_SOURCE_ONLY', 'Show Only Open Source Apps');
    chkAppDirectoryShowAdvancedApps.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_APP_DIRECTORY_SHOW_ADVANCED_APPS', 'Show Advanced Apps (Beta, Test, etc)');
    chkKeyboardFriendly.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_KEYBOARD_FRIENDLY', 'Screen Reader-Friendly Selections in Updater and App Directory');

    grpShow64BitOnlyApps.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'APP_DIRECTORY_SHOW_64BIT', 'Show 64-Bit Only Apps');
    radio64BitAutomatic.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'APP_DIRECTORY_SHOW_64BIT_AUTO', 'Automatic (Show on 64-bit Windows)');
    radio64BitAlways.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'APP_DIRECTORY_SHOW_64BIT_ALWAYS', 'Always');
    radio64BitNever.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'APP_DIRECTORY_SHOW_64BIT_NEVER', 'Never');


    chkCloseAppsOnPlatformExit.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_CLOSE_APPS_ON_PLATFORM_EXIT', 'Close Apps On Platform Exit');
    chkSearchWithinAppDescriptions.Caption:=iniLocaleFile.ReadString('FORM_OPTIONS', 'ADVANCED_SEARCH_WITHIN_APP_DESCRIPTIONS', 'Search within app descriptions when searching');


    strTempDark:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_DARK', 'Dark');
    strTempLight:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_LIGHT', 'Light');
    strTempClassic:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_CLASSIC', 'Classic');
    strTempDefault:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_DEFAULT', 'Default');
    strTempFlat:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_FLAT', 'Flat');
    strTempGlassy:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_GLASSY', 'Glassy');
    strTempModern:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_MODERN', 'Modern');
    strTempRetro:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_RETRO', 'Retro');
    strTempSmooth:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_SMOOTH', '11.x');

    strTransPink:=iniLocaleFile.ReadString('GENERAL', 'COLOR_PINK', 'Pink');
    strTransRed:=iniLocaleFile.ReadString('GENERAL', 'COLOR_RED', 'Red');
    strTransOrange:=iniLocaleFile.ReadString('GENERAL', 'COLOR_ORANGE', 'Orange');
    strTransYellow:=iniLocaleFile.ReadString('GENERAL', 'COLOR_YELLOW', 'Yellow');
    strTransGreen:=iniLocaleFile.ReadString('GENERAL', 'COLOR_GREEN', 'Green');
    strTransBlue:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BLUE', 'Blue');
    strTransPurple:=iniLocaleFile.ReadString('GENERAL', 'COLOR_PURPLE', 'Purple');
    strTransViolet:=iniLocaleFile.ReadString('GENERAL', 'COLOR_VIOLET', 'Violet');
    strTransBlack:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BLACK', 'Black');
    strTransWhite:=iniLocaleFile.ReadString('GENERAL', 'COLOR_WHITE', 'White');
    strTransGray:=iniLocaleFile.ReadString('GENERAL', 'COLOR_GRAY', 'Gray');
    strTransSilver:=iniLocaleFile.ReadString('GENERAL', 'COLOR_SILVER', 'Silver');
    strTransBronze:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BRONZE', 'Bronze');
    strTransGold:=iniLocaleFile.ReadString('GENERAL', 'COLOR_GOLD', 'Gold');
    strTransBrown:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BROWN', 'Brown');

    strTransDefault:=iniLocaleFile.ReadString('FORM_OPTIONS', 'THEMES_DEFAULT', 'Default');

    strPADefaultTheme:='PortableApps.com ' + strTempDefault + ' ' + strTempLight;
    strPADefaultDarkTheme:='PortableApps.com ' + strTempDefault + ' ' + strTempDark;
    strPAClassicTheme:='PortableApps.com ' + strTempClassic + ' ' + strTempLight;
    strPAClassicDarkTheme:='PortableApps.com ' + strTempClassic + ' ' + strTempDark;
    strPAFlatTheme:='PortableApps.com ' + strTempFlat + ' ' + strTempLight;
    strPAFlatThemeDark:='PortableApps.com ' + strTempFlat + ' ' + strTempDark;
    strPAGlassyTheme:='PortableApps.com ' + strTempGlassy + ' ' + strTempLight;
    strPAGlassyThemeDark:='PortableApps.com ' + strTempGlassy + ' ' + strTempDark;
    strPAModernTheme:='PortableApps.com ' + strTempModern + ' ' + strTempLight;
    strPAModernThemeDark:='PortableApps.com ' + strTempModern + ' ' + strTempDark;
    strPARetroTheme:='PortableApps.com ' + strTempRetro + ' ' + strTempLight;
    strPARetroThemeDark:='PortableApps.com ' + strTempRetro + ' ' + strTempDark;
    strPASmoothTheme:='PortableApps.com ' + strTempSmooth + ' ' + strTempLight;
    strPASmoothThemeDark:='PortableApps.com ' + strTempSmooth + ' ' + strTempDark;
    FreeAndNil(iniLocaleFile);
	end;
end;

procedure TfrmOptions.SetupMenus();
// Set up the language menu
// Acknowledgement: http://delphi.about.com/od/kbcurt/a/dynamicmenuitem.htm for the handy tutorial
var
  tsrchDirectory: TSearchRec;
  intSelectedLanguage: integer;
  strCurrentLanguageLocalized: string;
  strCurrentLanguage: string;
  strCurrentLocaleFile: string;
	iniLocaleFile: TINIFile;
  intTempSelected: integer;
begin
  // Clear the menus
  comboLanguage.Items.Clear;
  // Set up locale menu
  if FindFirst(ExtractFileDir(Application.ExeName) + '\App\Locale\*.locale',faAnyFile,tsrchDirectory)=0 then
  begin
    repeat
      strCurrentLocaleFile:=ExtractFileDir(Application.ExeName) + '\App\Locale\' + tsrchDirectory.FindData.cFileName;
      iniLocaleFile:=TINIFile.Create(strCurrentLocaleFile);
      strCurrentLanguage:=LeftStr(ExtractFileName(strCurrentLocaleFile), (Length(ExtractFileName(strCurrentLocaleFile))-7));
      strCurrentLanguageLocalized:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LocalizedName', strCurrentLanguage);
      intSelectedLanguage:=comboLanguage.Items.Add(strCurrentLanguage + ' / ' + strCurrentLanguageLocalized);
      if AnsiLowerCase(strCurrentLanguage)=AnsiLowerCase(strLocale) then
        comboLanguage.ItemIndex:=intSelectedLanguage;
      FreeAndNil(iniLocaleFile);
    Until FindNext(tsrchDirectory)<>0;
    FindClose(tsrchDirectory);
  end;

  comboThemeColors.Items.Clear;
  comboTaskbarIcon.Items.Clear;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransDefault + ' / Default');
  if strTaskbarIcon='Default' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransRed + ' / Red');
  if strCurrentThemeColor='Red' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransRed + ' / Red');
  if strTaskbarIcon='Red' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransPink + ' / Pink');
  if strCurrentThemeColor='Pink' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransPink + ' / Pink');
  if strTaskbarIcon='Pink' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransOrange + ' / Orange');
  if strCurrentThemeColor='Orange' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransOrange + ' / Orange');
  if strTaskbarIcon='Orange' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransYellow + ' / Yellow');
  if strCurrentThemeColor='Yellow' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransYellow + ' / Yellow');
  if strTaskbarIcon='Yellow' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransGreen + ' / Green');
  if strCurrentThemeColor='Green' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransGreen + ' / Green');
  if strTaskbarIcon='Green' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransBlue + ' / Blue');
  if strCurrentThemeColor='Blue' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransBlue + ' / Blue');
  if strTaskbarIcon='Blue' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransPurple + ' / Purple');
  if strCurrentThemeColor='Purple' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransPurple + ' / Purple');
  if strTaskbarIcon='Purple' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransViolet + ' / Violet');
  if strCurrentThemeColor='Violet' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransViolet + ' / Violet');
  if strTaskbarIcon='Violet' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransBlack + ' / Black');
  if strCurrentThemeColor='Black' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransBlack + ' / Black');
  if strTaskbarIcon='Black' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransWhite + ' / White');
  if strCurrentThemeColor='White' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransWhite + ' / White');
  if strTaskbarIcon='White' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransGray + ' / Gray');
  if strCurrentThemeColor='Gray' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransGray + ' / Gray');
  if strTaskbarIcon='Gray' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransSilver + ' / Silver');
  if strCurrentThemeColor='Silver' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransSilver + ' / Silver');
  if strTaskbarIcon='Silver' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransBronze + ' / Bronze');
  if strCurrentThemeColor='Bronze' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransBronze + ' / Bronze');
  if strTaskbarIcon='Bronze' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;
  intTempSelected:=comboThemeColors.Items.Add(strTransGold + ' / Gold');
  if strCurrentThemeColor='Gold' then
    comboThemeColors.ItemIndex:=intTempSelected;
  intTempSelected:=comboTaskbarIcon.Items.Add(strTransGold + ' / Gold');
  if strTaskbarIcon='Gold' then
    comboTaskbarIcon.ItemIndex:=intTempSelected;

  comboTransparency.Items.Clear;
  comboTransparency.Items.Add(strTranslatedTransparencyOff);
  comboTransparency.Items.Add('90%');
  comboTransparency.Items.Add('80%');
  comboTransparency.Items.Add('70%');
  comboTransparency.Items.Add('60%');
  comboTransparency.Items.Add('50%');
  comboTransparency.Items.Add('40%');
  comboTransparency.Items.Add('30%');
  comboTransparency.Items.Add('20%');
  comboTransparency.Items.Add('10%');

  case intAlphaBlendMain of
    255: comboTransparency.ItemIndex:=0;
    230: comboTransparency.ItemIndex:=1;
    204: comboTransparency.ItemIndex:=2;
    179: comboTransparency.ItemIndex:=3;
    153: comboTransparency.ItemIndex:=4;
    128: comboTransparency.ItemIndex:=5;
    102: comboTransparency.ItemIndex:=6;
    77: comboTransparency.ItemIndex:=7;
    51: comboTransparency.ItemIndex:=8;
    26: comboTransparency.ItemIndex:=9;
    else comboTransparency.ItemIndex:=0;
  end;
  if bolShowAllApps then
    if bolUseCategories then
      radioAllCategories.Checked:=true
    else
      radioAllAlphabetical.Checked:=true
  else
    if bolUseCategories then
      radioSmartCategories.Checked:=true
    else
      radioSmartAlphabetical.Checked:=true;

  chkCollapseCategoriesOnMinimize.Checked:=bolCollapseCategoriesOnMinimize;
  chkCloseAppsOnPlatformExit.Checked:=bolCloseAppsOnPlatformExit;

  if bolDisableAppLanguageSwitching then
    chkUseLanguageForAllApps.Checked:=false
  else
    chkUseLanguageForAllApps.Checked:=true;

  listboxThemes.Items.Clear;
  //Check for OEM file to add here
  if strOEM<>'' then
    if FileExists(PChar(ExtractFileDir(Application.ExeName)+'\OEM\Theme\PATheme.ini')) then
    begin
      intTempSelected:=listboxThemes.Items.Add(strOEMThemeName);
      if strCurrentTheme='OEM' then
        listboxThemes.Selected[intTempSelected]:=true;
    end;

  intTempSelected:=listboxThemes.Items.Add(strPADefaultTheme);
  if strCurrentTheme='Default' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPADefaultDarkTheme);
  if strCurrentTheme='DefaultDark' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAClassicTheme);
  if strCurrentTheme='Classic' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAClassicDarkTheme);
  if strCurrentTheme='ClassicDark' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAFlatTheme);
  if strCurrentTheme='Flat' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAFlatThemeDark);
  if strCurrentTheme='FlatDark' then
    listboxThemes.Selected[intTempSelected]:=true;

  intTempSelected:=listboxThemes.Items.Add(strPAGlassyTheme);
  if strCurrentTheme='Glassy' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAGlassyThemeDark);
  if strCurrentTheme='GlassyDark' then
    listboxThemes.Selected[intTempSelected]:=true;

  intTempSelected:=listboxThemes.Items.Add(strPAModernTheme);
  if strCurrentTheme='Modern' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPAModernThemeDark);
  if strCurrentTheme='ModernDark' then
    listboxThemes.Selected[intTempSelected]:=true;

  intTempSelected:=listboxThemes.Items.Add(strPARetroTheme);
  if strCurrentTheme='Retro' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPARetroThemeDark);
  if strCurrentTheme='RetroDark' then
    listboxThemes.Selected[intTempSelected]:=true;

  intTempSelected:=listboxThemes.Items.Add(strPASmoothTheme);
  if strCurrentTheme='Smooth' then
    listboxThemes.Selected[intTempSelected]:=true;
  intTempSelected:=listboxThemes.Items.Add(strPASmoothThemeDark);
  if strCurrentTheme='SmoothDark' then
    listboxThemes.Selected[intTempSelected]:=true;
end;

procedure TfrmOptions.ThemeSelected();
var
  strTempThemePath: string;
  strTempThemeName: string;
//  strTempThemeID: string;
  iniThemeFile: TINIFile;
  strBackground: string;
  strChrome: string;
  strMatte: string;
  strTempPreviewColor: string;
  strLayout: string;
begin
  if listboxThemes.Items[listboxThemes.ItemIndex]=strPADefaultTheme then
    strTempThemeName:='Default'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPADefaultDarkTheme then
    strTempThemeName:='DefaultDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAModernTheme then
    strTempThemeName:='Modern'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAModernThemeDark then
    strTempThemeName:='ModernDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAGlassyTheme then
    strTempThemeName:='Glassy'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAGlassyThemeDark then
    strTempThemeName:='GlassyDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPARetroTheme then
    strTempThemeName:='Retro'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPARetroThemeDark then
    strTempThemeName:='RetroDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPASmoothTheme then
    strTempThemeName:='Smooth'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPASmoothThemeDark then
    strTempThemeName:='SmoothDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAClassicTheme then
    strTempThemeName:='Classic'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAClassicDarkTheme then
    strTempThemeName:='ClassicDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAFlatTheme then
    strTempThemeName:='Flat'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strPAFlatThemeDark then
    strTempThemeName:='FlatDark'
  else if listboxThemes.Items[listboxThemes.ItemIndex]=strOEMThemeName then
    strTempThemeName:='OEM';

  strOptionsThemeSelected:=strTempThemeName;

  if strTempThemeName = 'OEM' then
    strTempThemePath:=PChar(ExtractFileDir(Application.ExeName)+'\OEM\Theme')
  else
    strTempThemePath:=PChar(ExtractFileDir(Application.ExeName)+'\App\Graphics\Themes\' + strTempThemeName);
  if FileExists(strTempThemePath+'\PATheme.ini') then
  	iniThemeFile:=TINIFile.Create(strTempThemePath +'\PATheme.ini')
  else
  	iniThemeFile:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\App\Graphics\Themes\Default\PATheme.ini');
  if fileexists(strTempThemePath+'\preview.png') then   begin
    imgPreviewChrome.Picture.LoadFromFile(strTempThemePath+'\preview.png');
    imgPreviewBackground.Picture.Graphic:=nil;
    imgPreviewDocuments.Picture.Graphic:=nil;
    imgPreviewMusic.Picture.Graphic:=nil;
    imgPreviewPictures.Picture.Graphic:=nil;
    imgPreviewVideos.Picture.Graphic:=nil;
  end
  else
  begin
    imgPreviewChrome.Picture.Graphic:=nil;
    strBackground:=iniThemeFile.ReadString('Menu', 'Background', 'custom');
    strChrome:=iniThemeFile.ReadString('Menu', 'Chrome', 'none');
    strMatte:=iniThemeFile.ReadString('Menu', 'Matte', 'standard');
    strLayout:=iniThemeFile.ReadString('Menu', 'Layout', 'classic');

    if strLayout = 'classic' then
      imgPreviewBackground.Height:=PixelsAdjusted(573)
    else
      imgPreviewBackground.Height:=PixelsAdjusted(558);

    imgPreviewMatte.Height:=imgPreviewBackground.Height;
    imgPreviewChrome.Height:=imgPreviewBackground.Height;

    if strBackground = 'custom' then
      if FileExists(strTempThemePath +'\background.png') then
        imgPreviewBackground.Picture.LoadFromFile(strThemePath +'\background.png')
      else
        imgPreviewBackground.Picture.Graphic:=nil
    else
      imgPreviewBackground.Picture.Graphic:=nil;

    if strChrome = 'custom' then
    begin
      if FileExists(strTempThemePath +'\chrome.png') then
        imgPreviewBackground.Picture.LoadFromFile(strTempThemePath +'\chrome.png')
      else
        imgPreviewBackground.Picture.Graphic:=nil;
    end
    else
      if FileExists(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png') then
        imgPreviewBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png');


    if strMatte = 'standard' then
      imgPreviewMatte.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\matte_white.png')
    else
      imgPreviewMatte.Picture.Graphic:=nil;

   strOptionsThemeColorSelected:=RightStr(comboThemeColors.Text, Length(comboThemeColors.Text)-(Pos(' / ', comboThemeColors.Text)+2));

    if strOptionsThemeColorSelected='Default' then
      strOptionsThemeColorSelected:=iniThemeFile.ReadString('Menu', 'DefaultBackgroundColor', 'Red');

    if strOptionsThemeColorSelected='Custom' then
      strTempPreviewColor:=strThemeCustomColor
    else
    begin
      strTempPreviewColor:=iniThemeFile.ReadString('Menu', strOptionsThemeColorSelected+'BackgroundColor', 'BLANK');
      if strTempPreviewColor='BLANK' then
        strTempPreviewColor:=iniThemeFile.ReadString('Menu', 'BackgroundColor', 'FFFFFF');
    end;
    pnlColorPreview.Color:=HexColorToTColor(strTempPreviewColor);
    FreeAndNil(iniThemeFile);

  if FileExists(strTempThemePath +'\menu_icons\documents.png') then
  	imgPreviewDocuments.Picture.LoadFromFile(strTempThemePath +'\menu_icons\documents.png')
  else
   	imgPreviewDocuments.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\documents.png');

  if FileExists(strTempThemePath +'\menu_icons\music.png') then
  	imgPreviewMusic.Picture.LoadFromFile(strTempThemePath +'\menu_icons\music.png')
  else
   	imgPreviewMusic.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\music.png');

  if FileExists(strTempThemePath +'\menu_icons\pictures.png') then
  	imgPreviewPictures.Picture.LoadFromFile(strTempThemePath +'\menu_icons\pictures.png')
  else
   	imgPreviewPictures.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\pictures.png');

  if FileExists(strTempThemePath +'\menu_icons\videos.png') then
  	imgPreviewVideos.Picture.LoadFromFile(strTempThemePath +'\menu_icons\videos.png')
  else
   	imgPreviewVideos.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\videos.png');
  end;
  end;
end.


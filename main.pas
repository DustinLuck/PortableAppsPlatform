{

Note: WORKING ON DRAG AND DROP AND URL HANDLING, SUBMENU POSITION BACKUP

Copyright 2006-2022 John T. Haller of PortableApps.com

Contributions from Martijn (aka Kloas76): system tray app menu

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

Included in this project is dcpCrypt2010 licensed under the MIT license
}

unit main;

interface

uses Windows, Classes, Forms, StdCtrls, Buttons, ExtCtrls, ComCtrls, Messages,
	Jpeg, ShellAPI, Controls, Graphics, Dialogs, SysUtils, INIFiles,
	StrUtils, Menus, Registry, about, variables, functions, objects,
	pngimage, GIFImg, ImgList, ComObj, ShlObj, DateUtils, Cromis.DirectoryWatch, ProcessList, IOUtils,
  System.Hash, System.ImageList, commctrl, Vcl.Touch.GestureMgr, System.Math;

type
	TfrmMenu = class(TForm)
  imgPortableAppsLogo: TImage;
	imgClose: TImage;
	imgDriveSpace: TImage;
	imgDocuments: TImage;
	imgMusic: TImage;
	imgPictures: TImage;
	imgVideos: TImage;
	imgExplore: TImage;

	imgDivider1: TImage;
	imgBackup: TImage;
	imgOptions: TImage;

	imgDivider2: TImage;
	imgSearch: TImage;
	imgHelp: TImage;

	// Drive name and free space display
	lblDriveName: TLabel;
	lblDriveSpace: TLabel;

	// === POPUP MENUS ===
	pmnuBackup: TPopupMenu;
  pmnuitmBackupBackup: TMenuItem;
  pmnuitmBackupRestore: TMenuItem;

	pmnuOptions: TPopupMenu;
	pmnuitmOptionsSmallFonts: TMenuItem;
	pmnuitmOptionsLargeFonts: TMenuItem;
	pmnuitmOptionsDivider: TMenuItem;

	pmnuSearch: TPopupMenu;
	pmnuitmSearchDrive: TMenuItem;
	pmnuitmSearchComputer: TMenuItem;
	pmnuitmSearchWeb: TMenuItem;

	// === TRAY ICON ===
	trayiconMenu: TTrayIcon;

	// === TIMERS ===
	tmrFader: TTimer;
	tmrWatchFocus: TTimer;
	opndlgAddApp: TOpenDialog;
    imgDragSpaceHidden: TImage;
    pmnuTray: TPopupMenu;
    pmnuitmTrayExit: TMenuItem;
    pmnuitmOptionsLanguage: TMenuItem;
    pmnuHelp: TPopupMenu;
    pmnuitmHelpPortableAppsSupport: TMenuItem;
    pmnuitmHelpAbout: TMenuItem;
    pmnuitmTrayDocuments: TMenuItem;
    pmnuitmTrayMusic: TMenuItem;
    pmnuitmTrayVideos: TMenuItem;
    pmnuitmTrayDivider2: TMenuItem;
    pmnuitmTrayPictures: TMenuItem;
    pmnuitmTrayExplore: TMenuItem;
    imgPersonalPicture: TImage;
    bvlPersonalPicture: TBevel;
    edtDriveName: TEdit;
    btnChangeDriveName: TButton;
    imgEject: TImage;
    imgAppButtonBackground01: TImage;
    imgAppButtonBackground02: TImage;
    imgAppButtonIcon01: TImage;
    lblAppButton01: TLabel;
    imgAppButtonBackground03: TImage;
    imgAppButtonBackground04: TImage;
    imgAppButtonBackground05: TImage;
    imgAppButtonBackground06: TImage;
    imgAppButtonBackground07: TImage;
    imgAppButtonBackground08: TImage;
    imgAppButtonBackground09: TImage;
    imgAppButtonBackground10: TImage;
    imgAppButtonBackground11: TImage;
    imgAppButtonBackground12: TImage;
    imgAppButtonBackground13: TImage;
    imgAppButtonBackground14: TImage;
    imgAppButtonBackground15: TImage;
    imgAppbuttonBackground16: TImage;
    imgAppButtonBackground17: TImage;
    imgAppbuttonBackground18: TImage;
    imgAppButtonBackground19: TImage;
    imgAppButtonBackground20: TImage;
    imgAppButtonIcon02: TImage;
    imgAppButtonIcon03: TImage;
    imgAppButtonIcon04: TImage;
    imgAppButtonIcon05: TImage;
    imgAppButtonIcon06: TImage;
    imgAppButtonIcon07: TImage;
    imgAppButtonIcon08: TImage;
    imgAppButtonIcon09: TImage;
    imgAppButtonIcon10: TImage;
    imgAppButtonIcon11: TImage;
    imgAppButtonIcon12: TImage;
    imgAppButtonIcon13: TImage;
    imgAppButtonIcon14: TImage;
    imgAppButtonIcon15: TImage;
    imgAppButtonIcon16: TImage;
    imgAppButtonIcon17: TImage;
    imgAppButtonIcon18: TImage;
    imgAppButtonIcon19: TImage;
    imgAppButtonIcon20: TImage;
    lblAppButton02: TLabel;
    lblAppButton03: TLabel;
    lblAppButton05: TLabel;
    lblAppButton06: TLabel;
    lblAppButton07: TLabel;
    lblAppButton08: TLabel;
    lblAppButton09: TLabel;
    lblAppButton10: TLabel;
    lblAppButton11: TLabel;
    lblAppButton12: TLabel;
    lblAppButton13: TLabel;
    lblAppButton14: TLabel;
    lblAppButton15: TLabel;
    lblAppButton16: TLabel;
    lblAppButton17: TLabel;
    lblAppButton18: TLabel;
    lblAppButton19: TLabel;
    lblAppButton20: TLabel;
    imgAppButtonForeground01: TImage;
    imgAppButtonForeground02: TImage;
    imgAppButtonForeground03: TImage;
    imgAppButtonForeground04: TImage;
    imgAppButtonForeground05: TImage;
    imgAppButtonForeground06: TImage;
    imgAppButtonForeground07: TImage;
    imgAppButtonForeground08: TImage;
    imgAppButtonForeground09: TImage;
    imgAppButtonForeground10: TImage;
    imgAppButtonForeground11: TImage;
    imgAppButtonForeground12: TImage;
    imgAppButtonForeground13: TImage;
    imgAppButtonForeground14: TImage;
    imgAppButtonForeground15: TImage;
    imgAppButtonForeground16: TImage;
    imgAppButtonForeground17: TImage;
    imgAppButtonForeground18: TImage;
    imgAppButtonForeground19: TImage;
    imgAppButtonForeground20: TImage;
    imgButtonDocumentsBackground: TImage;
    lblButtonDocuments: TLabel;
    imgButtonDocumentsForeground: TImage;
    imgButtonMusicBackground: TImage;
    lblButtonMusic: TLabel;
    imgButtonMusicForeground: TImage;
    imgButtonPicturesBackground: TImage;
    imgButtonVideosBackground: TImage;
    imgButtonExploreBackground: TImage;
    imgButtonBackupBackground: TImage;
    imgButtonOptionsBackground: TImage;
    imgButtonSearchBackground: TImage;
    imgButtonHelpBackground: TImage;
    lblButtonPictures: TLabel;
    lblButtonVideos: TLabel;
    lblButtonExplore: TLabel;
    lblButtonBackup: TLabel;
    lblButtonOptions: TLabel;
    lblButtonSearch: TLabel;
    lblButtonHelp: TLabel;
    imgButtonPicturesForeground: TImage;
    imgButtonVideosForeground: TImage;
    imgButtonExploreForeground: TImage;
    imgButtonBackupForeground: TImage;
    imgButtonOptionsForeground: TImage;
    imgButtonSearchForeground: TImage;
    imgButtonHelpForeground: TImage;
    imgButtonScrollUp: TImage;
    imgButtonScrollDown: TImage;
    lblDriveSpaceShadow: TLabel;
    pmnuAppRightClick: TPopupMenu;
    pmnuitmAppRightClickRun: TMenuItem;
    pmnuitmAppRightClickRunAsAdmin: TMenuItem;
    pmnuitmAppRightClickDivider1: TMenuItem;
    pmnuitmAppRightClickFavorite: TMenuItem;
    pmnuitmAppRightClickHideFromMenu: TMenuItem;
    pmnuitmAppRightClickRename: TMenuItem;
    pmnuitmAppRightClickDivider2: TMenuItem;
    pmnuitmAppRightClickShowHiddenIcons: TMenuItem;
    imgPortableAppsLogo2: TImage;
    imgDivider3: TImage;
    imgButtonOEMForeground: TImage;
    imgButtonOEMBackground: TImage;
    imgOEMButton: TImage;
    lblButtonOEM: TLabel;
    pmnuOEM: TPopupMenu;
    pmnuitmOEMHomepage: TMenuItem;
    pmnuitmOEMStore: TMenuItem;
    pmnuitmOEMSupport: TMenuItem;
    pmnuitmOptionsHideDesktopIcons: TMenuItem;
    pmnuitmHelpUpdateClick: TMenuItem;
    pmnuitmTrayTitle: TMenuItem;
    pmnuitmTrayDivider: TMenuItem;
    pmnuitmTrayEject: TMenuItem;
    tmrShowAppIcons: TTimer;
    lblAppLoading: TLabel;
    imgAppLoading: TImage;
    imgAppLoadingBackground: TImage;
    lblAppLoadingShadow: TLabel;
    shapeAppDivider01: TShape;
    pmnuitmAppRightClickDivider3: TMenuItem;
    pmnuitmAppRightClickUninstall: TMenuItem;
    pmnuitmAppRightClickRefresh: TMenuItem;
    shapeAppDivider02: TShape;
    shapeAppDivider03: TShape;
    shapeAppDivider04: TShape;
    shapeAppDivider05: TShape;
    shapeAppDivider06: TShape;
    shapeAppDivider07: TShape;
    shapeAppDivider08: TShape;
    shapeAppDivider09: TShape;
    shapeAppDivider10: TShape;
    shapeAppDivider11: TShape;
    shapeAppDivider12: TShape;
    shapeAppDivider13: TShape;
    shapeAppDivider14: TShape;
    shapeAppDivider15: TShape;
    shapeAppDivider16: TShape;
    shapeAppDivider17: TShape;
    shapeAppDivider18: TShape;
    shapeAppDivider19: TShape;
    pmnuitmAppRightClickAutomaticallyStart: TMenuItem;
    pmnuitmAppRightClickDivider4: TMenuItem;
    btnDocuments: TButton;
    btnMusic: TButton;
    btnPictures: TButton;
    btnVideos: TButton;
    btnExplore: TButton;
    btnBackup: TButton;
    btnOptions: TButton;
    btnSearch: TButton;
    btnHelp: TButton;
    btnOEM: TButton;
    btnClose: TButton;
    pmnuitmOptionsDivider3: TMenuItem;
    pmnuitmOptionsCheckDrive: TMenuItem;
    pmnuitmHelpSeperator: TMenuItem;
    pmnuitmOptionsTheme: TMenuItem;
    pmnuitmOptionsThemeRed: TMenuItem;
    pmnuitmOptionsThemeBronze: TMenuItem;
    pmnuitmOptionsThemeGreen: TMenuItem;
    pmnuitmOptionsThemeBlue: TMenuItem;
    pmnuitmOptionsThemeViolet: TMenuItem;
    pmnuitmOptionsThemeBlack: TMenuItem;
    pmnuitmOptionsThemeSilver: TMenuItem;
    pmnuitmOptionsThemeDivider: TMenuItem;
    pmnuitmOptionsThemeCustom: TMenuItem;
    pmnuitmOptionsDivider4: TMenuItem;
    pmnuitmOptionsDivider5: TMenuItem;
    pmnuitmOptionsTransparency: TMenuItem;
    pmnuitmOptionsTransparency0: TMenuItem;
    pmnuitmOptionsTransparency10: TMenuItem;
    pmnuitmOptionsTransparency20: TMenuItem;
    pmnuitmOptionsTransparency30: TMenuItem;
    pmnuitmOptionsTransparency40: TMenuItem;
    pmnuitmOptionsTransparency50: TMenuItem;
    pmnuitmOptionsTransparency60: TMenuItem;
    pmnuitmOptionsTransparency70: TMenuItem;
    pmnuitmOptionsTransparency80: TMenuItem;
    pmnuitmOptionsTransparency90: TMenuItem;
    lblAppButton04: TLabel;
    pmnuitmOEMTwitter: TMenuItem;
    pmnuitmOEMFacebook: TMenuItem;
    pmnuitmOptionsThemeOEM: TMenuItem;
    imgBackgroundChrome: TImage;
    pmnuitmOEMCustom1: TMenuItem;
    pmnuitmOEMCustom2: TMenuItem;
    pmnuitmOEMCustom3: TMenuItem;
    pmnuitmHelpDonate: TMenuItem;
    lblButtonManageApps: TLabel;
    imgButtonManageAppsBackground: TImage;
    imgButtonManageAppsForeground: TImage;
    imgManageApps: TImage;
    btnManageApps: TButton;
    pmnuManageApps: TPopupMenu;
    pmnuitmManageAppsUpdate: TMenuItem;
    pmnuitmManageAppsGetMoreApps: TMenuItem;
    pmnuitmManageAppsInstallAnApp: TMenuItem;
    pmnuitmOptionsThemeYellow: TMenuItem;
    pmnuitmOptionsThemeOrange: TMenuItem;
    pmnuitmOptionsThemePurple: TMenuItem;
    pmnuitmOptionsThemeGold: TMenuItem;
    pmnuitmOptionsThemeGray: TMenuItem;
    pmnuitmOptionsThemePink: TMenuItem;
    pmnuitmOptionsThemeWhite: TMenuItem;
    pmnuitmOptionsThemeDefaultDark: TMenuItem;
    pmnuitmOptionsThemeBlackDark: TMenuItem;
    pmnuitmOptionsThemeBlueDark: TMenuItem;
    pmnuitmOptionsThemeBronzeDark: TMenuItem;
    pmnuitmOptionsThemeGoldDark: TMenuItem;
    pmnuitmOptionsThemeGrayDark: TMenuItem;
    pmnuitmOptionsThemeGreenDark: TMenuItem;
    pmnuitmOptionsThemeOrangeDark: TMenuItem;
    pmnuitmOptionsThemePinkDark: TMenuItem;
    pmnuitmOptionsThemePurpleDark: TMenuItem;
    pmnuitmOptionsThemeSilverDark: TMenuItem;
    pmuOptionsThemeYellowDark: TMenuItem;
    pmnuitmOptionsThemeVioletDark: TMenuItem;
    pmnuitmOptionsThemeWhiteDark: TMenuItem;
    pmnuitmOptionsThemeRainbow: TMenuItem;
    pmnuitmOptionsThemeRainbowDark: TMenuItem;
    pmnuitmOptionsThemeTextured: TMenuItem;
    pmnuitmOptionsTexturedDark: TMenuItem;
    imgBackground: TImage;
    imgAnimation: TImage;
    pmnuitmAppRightClickHelp: TMenuItem;
    pmnuitmHelpSeperator2: TMenuItem;
    pmnuitmHelpFacebook: TMenuItem;
    pmnuitmHelpTwitter: TMenuItem;
    pmnuitmAppRightClickExploreHere: TMenuItem;
    pmnuitmAppRightClickCategory: TMenuItem;
    pmnuitmAppRightClickDivider0: TMenuItem;
    pmnuitmAppRightClickAppName: TMenuItem;
    scrollAppList: TScrollBar;
    imgMatte: TImage;
    pmnuitmManageAppsSeparator: TMenuItem;
    pmnuitmManageAppsRefresh: TMenuItem;
    pmnuitmSearchSeparator: TMenuItem;
    pmnuitmSearchInstalledApps: TMenuItem;
    pmnuitemTrayBackup: TMenuItem;
    pmnuitmTrayDivider3: TMenuItem;
    pmnuitemTrayBackupBackup: TMenuItem;
    pmnuitemTrayBackupRestore: TMenuItem;
    pmnuitemTrayOptions: TMenuItem;
    pmnuitemTrayApps: TMenuItem;
    pmnuitemTrayAppsUpdates: TMenuItem;
    pmnuitemTrayAppsGetMore: TMenuItem;
    pmnuitemTrayAppsInstall: TMenuItem;
    btnEject: TButton;
    btnAppButton01: TButton;
    btnAppButton02: TButton;
    btnAppButton03: TButton;
    btnAppButton04: TButton;
    btnAppButton05: TButton;
    btnAppButton06: TButton;
    btnAppButton07: TButton;
    btnAppButton08: TButton;
    btnAppButton09: TButton;
    btnAppButton10: TButton;
    btnAppButton11: TButton;
    btnAppButton12: TButton;
    btnAppButton13: TButton;
    btnAppButton14: TButton;
    btnAppButton15: TButton;
    btnAppButton16: TButton;
    btnAppButton17: TButton;
    btnAppButton18: TButton;
    btnAppButton19: TButton;
    btnAppButton20: TButton;
    imglstSubmenuIcons: TImageList;
    pmnuitmHelpLinkedIn: TMenuItem;
    pmnuitmHelpSeperator1: TMenuItem;
    imglstTaskbarThumbButtons: TImageList;
    pmnuitmManageAppsGetMoreAppsCategory: TMenuItem;
    pmnuitmManageAppsGetMoreAppsTitle: TMenuItem;
    pmnuitmManageAppsGetMoreAppsNew: TMenuItem;
    pmnuitmManageAppsGetMoreAppsUpdated: TMenuItem;
    pmnuitemTrayAppsGetMoreCategory: TMenuItem;
    pmnuitemTrayAppsGetMoreTitle: TMenuItem;
    pmnuitemTrayAppsGetMoreNew: TMenuItem;
    pmnuitemTrayAppsGetMoreUpdated: TMenuItem;
    pmnuitmHelpCheckDrive: TMenuItem;
    imgLogoMod: TImage;
    imgOEMLogoTopRight: TImage;
    pmnuitmOEMGooglePlus: TMenuItem;
    pmnuCategoryRightClick: TPopupMenu;
    pmnuitmCategoryRightClickRename: TMenuItem;
    pmnuitmCategoryRightClickDelete: TMenuItem;
    pnlLiveSearchBorder: TPanel;
    pnlLiveSearchBackground: TPanel;
    imgLiveSearchClose: TImage;
    imgLiveSearchIcon: TImage;
    edtLiveSearch: TEdit;
    imgButtonLeftIcon: TImage;
    imgButtonRightIcon: TImage;
    pmnuLeftButton: TPopupMenu;
    pmnuitmLeftButtonAutomatic: TMenuItem;
    pmnuitmLeftButtonEject: TMenuItem;
    pmnuitmLeftButtonPower: TMenuItem;
    pmnuitmAppRightClickWebsite: TMenuItem;
    pmnuitmAppRightClickDonate: TMenuItem;
    pmnuitmManageAppsShowHiddenIcons: TMenuItem;
    pmnuitmManageAppsSeparator2: TMenuItem;
    gestureManagerMain: TGestureManager;
    pmnuitmAppRightClickPinToTaskbar: TMenuItem;
    pmnuitmAppRightClickAddToStart: TMenuItem;

    procedure pmnuitmOEMCustom3Click(Sender: TObject);
    procedure pmnuitmOEMCustom2Click(Sender: TObject);
    procedure pmnuitmOEMCustom1Click(Sender: TObject);
    procedure imgDragSpaceHiddenDblClick(Sender: TObject);

    procedure pmnuitmOEMFacebookClick(Sender: TObject);
    procedure pmnuitmOEMTwitterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pmnuitmAppRightClickUninstallClick(Sender: TObject);
    procedure btnCloseExit(Sender: TObject);
    procedure btnCloseEnter(Sender: TObject);
    procedure btnBackupExit(Sender: TObject);
    procedure btnBackupEnter(Sender: TObject);
    procedure btnOEMClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnExploreClick(Sender: TObject);
    procedure btnVideosClick(Sender: TObject);
    procedure btnPicturesClick(Sender: TObject);
    procedure btnMusicClick(Sender: TObject);
    procedure btnDocumentsExit(Sender: TObject);
    procedure btnDocumentsEnter(Sender: TObject);
    procedure btnDocumentsClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pmnuitmAppRightClickAutomaticallyStartClick(Sender: TObject);
    procedure pmnuitmAppRightClickShowHiddenIconsClick(Sender: TObject);
    procedure pmnuitmAppRightClickRefreshClick(Sender: TObject);
    procedure pmnuitmAppRightClickFavoriteClick(Sender: TObject);
    procedure pmnuitmAppRightClickHideFromMenuClick(Sender: TObject);
    procedure pmnuitmAppRightClickRenameClick(Sender: TObject);
    procedure tmrShowAppIconsTimer(Sender: TObject);
    procedure pmnuitmHelpUpdateClickClick(Sender: TObject);
    procedure pmnuitmOptionsHideDesktopIconsClick(Sender: TObject);
    procedure pmnuitmOEMSupportClick(Sender: TObject);
    procedure pmnuitmOEMStoreClick(Sender: TObject);
    procedure pmnuitmOEMHomepageClick(Sender: TObject);
    procedure imgButtonOEMForegroundClick(Sender: TObject);
    procedure pmnuitmAppRightClickRunAsAdminClick(Sender: TObject);
    procedure pmnuitmAppRightClickRunClick(Sender: TObject);
    procedure imgButtonScrollDownClick(Sender: TObject);
    procedure imgButtonScrollUpClick(Sender: TObject);
    procedure imgButtonHelpForegroundClick(Sender: TObject);
    procedure imgButtonSearchForegroundClick(Sender: TObject);
    procedure imgButtonOptionsForegroundClick(Sender: TObject);
    procedure imgButtonBackupForegroundClick(Sender: TObject);
    procedure imgButtonExploreForegroundClick(Sender: TObject);
    procedure imgButtonVideosForegroundClick(Sender: TObject);
    procedure imgButtonPicturesForegroundClick(Sender: TObject);
    procedure imgButtonMusicForegroundClick(Sender: TObject);
    procedure imgButtonDocumentsForegroundClick(Sender: TObject);
    procedure imgBackgroundClick(Sender: TObject);
    procedure imgEjectClick(Sender: TObject);
    procedure imgEjectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEjectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEjectMouseLeave(Sender: TObject);
    procedure imgEjectMouseEnter(Sender: TObject);
    procedure imgCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseMouseLeave(Sender: TObject);
    procedure imgCloseMouseEnter(Sender: TObject);
    procedure btnChangeDriveNameClick(Sender: TObject);
    procedure imgPersonalPictureMouseLeave(Sender: TObject);
    procedure imgPersonalPictureMouseEnter(Sender: TObject);
    procedure edtDriveNameKeyPress(Sender: TObject; var Key: Char);
    procedure lblDriveNameClick(Sender: TObject);
    procedure imgPersonalPictureMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgPersonalPictureClick(Sender: TObject);
    procedure pmnuitmHelpAboutClick(Sender: TObject);
    procedure pmnuitmHelpPortableAppsSupportClick(Sender: TObject);
    procedure pmnuitmTrayExitClick(Sender: TObject);
    procedure imgDragSpaceHiddenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

	// === PROCEDURES ===
	// standard form handlers
	procedure FormCreate(Sender: TObject);
	procedure FormDestroy(Sender: TObject);



	// Special handler for clicks of app icons
	procedure AppButtonMouseEnter(Sender: TObject);
	procedure AppButtonMouseLeave(Sender: TObject);
  procedure AppButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure AppButtonClick(Sender: TObject);

    // Scrolling the app icon list up or down
	procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
		MousePos: TPoint; var Handled: Boolean);
	procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
		MousePos: TPoint; var Handled: Boolean);
	procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure ScrollApps(bolScrollUp: Boolean);

	// Handlers for the folder and function buttons
	procedure imgCloseClick(Sender: TObject);

	// Tray icon handler
	procedure trayiconMenuClick(Sender: TObject);

  // Special
  procedure CheckDriveForErrors(Sender: TObject);

	// Display / hide the menu, fade in/out
	procedure FadeInOut(bolFadeInNow: Boolean);
	procedure tmrWatchFocusTimer(Sender: TObject);
	procedure tmrFaderTimer(Sender: TObject);

	// Popup menu handlers
	// Backup popup menu
	procedure pmnuitmBackupBackupClick(Sender: TObject);
	procedure pmnuitmBackupRestoreClick(Sender: TObject);

	// Options popup menu
	procedure pmnuitmOptionsAddAppClick(Sender: TObject);
	procedure pmnuitmOptionsRefreshAppsClick(Sender: TObject);
	procedure pmnuitmOptionsGetMoreClick(Sender: TObject);

	// Help popup menu
	procedure pmnuitmSearchWebClick(Sender: TObject);
	procedure pmnuitmSearchComputerClick(Sender: TObject);
	procedure pmnuitmSearchDriveClick(Sender: TObject);
    procedure pmnuitmHelpDonateClick(Sender: TObject);
    procedure lblDriveSpaceClick(Sender: TObject);
    procedure GetMoreAppsClick(Sender: TObject);
    procedure pmnuitmManageAppsUpdateClick(Sender: TObject);
    procedure imgButtonManageAppsForegroundClick(Sender: TObject);
    procedure pmnuitmAppRightClickHelpClick(Sender: TObject);
    procedure pmnuitmHelpFacebookClick(Sender: TObject);
    procedure pmnuitmHelpTwitterClick(Sender: TObject);
    procedure pmnuitmAppRightClickExploreHereClick(Sender: TObject);
    procedure pmnuitmAppRightClickCategoryClick(Sender: TObject);
    procedure scrollAppListScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure edtLiveSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtLiveSearchChange(Sender: TObject);
    procedure pmnuitmManageAppsRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure imgLiveSearchCloseClick(Sender: TObject);
    procedure pmnuitmSearchInstalledAppsClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnMusicEnter(Sender: TObject);
    procedure btnMusicExit(Sender: TObject);
    procedure btnPicturesEnter(Sender: TObject);
    procedure btnPicturesExit(Sender: TObject);
    procedure btnVideosEnter(Sender: TObject);
    procedure btnVideosExit(Sender: TObject);
    procedure btnExploreEnter(Sender: TObject);
    procedure btnExploreExit(Sender: TObject);
    procedure btnManageAppsEnter(Sender: TObject);
    procedure btnManageAppsExit(Sender: TObject);
    procedure btnOptionsEnter(Sender: TObject);
    procedure btnOptionsExit(Sender: TObject);
    procedure btnSearchEnter(Sender: TObject);
    procedure btnSearchExit(Sender: TObject);
    procedure btnHelpEnter(Sender: TObject);
    procedure btnHelpExit(Sender: TObject);
    procedure btnOEMEnter(Sender: TObject);
    procedure btnOEMExit(Sender: TObject);
    procedure btnEjectEnter(Sender: TObject);
    procedure btnEjectExit(Sender: TObject);
    procedure AppButtonEnter(Sender: TObject);
    procedure AppButtonExit(Sender: TObject);
    procedure pmnuitmHelpLinkedInClick(Sender: TObject);
    procedure edtLiveSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure imgLogoModClick(Sender: TObject);
    procedure trayiconMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pmnuitmOEMGooglePlusClick(Sender: TObject);
    procedure pmnuitmLeftButtonEjectClick(Sender: TObject);
    procedure pmnuitmLeftButtonPowerClick(Sender: TObject);
    procedure pmnuitmLeftButtonAutomaticClick(Sender: TObject);
    procedure AppButtonKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pmnuitmAppRightClickWebsiteClick(Sender: TObject);
    procedure pmnuitmAppRightClickDonateClick(Sender: TObject);
    procedure pmnuitmManageAppsShowHiddenIconsClick(Sender: TObject);

    // Handle app starts
    function DoesSHA256HashMatchIfExists(strFilePath: string; strHash: string): boolean;

    function StartPortableApp(strFilePath: string; strWorkingDirectory: string; bolAdmin: boolean; strDotNetVersion:string): boolean;
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure pmnuitmAppRightClickPinToTaskbarClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure imgPortableAppsLogo2Click(Sender: TObject);
    procedure pmnuitmAppRightClickAddToStartClick(Sender: TObject);

	protected
		// Used to add a drop shadow to the menu
		procedure CreateParams(var Params: TCreateParams); override;
    //procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;

	private
    // Taskbar
    TaskbarList: ITaskbarList;
    TaskbarList2: ITaskbarList2;
    TaskbarList3: ITaskbarList3;
    TaskbarList4: ITaskbarList4;

		// object array of app buttons, corresponds to tstrlstApplications
    arrAppButtonBackgrounds: array [0..19] of TImage;
    arrAppButtonForegrounds: array [0..19] of TImage;
    arrAppButtonIcons: array [0..19] of TImage;
    arrAppButtonLabels: array [0..19] of TLabel;
    arrAppButtonButtons: array [0..19] of TButton;
    arrAppDividers: array [0..18] of TShape;
    arrAppItems: array of TAppListItem;
    arrAppCategories: array of TCategoryListItem;
    arrMenuItems: array of TMenuListItem;


		// object array of app icons, corresponds to arrAppButtons
		//arrAppIcons: array of HICON;

		// tracking variable for the currently displayer first icon
		intFirstButton: integer;
    intSelectedButton: integer;

		// tracking variables for the fade timers
		bolFadeIn: boolean; // true if fading in
		bolFadeToExit: boolean; // true if exiting on fade out
    bolFadeToEject: boolean;  // true if ejecting on fade out

		// container variables for drive size, free space size and name
		dblDriveSize: int64;
		strDriveSize: string;
		dblDriveFree: int64;
		dblDriveUsed: int64;
		strDriveFree: string;
		strDriveName: string;
    strDriveSpace: string;

		// Variables for storing wallpaper change state
		bolWallpaperChanged: boolean;
		strWallpaperBackup: string;
		strWallpaperStyleBackup: string;
		strWallpaperTileBackup: string;
    decScreenRatio: single;

    // Locale
    intLocaleID: integer;
    strLocaleWinName: string;
    strLocaleCode2: string;
    strLocaleCode3: string;
    strLanguageCode: string;
    strLocaleglibc: string;
    strLanguageName: string;

    // Theme Internals
    imgAppButtonHover: TImage;
  	imgFolderButtonHover: TImage;
    imgScrollUpNormal: TImage;
    imgScrollUpHover: TImage;
    imgScrollDownNormal: TImage;
    imgScrollDownHover: TImage;

  	// Display
		strStartPositionHorizontal: string;
		strStartPositionVertical: string;
		bolShadow: boolean;
		bolShowSingleIconForMultiIconApps: boolean;
		bolAnotherFormDisplayed: boolean;
		bolTrayIcon: boolean;
    bolShowTaskbarIcon: boolean;
    bolWindows7TaskbarIcon: boolean;
    tclrAppIconTransparent: TColor;
    tclrAppIconFont: TColor;
    tclrAppIconFadedFont: TColor;
    bolShowHiddenIcons: boolean;

    // Label Strings
    strLabelDocuments, strLabelMusic, strLabelPictures, strLabelVideos, strLabelExplore, strLabelBackup, strLabelOptions, strLabelManageApps, strLabelSearch, strLabelHelp: string;
    strUninstallTitle, strUninstallMessage, strUninstallQuestion, strUninstallingTitle, strUninstallingMessage, strUninstallFailMessage, strOK, strCancel, strYes, strNo: string;
    strCategoryAccessibility, strCategoryDevelopment, strCategoryEducation, strCategoryGames, strCategoryGraphicsPictures, strCategoryInternet, strCategoryMusicVideo, strCategoryOffice, strCategorySecurity, strCategoryUtilities, strCategoryOther: string;
    strAddANewCategory, strAllPortableApps, strBackToPageOne, strAppPrefix, strCategoryPrefix, strKB, strMB, strGB, strTrayFavorites, strTrayApps, strCloseAppsOnPlatformExit, strCloseAppsOnPlatformExitHeader, strEjectButton, strPowerButton: string;
    strAutoRunChangeWarning, strAutoRunChangeWarningTitle, strDialogAppsStillRunning, strDialogAppsStillRunningEject: WideString;
    strSecurityWarningUnexpectedDLLs, strSecurityWarningHashFailure, strRequiresDotNetFramework, strTaskbarLinkCreated, strTaskbarLinkCreatedWin11, strStartLinkCreated: WideString;

    // OEM
    strOEMIconName: string;

    bolPersonalPictureTransparent: boolean;

    // Hotkey
    intHotkey1: LongWord;

    // Cascading menu
    miTrayFavorites    : TMenuItem;
    miTrayApplications : TMenuItem;
    miTraySeparator    : TMenuItem;
    imglstIndexMHL     : Integer;

		// Internal procedures to handle the buttons and font size
  	procedure FormHotkey(var msg: TWMHotkey); message WM_HOTKEY;
		procedure ChangeMenuFontSize(intFontSize: integer);
		procedure SetupButtons();
    procedure SortButtons();
		procedure DisplayButtons();
    procedure RebuildTrayAppIcons();
		procedure ClearButtons();
 		procedure LoadTheme();
		procedure LoadLocale();
		procedure SetupMenus();
		procedure pmnuitmLocaleClick(Sender : TObject);
		procedure LoadSettings();
		procedure SaveSettings();
		procedure SaveStatistics();
    procedure UpdateFreeSpace();

		// Handle windows messages
		function WindowsMessageRecieved(var Msg : TMessage) : Boolean;

		// Handle device and theme messages
		procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    // procedure WMThemeChanged(var Msg: TMessage); message WM_THEMECHANGED;
    //procedure WMDwmCompositionChanged(var Msg: TMessage); message WM_DWMCOMPOSITIONCHANGED;

    // Calculate SHA256 hashes on files
    function GetSHA256Hash(strFilePath: string): string;

    // Cascading menu
    procedure AddMenuItemExtended(aParentMI: TMenuItem; aAppItem: TAppListItem; aTag: Integer);

	public
		// public variable for the add app function to pass in the app to install
		strAppToInstall: string;
		strRenameMenuItem: string;
end;

  TMenuItemExtended = class(TMenuItem)
  private
    fValue: string;
  published
    property Value : string read fValue write fValue;
end;

var
	frmMenu: TfrmMenu;

implementation

uses System.UITypes, renamemenuitem, dialog, options;

{$R *.dfm}

//resourcestring

const
	DBT_DEVICETYPESPECIFIC      = $00008006;
	DBT_DEVICEREMOVECOMPLETE    = $00008005;
	DBT_DEVICEREMOVEPENDING     = $00008004;
	DBT_DEVICEQUERYREMOVEFAILED = $00008003;
	DBT_DEVICEQUERYREMOVE       = $00008002;
	DBT_DEVICEARRIVAL           = $00008001;
	DBT_DEVTYP_VOLUME           = $00000002;

type
	_DEV_BROADCAST_HDR = packed record
		dbch_size: DWORD;
		dbch_devicetype: DWORD;
		dbch_reserved: DWORD;
	end;
	DEV_BROADCAST_HDR = _DEV_BROADCAST_HDR;
	TDevBroadcastHeader = DEV_BROADCAST_HDR;
	PDevBroadcastHeader = ^TDevBroadcastHeader;

type
	_DEV_BROADCAST_VOLUME = packed record
		dbch_size: DWORD;
		dbch_devicetype: DWORD;
		dbch_reserved: DWORD;
		dbcv_unitmask: DWORD;
		dbcv_flags: WORD;
  end;
	DEV_BROADCAST_VOLUME = _DEV_BROADCAST_VOLUME;
	TDevBroadcastVolume = DEV_BROADCAST_VOLUME;
	PDevBroadcastVolume = ^TDevBroadcastVolume;

//procedure TfrmMenu.WMCommand(var Message: TWMCommand);
//begin
 // if Message.NotifyCode = THBN_CLICKED then
//  begin
 //   ShowMessage('You clicked on button #' + IntToStr(Message.ItemID));
//  end;
//  inherited;
//end;

procedure TfrmMenu.WMDeviceChange(var Msg: TMessage);
// Handles device changes so we can detect unsafe ejects
var
	intHeader: PDevBroadcastHeader;
	//intVolume: PDevBroadcastVolume;
	//intIndex: Integer;
	//strDrive: String;
begin
  inherited;

	intHeader:=PDevBroadcastHeader(Msg.lParam);

  case Msg.WParam of
		 DBT_DEVICEREMOVEPENDING:
     begin
				if (intHeader^.dbch_devicetype = DBT_DEVTYP_VOLUME) then
				begin
					if Not FileExists(Application.ExeName) then
					begin
						bolFadeToExit := true;
            bolDriveEjectExit:=true;
						FadeInOut(false);
					end;
				end;
		 end;
		 DBT_DEVICEREMOVECOMPLETE:
		 begin
				if (intHeader^.dbch_devicetype = DBT_DEVTYP_VOLUME) then
				begin
					if Not FileExists(Application.ExeName) then
					begin
						bolFadeToExit := true;
            bolDriveEjectExit:=true;
						FadeInOut(false);
					end;
				end;
		 end;
  end;
end;

procedure TfrmMenu.WMDropFiles(var Msg: TWMDropFiles);
var
  hndDrop: HDROP;
  intFilesDropped, intFileNameLength, intCurrentFile: Integer;
  strFileName: string;
  hicoLarge, hicoSmall: Hicon;
begin
  inherited;
  hndDrop := Msg.Drop;
  try
    intFilesDropped := DragQueryFile(hndDrop, $FFFFFFFF, nil, 0);
    for intCurrentFile := 0 to Pred(intFilesDropped) do
    begin
      intFileNameLength := DragQueryFile(hndDrop, intCurrentFile, nil, 0);
      SetLength(strFileName, intFileNameLength);
      DragQueryFile(hndDrop, intCurrentFile, PChar(strFileName), intFileNameLength + 1);
      if AnsiLowerCase(AnsiRightStr(strFileName,4)) = '.url' then
      begin
        if not FileExists(ExtractFileDir(Application.ExeName) + '\Data\URLs\' + ExtractFileName(strFileName)) then
        begin
          CreateDir(PChar(ExtractFileDir(Application.ExeName) + '\Data\URLs'));
          CopyFile(PChar(strFileName),PChar(ExtractFileDir(Application.ExeName) + '\Data\URLs\' + ExtractFileName(strFileName)),false);


          SetLength(arrAppItems, Length(arrAppItems)+1);
					arrAppItems[Length(arrAppItems)-1]:=TAppListItem.Create;
          arrAppItems[Length(arrAppItems)-1].CommandLine:=ExtractFileDir(Application.ExeName) + '\Data\URLs\' + ExtractFileName(strFileName);
          arrAppItems[Length(arrAppItems)-1].WorkingDirectory:=ExtractFileDir(ExtractFileDir(Application.ExeName) + '\Data\URLs');
					arrAppItems[Length(arrAppItems)-1].Caption:=AnsiLeftStr(ExtractFileName(strFileName),Length(ExtractFileName(strFileName))-4);
          arrAppItems[Length(arrAppItems)-1].PortableAppName:='URL';
          arrAppItems[Length(arrAppItems)-1].DefaultName:=arrAppItems[Length(arrAppItems)-1].Caption;
          arrAppItems[Length(arrAppItems)-1].CategoryIndex:=10; //Other
          arrAppItems[Length(arrAppItems)-1].InternalCategory:='Other';
          arrAppItems[Length(arrAppItems)-1].IsFavorite:=False;
          arrAppItems[Length(arrAppItems)-1].AutoStart:=False;

          ExtractIconEx(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\url.ico'), 0, hicoLarge, hicoSmall, 1);
          arrAppItems[Length(arrAppItems)-1].Icon:=TIcon.Create;
          if hicoSmall > 1 then
            arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoSmall)
          else if hicoLarge > 1 then
            arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoLarge)
          else
            arrAppItems[Length(arrAppItems)-1].Icon.Handle:=0;
          DestroyIcon(hicoLarge);
          DestroyIcon(hicoSmall);
        end;
      end;

      ShowMessage(strFileName);
    end;
  finally
    DragFinish(hndDrop);
  end;
  Msg.Result := 0;
end;

procedure TfrmMenu.CreateParams(var Params: TCreateParams);
// used to display a drop shadow on the menu on WinXP and up
const
	CS_DROPSHADOW = $00020000;
begin
	inherited;
	if ((Win32MajorVersion >= 5) and (Win32MinorVersion >= 1)) OR (Win32MajorVersion >= 6) then
  begin
		//Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
    bolShadow:=true;
  end else
  	bolShadow:=false;
end;

function TFrmMenu.WindowsMessageRecieved(var Msg : TMessage) : Boolean;
// Handle our custom 'multiple-instance' event
begin
  result:=false;
  if Msg.Msg = WM_SYSCOMMAND then
  begin
    case Msg.WParam of
      //Handle Minimize-Events
      SC_MINIMIZE:
      begin
        //Hide the Menu
        FadeInOut(false);
      end;
      //Handle Restore-Events
      SC_RESTORE:
      begin
        //Show the Menu
        FadeInOut(true);
      end;
      else
        //For everything else, we'll use the default implementation
        inherited;
    end;
  end
  else if Msg.Msg = intWindowsMessageRecallInstance then
	begin
		FadeInOut(true);
		result:= true;
	end
	else if msg.Msg = intWindowsMessageRefresh then
	begin
		//Cde to refresh window
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();

    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
    UpdateFreeSpace;
		//ShowMessage('got message');
		result:=true;
	end
	else if msg.Msg = intWindowsMessageCloseForUpdate then
	begin
     //Shutdown the platform for it to update and restart
     bolClosingForPlatformUpdate:=true;
     SetEnvironmentVariable(PChar('PortableApps.comPlatformUpdating'), PChar('true'));
     bolFadeToExit := true;
     FadeInOut(false);
  end;
end;

procedure TFrmMenu.FormHotkey(var msg: TWMHotkey);
// handle hotkey presses
begin
  if msg.HotKey=intHotkey1 then
  	if bolFadeIn then
	  	FadeInOut(false)
  	else
	  	FadeInOut(true);
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
 if not bolShowTaskbarIcon then
     ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
var
  regControlPanel: TRegIniFile;
  strDriveLetter: string;
  vProcList: TProcesses;
  intProcess, intProcessSub: integer;
  strProcesses, strCurrentProcess, strCurrentProcessSub: string;
  bolOKToClose, bolHasSubProcess, bolClosedSomeApps: boolean;
  shell: Variant;
  strCurrentProcessDetails: string;
  tslProcesses: TStringList;
  intCounter: integer;
label
  labelRetryCloseApps;
begin
  bolOKToClose:=false;
  if not bolAskCloseAppsOnPlatformExit and (strCloseAppsOnPlatformExit <> 'BLANK') and not bolClosingForPlatformUpdate then
  begin
    tmrFader.Enabled:= False;
    if not bolAnotherFormDisplayed then
    begin
      frmDialog.strTitle:=strCloseAppsOnPlatformExitHeader;
      frmDialog.strMessage:=strCloseAppsOnPlatformExit;
      frmDialog.strIconType:='QUESTION';
      frmDialog.bolButtons:=true;
      frmDialog.strButtonOK:=strYes;
      frmDialog.strButtonCancel:=strNo;
      frmDialog.bolOKDefault:=true;
      bolAnotherFormDisplayed:=true;
      frmDialog.ShowModal;
      bolAnotherFormDisplayed:=false;
      if frmDialog.strButton='OK' then
      begin
        bolCloseAppsOnPlatformExit:=true;
        bolAskCloseAppsOnPlatformExit:=true
      end
      else
      begin
        bolAskCloseAppsOnPlatformExit:=true;
        bolCloseAppsOnPlatformExit:=false
      end;
    end
    else
      bolOKToClose:=false;
  end;

  if bolCloseAppsOnPlatformExit and not bolClosingForPlatformUpdate then
    begin
      labelRetryCloseApps:

      tmrFader.Enabled:= False;
       // enumerate running processes and attempt to close as appropriate
      vProcList := TProcesses.Create;



      try
        vProcList.ReadSystem;

        // Pass 1: First attempt to close all EXEs in sub-directories
        bolClosedSomeApps:=false;
        for intProcess := 0 to vProcList.Count-1 do
        begin
          strCurrentProcess:=vProcList[intProcess].Fullname;
          strCurrentProcess:=StringReplace(strCurrentProcess, '\'+ExtractFileName(strCurrentProcess)+'\'+ExtractFileName(strCurrentProcess), '\'+ExtractFileName(strCurrentProcess), [rfReplaceAll,rfIgnoreCase]);
          if (AnsiLowerCase(LeftStr(strCurrentProcess, Length(strPortableAppsPath))) = AnsiLowerCase(strPortableAppsPath)) then
            if AnsiLowerCase(LeftStr(strCurrentProcess, Length(Application.ExeName))) <> AnsiLowerCase(Application.ExeName) then
            begin
              if AnsiLowerCase(ExtractFileDir(ExtractFileDir(strCurrentProcess))+'\') <> AnsiLowerCase(strPortableAppsPath) then
              begin
                if (AnsiLowerCase(ExtractFileName(strCurrentProcess)) = 'ditto.exe') then
                  // Ditto has no way of externally closing but loses no important data on termination
                  TerminateAppByProcess(vProcList[intProcess].ID)
                else if (AnsiLowerCase(ExtractFileName(strCurrentProcess)) = 'pnotes.exe') then
                  // PNotes has a way to prompt a close
                  ShellExecute(0,'open', PChar(strCurrentProcess), PChar('-x'), PChar(ExtractFileDir(strCurrentProcess)), SW_SHOWNORMAL)
                else
                  // Other apps should be closed by WM_CLOSE to their primary window
                  CloseAppByProcess(vProcList[intProcess].ID);
                bolClosedSomeApps:=true;
              end;
            end;
        end;

        if bolClosedSomeApps then
          Sleep(2000);

        vProcList.ReadSystem;

        // Pass 2: Close all EXEs without additional EXEs in sub-directories
        bolClosedSomeApps:=false;
        for intProcess := 0 to vProcList.Count-1 do
        begin
          bolHasSubProcess:=false;
          strCurrentProcess:=vProcList[intProcess].Fullname;
          strCurrentProcess:=StringReplace(strCurrentProcess, '\'+ExtractFileName(strCurrentProcess)+'\'+ExtractFileName(strCurrentProcess), '\'+ExtractFileName(strCurrentProcess), [rfReplaceAll,rfIgnoreCase]);
          if (AnsiLowerCase(LeftStr(strCurrentProcess, Length(strPortableAppsPath))) = AnsiLowerCase(strPortableAppsPath)) then
            if AnsiLowerCase(LeftStr(strCurrentProcess, Length(Application.ExeName))) <> AnsiLowerCase(Application.ExeName) then
              if AnsiLowerCase(ExtractFileDir(strCurrentProcess)) = AnsiLowerCase(strPortableAppsPath) then
                begin
                  for intProcessSub := 0 to vProcList.Count-1 do
                  begin
                    strCurrentProcessSub:=vProcList[intProcessSub].Fullname;
                    strCurrentProcessSub:=StringReplace(strCurrentProcessSub, '\'+ExtractFileName(strCurrentProcessSub)+'\'+ExtractFileName(strCurrentProcessSub), '\'+ExtractFileName(strCurrentProcessSub), [rfReplaceAll,rfIgnoreCase]);
                    if (AnsiLowerCase(strCurrentProcess) <> AnsiLowerCase(strCurrentProcessSub)) and (AnsiLowerCase(LeftStr(ExtractFileDir(strCurrentProcessSub), Length(ExtractFileDir(strCurrentProcess))+1)) = AnsiLowerCase(ExtractFileDir(strCurrentProcess)+'\')) then
                      bolHasSubProcess:=true;
                  end;
                  if not bolHasSubProcess then
                  begin
                    CloseAppByProcess(vProcList[intProcess].ID);
                    bolClosedSomeApps:=true;
                  end;
                end;
        end;

        if bolClosedSomeApps then
          Sleep(2000);

        vProcList.ReadSystem;

        // Pass 3: Enumerate remaining processes for display
        tslProcesses:=TStringList.Create;
        tslProcesses.Duplicates:=dupIgnore;
        tslProcesses.Sorted:=True;

        for intProcess := 0 to vProcList.Count-1 do
        begin
          strCurrentProcess:=vProcList[intProcess].Fullname;
          strCurrentProcess:=StringReplace(strCurrentProcess, '\'+ExtractFileName(strCurrentProcess)+'\'+ExtractFileName(strCurrentProcess), '\'+ExtractFileName(strCurrentProcess), [rfReplaceAll,rfIgnoreCase]);
          if (AnsiLowerCase(LeftStr(strCurrentProcess, Length(strPortableAppsPath))) = AnsiLowerCase(strPortableAppsPath)) then
            if AnsiLowerCase(LeftStr(strCurrentProcess, Length(Application.ExeName))) <> AnsiLowerCase(Application.ExeName) then
            begin
              strCurrentProcessDetails:='';
              strCurrentProcessDetails:=GetFileDetails(strCurrentProcess, 'ProductName');
              strCurrentProcessDetails:=StringReplace(StringReplace(StringReplace(StringReplace(strCurrentProcessDetails,', Portable Edition','',[]),' PortableApps.com',' XXX^^^XXX^^^',[]),' Portable','',[]),' XXX^^^XXX^^^',' PortableApps.com',[]);
              if strCurrentProcessDetails='' then
                strCurrentProcessDetails:=vProcList[intProcess].Name;
              tslProcesses.Add(strCurrentProcessDetails);
//              strProcesses:=strProcesses+strCurrentProcessDetails+AnsiString(#13#10);
            end;
        end;

        // Store Processes in variable and free list
        if tslProcesses.Count>0 then
        begin
          strProcesses:='';
          for intCounter := 0 to tslProcesses.Count - 1 do
            if strProcesses='' then
              strProcesses:=tslProcesses[intCounter]
            else
              strProcesses:=strProcesses + ', ' + tslProcesses[intCounter];
          strProcesses:=AnsiString(#13#10) + strProcesses + AnsiString(#13#10);
        end
        else
          strProcesses:='';

        FreeAndNil(tslProcesses);

      finally
        FreeAndNil(vProcList);
      end;

      if ((strProcesses = '') and (not bolAnotherFormDisplayed)) or bolDriveEjectExit then
        bolOKToClose:=true
      else
      begin
        if not frmDialog.Showing then
        begin
          bolFadeToExit:=false;
          frmDialog.strMessage:=StringReplace(strDialogAppsStillRunning, '%RUNNINGAPPS%', AnsiString(#13#10)+strProcesses+AnsiString(#13#10), [rfReplaceAll,rfIgnoreCase]);
          frmDialog.strIconType:='WARNING';
          frmDialog.bolButtons:=true;
          frmDialog.bolOKOnly:=false;
          frmDialog.strButtonOK:=strOK;
          frmDialog.strButtonCancel:=strCancel;
          bolAnotherFormDisplayed:=true;
          frmDialog.ShowModal;
          bolAnotherFormDisplayed:=false;
          if frmDialog.strButton='OK' then
            goto labelRetryCloseApps;
        end;
      end;
    end
  else
    bolOKToClose:=true;

  if bolOKToClose and (not frmDialog.Showing) then
  begin
    if bolWallpaperChanged=true then begin
      regControlPanel:= TRegIniFile.Create('Control Panel\Desktop');
      regControlPanel.WriteString('', 'Wallpaper', strWallpaperBackup);
      regControlPanel.WriteString('', 'TileWallpaper', strWallpaperTileBackup);
      regControlPanel.WriteString('', 'WallpaperStyle', strWallpaperStyleBackup);
      FreeAndNil(regControlPanel);
      SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);
      if bolRunningUnderWin8 then begin
        TFile.Delete(GetEnvironmentVariable('TEMP')+'portableapps_platform_wallpaper_temp.bmp');
    end;
    end;

    if bolHideDesktopIcons then
      ShowDesktopIcons(true);

    SaveSettings;
    SaveStatistics();

    // EJECT HERE
    if bolFadeToEject then
    begin
      if (((not bolRunningFromUNCPath) and (bolRunningOnRemovableDrive)) or bolAlwaysShowEject) and not bolAlwaysShowPower then // EJECT
      begin
        strDriveLetter:=ExtractFileDrive(GetEnvironmentVariable('USERPROFILE'));
        if ((strDriveLetter <> ExtractFileDrive(Application.ExeName)) and (not bolRunningUnderWine)) then
          ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\App\bin\eject.exe'), '/REMOVETHIS /SHOWEJECT', Nil, SW_SHOWNORMAL);
      end
      else
      begin  //Shutdown Windows via call
        shell := CreateOleObject('Shell.Application');
        shell.ShutdownWindows;
      end;
    end
  end
  else
    Action:=caNone;
end;

procedure TFrmMenu.FormCreate(Sender: TObject);
	var
		//dcDesktop: HDC;
		//intColorDepth: integer;
		regControlPanel: TRegIniFile;
		iniAutorun: TINIFile;
		iniOEM: TINIFile;
    strAutorunFilename: string;
		strOEMFilename: string;
    osVerInfo: TOSVersionInfo;
    hndKey: HKey;
    //bolResult: boolean;
    strDriveLetter: string;
    intDriveType: integer;
    strWallpaperPath: string;
    //tbtnTemp: TThumbButton;
{    bmpTemp: TBitmap;
    icoTemp: TIcon;}
    //icoTemp: TIcon;
    contrastThing: THighContrast;
begin
  // Base paths
  strPortableAppsPath := ExtractFileDir(ExtractFileDir(Application.ExeName));
  if AnsiRightStr(strPortableAppsPath,1) = '\' then
    strPortableAppsPath:=AnsiLeftStr(strPortableAppsPath,Length(strPortableAppsPath)-1);
  strPortableAppsRootPath := ExtractFileDir(strPortableAppsPath);
  if AnsiRightStr(strPortableAppsRootPath,1) = '\' then
    strPortableAppsRootPath:=AnsiLeftStr(strPortableAppsRootPath,Length(strPortableAppsRootPath)-1);

  // Check if we're restarting after an update
  if (GetEnvironmentVariable('PortableApps.comPlatformUpdating')='true') then
    bolOpeningFromPlatformUpdate:=true
  else
    bolOpeningFromPlatformUpdate:=false;

  // Reset log file if there is one
  DeleteFile(ChangeFileExt (Application.Exename, '.log'));

  // Settings
  LoadSettings;

  LogWrite('Info', Self.Name, 'Application Start, Settings Loaded');

  // Setup Environment
  SetPlatformEnvironmentVariables;

  // Load taskbar icon
  if strTaskbarIcon <> 'Default' then
  begin
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico')) then
    begin
      Application.Icon.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico');
      trayiconMenu.Icon.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico');
    end;
  end;

  // Get Windows version details
  osVerInfo.dwOSVersionInfoSize := SizeOf(osVerInfo);
	GetVersionEx(osVerInfo);
  if (osVerInfo.dwPlatformId<>VER_PLATFORM_WIN32_NT) then
    bolRunningUnderWin9x:=true
  else
  begin
    bolRunningUnderWin9x:=false;
    if ((Win32MajorVersion >= 6) and (Win32MinorVersion >= 1)) OR (Win32MajorVersion >= 7) then
      bolRunningUnderWin7:=true
    else
      bolRunningUnderWin7:=false;
    if ((Win32MajorVersion >= 6) and (Win32MinorVersion >= 2)) OR (Win32MajorVersion >= 7) then
      bolRunningUnderWin8:=true
    else
      bolRunningUnderWin8:=false;
    if ((Win32MajorVersion >= 6) and (Win32MinorVersion >= 3)) OR (Win32MajorVersion >= 7) then
      bolRunningUnderWin8_1:=true
    else
      bolRunningUnderWin8_1:=false;
    if (Win32MajorVersion >= 10) then
      bolRunningUnderWin10:=true
    else
      bolRunningUnderWin10:=false;
    if ((Win32MajorVersion >= 10) and (Win32BuildNumber>21900)) then
      bolRunningUnderWin11:=true
    else
      bolRunningUnderWin11:=false;
  end;

  if (TOSVersion.Architecture = TOSVersion.TArchitecture.arARM64) or (TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX64) then
    bolRunningUnder64bitWin:=true
  else
    bolRunningUnder64bitWin:=false;

  // Get additional paths
  if bolRunningUnder64bitWin then
  begin
    strProgramFilesPath:=GetEnvironmentVariable('ProgramW6432');
    strProgramFilesx86Path:=GetEnvironmentVariable('PROGRAMFILES');
  end
  else
  begin
    strProgramFilesPath:=GetEnvironmentVariable('PROGRAMFILES');
    strProgramFilesx86Path:=strProgramFilesPath;
  end;

  // Check dot net versions
  CheckDotNetVersions;

  // Touch handling disabled under Windows 7 and earlier
  if (bolRunningUnderWin10 or bolRunningUnderWin8 or bolRunningUnderWin11) then
  begin
    frmMenu.Touch.GestureManager:=Self.gestureManagerMain;
    frmMenu.Touch.StandardGestures:=[TStandardGesture.sgUp, TStandardGesture.sgDown];
    frmMenu.OnGesture:=FormGesture;
    //frmMenu.Touch.GestureList[0].Action:=FormGesture;
  end;

  // Hide pin to task bar on Windows XP/Vista
  if not bolRunningUnderWin7 then
    pmnuitmAppRightClickPinToTaskbar.Visible:=false;

//  DragAcceptFiles(Self.Handle, True);

  // Determine if Windows is running with a high contrast theme
  contrastThing.cbSize := SizeOf(THighContrast);
  SystemParametersInfo(SPI_GETHIGHCONTRAST, SizeOf(THighContrast), @contrastThing, 0);
  if ((HCF_HIGHCONTRASTON and contrastThing.dwFlags)>0) then
    bolHighContrastTheme := true
  else
    bolHighContrastTheme := false;

  if bolHighContrastTheme then
    SetEnvironmentVariable(PChar('PortableApps.comHighContrast'), PChar('true'))
  else
    SetEnvironmentVariable(PChar('PortableApps.comHighContrast'), PChar('false'));

  // Determine the type of path we're running on
  if Length(ExtractFileDrive(Application.ExeName))>2 then
  begin
    bolRunningFromUNCPath:=true;
    bolRunningOnRemovableDrive:=false;
  end
  else
  begin
    bolRunningFromUNCPath:=false;
    strDriveLetter:=ExtractFileDrive(GetEnvironmentVariable('WINDIR'));
    if strDriveLetter = ExtractFileDrive(Application.ExeName) then
      bolRunningOnRemovableDrive:=False
    else
    begin
      intDriveType:=GetDriveType(PChar(ExtractFileDrive(Application.ExeName)+'\'));
      if intDriveType=DRIVE_REMOVABLE then
        bolRunningOnRemovableDrive:=True
      else
        bolRunningOnRemovableDrive:=False;
    end;
  end;

  // Cascading Menu
  miTrayFavorites := TMenuItem.Create(pmnuTray);
  miTrayFavorites.Name := 'miTrayFavorites';
  miTrayFavorites.Caption := '&Favorites';
  miTrayFavorites.ImageIndex:=38;
  pmnuTray.Items.Insert(pmnuTray.Items.IndexOf(pmnuitmTrayEject), miTrayFavorites);
  miTrayApplications := TMenuItem.Create(pmnuTray);
  miTrayApplications.Name := 'miTrayApplications';
  miTrayApplications.Caption := '&Apps';
  miTrayApplications.ImageIndex:=39;
  pmnuTray.Items.Insert(pmnuTray.Items.IndexOf(pmnuitmTrayEject), miTrayApplications);
  miTraySeparator := TMenuItem.Create(pmnuTray);
  miTraySeparator.Name := 'miTraySeparator';
  miTraySeparator.Caption:= '-';
  pmnuTray.Items.Insert(pmnuTray.Items.IndexOf(pmnuitmTrayEject), miTraySeparator);
  imglstIndexMHL := imglstSubmenuIcons.Count;
  // End Cascading Menu

  strLastThemeLayout:='classic';
	try
		trayiconMenu.Visible:=true;
		bolTrayIcon:=true;
	except
		bolTrayIcon:=false;
  end;
        GIFImageDefaultAnimate := True;
  if RegOpenKey(HKEY_CURRENT_USER,PChar('Software\Wine'),hndKey) = ERROR_SUCCESS then
  begin
    RegCloseKey(hndKey);
    bolRunningUnderWine:=true;
    pmnuitmOptionsCheckDrive.Enabled:=false;
  end
  else
    bolRunningUnderWine:=false;



	if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
    // Create the Data directory if it is missing
    ForceDirectories(PChar(ExtractFileDir(Application.ExeName) + '\Data'));
	end;

	// Message handler
	Application.HookMainWindow(WindowsMessageRecieved);

	// Default Button State
	intFirstButton:=0;

  frmMenu.Caption:='PortableApps.com Platform - '+Application.ExeName;

  // OEM Branding
  if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/OEM/oem.ini')) then begin
  	if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_icon.png')) then begin
    	imgOEMButton.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_icon.png');
    	imgOEMButton.Visible:=true;
    	lblButtonOEM.Visible:=true;
    	imgButtonOEMForeground.visible:=true;
      imgDivider3.Visible:=true;
  	end;
    if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_topright.png')) then begin
      imgPortableAppsLogo.Visible:=false;
      imgOEMLogoTopRight.Visible:=true;
      imgPersonalPicture.Enabled:=false;
      imgPersonalPicture.Visible:=false;
      imgOEMLogoTopRight.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_topright.png');
    end
    else begin
      if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_main.png')) then begin
        imgPortableAppsLogo.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/OEM/oemlogo_main.png');
        imgPortableAppsLogo2.Visible:=true;
      end
      else begin
        imgPortableAppsLogo.Visible:=false;
      end;
    end;
    strOEMFilename:= Trim(ExtractFileDir(Application.ExeName)+'/OEM/oem.ini');
	  iniOEM:=TINIFile.Create(strOEMFilename);
  	strOEM := iniOEM.ReadString('oem_information', 'oem', 'OEM');
    strOEMIconName := iniOEM.ReadString('oem_platform', 'icon_name', strOEM);
    strOEMThemeName := iniOEM.ReadString('oem_platform', 'theme_name', 'OEM');
    if strOEMIconName<>'NONE' then
    begin
      lblButtonOEM.Caption:=strOEMIconName;
      pmnuitmOptionsThemeOEM.Caption:=strOEMThemeName;
      pmnuitmOptionsThemeOEM.Visible:=true;
      pmnuitmOptionsThemeOEM.Enabled:=true;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'homepage', 'false'))='false' then
        pmnuitmOEMHomepage.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'store', 'false'))='false' then
        pmnuitmOEMStore.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'support', 'false'))='false' then
        pmnuitmOEMSupport.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'twitter', 'false'))='false' then
        pmnuitmOEMTwitter.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'facebook', 'false'))='false' then
        pmnuitmOEMFacebook.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'googleplus', 'false'))='false' then
        pmnuitmOEMGooglePlus.Visible:=False;
      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'custom1', 'false'))='false' then
        pmnuitmOEMCustom1.Visible:=False
      else
        pmnuitmOEMCustom1.Caption:=iniOEM.ReadString('oem_menu', 'custom1_caption', 'Custom 1');

      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'custom2', 'false'))='false' then
        pmnuitmOEMCustom2.Visible:=False
      else
        pmnuitmOEMCustom2.Caption:=iniOEM.ReadString('oem_menu', 'custom2_caption', 'Custom 2');

      if ansiLowerCase(iniOEM.ReadString('oem_menu', 'custom3', 'false'))='false' then
        pmnuitmOEMCustom3.Visible:=False
      else
        pmnuitmOEMCustom3.Caption:=iniOEM.ReadString('oem_menu', 'custom3_caption', 'Custom 3');
    end
    else
      btnOEM.Enabled:=false;

    pmnuitmOptionsTheme.Visible:=true;
    	imgPortableAppsLogo2.Visible:=true;
	  FreeAndNil(iniOEM);
  end
  else begin
    imgPortableAppsLogo2.Visible:=true;
    imgPortableAppsLogo.Visible:=false;
    btnOEM.Enabled:=false;
  end;

  // Left button behavior
  if bolAlwaysShowEject then
  begin
    pmnuitmLeftButtonEject.Checked:=true;
  end;

  if bolAlwaysShowPower then
    pmnuitmLeftButtonPower.Checked:=true;

  if bolHideSearchWhenNotInUse then
    pnlLiveSearchBorder.Visible:=false;

  if bolDisableSplashScreens then
    SetEnvironmentVariable(PChar('PortableApps.comDisableSplash'), PChar('true'));

  if (not bolRunningOnRemovableDrive and not bolAlwaysShowEject) or bolAlwaysShowPower then
    pmnuitmTrayEject.ImageIndex:=40;

	// Load Theme (temporarily hard-coded to App/DefaultData until theme setup finalized)
	// **TODO - Check data directory first, add theme loader and selector

  imgAppButtonHover:=TImage.Create(Self);
  imgFolderButtonHover:=TImage.Create(Self);
  imgScrollUpHover:=TImage.Create(Self);
 	imgScrollUpNormal:=TImage.Create(Self);
 	imgScrollDownHover:=TImage.Create(Self);
 	imgScrollDownNormal:=TImage.Create(Self);

  if strCurrentTheme='Default' then
    pmnuitmOptionsThemeRed.Checked:=true
  else if strCurrentTheme='Bronze' then
    pmnuitmOptionsThemeBronze.Checked:=true
  else if strCurrentTheme='Green' then
    pmnuitmOptionsThemeGreen.Checked:=true
  else if strCurrentTheme='Blue' then
    pmnuitmOptionsThemeBlue.Checked:=true
  else if strCurrentTheme='Violet' then
    pmnuitmOptionsThemeViolet.Checked:=true
  else if strCurrentTheme='Black' then
    pmnuitmOptionsThemeBlack.Checked:=true
  else if strCurrentTheme='Silver' then
    pmnuitmOptionsThemeSilver.Checked:=true
  else if strCurrentTheme='OEM' then
    pmnuitmOptionsThemeOEM.Checked:=true;

  if strCurrentTheme='Custom' then
  begin
    strThemePath:='Data\Theme';
    pmnuitmOptionsThemeCustom.Checked:=true;
  end
  else
    if strCurrentTheme='OEM' then
      strThemePath:='OEM\Theme'
    else
      strThemePath:='App\Graphics\Themes\' + strCurrentTheme;

    LoadTheme();

  case intAlphaBlendMain of
    255: pmnuitmOptionsTransparency0.Checked:=true;
    230: pmnuitmOptionsTransparency10.Checked:=true;
    204: pmnuitmOptionsTransparency20.Checked:=true;
    179: pmnuitmOptionsTransparency30.Checked:=true;
    153: pmnuitmOptionsTransparency40.Checked:=true;
    128: pmnuitmOptionsTransparency50.Checked:=true;
    102: pmnuitmOptionsTransparency60.Checked:=true;
    77: pmnuitmOptionsTransparency70.Checked:=true;
    51: pmnuitmOptionsTransparency80.Checked:=true;
    26: pmnuitmOptionsTransparency90.Checked:=true;
    else pmnuitmOptionsTransparency0.Checked:=true;

    
  end;

  // Menu icons
  {icoTemp := TIcon.Create;
  bmpTemp:=TBitmap.Create;
  icoTemp.LoadFromFile();
     try
     bmpTemp.Width := imgDocuments.Picture.Graphic.Width;
     bmpTemp.Height := imgDocuments.Picture.Graphic.Height;
     //bmpTemp.Canvas.Brush.Color:=clRed;
     bmpTemp.PixelFormat := pf24bit;
		 bmpTemp.Canvas.Draw(0, 0, imgDocuments.Picture.Graphic);
     //bmpTemp.TransparentColor:= RGB(255, 0, 0);
     pmnuitmTrayDocuments.Bitmap:=bmpTemp;
   finally
     bmpTemp.Free;
   end;}


	// Setup the app list
	//SetupButtons;
	//DisplayButtons;

  // Setup Category Array
  SetLength(arrAppCategories, 11);
  arrAppCategories[0]:=TCategoryListItem.Create('Accessibility');
  arrAppCategories[1]:=TCategoryListItem.Create('Development');
  arrAppCategories[2]:=TCategoryListItem.Create('Education');
  arrAppCategories[3]:=TCategoryListItem.Create('Games');
  arrAppCategories[4]:=TCategoryListItem.Create('Graphics and Pictures');
  arrAppCategories[5]:=TCategoryListItem.Create('Internet');
  arrAppCategories[6]:=TCategoryListItem.Create('Music and Video');
  arrAppCategories[7]:=TCategoryListItem.Create('Office');
  arrAppCategories[8]:=TCategoryListItem.Create('Security');
  arrAppCategories[9]:=TCategoryListItem.Create('Utilities');
  arrAppCategories[10]:=TCategoryListItem.Create('Other');

	// Language
  LoadLocale();
  SetupMenus();

  // Get the drive's name from the autorun.inf
  strAutorunFilename:= Trim(ExtractFileDrive(Application.ExeName) + '\autorun.inf');
  iniAutorun:=TINIFile.Create(strAutorunFilename);
  strDriveName := iniAutorun.ReadString('Autorun', 'Label', '');
  FreeAndNil(iniAutorun);
  lblDriveName.Caption:=strDriveName + ' (' + ExtractFileDrive(Application.ExeName) + ')';

	// Position our menu
	if ansiLowerCase(strStartPositionHorizontal)='left' then
		Left:= Screen.WorkAreaRect.Left
  else if ansiLowerCase(strStartPositionHorizontal)='center' then
    Left:=(Screen.WorkAreaRect.Right div 2) - (Width div 2)
  else // default to right
    Left:= Screen.WorkAreaRect.Right-Width;

	if ansiLowerCase(strStartPositionVertical)='top' then
		Top:= Screen.WorkAreaRect.Top
  else if ansiLowerCase(strStartPositionVertical)='middle' then
    Top:=(Screen.WorkAreaRect.Bottom div 2) - (Height div 2)
  else // default to bottom
		Top:= Screen.WorkAreaRect.Bottom-Height;

  // Create the window hidden and set its properties
	ShowWindow(Application.Handle, SW_HIDE);
  if (bolRunningUnderWin7 and bolWindows7TaskbarIcon) then
    bolShowTaskbarIcon:=true
  else
    bolShowTaskbarIcon:=false;


  //with Self do
  //SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  // Wallpaper
  decScreenRatio:=(Screen.Width * 1000 div Screen.Height);
  //showmessage(FormatFloat('#.####',decScreenRatio));
  if FileExists(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName)))+'\Documents\Pictures\portableapps_wallpaper.bmp') then begin
    regControlPanel:= TRegIniFile.Create('Control Panel\Desktop');
    bolWallpaperChanged:=true;
    strWallpaperBackup:=regControlPanel.ReadString('','Wallpaper','');
    strWallpaperStyleBackup:=regControlPanel.ReadString('','WallpaperStyle','');
    strWallpaperTileBackup:=regControlPanel.ReadString('','TileWallpaper','');
    strWallpaperPath:=ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName)))+'\Documents\Pictures\portableapps_wallpaper.bmp';
    if FileExists(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName)))+'\Documents\Pictures\portableapps_wallpaper_wide.bmp') and (decScreenRatio > 1450) then
        strWallpaperPath:=ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName)))+'\Documents\Pictures\portableapps_wallpaper_wide.bmp';
    //regControlPanel.WriteString('', 'Wallpaper', strWallpaperPath);
    //regControlPanel.WriteString('', 'TileWallpaper', '0');
    //regControlPanel.WriteString('', 'WallpaperStyle', '2');
    //regControlPanel.Free;
    if bolRunningUnderWin8 then begin
      TFile.Copy(strWallpaperPath, GetEnvironmentVariable('TEMP')+'portableapps_platform_wallpaper_temp.bmp',True);
      strWallpaperPath:=GetEnvironmentVariable('TEMP')+'portableapps_platform_wallpaper_temp.bmp';
    end;
    SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, pChar(strWallpaperPath), SPIF_SENDCHANGE);
  end else
    bolWallpaperChanged:=false;

	// Display the window
	//ShowWindow(Application.Handle, SW_SHOW);
  if not bolStartMinimized then
  	FadeInOut(true);
  bolFadeToExit:=false;

  // Check for personal picture
  if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp')) then
  begin
		imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp');
  	bolPersonalPictureTransparent:=false;
  end
  else if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg')) then
  begin
		imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg');
    bolPersonalPictureTransparent:=false;
  end
  else if FileExists(PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png')) then
  begin
		imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png');
    bolPersonalPictureTransparent:=true;
    bvlPersonalPicture.Visible:=false;
  end
  else
    bvlPersonalPicture.Visible:=false;

  // Hide Desktop Icons
  if bolHideDesktopIcons then
  	ShowDesktopIcons(false)
  else
		pmnuitmOptionsHideDesktopIcons.checked:=false;

	frmMenu.DoubleBuffered:=true;
  ClearButtons();
  lblAppButton01.Caption:='';
  lblAppButton02.Caption:='';
  lblAppButton03.Caption:='';
  lblAppButton04.Caption:='';
  lblAppButton05.Caption:='';
  lblAppButton06.Caption:='';
  lblAppButton07.Caption:='';
  lblAppButton08.Caption:='';
  lblAppButton09.Caption:='';
  lblAppButton10.Caption:='';
  lblAppButton11.Caption:='';
  lblAppButton12.Caption:='';
  lblAppButton13.Caption:='';
  lblAppButton14.Caption:='';
  lblAppButton15.Caption:='';
  lblAppButton16.Caption:='';
  lblAppButton17.Caption:='';
  lblAppButton18.Caption:='';
  lblAppButton19.Caption:='';
  lblAppButton20.Caption:='';

    // Font size
  if bolLargeFonts and (Screen.PixelsPerInch < 100) then begin
		pmnuitmOptionsLargeFonts.Checked:=true;
		ChangeMenuFontSize(11)
  end
  else
    ChangeMenuFontSize(9);

  // Modern font
  if Screen.Fonts.IndexOf('Segoe UI Regular') <> -1 then
  begin
    lblAppButton01.Font.Name:='Segoe UI Regular';
    lblAppButton02.Font.Name:='Segoe UI Regular';
    lblAppButton03.Font.Name:='Segoe UI Regular';
    lblAppButton04.Font.Name:='Segoe UI Regular';
    lblAppButton05.Font.Name:='Segoe UI Regular';
    lblAppButton06.Font.Name:='Segoe UI Regular';
    lblAppButton07.Font.Name:='Segoe UI Regular';
    lblAppButton08.Font.Name:='Segoe UI Regular';
    lblAppButton09.Font.Name:='Segoe UI Regular';
    lblAppButton10.Font.Name:='Segoe UI Regular';
    lblAppButton11.Font.Name:='Segoe UI Regular';
    lblAppButton12.Font.Name:='Segoe UI Regular';
    lblAppButton13.Font.Name:='Segoe UI Regular';
    lblAppButton14.Font.Name:='Segoe UI Regular';
    lblAppButton15.Font.Name:='Segoe UI Regular';
    lblAppButton16.Font.Name:='Segoe UI Regular';
    lblAppButton17.Font.Name:='Segoe UI Regular';
    lblAppButton18.Font.Name:='Segoe UI Regular';
    lblAppButton19.Font.Name:='Segoe UI Regular';
    lblAppButton20.Font.Name:='Segoe UI Regular';
    lblButtonDocuments.Font.Name:='Segoe UI Regular';
    lblButtonPictures.Font.Name:='Segoe UI Regular';
    lblButtonMusic.Font.Name:='Segoe UI Regular';
    lblButtonVideos.Font.Name:='Segoe UI Regular';
    lblButtonExplore.Font.Name:='Segoe UI Regular';
    lblButtonBackup.Font.Name:='Segoe UI Regular';
    lblButtonOptions.Font.Name:='Segoe UI Regular';
    lblButtonManageApps.Font.Name:='Segoe UI Regular';
    lblButtonSearch.Font.Name:='Segoe UI Regular';
    lblButtonHelp.Font.Name:='Segoe UI Regular';
    lblButtonOEM.Font.Name:='Segoe UI Regular';
    lblDriveName.Font.Name:='Segoe UI Regular';
    lblDriveSpace.Font.Name:='Segoe UI Regular';
    lblDriveSpaceShadow.Font.Name:='Segoe UI Regular';
    edtLiveSearch.Font.Name:='Segoe UI Regular';
  end
  else if Screen.Fonts.IndexOf('Segoe UI') <> -1 then
  begin
    lblAppButton01.Font.Name:='Segoe UI';
    lblAppButton02.Font.Name:='Segoe UI';
    lblAppButton03.Font.Name:='Segoe UI';
    lblAppButton04.Font.Name:='Segoe UI';
    lblAppButton05.Font.Name:='Segoe UI';
    lblAppButton06.Font.Name:='Segoe UI';
    lblAppButton07.Font.Name:='Segoe UI';
    lblAppButton08.Font.Name:='Segoe UI';
    lblAppButton09.Font.Name:='Segoe UI';
    lblAppButton10.Font.Name:='Segoe UI';
    lblAppButton11.Font.Name:='Segoe UI';
    lblAppButton12.Font.Name:='Segoe UI';
    lblAppButton13.Font.Name:='Segoe UI';
    lblAppButton14.Font.Name:='Segoe UI';
    lblAppButton15.Font.Name:='Segoe UI';
    lblAppButton16.Font.Name:='Segoe UI';
    lblAppButton17.Font.Name:='Segoe UI';
    lblAppButton18.Font.Name:='Segoe UI';
    lblAppButton19.Font.Name:='Segoe UI';
    lblAppButton20.Font.Name:='Segoe UI';
    lblButtonDocuments.Font.Name:='Segoe UI';
    lblButtonPictures.Font.Name:='Segoe UI';
    lblButtonMusic.Font.Name:='Segoe UI';
    lblButtonVideos.Font.Name:='Segoe UI';
    lblButtonExplore.Font.Name:='Segoe UI';
    lblButtonBackup.Font.Name:='Segoe UI';
    lblButtonOptions.Font.Name:='Segoe UI';
    lblButtonManageApps.Font.Name:='Segoe UI';
    lblButtonSearch.Font.Name:='Segoe UI';
    lblButtonHelp.Font.Name:='Segoe UI';
    lblButtonOEM.Font.Name:='Segoe UI';
    lblDriveName.Font.Name:='Segoe UI';
    lblDriveSpace.Font.Name:='Segoe UI';
    lblDriveSpaceShadow.Font.Name:='Segoe UI';
    edtLiveSearch.Font.Name:='Segoe UI';
  end;

  // Main app handle for use with the taskbar
  if not Application.MainFormOnTaskBar then
      hndMainForm := Application.Handle
    else hndMainForm := Application.MainForm.Handle;

  // Windows 7+ taskbar initialization
  if CheckWin32Version(6, 1) then
  begin
    TaskbarList := CreateComObject(CLSID_TaskbarList) as ITaskbarList;
    TaskbarList.HrInit;
    Supports(TaskbarList, IID_ITaskbarList2, TaskbarList2);
    Supports(TaskbarList, IID_ITaskbarList3, TaskbarList3);
    Supports(TaskbarList, IID_ITaskbarList4, TaskbarList4);
    //tbtnTemp.iId := 42;
    //tbtnTemp.iBitmap := 0;
    //tbtnTemp.dwMask := THB_FLAGS or THB_BITMAP or THB_TOOLTIP;
    //tbtnTemp.dwFlags :=  THBF_ENABLED or THBF_NOBACKGROUND;
    //StrCopy(tbtnTemp.szTip, PChar('Answer'));
    //TaskbarList3.ThumbBarSetImageList(hndMainForm, imglstTaskbarThumbButtons.Handle);
    //TaskbarList3.ThumbBarAddButtons(hndMainForm, 1, @tbtnTemp);
  end;

  tmrShowAppIcons.enabled:=true;

  LoadPortableFonts();

	//RegisterHotkey(Handle, 1, MOD_WIN, VK_P);
//  RegisterHotKey(Handle, intHotkey1, MOD_ALT, VK_SPACE);
  intHotkey1:=GlobalAddAtom('HotKey1');
  //intHotkey1:=1;
//  bolResult:=RegisterHotKey(Handle, intHotkey1, MOD_ALT+MOD_CONTROL, VK_SPACE);

  //if not bolResult then
    //showmessage('Unable to register hotkey');

  // Global hotket to show menu
  intHotKey1:=GlobalAddAtom('HotKey1');
  if strGlobalHotKey='CTRL-ALT-SPACE' then
    RegisterHotKey(Handle, intHotkey1, MOD_ALT+MOD_CONTROL, VK_SPACE)
  else if strGlobalHotKey='CTRL-ALT-P' then
    RegisterHotKey(Handle, intHotkey1, MOD_ALT+MOD_CONTROL, VK_P)
  else if strGlobalHotKey='CTRL-ALT-M' then
    RegisterHotKey(Handle, intHotkey1, MOD_ALT+MOD_CONTROL, VK_M)
  else if strGlobalHotKey='WIN-ALT-SPACE' then
    RegisterHotKey(Handle, intHotkey1, MOD_ALT+MOD_WIN, VK_SPACE)
  else if strGlobalHotKey='CTRL-SPACE' then
    RegisterHotKey(Handle, intHotkey1, MOD_CONTROL, VK_SPACE)
  else if strGlobalHotKey='ALT-SPACE' then
    RegisterHotKey(Handle, intHotkey1, MOD_ALT, VK_SPACE)
  else
    strGlobalHotKey:='DISABLED';

  if not bolHideLogoDecorations then
  begin
    // Logo modification for holiday
    if (MonthOf(Now) = 12) and ((23 < DayOfTheMonth(Now)) and (DayOfTheMonth(Now) < 27)) then begin
      // Santa hat from December 24 to December 26 for Christmas
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-santa.png');
      imgLogoMod.Visible:=true
    end
    else if (MonthOf(Now) = 10) and (29 < DayOfTheMonth(Now)) then begin
      // Witch hat from October 30 to October 31 for Halloween
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-witch.png');
      imgLogoMod.Visible:=true
    end
    else if (((MonthOf(Now) = 12) and (30 < DayOfTheMonth(Now))) or ((MonthOf(Now) = 1) and (2 > DayOfTheMonth(Now)))) then begin
      // Fireworks from December 31 to January 1 for New Year
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-fireworks.png');
      imgLogoMod.Visible:=true
    end
    else if (MonthOf(Now) = 2) and (14 = DayOfTheMonth(Now)) then begin
      // Heart on February 14 for Valentine's Day
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-heart.png');
      imgLogoMod.Visible:=true
    end
    else if (YearOf(Now) = 2022) and (MonthOf(Now) = 12) and ((DayOfTheMonth(Now) = 18) or (DayOfTheMonth(Now) = 26)) then begin
      // Menora on Dec 18 and 26, 2022 for Hanukkah (changes yearly)
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-menora.png');
      imgLogoMod.Visible:=true
    end
    else if (YearOf(Now) = 2023) and (MonthOf(Now) = 1) and (DayOfTheMonth(Now) = 22) then begin
      // Fireworks on Jan 22, 2023 for Lunar New Year (changes yearly)
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-fireworks.png');
      imgLogoMod.Visible:=true
    end
    else if (YearOf(Now) = 2022) and (MonthOf(Now) = 5) and ((DayOfTheMonth(Now) = 2) or (DayOfTheMonth(Now) = 3)) then begin
      // Fireworks on May 2-3, 2022 for Eid al-Fitr (changes yearly)
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-fireworks.png');
      imgLogoMod.Visible:=true
    end
    else if (YearOf(Now) = 2022) and (MonthOf(Now) = 10) and (DayOfTheMonth(Now) = 24) then begin
      // Fireworks on Oct 24, 2022 for Diwali (changes yearly)
      imgLogoMod.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\logo-accent-fireworks.png');
      imgLogoMod.Visible:=true
    end;
  end;
end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  DragAcceptFiles(Self.Handle, False);
  FreeAndNil(miTrayFavorites);
  FreeAndNil(miTrayApplications);
  FreeAndNil(miTraySeparator);

  // Unregister our Global Hotkeys
  if strGlobalHotKey<>'DISABLED' then
    UnregisterHotkey(Handle, intHotkey1);
  GlobalDeleteAtom(intHotkey1);

  // Unhook our message handler
  Application.UnHookMainWindow(WindowsMessageRecieved);

  UnLoadPortableFonts();

  UnSetPlatformEnvironmentVariables();

  LogWrite('Info', Self.Name, 'Application End');
end;

procedure TfrmMenu.FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  intCounter: integer;
begin
  if EventInfo.GestureID = sgiUp then
  for intCounter := 1 to 19 do
  begin
    ScrollApps(false);
  end
  else if EventInfo.GestureID = sgiDown then
  for intCounter := 1 to 19 do
  begin
    ScrollApps(true);
  end
  //else if EventInfo.GestureID = sgiLeft then
  //  if (not bolSecondAppPage) and (not bolShowAllApps) then
  //  begin
  //    bolSecondAppPage:=true;
  //    SortButtons();
  //    DisplayButtons();
  //  end
  //else if EventInfo.GestureID = sgiRight then
  // if bolSecondAppPage then
  //  begin
  //    showmessage('right');
  //    bolSecondAppPage:=false;
  //    SortButtons();
  //    DisplayButtons();
  //  end
end;

procedure TfrmMenu.AppButtonClick(Sender: TObject);
var
  iControl, intCounter2 : integer;
  TempShiftState: TShiftState;
  bolRunAdmin, bolAppRun: boolean;

begin
  bolRunAdmin:= false; //(GetKeyState(VK_CONTROL)<>0);
  for iControl := Low(arrAppButtonForegrounds) to High(arrAppButtonForegrounds) do
    if (TObject(arrAppButtonButtons[iControl]) = Sender) or (TObject(arrAppButtonForegrounds[iControl]) = Sender) then
      if (not bolSecondAppPage) and (not bolShowAllApps) and (iControl=19) then
      begin
        bolSecondAppPage:=true;
        SortButtons();
        DisplayButtons();
        btnAppButton20.SetFocus;
      end
      else if bolSecondAppPage and (iControl=19) then
      begin
        bolSecondAppPage:=false;
        SortButtons();
        DisplayButtons();
        btnAppButton20.SetFocus;
      end
      else
      begin
        if arrMenuItems[iControl+intFirstButton].Folder then
          begin
            // CLick a category
            if arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].Expanded then
              arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].Expanded:=false
            else
              begin
                if bolCollapseOtherFoldersOnExpand then begin
                  for intCounter2:=0 to Length(arrAppCategories)-1 do begin
                    arrAppCategories[intCounter2].Expanded:=false;
                  end;
                  arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].Expanded:=true;
                end
                else
                  arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].Expanded:=true;
              end;
            sortbuttons();
            displaybuttons();
        end
        else
         begin
          arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].TimesRun:=arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].TimesRun+1;
          // execute the exe path that corresponds to the same index in the app array


          // If CTRL down start as admin, otherwise normal
          bolAppRun:=StartPortableApp(arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].CommandLine, arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].WorkingDirectory, bolRunAdmin, arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].DotNetVersion);

          if ((not bolRemainVisible) and bolAppRun) then FadeInOut(False);

          if not bolSecondAppPage and not bolShowAllApps and not bolLiveSearchResults then
          begin
            SortButtons;
            DisplayButtons;
          end;
          if bolLiveSearchResults then begin
            edtLiveSearch.Text:='';
            //bolLiveSearchResults:=false;
            //edtLiveSearch.Visible:=false;
            //imgLiveSearchClose.Visible:=false;
            //imgLiveSearchIcon.Visible:=true;
            intFirstButton:=0;
            SortButtons;
            DisplayButtons;
            if bolHideSearchWhenNotInUse then
            begin
              pnlLiveSearchBorder.Visible:=false;
              if frmMenu.Showing then
                SelectNext(edtLiveSearch as TWinControl,True,True);
             end
          end;
        end;
      end;


    TempShiftState:= [];
    for iControl := Low(arrAppButtonButtons) to High(arrAppButtonButtons) do
      if (TObject(arrAppButtonButtons[iControl]) = Sender) or (TObject(arrAppButtonForegrounds[iControl]) = Sender) then
      begin
        //ShowMessage('click');
        AppButtonMouseUp(arrAppButtonForegrounds[iControl], mbLeft, TempShiftState, Round(screen.Width/2), Round(screen.Height/2));
      end;
end;

procedure TfrmMenu.AppButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  iControl : integer;
  pmnuitmTemp: TMenuItemExtended;
  intCounter: integer;
  arrSortedCategories: array of integer;
  intMin, intLook, intTemp: integer;
begin
  for iControl := Low(arrAppButtonForegrounds) to High(arrAppButtonForegrounds) do
    if (TObject(arrAppButtonForegrounds[iControl]) = Sender) and (Button = mbRight) then
      if (not arrMenuItems[iControl+intFirstButton].Folder) then
      begin

        // Setup Category Menu
        // Setup category sort array
        SetLength(arrSortedCategories,Length(arrAppCategories));

        for intCounter := 0 to Length(arrAppCategories)-1 do
          arrSortedCategories[intCounter]:=intCounter;

        // Sort Categories
        for intCounter := 0 to Length(arrSortedCategories)-1 do begin
          intMin:=intCounter;
          for intLook:=intCounter+1 to Length(arrSortedCategories)-1 do
            if LowerCase(arrAppCategories[arrSortedCategories[intLook]].DisplayName)<LowerCase(arrAppCategories[arrSortedCategories[intMin]].DisplayName) then intMin:=intLook;
          intTemp:=arrSortedCategories[intMin];
          arrSortedCategories[intMin]:=arrSortedCategories[intCounter];
          arrSortedCategories[intCounter]:=intTemp;
        end;


        // Clear the menus
        pmnuitmAppRightClickCategory.Clear;
        // Set up
        for intCounter := 0 to Length(arrSortedCategories)-1 do
        begin
          pmnuitmTemp:=TMenuItemExtended.Create(pmnuitmAppRightClickCategory);
          pmnuitmTemp.Value:=IntToStr(arrSortedCategories[intCounter]);
          pmnuitmTemp.Caption:=arrAppCategories[arrSortedCategories[intCounter]].DisplayName;
          pmnuitmTemp.OnClick:=pmnuitmAppRightClickCategoryClick;
          pmnuitmTemp.RadioItem:=True;

          // If it's the currently enabled category, enable it's menu option
          if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].CategoryIndex=arrSortedCategories[intCounter] then
            pmnuitmTemp.Checked:=true;

          pmnuitmAppRightClickCategory.Add(pmnuitmTemp);
        end;
        pmnuitmTemp:=TMenuItemExtended.Create(pmnuitmAppRightClickCategory);
        pmnuitmTemp.Value:='-';
        pmnuitmTemp.Caption:='-';
        pmnuitmTemp.OnClick:=pmnuitmAppRightClickCategoryClick;
        pmnuitmAppRightClickCategory.Add(pmnuitmTemp);

        pmnuitmTemp:=TMenuItemExtended.Create(pmnuitmAppRightClickCategory);
        pmnuitmTemp.Value:='+';
        pmnuitmTemp.Caption:=strAddANewCategory;
        pmnuitmTemp.OnClick:=pmnuitmAppRightClickCategoryClick;
        pmnuitmAppRightClickCategory.Add(pmnuitmTemp);

        intSelectedButton:=iControl;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].IsFavorite=true then
          pmnuitmAppRightClickFavorite.Checked:=true
        else
          pmnuitmAppRightClickFavorite.Checked:=false;
        if bolShowHiddenIcons then
          pmnuitmAppRightClickShowHiddenIcons.Checked:=true
        else
          pmnuitmAppRightClickShowHiddenIcons.Checked:=false;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].IsHidden then
          pmnuitmAppRightClickHideFromMenu.Checked:=true
        else
          pmnuitmAppRightClickHideFromMenu.Checked:=false;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].AutoStart then
          pmnuitmAppRightClickAutomaticallyStart.Checked:=true
        else
          pmnuitmAppRightClickAutomaticallyStart.Checked:=false;
        pmnuitmAppRightClickAppName.Caption:=strAppPrefix + ': '+arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].Caption;
        if bolUninstalling then
          pmnuitmAppRightClickUninstall.Enabled:=false
        else
          pmnuitmAppRightClickUninstall.Enabled:=true;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].HomepageURL<>'' then
          pmnuitmAppRightClickWebsite.Enabled:=true
        else
          pmnuitmAppRightClickWebsite.Enabled:=false;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].DonateURL<>'' then
          pmnuitmAppRightClickDonate.Enabled:=true
        else
          pmnuitmAppRightClickDonate.Enabled:=false;
        if arrAppItems[arrMenuItems[iControl+intFirstButton].ListIndex].BaseAppID<>'' then
          pmnuitmAppRightClickPinToTaskbar.Enabled:=true
        else
          pmnuitmAppRightClickPinToTaskbar.Enabled:=false;
        pmnuAppRightClick.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

      end
      else
      begin
        // Right-click a category
        //intSelectedButton:=iControl;
        //Showmessage(arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].DisplayName);
        //if arrAppCategories[arrMenuItems[iControl+intFirstButton].ListIndex].Custom then
        //begin
        //  pmnuitmCategoryRightClickRename.Enabled:=true;
        //  pmnuitmCategoryRightClickDelete.Enabled:=true;
        //end
        //else
        //begin
        //  pmnuitmCategoryRightClickRename.Enabled:=false;
        //  pmnuitmCategoryRightClickDelete.Enabled:=false;
        //end;
        //pmnuCategoryRightClick.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
      end
end;

procedure TfrmMenu.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
// scroll the menu up when the user scrolls the mouse wheel up over the form
begin
  //ScrollApps(true);

end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  if not bolShowTaskbarIcon then
    ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmMenu.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var intCounter: integer;
  intScrollLines: integer;
begin
  intCounter:=0;
  intScrollLines:=GetMouseWheelLines;
  WheelDelta:=WheelDelta*intScrollLines;
  if WheelDelta >0 then
    while WheelDelta > intCounter do begin
      ScrollApps(true);
      inc(intCounter, 120);
    end
  else
    while WheelDelta < intCounter do begin
      ScrollApps(false);
      inc(intCounter, -120);
    end;
  Handled:=true;
end;

procedure TfrmMenu.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
// scroll the menu down when the user scrolls the mouse wheel down over the form
begin
 // ScrollApps(false);
end;

procedure TfrmMenu.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
// catch presses of the up or down arrow as an alternative means of scrolling
var
	intCounter: integer;
begin
//  if (((Key>47) and (Key<91)) or (Key=191)) and (not bolLiveSearchResults) and (not edtDriveName.Visible) and not (ssAlt in Shift) then
  if (Key=vk_F3) and (not edtDriveName.Visible) and not (ssAlt in Shift) then
  begin
    if frmMenu.Showing then
    begin
      if bolHideSearchWhenNotInUse then
        pnlLiveSearchBorder.Visible:=true;

      edtLiveSearch.SetFocus;
      edtLiveSearch.SelStart:=length(edtLiveSearch.Text);
    end;
  end;

  if (Key=VK_LEFT) and bolSecondAppPage and (HiWord(GetKeyState(VK_MENU)) <> 0) then
  begin
    bolSecondAppPage:=false;
    SortButtons();
    DisplayButtons();
  end;

  if (Key=VK_UP ) then
  begin
    ScrollApps(true);
  end
  else if (HiWord(GetKeyState(VK_DOWN)) <> 0) then
    ScrollApps(false)
  else if HiWord(GetKeyState(VK_NEXT)) <> 0 then
  	begin
			for intCounter := 1 to 19 do
			begin
				ScrollApps(false);
				//lblAppButton01.Repaint;
			end;
    end
	else if HiWord(GetKeyState(VK_PRIOR)) <> 0 then
  	begin
			for intCounter := 1 to 19 do
			begin
				ScrollApps(true);
				//lblAppButton01.Repaint;
			end;
		end
  else if (HiWord(GetKeyState(VK_F5)) <> 0) then
    if ssShift in Shift then
      // reload theme goes here
    else
    begin
 		  intFirstButton:=0;
  		ClearButtons();
      SortButtons();

      DisplayButtons();
      frmMenu.Refresh;
      frmMenu.Repaint;
      lblAppButton01.caption:='';
      lblAppButton01.Repaint;

  		SetupButtons();
      SortButtons();
      DisplayButtons();
      if not bolLiveSearchResults then
       RebuildTrayAppIcons();
    end
  else if HiWord(GetKeyState(VK_MENU)) <> 0 then
  begin
    lblButtonDocuments.Caption:=strLabelDocuments;
		lblButtonMusic.Caption:=strLabelMusic;
		lblButtonPictures.Caption:=strLabelPictures;
		lblButtonVideos.Caption:=strLabelVideos;
		lblButtonExplore.Caption:=strLabelExplore;
		lblButtonBackup.Caption:=strLabelBackup;
		lblButtonOptions.Caption:=strLabelOptions;
 		lblButtonManageApps.Caption:=strLabelManageApps;
		lblButtonHelp.Caption:=strLabelHelp;
		lblButtonSearch.Caption:=strLabelSearch;
  end
  else if (HiWord(GetKeyState(VK_ESCAPE)) <> 0) and (not bolLiveSearchResults) then
    FadeInOut(false);
end;

procedure TfrmMenu.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key='/') and (not bolLiveSearchResults) and (not edtDriveName.Visible) then
  begin
    if frmMenu.Showing then
    begin
      if bolHideSearchWhenNotInUse then
        pnlLiveSearchBorder.Visible:=true;
      edtLiveSearch.SetFocus;
      edtLiveSearch.SelStart:=length(edtLiveSearch.Text);
    end;
  end;

end;

procedure TfrmMenu.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

begin
  if (Key=VK_BROWSER_BACK) and bolSecondAppPage then
  begin
    bolSecondAppPage:=false;
    SortButtons();
    DisplayButtons();
  end;
	lblButtonDocuments.Caption:=StringReplace(strLabelDocuments, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonMusic.Caption:=StringReplace(strLabelMusic, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonPictures.Caption:=StringReplace(strLabelPictures, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonVideos.Caption:=StringReplace(strLabelVideos, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonExplore.Caption:=StringReplace(strLabelExplore, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonBackup.Caption:=StringReplace(strLabelBackup, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonOptions.Caption:=StringReplace(strLabelOptions, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonManageApps.Caption:=StringReplace(strLabelManageApps, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonHelp.Caption:=StringReplace(strLabelHelp, '&', '', [rfReplaceAll, rfIgnoreCase]);
	lblButtonSearch.Caption:=StringReplace(strLabelSearch, '&', '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmMenu.ScrollApps(bolScrollUp: Boolean);
// scroll the icon list
begin
  if bolScrollUp then
  begin
    if (intFirstButton > 0) and imgButtonScrollUp.visible then
    begin
      intFirstButton:=intFirstButton-1;
      DisplayButtons();
    end
  end else begin
		if (intFirstButton < (Length(arrMenuItems)-length(arrAppButtonLabels))) and imgButtonScrollDown.visible then
    begin
      intFirstButton:=intFirstButton+1;
      DisplayButtons();
    end;
  end;
  scrollAppList.Position:=intFirstButton;
end;

procedure TfrmMenu.imgBackgroundClick(Sender: TObject);
begin
		edtDriveName.Visible:=false;
		btnChangeDriveName.Visible:=false;
    lblButtonDocuments.Caption:=StringReplace(strLabelDocuments, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonMusic.Caption:=StringReplace(strLabelMusic, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonPictures.Caption:=StringReplace(strLabelPictures, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonVideos.Caption:=StringReplace(strLabelVideos, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonExplore.Caption:=StringReplace(strLabelExplore, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonBackup.Caption:=StringReplace(strLabelBackup, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonOptions.Caption:=StringReplace(strLabelOptions, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonManageApps.Caption:=StringReplace(strLabelManageApps, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonHelp.Caption:=StringReplace(strLabelHelp, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonSearch.Caption:=StringReplace(strLabelSearch, '&', '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmMenu.imgButtonBackupForegroundClick(Sender: TObject);
begin
  //if (mouse.CursorPos.X < self.Left) or (mouse.CursorPos.X > (self.Left + self.Width))  then
  //  pmnuBackup.Popup(self.left + imgButtonBackupForeground.Left, self.top + imgButtonBackupForeground.Top)
  //else
    pmnuBackup.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgButtonDocumentsForegroundClick(Sender: TObject);
begin
	ShellExecute(0,'open', PChar(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName))) + '\Documents\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.imgButtonExploreForegroundClick(Sender: TObject);
begin
  ShellExecute(0,'explore', PChar(ExtractFileDrive(Application.ExeName) + '\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.imgButtonHelpForegroundClick(Sender: TObject);
begin
  pmnuHelp.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgButtonManageAppsForegroundClick(Sender: TObject);
begin
  //frmAppStore.ShowModal;
  if bolShowHiddenIcons then
    pmnuitmManageAppsShowHiddenIcons.Checked:=true
  else
    pmnuitmManageAppsShowHiddenIcons.Checked:=false;
  pmnuManageApps.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgButtonMusicForegroundClick(Sender: TObject);
begin
	ShellExecute(0,'open', PChar(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName))) + '\Documents\Music\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.imgButtonOEMForegroundClick(Sender: TObject);
begin
  pmnuOEM.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgButtonOptionsForegroundClick(Sender: TObject);
var
  bolExpandCategoriesByDefaultOldValue, bolShowAllAppsOld, bolUseCategoriesOld, bolDisableScrollBarOld: boolean;
  intCounter: Integer;
begin
  if frmOptions.Visible = false then
  begin
    // Store old values for comparison
    bolExpandCategoriesByDefaultOldValue:=bolExpandCategoriesByDefault;
    bolShowAllAppsOld:=bolShowAllApps;
    bolUseCategoriesOld:=bolUseCategories;
    bolDisableScrollBarOld:=bolDisableScrollBar;

    bolAnotherFormDisplayed:=true;
    frmOptions.ShowModal;
    bolAnotherFormDisplayed:=false;
    LoadLocale();
    UpdateFreeSpace();
    if bolLargeFonts and (Screen.PixelsPerInch < 100) then
      ChangeMenuFontSize(11)
    else
      ChangeMenuFontSize(9);
    frmMenu.AlphaBlendValue:=intAlphaBlendMain;
    LoadTheme();
    if (bolShowAllAppsOld<>bolShowAllApps) or (bolUseCategoriesOld<>bolUseCategories) or (bolDisableScrollBarOld<>bolDisableScrollBar) then begin
      bolSecondAppPage:=false;
      SortButtons;
    end;
    edtLiveSearch.Text:='';
    DisplayButtons;
    RebuildTrayAppIcons();
    if bolHideSearchWhenNotInUse then
      begin
        pnlLiveSearchBorder.Visible:=false;
        if edtLiveSearch.Focused and frmMenu.Showing then
          SelectNext(edtLiveSearch as TWinControl,True,True);
      end
    else
      pnlLiveSearchBorder.Visible:=true;
    if bolExpandCategoriesByDefaultOldValue <> bolExpandCategoriesByDefault then
      for intCounter := 0 to Length(arrAppCategories)-1 do
        arrAppCategories[intCounter].Expanded:=bolExpandCategoriesByDefault;

    if bolDisableSplashScreens then
      SetEnvironmentVariable(PChar('PortableApps.comDisableSplash'), PChar('true'))
    else
      SetEnvironmentVariable(PChar('PortableApps.comDisableSplash'), PChar('false'));
    SaveSettings;
    if bolHideDesktopIcons then
      ShowDesktopIcons(false)
    else
      ShowDesktopIcons(true);

    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico')) then
    begin
      Application.Icon.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico');
      trayiconMenu.Visible:=false;
      trayiconMenu.Icon.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\TaskbarIcons\PortableApps' + strTaskbarIcon + '.ico');
      trayiconMenu.Visible:=true;
    end;


    SaveSettings;
  end;
end;

procedure TfrmMenu.imgButtonPicturesForegroundClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName))) + '\Documents\Pictures\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.imgButtonScrollDownClick(Sender: TObject);
var
	intCounter: integer;
begin
	for intCounter := 1 to 19 do
	begin
	ScrollApps(false);
	lblAppButton01.Repaint;
	end;
end;

procedure TfrmMenu.imgButtonScrollUpClick(Sender: TObject);
var
	intCounter: integer;
begin
	for intCounter := 1 to 19 do
	begin
	ScrollApps(true);
  lblAppButton01.Repaint;
	end;
	ScrollApps(true);
end;

procedure TfrmMenu.imgButtonSearchForegroundClick(Sender: TObject);
begin
  pmnuSearch.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgButtonVideosForegroundClick(Sender: TObject);
begin
	ShellExecute(0,'open', PChar(ExtractFileDir(ExtractFileDir(ExtractFileDir(Application.ExeName))) + '\Documents\Videos\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.imgCloseClick(Sender: TObject);
// close the application
begin
  bolFadeToExit := true;
  FadeInOut(false);
end;

procedure TfrmMenu.imgCloseMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_pressed.png')) then
  	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_pressed.png')
  else
   	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_pressed.png');
end;

procedure TfrmMenu.imgCloseMouseEnter(Sender: TObject);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_hover.png')) then
  	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_hover.png')
  else
   	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_hover.png');
end;

procedure TfrmMenu.imgCloseMouseLeave(Sender: TObject);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')) then
  	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')
  else
   	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_normal.png');
end;

procedure TfrmMenu.imgCloseMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (X > -1) and (X < imgClose.Width+1) and (Y > -1) and ( Y < imgClose.Height+1) then
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_hover.png')) then
  	  imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_hover.png')
    else
   	  imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_hover.png')
  else
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')) then
  	  imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')
    else
   	  imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_normal.png');
end;

procedure TfrmMenu.imgDragSpaceHiddenDblClick(Sender: TObject);
begin
  LoadTheme();
end;

procedure TfrmMenu.imgDragSpaceHiddenMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure TfrmMenu.imgEjectClick(Sender: TObject);
//var
	//strWindowsPath: string;
begin
	//strWindowsPath:=GetEnvironmentVariable('WINDIR');
	//ShellExecute(0,'open',PChar(strWindowsPath + '\System32\Rundll32.exe'),
  //	PChar('Shell32,Control_RunDLL hotplug.dll'),PChar(strWindowsPath + '\System32'),SW_SHOWNORMAL);
  bolFadeToExit := true;
  bolFadeToEject:= true;
  FadeInOut(false);
end;

procedure TfrmMenu.imgEjectMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_pressed.png')) then
  	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_pressed.png')
  else
   	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_pressed.png');
end;

procedure TfrmMenu.imgEjectMouseEnter(Sender: TObject);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_hover.png')) then
  	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_hover.png')
  else
   	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_hover.png');
end;

procedure TfrmMenu.imgEjectMouseLeave(Sender: TObject);
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')) then
  	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')
  else
   	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_normal.png');
end;

procedure TfrmMenu.imgEjectMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (X > -1) and (X < imgEject.Width+1) and (Y > -1) and ( Y < imgEject.Height+1) then
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_hover.png')) then
    	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_hover.png')
    else
     	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_hover.png')
  else
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')) then
    	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')
    else
     	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_normal.png');
  if Button=mbRight then
    pmnuLeftButton.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmMenu.imgLiveSearchCloseClick(Sender: TObject);
begin
    edtLiveSearch.Text:='';
    bolLiveSearchResults:=false;
    //edtLiveSearch.Visible:=false;
//    edtLiveSearch.Width:=254;
    imgLiveSearchClose.Visible:=false;
    imgLiveSearchIcon.Visible:=true;
    intFirstButton:=0;
    SortButtons;
    DisplayButtons;
    if bolHideSearchWhenNotInUse then
    begin
      pnlLiveSearchBorder.Visible:=false;
      if edtLiveSearch.Focused then
        SelectNext(edtLiveSearch as TWinControl,True,True);
    end
end;

procedure TfrmMenu.imgLogoModClick(Sender: TObject);
begin
//  if imgAnimation.Visible then
//  begin
    imgLogoMod.Visible:=false;
    imgAnimation.Visible:=false;
//  end
  //else
  //begin
    //imgAnimation.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/App/Graphics/Misc/snow.gif');
    //imgAnimation.Visible:=true;
  //end;
end;

procedure TfrmMenu.imgPersonalPictureClick(Sender: TObject);
var
  strTempFileName:string;
begin
  strTempFileName:='';
  opndlgAddApp.Filter:='Personal Picture [48x48] (*.bmp,*.jpg,*.jpeg,*.png)|*.jpg;*.jpeg;*.bmp;*.png';
  if opndlgAddApp.Execute then
  begin
    strTempFileName:=opndlgAddApp.FileName;
  end;
  if strTempFileName<>'' then
  begin
		imgPersonalPicture.Picture.Graphic:=nil;
  	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg');
   	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp');
   	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png');
    if ansiLowerCase(ExtractFileExt(strTempFileName))='.bmp' then
    begin
      CopyFile(PChar(strTempFileName), PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp'), True);
			imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp');
      bolPersonalPictureTransparent:=false;
    end
    else if ansiLowerCase(ExtractFileExt(strTempFileName))='.jpg' then
    begin
      CopyFile(PChar(strTempFileName), PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg'), True);
			imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg');
      bolPersonalPictureTransparent:=false;
    end
    else
    begin
      CopyFile(PChar(strTempFileName), PChar(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png'), True);
			imgPersonalPicture.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png');
      bolPersonalPictureTransparent:=true;
    end;
    bvlPersonalPicture.Visible:=not bolPersonalPictureTransparent;
  end;
end;

procedure TfrmMenu.imgPersonalPictureMouseEnter(Sender: TObject);
begin
	if ((imgPersonalPicture.Picture.Graphic=nil) and (not imgOEMLogoTopRight.Visible)) then
  	bvlPersonalPicture.Visible:=true;
end;

procedure TfrmMenu.imgPersonalPictureMouseLeave(Sender: TObject);
begin
	if (imgPersonalPicture.Picture.Graphic=nil) or bolPersonalPictureTransparent then
  	bvlPersonalPicture.Visible:=false;
end;

procedure TfrmMenu.imgPersonalPictureMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if Button = mbRight then
  begin
		imgPersonalPicture.Picture.Graphic:=nil;
    bvlPersonalPicture.Visible:=false;
   	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.jpg');
   	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.bmp');
   	DeleteFile(ExtractFileDir(Application.ExeName)+'/Data/PersonalPicture.png');
  end;
end;

procedure TfrmMenu.imgPortableAppsLogo2Click(Sender: TObject);
begin
  OpenURL('https://portableapps.com/');
end;

procedure TfrmMenu.lblDriveNameClick(Sender: TObject);
begin
	edtDriveName.Text:=strDriveName;
	edtDriveName.Visible:=true;
  btnChangeDriveName.Visible:=true;
  edtDriveName.SetFocus;
end;

procedure TfrmMenu.lblDriveSpaceClick(Sender: TObject);
begin
	edtDriveName.Text:=strDriveName;
	edtDriveName.Visible:=true;
  btnChangeDriveName.Visible:=true;
  edtDriveName.SetFocus;
end;

procedure TfrmMenu.trayiconMenuClick(Sender: TObject);
// show/hide the menu on a tray icon click
begin
//  if (frmMenu.AlphaBlendValue<>0) and (frmMenu.WindowState<>wsMinimized) then begin
 //   FadeInOut(false);
  //end else begin
  //bolFadeIn keeps track of the Menu's current state

  //end;

end;

procedure TfrmMenu.trayiconMenuMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if bolAlwaysShowPower or (not bolRunningOnRemovableDrive and not bolAlwaysShowEject) then
  begin
    pmnuitmTrayEject.ImageIndex:=40;
    pmnuitmTrayEject.Caption:=strPowerButton
  end
  else
  begin
    pmnuitmTrayEject.ImageIndex:=24;
    pmnuitmTrayEject.Caption:=strEjectButton
  end;
  if bolFadeIn then
    FadeInOut(false)
  else if button<>mbRight then
    FadeInOut(true);
end;

procedure TfrmMenu.UpdateFreeSpace();

begin
  LogWrite('Info', Self.Name, 'Calculating drive free space');

    // calculate and display the drive size
    if Length(ExtractFileDrive(Application.ExeName))>2 then begin
      // Network drive
      lblDriveSpace.Caption:= lblDriveName.Caption;
      lblDriveSpaceShadow.Caption:=lblDriveSpace.Caption;
      trayiconMenu.Hint:='PortableApps.com Platform' + #13#10 + lblDriveName.Caption;
      imgDriveSpace.Width:=intDriveSpaceWidth;
    end
    else
    begin
      dblDriveSize := DiskSize(Ord(Application.ExeName[1]) - $40) div 1024;
      if dblDriveSize > 1048576 then
        if (dblDriveSize/1048576)<100 then
          strDriveSize := FloatToStrF((dblDriveSize/1048576), ffFixed, 4, 1) + strGB
        else
          strDriveSize := FloatToStrF((dblDriveSize/1048576), ffFixed, 4, 0) + strGB
      else
          if dblDriveSize > 1024 then
            if (dblDriveSize/1024)<100 then
              strDriveSize := FloatToStrF((dblDriveSize/1024), ffFixed, 4, 1) + strMB
            else
              strDriveSize := FloatToStrF((dblDriveSize/1024), ffFixed, 4, 0) + strMB
          else
            if dblDriveSize<100 then
              strDriveSize := FloatToStrF((dblDriveSize), ffFixed, 4, 1) + strKB
            else
              strDriveSize := FloatToStrF((dblDriveSize), ffFixed, 4, 0) + strKB;

      dblDriveFree := DiskFree(Ord(Application.ExeName[1]) - $40) div 1024;
      dblDriveUsed := dblDriveSize - dblDriveFree;

      if dblDriveFree > 1048576 then
        if (dblDriveFree/1048576)<100 then
          strDriveFree := FloatToStrF((dblDriveFree/1048576), ffFixed, 4, 1) + strGB
        else
          strDriveFree := FloatToStrF((dblDriveFree/1048576), ffFixed, 4, 0) + strGB
      else
          if dblDriveUsed > 1024 then
            if (dblDriveFree/1024)<100 then
              strDriveFree := FloatToStrF((dblDriveFree/1024), ffFixed, 4, 1) + strMB
            else
              strDriveFree := FloatToStrF((dblDriveFree/1024), ffFixed, 4, 0) + strMB
          else
            if dblDriveFree<100 then
              strDriveFree := FloatToStrF((dblDriveFree), ffFixed, 4, 1) + strKB
            else
              strDriveFree := FloatToStrF((dblDriveFree), ffFixed, 4, 0) + strKB;

      lblDriveSpace.Caption:= lblDriveName.Caption + ' ' + StringReplace(StringReplace(strDriveSpace, '$DRIVEFREE', strDriveFree, []), '$DRIVETOTAL', strDriveSize, []);
      lblDriveSpaceShadow.Caption:=lblDriveSpace.Caption;
      trayiconMenu.Hint:='PortableApps.com Platform' + #13#10 + lblDriveName.Caption;
      imgDriveSpace.Width:=round(dblDriveUsed/dblDriveSize*intDriveSpaceWidth);
    end;
end;

procedure TfrmMenu.FadeInOut(bolFadeInNow: Boolean);
// fade the menu in or out and recalculate the drive size on a fade in
begin
  if bolFadeInNow then begin
    // position at the bottom right with space for the shadow
    //Top:= Screen.WorkAreaRect.Bottom-Height-4;
    //Left:= Screen.WorkAreaRect.Right-Width-4;

    UpdateFreeSpace;

   	lblButtonDocuments.Caption:=StringReplace(strLabelDocuments, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonMusic.Caption:=StringReplace(strLabelMusic, '&', '', [rfReplaceAll, rfIgnoreCase]);
	  lblButtonPictures.Caption:=StringReplace(strLabelPictures, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonVideos.Caption:=StringReplace(strLabelVideos, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonExplore.Caption:=StringReplace(strLabelExplore, '&', '', [rfReplaceAll, rfIgnoreCase]);
	  lblButtonBackup.Caption:=StringReplace(strLabelBackup, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonOptions.Caption:=StringReplace(strLabelOptions, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonManageApps.Caption:=StringReplace(strLabelManageApps, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonHelp.Caption:=StringReplace(strLabelHelp, '&', '', [rfReplaceAll, rfIgnoreCase]);
  	lblButtonSearch.Caption:=StringReplace(strLabelSearch, '&', '', [rfReplaceAll, rfIgnoreCase]);

    // fade in now
    bolFadeIn:= True;
    tmrFader.Enabled:= True;
    if bolShowTaskbarIcon then
    begin
      Application.Restore;
      frmMenu.show;
    end
    else
      frmMenu.Show;
    if frmMenu.Showing then
    begin
      frmMenu.SetFocus;
      if pnlLiveSearchBorder.Visible then
        edtLiveSearch.SetFocus;
    end;
		SetActiveWindow(Handle);
		SetForegroundWindow(Handle);
  end else begin // fade the menu out
    bolFadeIn:= False;
    tmrFader.Enabled:= True;
    edtDriveName.Visible:=false;
    btnChangeDriveName.Visible:=false;
  end;
end;

procedure TfrmMenu.tmrWatchFocusTimer(Sender: TObject);
begin
  if (frmMenu.AlphaBlendValue<>0) and (not bolMenuBusy) then
    if (getFocus() = 0) and (not bolRemainVisible) and (not bolAnotherFormDisplayed) then FadeInOut(False);
end;

procedure TfrmMenu.tmrFaderTimer(Sender: TObject);
// adjust the alpha values to fade the menu in or out
//var
  //regControlPanel: TRegIniFile;
  //strDriveLetter: string;
var
  intCounter2: integer;
begin
  if bolFadeIn then
  begin
    if frmMenu.WindowState=wsMinimized then
      Application.Restore;
    if ((frmMenu.AlphaBlendValue + 30) < intAlphaBlendMain) and bolFadeMenu then
 	  begin
     	frmMenu.AlphaBlendValue := frmMenu.AlphaBlendValue + 30;
    end else begin
 	    frmMenu.AlphaBlendValue := intAlphaBlendMain;
   	  tmrFader.Enabled:= False;
    end;
  end else begin
    if (frmMenu.AlphaBlendValue > 30) and bolFadeMenu then
    begin
      frmMenu.AlphaBlendValue := frmMenu.AlphaBlendValue - 30;
    end else begin
      if bolShowTaskbarIcon then
      begin
        Application.Minimize;
      end
      else
      begin
        frmMenu.AlphaBlendValue := 0;
        frmMenu.Hide;
      end;
      tmrFader.Enabled:= False;
      if bolFadeToExit then // Exit the app on fade out if set to
      begin
        Close;
      end;
      if bolCollapseCategoriesOnMinimize and bolInitializationComplete then begin
        for intCounter2:=0 to Length(arrAppCategories)-1 do begin
          arrAppCategories[intCounter2].Expanded:=false;
          end;
        sortbuttons();
        displaybuttons();
      end;
    end;
  end;
end;

procedure TfrmMenu.tmrShowAppIconsTimer(Sender: TObject);
var
  stringsAutoStart: TStrings;
  strOptions: string;
  iniSettingsFile: TINIFile;
  intCounter: integer;
  bolResult: boolean;
begin
  tmrShowAppIcons.Enabled:=false;
	SetupButtons;
  SortButtons;
	DisplayButtons;
  RebuildTrayAppIcons();

  //if btnAppButton01.Visible and (frmMenu.Showing) then
    //btnAppButton01.SetFocus;


  if (frmMenu.Showing) then
  begin
    if bolHideSearchWhenNotInUse then
    begin
      if btnAppButton01.Enabled then
      begin
        btnAppButton01.SetFocus;
        AppButtonEnter(btnAppButton01);
      end
      else
        btnDocuments.SetFocus;
        AppButtonMouseEnter(imgButtonDocumentsForeground);
    end
    else
      edtLiveSearch.SetFocus;
  end;

    if strLastVersion <> APPVERSION then
  begin
    bolHelpWhatsNew:=true;
    bolAnotherFormDisplayed:=true;
  	frmAbout.ShowModal;
  	bolAnotherFormDisplayed:=false;
    strLastVersion:= APPVERSION;
    SaveSettings;
  end;

  if length(arrMenuItems)=0 then
    GetMoreAppsClick(nil)
  else
  begin
    if bolUpdateAutomatically then
    begin


      strOptions:='/STARTUP=true /MODE=UPDATE';

      if bolShowUpdaterStarupErrors then
        strOptions:=strOptions + ' /STARTUPSHOWERRORS=true';

      if bolKeyboardFriendly then
        strOptions:=strOptions + ' /KEYBOARDFRIENDLY=true'
      else
        strOptions:=strOptions + ' /KEYBOARDFRIENDLY=false';

      if bolHidePortableInAppNames then
        strOptions:=strOptions + ' /HIDEPORTABLE=true'
      else
        strOptions:=strOptions + ' /HIDEPORTABLE=false';

      if bolBetaPlatformReleases then
        strOptions:=strOptions + ' /BETA=true'
      else
        strOptions:=strOptions + ' /BETA=false';

      if strConnectionType='Automatic' then
        strOptions:=strOptions + ' /CONNECTION=Automatic';
      if strConnectionType='Direct' then
        strOptions:=strOptions + ' /CONNECTION=Direct';
      if strConnectionType='Proxy' then
      begin
        strOptions:=strOptions + ' /CONNECTION=Proxy';
        strOptions:=strOptions + ' /PROXYIP=' + strConnectionProxyIP;
        strOptions:=strOptions + ' /PROXYPORT=' + strConnectionProxyPort;
      end;

      ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\PortableAppsUpdater.exe'), PChar(strOptions), Nil, SW_SHOWNORMAL);
    end;
  end;

    // Autorun apps
   if HiWord(GetKeyState(VK_SHIFT)) = 0 then begin
    stringsAutoStart := TStringList.Create;
    iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
    try
      if iniSettingsFile.SectionExists('AppsAutoStart') then
      begin
        iniSettingsFile.ReadSection('AppsAutoStart',stringsAutoStart);
        if ((stringsAutoStart.Count > 0) and not bolOpeningFromPlatformUpdate) then
          for intCounter := 0 to stringsAutoStart.Count-1 do
          begin
            if FileExists(PChar(strPortableAppsPath+'\'+stringsAutoStart[intCounter])) then
              StartPortableApp(strPortableAppsPath+'\'+stringsAutoStart[intCounter], ExtractFileDir(strPortableAppsPath+'\'+stringsAutoStart[intCounter]), false, '');
         end;
      end;
    finally
      FreeAndNil(iniSettingsFile);
    end;
    FreeAndNil(stringsAutoStart);
   end;
     bolInitializationComplete:=True;



  // Check autorun.inf for changes
  if bolAutoRunProtection then begin
    bolResult:=FilesTheSame(PChar(Trim(ExtractFileDrive(Application.ExeName))+'\autorun.inf'),PChar(ExtractFileDir(Application.ExeName) + '\Data\autorun.inf.backup'));
    if not bolResult then
    begin
      bolAnotherFormDisplayed:=true;
      Application.MessageBox(PChar(strAutoRunChangeWarning),PChar(strAutoRunChangeWarningTitle),MB_ICONEXCLAMATION);
      bolAnotherFormDisplayed:=false;
    end;

    DeleteFile(PChar(ExtractFileDir(Application.ExeName) + '\Data\autorun.inf.backup'));
    if FileExists(PChar(Trim(ExtractFileDrive(Application.ExeName))+'\autorun.inf')) then
      CopyFile(PChar(Trim(ExtractFileDrive(Application.ExeName))+'\autorun.inf'),PChar(ExtractFileDir(Application.ExeName) + '\Data\autorun.inf.backup'),true);
  end;

end;

procedure TfrmMenu.pmnuitmAppRightClickAddToStartClick(Sender: TObject);
var
  strAppRunString: String;
  strBaseAppID: String;
  strLinkName: String;
  strPortableLinkDirectory: String;
  strStartLinkCreatedMessage: WideString;
  FilePath: array [0..MAX_PATH] of char;
begin
  if (Sender is TMenuItemExtended) then
    begin
      strAppRunString:=arrAppItems[TMenuItemExtended(Sender).Tag].CommandLine;
      strBaseAppID:=arrAppItems[TMenuItemExtended(Sender).Tag].BaseAppID;
      strLinkName:=arrAppItems[TMenuItemExtended(Sender).Tag].Caption;
    end
  else
    begin
      strAppRunString:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine;
      strBaseAppID:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].BaseAppID;
      strLinkName:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Caption;
    end;

  strBaseAppID:=ExpandEnvStrings(strBaseAppID);
  SHGetFolderPath(0, CSIDL_STARTMENU, 0, 0, FilePath);
  strPortableLinkDirectory:=FilePath;

  if not DirectoryExists(strPortableLinkDirectory) then
    MkDir(strPortableLinkDirectory);

  DeleteFile(strPortableLinkDirectory + '\' + strLinkName + '.lnk');
  if strBaseAppID<>'' then
    ShellExecute(0, nil, PChar(strPortableAppsPath + '\PortableApps.com\App\bin\mkshortcut.exe'), PChar('-output "' + strPortableLinkDirectory + '\' + strLinkName + '.lnk" -target "' + strAppRunString + '" -appid "' + strBaseAppID + '"'), nil, SW_HIDE)
  else
    ShellExecute(0, nil, PChar(strPortableAppsPath + '\PortableApps.com\App\bin\mkshortcut.exe'), PChar('-output "' + strPortableLinkDirectory + '\' + strLinkName + '.lnk" -target "' + strAppRunString + '"'), nil, SW_HIDE);

  strStartLinkCreatedMessage:=stringreplace(strStartLinkCreated, '%SHORTCUTNAME%', strLinkName, [rfReplaceAll, rfIgnoreCase]);
  bolAnotherFormDisplayed:=true;
  Application.MessageBox(PCHAR(strStartLinkCreatedMessage),'PortableApps.com Platform',MB_ICONINFORMATION);
  bolAnotherFormDisplayed:=false;

  if ((not bolRemainVisible)) then FadeInOut(False);

  if not bolSecondAppPage and not bolShowAllApps then
  begin
    SortButtons;
    DisplayButtons;
  end;
end;

procedure TfrmMenu.pmnuitmAppRightClickAutomaticallyStartClick(Sender: TObject);
var
  iniSettingsFile: TINIFile;
  strAppPath: string;
begin
  iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  strAppPath:=RightStr(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine,Length(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'));

  if arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].AutoStart then
  begin
    iniSettingsFile.DeleteKey('AppsAutoStart', MakePathIntoINIKey(strAppPath));
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].AutoStart:=false;
  end
  else
  begin
    iniSettingsFile.WriteBool('AppsAutoStart',MakePathIntoINIKey(strAppPath),True);
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].AutoStart:=true;
  end;
  DisplayButtons;
	iniSettingsFile.UpdateFile;
	FreeAndNil(iniSettingsFile);
end;

procedure TfrmMenu.pmnuitmAppRightClickCategoryClick(Sender: TObject);
var
  iniSettingsFile: TINIFile;
  strAppPath: string;
  strPassedValue: string;
  intCounter: integer;
  bolAddNewCategory: boolean;
begin
  //Get the locale name from the menu caption
  strPassedValue:=TMenuItemExtended(Sender).Value;
  if strPassedValue='+' then
  begin
    //Add a new category and set it here
      frmRenameMenuItem.bolAddCategory:=true;
      frmRenameMenuItem.Caption:=strAddANewCategory;
    	frmRenameMenuItem.strOriginalName:='';
    	frmRenameMenuItem.strCustomName:='';
      frmRenameMenuItem.btnOK.Caption:=strOK;
      frmRenameMenuItem.btnCancel.Caption:=strCancel;
      bolAnotherFormDisplayed:=true;
    	frmRenameMenuItem.ShowModal;
    	bolAnotherFormDisplayed:=false;
      bolAddNewCategory:=true;
    	if frmRenameMenuItem.strCustomName<>'' then
      begin
        // Loop through the existing categories for a match
        for intCounter:=0 to Length(arrAppCategories)-1 do
          if arrAppCategories[intCounter].DisplayName=frmRenameMenuItem.strCustomName then begin
            bolAddNewCategory:=false;
            strPassedValue:=IntToStr(intCounter);
          end;

        // Add the category
        if bolAddNewCategory then begin
          SetLength(arrAppCategories,Length(arrAppCategories)+1);
          arrAppCategories[Length(arrAppCategories)-1]:=TCategoryListItem.Create(frmRenameMenuItem.strCustomName);
          strPassedValue:=IntToStr(Length(arrAppCategories)-1);
        end;
      end
      else
        strPassedValue:='-';
  end;
  if strPassedValue<>'-' then
  begin
    	if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
        // Create the Data directory if it is missing
        ForceDirectories(PChar(ExtractFileDir(Application.ExeName) + '\Data'));
      end;
			iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
      strAppPath:=RightStr(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine,Length(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'));

      if arrAppCategories[StrToInt(strPassedValue)].InternalName=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].InternalCategory then
        iniSettingsFile.DeleteKey('AppsRecategorized', MakePathIntoINIKey(strAppPath))
      else
  			iniSettingsFile.WriteString('AppsRecategorized',MakePathIntoINIKey(strAppPath),arrAppCategories[StrToInt(strPassedValue)].InternalName);
      arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CategoryIndex:=StrToInt(strPassedValue);
   		FreeAndNil(iniSettingsFile);
      SortButtons();
      DisplayButtons();
      if not bolLiveSearchResults then
        RebuildTrayAppIcons();
  end;


  //strLocale:=StringReplace(TMenuItemExtended(Sender).Caption, '&', '', [rfReplaceAll, rfIgnoreCase]);
  //TMenuItemExtended(Sender).Checked:=true;
  // ShowMessage(strLocale);
  //LoadLocale();
end;

procedure TfrmMenu.pmnuitmAppRightClickDonateClick(Sender: TObject);
begin
OpenURL(PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].DonateURL));
end;

procedure TfrmMenu.pmnuitmAppRightClickExploreHereClick(Sender: TObject);
begin
	ShellExecute(0,'open', PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory+#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmAppRightClickHelpClick(Sender: TObject);
begin
//  ShowMessage ('file:///' + PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory + '/help.html'));
  OpenURL('file:///' + PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory + '/help.html'));
end;

procedure TfrmMenu.pmnuitmAppRightClickHideFromMenuClick(Sender: TObject);
var
  iniSettingsFile: TINIFile;
  strAppPath: string;
  intCounter, intAppCount: integer;
begin
  iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  strAppPath:=RightStr(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine,Length(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'));

  if arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].IsHidden then
  begin
    iniSettingsFile.DeleteKey('AppsHidden', MakePathIntoINIKey(strAppPath));
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].IsHidden:=false;
  end
  else
  begin
    iniSettingsFile.DeleteKey('AppsRenamed', MakePathIntoINIKey(strAppPath));
    iniSettingsFile.WriteString('AppsHidden',MakePathIntoINIKey(strAppPath),'true');
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].IsHidden:=true;

    if not bolShowHiddenIcons then
    begin
      intAppCount:=Length(arrAppItems);
      arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Icon.Destroy;
      if (arrMenuItems[intSelectedButton+intFirstButton].ListIndex)<intAppCount then
        for intCounter:= (arrMenuItems[intSelectedButton+intFirstButton].ListIndex) + 1 to intAppCount - 1 do
        begin
          arrAppItems[intCounter - 1] := arrAppItems[intCounter];
        end;
      SetLength(arrAppItems, intAppCount - 1);
      if intFirstButton>1 then
        intFirstButton:=intFirstButton-1;
    	SortButtons;
    end;
  end;
  DisplayButtons;
  if not bolLiveSearchResults then
    RebuildTrayAppIcons();
	iniSettingsFile.UpdateFile;
	FreeAndNil(iniSettingsFile);
end;

procedure TfrmMenu.pmnuitmAppRightClickPinToTaskbarClick(Sender: TObject);
var
  strAppRunString: String;
  strBaseAppID: String;
  strLinkName: String;
  strPortableLinkDirectory: String;
  strTaskbarLinkCreatedMessage: WideString;
  FilePath: array [0..MAX_PATH] of char;
begin
  if (Sender is TMenuItemExtended) then
    begin
      strAppRunString:=arrAppItems[TMenuItemExtended(Sender).Tag].CommandLine;
      strBaseAppID:=arrAppItems[TMenuItemExtended(Sender).Tag].BaseAppID;
      strLinkName:=arrAppItems[TMenuItemExtended(Sender).Tag].Caption;
    end
  else
    begin
      strAppRunString:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine;
      strBaseAppID:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].BaseAppID;
      strLinkName:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Caption;
    end;

  strBaseAppID:=ExpandEnvStrings(strBaseAppID);
  strPortableLinkDirectory:=GetEnvironmentVariable('USERPROFILE') + '\PortableApps.comTaskbarShortcuts';
  if (Win32BuildNumber>21900) then
  begin
    SHGetFolderPath(0, CSIDL_STARTMENU, 0, 0, FilePath);
    strPortableLinkDirectory:=FilePath;
  end;

  if not DirectoryExists(strPortableLinkDirectory) then
    MkDir(strPortableLinkDirectory);

  DeleteFile(strPortableLinkDirectory + '\' + strLinkName + '.lnk');

  if strBaseAppID='NOT-NEEDED' then
    ShellExecute(0, nil, PChar(strPortableAppsPath + '\PortableApps.com\App\bin\mkshortcut.exe'), PChar('-output "' + strPortableLinkDirectory + '\' + strLinkName + '.lnk" -target "' + strAppRunString + '"'), nil, SW_HIDE)
  else
    ShellExecute(0, nil, PChar(strPortableAppsPath + '\PortableApps.com\App\bin\mkshortcut.exe'), PChar('-output "' + strPortableLinkDirectory + '\' + strLinkName + '.lnk" -target "' + strAppRunString + '" -appid "' + strBaseAppID + '"'), nil, SW_HIDE);


  if (Win32BuildNumber>21900) then
    strTaskbarLinkCreatedMessage:=stringreplace(strTaskbarLinkCreatedWin11, '%SHORTCUTNAME%', strLinkName, [rfReplaceAll, rfIgnoreCase])
  else
    strTaskbarLinkCreatedMessage:=stringreplace(strTaskbarLinkCreated, '%SHORTCUTNAME%', strLinkName + '.lnk', [rfReplaceAll, rfIgnoreCase]);
  bolAnotherFormDisplayed:=true;
  Application.MessageBox(PCHAR(strTaskbarLinkCreatedMessage),'PortableApps.com Platform',MB_ICONINFORMATION);
  bolAnotherFormDisplayed:=false;

  if (Win32BuildNumber<=21900) then
    ShellExecute(0,'open', PChar(strPortableLinkDirectory+#0), Nil, Nil, SW_SHOWNORMAL);

  if ((not bolRemainVisible)) then FadeInOut(False);

  if not bolSecondAppPage and not bolShowAllApps then
  begin
    SortButtons;
    DisplayButtons;
  end;

end;

procedure TfrmMenu.pmnuitmAppRightClickWebsiteClick(Sender: TObject);
begin
OpenURL(PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].HomepageURL));
end;

procedure TfrmMenu.pmnuitmAppRightClickFavoriteClick(Sender: TObject);
var
  strAppPath: string;
  iniSettingsFile: TINIFile;
begin
  iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  strAppPath:=RightStr(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine,Length(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'));
  if pmnuitmAppRightClickFavorite.Checked=false then
  begin
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].IsFavorite:=true;
    iniSettingsFile.WriteBool('AppsFavorite',MakePathIntoINIKey(strAppPath),true);
  end
  else
  begin
    arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].IsFavorite:=false;
    iniSettingsFile.DeleteKey('AppsFavorite',MakePathIntoINIKey(strAppPath));
  end;
  SortButtons;
	DisplayButtons;
  if not bolLiveSearchResults then
    RebuildTrayAppIcons();
	iniSettingsFile.UpdateFile;
	FreeAndNil(iniSettingsFile);
end;

procedure TfrmMenu.pmnuitmAppRightClickRefreshClick(Sender: TObject);
begin
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
end;

procedure TfrmMenu.pmnuitmAppRightClickRenameClick(Sender: TObject);
var
  strOriginalName, strAppPath: string;
  iniSettingsFile: TINIFile;
begin
  strOriginalName:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Caption;
  frmRenameMenuItem.bolAddCategory:=false;
	frmRenameMenuItem.strOriginalName:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].DefaultName;
	frmRenameMenuItem.strCustomName:=strOriginalName;
  frmRenameMenuItem.btnOK.Caption:=strOK;
  frmRenameMenuItem.btnCancel.Caption:=strCancel;
  bolAnotherFormDisplayed:=true;
	frmRenameMenuItem.ShowModal;
	bolAnotherFormDisplayed:=false;
	if strOriginalName<>frmRenameMenuItem.strCustomName then
	begin
		iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
    strAppPath:=RightStr(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine,Length(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'));
		if frmRenameMenuItem.strCustomName='' then
    begin
		  // Reset to original name
			arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Caption:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].DefaultName;
      iniSettingsFile.DeleteKey('AppsRenamed', MakePathIntoINIKey(strAppPath));
    end
    else
		begin
		  arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].Caption:=frmRenameMenuItem.strCustomName;
			iniSettingsFile.WriteString('AppsRenamed',MakePathIntoINIKey(strAppPath),frmRenameMenuItem.strCustomName);
    end;
		SortButtons;
		DisplayButtons;
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
		iniSettingsFile.UpdateFile;
		FreeAndNil(iniSettingsFile);
  end;
end;

procedure TfrmMenu.pmnuitmAppRightClickRunAsAdminClick(Sender: TObject);
var
  bolAppRun: boolean;
begin
  arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun+1;



	bolAppRun:=StartPortableApp(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine, arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory, true, arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].DotNetVersion);

   if ((not bolRemainVisible) and bolAppRun) then FadeInOut(False);

  if not bolSecondAppPage and not bolShowAllApps then
  begin
    SortButtons;
    DisplayButtons;
  end;
end;

procedure TfrmMenu.pmnuitmAppRightClickRunClick(Sender: TObject);
var
  bolAppRun: boolean;
begin
//	ShellExecute(0,'open', PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine+#0),Nil, PChar(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory+#0), SW_SHOWNORMAL);
//  arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun+1;
  if (Sender is TMenuItemExtended) then
    begin
      arrAppItems[TMenuItemExtended(Sender).Tag].TimesRun := arrAppItems[TMenuItemExtended(Sender).Tag].TimesRun +1;
      bolAppRun:=StartPortableApp(arrAppItems[TMenuItemExtended(Sender).Tag].CommandLine, arrAppItems[TMenuItemExtended(Sender).Tag].WorkingDirectory, false, arrAppItems[TMenuItemExtended(Sender).Tag].DotNetVersion);
    end
  else
    begin
      arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].TimesRun+1;
      bolAppRun:=StartPortableApp(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].CommandLine, arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory, false, arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].DotNetVersion);
    end;

  if ((not bolRemainVisible) and bolAppRun) then FadeInOut(False);

  if not bolSecondAppPage and not bolShowAllApps then
  begin
    SortButtons;
    DisplayButtons;
  end;
end;

procedure TfrmMenu.pmnuitmAppRightClickShowHiddenIconsClick(Sender: TObject);
begin
  if bolShowHiddenIcons then
  begin
    bolShowHiddenIcons:=false;
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
  end
  else
  begin
    bolShowHiddenIcons:=true;
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
  end;
end;

procedure TfrmMenu.pmnuitmAppRightClickUninstallClick(Sender: TObject);
var
  //FileOpStruct : TShFileOpStruct;
  bolResult: boolean;
  strAppNameDoubleAmpersand: string;
  strAppNameSingleAmpersand: string;
begin
  if not bolUninstalling then
  begin
    bolUninstalling:=true;
    strAppNameSingleAmpersand:=arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].PortableAppName;
    strAppNameDoubleAmpersand:=StringReplace(strAppNameSingleAmpersand,'&','&&',[rfReplaceAll, rfIgnoreCase]);
    frmDialog.strTitle:=StringReplace(strUninstallTitle,'%APPNAME%',strAppNameSingleAmpersand,[rfReplaceAll, rfIgnoreCase]);
    frmDialog.strMessage:=strUninstallMessage;
    frmDialog.strMessage:=frmDialog.strMessage+#13#10+#13#10+arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory;
    frmDialog.strMessage:=frmDialog.strMessage+#13#10+#13#10+StringReplace(strUninstallQuestion,'%APPNAME%',strAppNameDoubleAmpersand,[rfReplaceAll, rfIgnoreCase]);
    frmDialog.strIconType:='WARNING';
    frmDialog.bolButtons:=true;
    frmDialog.strButtonOK:=strYes;
    frmDialog.strButtonCancel:=strNo;
    frmDialog.ShowModal;
    if frmDialog.strButton='OK' then
    begin
      //FileOpStruct.Wnd := Application.Handle;
      //FileOpStruct.wFunc := FO_DELETE;
      //FileOpStruct.fFlags := FOF_NOCONFIRMATION + FOF_NOERRORUI;
      //FileOpStruct.pFrom := PChar(arrAppItems[intSelectedButton+intFirstButton].WorkingDirectory+ #0);
      //FileOpStruct.pTo := nil;
      //FileOpStruct.fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
      frmDialog.strIconType:='UNINSTALL';
      frmDialog.bolButtons:=false;
      frmDialog.strTitle:=StringReplace(strUninstallingTitle,'%APPNAME%',strAppNameSingleAmpersand,[rfReplaceAll, rfIgnoreCase]);
      frmDialog.strMessage:=StringReplace(strUninstallingMessage,'%APPNAME%',strAppNameDoubleAmpersand,[rfReplaceAll, rfIgnoreCase]);
      frmDialog.Show;
      frmDialog.Repaint;
      bolResult:=DeleteDirectoryTree(arrAppItems[arrMenuItems[intSelectedButton+intFirstButton].ListIndex].WorkingDirectory);
      //bolResult := (ShFileOperation(FileOpStruct) = 0);
      frmDialog.Close;
      if not bolResult then
        ShowMessage(StringReplace(strUninstallFailMessage,'%APPNAME%',strAppNameDoubleAmpersand,[rfReplaceAll, rfIgnoreCase]))
      else
      begin
        intFirstButton:=0;
        ClearButtons();
        SetupButtons();
        SortButtons();
        DisplayButtons();
        if not bolLiveSearchResults then
          RebuildTrayAppIcons();
      end;
      frmDialog.Close;
      frmDialog.Destroy;
      frmDialog:=TfrmDialog.Create(nil);
    end;
    bolUninstalling:=false;
  end;
end;

procedure TfrmMenu.pmnuitmBackupBackupClick(Sender: TObject);
// Start PortableApps Backup
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsBackup.ini')) then
    CopyFile(PChar(ExtractFileDir(Application.ExeName) + '\App\Default\PortableAppsBackup.ini'), PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsBackup.ini'), true);
  ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\PortableAppsBackup.exe'), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmHelpAboutClick(Sender: TObject);
begin
  // Refresh .Net versions in case of an install after platform start
  CheckDotNetVersions;
	bolAnotherFormDisplayed:=true;
	frmAbout.ShowModal;
	bolAnotherFormDisplayed:=false;
end;

procedure TfrmMenu.pmnuitmHelpDonateClick(Sender: TObject);
begin
  OpenURL('https://portableapps.com/donate');
end;

procedure TfrmMenu.pmnuitmHelpFacebookClick(Sender: TObject);
begin
  OpenURL('https://facebook.com/portableapps');
end;

procedure TfrmMenu.pmnuitmHelpLinkedInClick(Sender: TObject);
begin
  OpenURL('https://www.linkedin.com/company/portableapps/');
end;

procedure TfrmMenu.pmnuitmHelpPortableAppsSupportClick(Sender: TObject);
begin
  OpenURL('https://portableapps.com/support');
end;

procedure TfrmMenu.pmnuitmHelpTwitterClick(Sender: TObject);
begin
  OpenURL('https://twitter.com/portableapps');
end;

procedure TfrmMenu.pmnuitmHelpUpdateClickClick(Sender: TObject);
begin
	pmnuitmManageAppsUpdateClick(Sender);
end;

procedure TfrmMenu.pmnuitmBackupRestoreClick(Sender: TObject);
// Start PortableApps Backup - Restore
begin
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsBackup.ini')) then
    CopyFile(PChar(ExtractFileDir(Application.ExeName) + '\App\Default\PortableAppsBackup.ini'), PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsBackup.ini'), true);
  ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\PortableAppsBackupRestore.exe'), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmOEMCustom1Click(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=custom1&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMCustom2Click(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=custom2&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMCustom3Click(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=custom3&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMFacebookClick(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=facebook&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMGooglePlusClick(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=facebook&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMHomepageClick(Sender: TObject);
begin
  OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=home&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMStoreClick(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=store&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMSupportClick(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=support&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOEMTwitterClick(Sender: TObject);
begin
	OpenURL('https://portableapps.com/oem/?oem='+strOEM+'&lang='+IntToStr(intLocaleID)+'&link=twitter&oem_icon_name='+strOEMIconName);
end;

procedure TfrmMenu.pmnuitmOptionsAddAppClick(Sender: TObject);
// Add an app
var
	//strInstallerPath: string;
	strPortableAppsInstallerVersion: string;
	procInstaller: TProcessInformation;
	startInstaller: TStartupInfo;
	ptrFileInfo: pointer;
	lngFileInfoSize: Longint;
	dwdFileInfoLength: DWORD;
	ptrFileInfoLanguage : Pointer;
	ptrFileInfoData: Pointer;
	strFileInfoQuery: String;
	uintFileInfoDataLength: Uint;
	bolWaitForInstaller: boolean;
begin
	strAppToInstall:='';
	opndlgAddApp.Filter:='PortableApps.com Format (*.paf.exe)|*.paf.exe';

  bolAnotherFormDisplayed:=true;
	if opndlgAddApp.Execute then
	begin
		frmMenu.strAppToInstall:=opndlgAddApp.FileName;
	end;
    bolAnotherFormDisplayed:=false;
	if ((strAppToInstall<>'') and FileExists(strAppToInstall)) then
	begin
		lngFileInfoSize:=GetFileVersionInfoSize(PChar(strAppToInstall), dwdFileInfoLength);
		if (lngFileInfoSize > 0) then
		begin
			GetMem(ptrFileInfo, lngFileInfoSize);
			try
			// Check if the current app has a PortableApps.comInstallerVersion
				if GetFileVersionInfo(PChar(strAppToInstall), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
				begin
					strFileInfoQuery:='PortableApps.comInstallerVersion';
					if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
						strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
					if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
						strPortableAppsInstallerVersion:=strPas(PChar(ptrFileInfoData));
				end;
			finally
				FreeMem(ptrFileInfo, lngFileInfoSize);
			end;
		end;

		if strPortableAppsInstallerVersion<>'' then
			if CompareVersions(strPortableAppsInstallerVersion,'0.12.3.0')=1 then
				bolWaitForInstaller:=false
			else
				bolWaitForInstaller:=true
		else
			bolWaitForInstaller:=true;

		if bolWaitForInstaller then
		begin
			// Wait for installer
			frmMenu.Enabled:=false;
			FillChar(procInstaller, sizeof(TProcessInformation), 0);
			FillChar(startInstaller, sizeof(TStartupInfo), 0);
			startInstaller.cb := sizeof(TStartupInfo);
			if CreateProcess(nil, PChar('"' + strAppToInstall + '" -o"' + strPortableAppsPath + '\" -y -/SILENT=YES /DESTINATION="' + strPortableAppsPath+'\"'+#0), nil,
				nil, false, NORMAL_PRIORITY_CLASS, nil, nil,
				startInstaller, procInstaller) <> False then
			begin
				WaitForSingleObject(procInstaller.hProcess, INFINITE);
				CloseHandle(procInstaller.hThread);
				CloseHandle(procInstaller.hProcess);
			end
			else
				ShowMessage('Could not execute ' + strAppToInstall);

			// Install done, refresh icons
			strAppToInstall:='';
			intFirstButton:=0;
			ClearButtons();
			SetupButtons();
      SortButtons();
			DisplayButtons();
      if not bolLiveSearchResults then
        RebuildTrayAppIcons();
			frmMenu.Enabled:=true;
		end
		else
			// Install out of process
			ShellExecute(0,'open', PChar('"' + strAppToInstall + '"'+#0),PChar(' -o"' + strPortableAppsPath + '\" -y -/SILENT=YES /DESTINATION="' + strPortableAppsPath+'\"'+#0), PChar(ExtractFileDir(strAppToInstall)+#0), SW_SHOWNORMAL);

		strAppToInstall:='';
  end;
end;

procedure TfrmMenu.CheckDriveForErrors(Sender: TObject);
begin
  if Win32MajorVersion = 5 then
    // Special handling for Windows 2000/XP
    ShellExecute(Handle,'open', PChar(ExtractFileDir(Application.ExeName) + '\App\bin\CheckDrive.bat'), PChar(ExtractFileDrive(Application.ExeName) + ' ' + lblDriveName.Caption), nil, SW_SHOWNORMAL)
  else
    ShellExecute(Handle,'runas', PChar(ExtractFileDir(Application.ExeName) + '\App\bin\CheckDrive.bat'), PChar(ExtractFileDrive(Application.ExeName) + ' ' + lblDriveName.Caption), nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmOptionsRefreshAppsClick(Sender: TObject);
// Refresh apps list
begin
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
end;

procedure TfrmMenu.pmnuitmOptionsGetMoreClick(Sender: TObject);
// Get more applications
begin
  OpenURL('https://portableapps.com/apps');
end;

procedure TfrmMenu.pmnuitmOptionsHideDesktopIconsClick(Sender: TObject);
begin
	if bolHideDesktopIcons then
  begin
     bolHideDesktopIcons:=false;
     ShowDesktopIcons(true);
     pmnuitmOptionsHideDesktopIcons.Checked:=false;
  end
  else
  begin
     bolHideDesktopIcons:=true;
     ShowDesktopIcons(false);
     pmnuitmOptionsHideDesktopIcons.Checked:=true;
  end;
end;

procedure TfrmMenu.pmnuitmSearchDriveClick(Sender: TObject);
// Open windows search for this drive
begin
  ShellExecute(0,'find', PChar(ExtractFileDrive(Application.ExeName) + '\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmSearchInstalledAppsClick(Sender: TObject);
begin
    //edtLiveSearch.Visible:=true;
    //imgLiveSearchClose.Visible:=true;
    //imgLiveSearchIcon.Visible:=false;
    if frmMenu.Showing then
    begin
      if bolHideSearchWhenNotInUse then
        pnlLiveSearchBorder.Visible:=true;
      edtLiveSearch.SetFocus;
      edtLiveSearch.SelStart:=length(edtLiveSearch.Text);
    end;
    //bolLiveSearchResults:=true;
    intFirstButton:=0;
    SortButtons;
    DisplayButtons;
end;

procedure TfrmMenu.pmnuitmSearchComputerClick(Sender: TObject);
// Open windows search for the drive containing the WINDIR
var
  strWinDir: string;
begin
  strWinDir := GetEnvironmentVariable('WINDIR');
  ShellExecute(0,'find', PChar(ExtractFileDrive(strWinDir) + '\' +#0), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TfrmMenu.pmnuitmSearchWebClick(Sender: TObject);
// Open a web search in Firefox Portable
begin
  OpenURL('http://start.portableapps.com/');
end;

procedure TfrmMenu.pmnuitmTrayExitClick(Sender: TObject);
begin
  bolFadeToExit := true;
	FadeInOut(false);
end;

procedure TfrmMenu.AppButtonMouseEnter(Sender: TObject);
// Special handler for the app button hovers
var
  intControl : integer;
  bolDone: boolean;
begin
	bolDone:=false;

  for intControl := Low(arrAppButtonForegrounds) to High(arrAppButtonForegrounds) do
  begin
    if TObject(arrAppButtonForegrounds[intControl]) = Sender then
		begin
      arrAppButtonBackgrounds[intControl].Picture:=imgAppButtonHover.Picture;
      bolDone:=true;
    end
    else
      arrAppButtonBackgrounds[intControl].Picture:=nil;
  end;

  if bolDone then
  begin
 		imgButtonDocumentsBackground.Picture:=nil;
 		imgButtonMusicBackground.Picture:=nil;
 		imgButtonPicturesBackground.Picture:=nil;
 		imgButtonVideosBackground.Picture:=nil;
 		imgButtonExploreBackground.Picture:=nil;
 		imgButtonBackupBackground.Picture:=nil;
 		imgButtonOptionsBackground.Picture:=nil;
 		imgButtonManageAppsBackground.Picture:=nil;
 		imgButtonSearchBackground.Picture:=nil;
 		imgButtonHelpBackground.Picture:=nil;
   	imgButtonOEMBackground.Picture:=nil;
  end
  else
    if imgButtonDocumentsForeground = Sender then
  		imgButtonDocumentsBackground.Picture:=imgFolderButtonHover.Picture
		else if imgButtonMusicForeground = Sender then
			imgButtonMusicBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonPicturesForeground = Sender then
  		imgButtonPicturesBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonVideosForeground = Sender then
  		imgButtonVideosBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonExploreForeground = Sender then
  		imgButtonExploreBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonBackupForeground = Sender then
  		imgButtonBackupBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonOptionsForeground = Sender then
  		imgButtonOptionsBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonManageAppsForeground = Sender then
  		imgButtonManageAppsBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonSearchForeground = Sender then
  		imgButtonSearchBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonHelpForeground = Sender then
  		imgButtonHelpBackground.Picture:=imgFolderButtonHover.Picture
    else if imgButtonScrollUp = Sender then
  		imgButtonScrollUp.Picture:=imgScrollUpHover.Picture
    else if imgButtonScrollDown = Sender then
			imgButtonScrollDown.Picture:=imgScrollDownHover.Picture
    else if imgButtonOEMForeground = Sender then
    	imgButtonOEMBackground.Picture:=imgFolderButtonHover.Picture;
end;

procedure TfrmMenu.AppButtonMouseLeave(Sender: TObject);
// Special handler for the app button hovers
var
  intControl : integer;
  bolDone: boolean;
begin
	bolDone:=false;

  for intControl := Low(arrAppButtonForegrounds) to High(arrAppButtonForegrounds) do
  begin
    if TObject(arrAppButtonForegrounds[intControl]) = Sender then
    begin
      arrAppButtonBackgrounds[intControl].Picture:=nil;
      bolDone:=true;
    end;
  end;

  if not bolDone then
	  if imgButtonDocumentsForeground = Sender then
  		imgButtonDocumentsBackground.Picture:=nil
    else if imgButtonMusicForeground = Sender then
  		imgButtonMusicBackground.Picture:=nil
    else if imgButtonPicturesForeground = Sender then
  		imgButtonPicturesBackground.Picture:=nil
    else if imgButtonVideosForeground = Sender then
  		imgButtonVideosBackground.Picture:=nil
    else if imgButtonExploreForeground = Sender then
  		imgButtonExploreBackground.Picture:=nil
    else if imgButtonBackupForeground = Sender then
  		imgButtonBackupBackground.Picture:=nil
    else if imgButtonOptionsForeground = Sender then
  		imgButtonOptionsBackground.Picture:=nil
    else if imgButtonManageAppsForeground = Sender then
  		imgButtonManageAppsBackground.Picture:=nil
    else if imgButtonSearchForeground = Sender then
  		imgButtonSearchBackground.Picture:=nil
    else if imgButtonHelpForeground = Sender then
  		imgButtonHelpBackground.Picture:=nil
  	else if imgButtonScrollUp = Sender then
  		imgButtonScrollUp.Picture:=imgScrollUpNormal.Picture
   	else if imgButtonScrollDown = Sender then
  		imgButtonScrollDown.Picture:=imgScrollDownNormal.Picture
    else if imgButtonOEMForeground = Sender then
    	imgButtonOEMBackground.Picture:=nil;
                                                
end;

procedure TfrmMenu.AppButtonEnter(Sender: TObject);
var
  iControl : integer;
begin
    for iControl := Low(arrAppButtonButtons) to High(arrAppButtonButtons) do
      if TObject(arrAppButtonButtons[iControl]) = Sender then
      begin
        //ShowMessage('click');
        AppButtonMouseEnter(arrAppButtonForegrounds[iControl]);
      end;
end;

procedure TfrmMenu.AppButtonExit(Sender: TObject);
var
  iControl : integer;
begin
    for iControl := Low(arrAppButtonButtons) to High(arrAppButtonButtons) do
      if TObject(arrAppButtonButtons[iControl]) = Sender then
      begin
        //ShowMessage('click');
        AppButtonMouseLeave(arrAppButtonForegrounds[iControl]);
      end;
end;

procedure TfrmMenu.AppButtonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  iControl : integer;
  TempShiftState: TShiftState;
begin

  if IntToStr(Key) = '93' then begin
    TempShiftState:= [];
    for iControl := Low(arrAppButtonButtons) to High(arrAppButtonButtons) do
      if (TObject(arrAppButtonButtons[iControl]) = Sender) or (TObject(arrAppButtonForegrounds[iControl]) = Sender) then
      begin
        //ShowMessage('click');
        AppButtonMouseUp(arrAppButtonForegrounds[iControl], mbRight, TempShiftState, Round(screen.Width/2), Round(screen.Height/2));
      end;
  end;
end;

procedure TfrmMenu.btnBackupClick(Sender: TObject);
begin
  imgButtonBackupForegroundClick(Sender);
end;

procedure TfrmMenu.btnBackupEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonBackupForeground);
end;

procedure TfrmMenu.btnBackupExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonBackupForeground);
end;

procedure TfrmMenu.btnChangeDriveNameClick(Sender: TObject);
var
    iniAutorun: TINIFile;
    strAutorunFilename: string;
begin
	strDriveName:=edtDriveName.Text;
	lblDriveName.Caption:=strDriveName + ' (' + ExtractFileDrive(Application.ExeName) + ')';
	strAutorunFilename:= Trim(ExtractFileDrive(Application.ExeName) + '\autorun.inf');
	iniAutorun:=TINIFile.Create(strAutorunFilename);
	iniAutorun.WriteString ('Autorun','Label',strDriveName);
	FreeAndNil(iniAutorun);
	edtDriveName.Visible:=false;
	btnChangeDriveName.Visible:=false;
end;

procedure TfrmMenu.btnCloseEnter(Sender: TObject);
begin
  imgCloseMouseEnter(Sender);
end;

procedure TfrmMenu.btnCloseExit(Sender: TObject);
begin
  imgCloseMouseLeave(Sender);
end;

procedure TfrmMenu.btnDocumentsClick(Sender: TObject);
begin
  imgButtonDocumentsForegroundClick(Sender);
end;

procedure TfrmMenu.btnDocumentsEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonDocumentsForeground);
end;

procedure TfrmMenu.btnDocumentsExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonDocumentsForeground);
end;

procedure TfrmMenu.btnEjectEnter(Sender: TObject);
begin
    imgEjectMouseEnter(Sender);
end;

procedure TfrmMenu.btnEjectExit(Sender: TObject);
begin
  imgEjectMouseLeave(Sender);
end;

procedure TfrmMenu.btnExploreClick(Sender: TObject);
begin
  imgButtonExploreForegroundClick(Sender);
end;

procedure TfrmMenu.btnExploreEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonExploreForeground);
end;

procedure TfrmMenu.btnExploreExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonExploreForeground);
end;

procedure TfrmMenu.btnHelpClick(Sender: TObject);
begin
  imgButtonHelpForegroundClick(Sender);
end;

procedure TfrmMenu.btnHelpEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonHelpForeground);
end;

procedure TfrmMenu.btnHelpExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonHelpForeground);
end;

procedure TfrmMenu.btnManageAppsEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonManageAppsForeground);
end;

procedure TfrmMenu.btnManageAppsExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonManageAppsForeground);
end;

procedure TfrmMenu.btnMusicClick(Sender: TObject);
begin
  imgButtonMusicForegroundClick(Sender);
end;

procedure TfrmMenu.btnMusicEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonMusicForeground);
end;

procedure TfrmMenu.btnMusicExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonMusicForeground);
end;

procedure TfrmMenu.btnOEMClick(Sender: TObject);
begin
  imgButtonOEMForegroundClick(Sender);
end;

procedure TfrmMenu.btnOEMEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonOEMForeground);
end;

procedure TfrmMenu.btnOEMExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonOEMForeground);
end;

procedure TfrmMenu.btnOptionsClick(Sender: TObject);
begin
  imgButtonOptionsForegroundClick(Sender);
end;

procedure TfrmMenu.btnOptionsEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonOptionsForeground);
end;

procedure TfrmMenu.btnOptionsExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonOptionsForeground);
end;

procedure TfrmMenu.btnPicturesClick(Sender: TObject);
begin
  imgButtonPicturesForegroundClick(Sender);
end;

procedure TfrmMenu.btnPicturesEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonPicturesForeground);
end;

procedure TfrmMenu.btnPicturesExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonPicturesForeground);
end;

procedure TfrmMenu.btnSearchClick(Sender: TObject);
begin
  imgButtonSearchForegroundClick(Sender);
end;

procedure TfrmMenu.btnSearchEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonSearchForeground);
end;

procedure TfrmMenu.btnSearchExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonSearchForeground);
end;

procedure TfrmMenu.btnVideosClick(Sender: TObject);
begin
  imgButtonVideosForegroundClick(Sender);
end;

procedure TfrmMenu.btnVideosEnter(Sender: TObject);
begin
  AppButtonMouseEnter(imgButtonVideosForeground);
end;

procedure TfrmMenu.btnVideosExit(Sender: TObject);
begin
  AppButtonMouseLeave(imgButtonVideosForeground);
end;

procedure TfrmMenu.ChangeMenuFontSize(intFontSize: integer);
//var
  //intCurrentButton: integer;
// Change the font size of the menu components
begin
  lblAppButton01.Font.Size:=intFontSize;
  lblAppButton02.Font.Size:=intFontSize;
  lblAppButton03.Font.Size:=intFontSize;
  lblAppButton04.Font.Size:=intFontSize;
  lblAppButton05.Font.Size:=intFontSize;
  lblAppButton06.Font.Size:=intFontSize;
  lblAppButton07.Font.Size:=intFontSize;
  lblAppButton08.Font.Size:=intFontSize;
  lblAppButton09.Font.Size:=intFontSize;
  lblAppButton10.Font.Size:=intFontSize;
  lblAppButton11.Font.Size:=intFontSize;
  lblAppButton12.Font.Size:=intFontSize;
  lblAppButton13.Font.Size:=intFontSize;
  lblAppButton14.Font.Size:=intFontSize;
  lblAppButton15.Font.Size:=intFontSize;
  lblAppButton16.Font.Size:=intFontSize;
  lblAppButton17.Font.Size:=intFontSize;
  lblAppButton18.Font.Size:=intFontSize;
  lblAppButton19.Font.Size:=intFontSize;
  lblAppButton20.Font.Size:=intFontSize;
  lblButtonDocuments.font.size:=intFontSize;
  lblButtonMusic.font.size:=intFontSize;
  lblButtonPictures.font.size:=intFontSize;
  lblButtonVideos.font.size:=intFontSize;
  lblButtonExplore.font.size:=intFontSize;
  lblButtonBackup.font.size:=intFontSize;
  lblButtonOptions.font.size:=intFontSize;
  lblButtonManageApps.font.size:=intFontSize;
  lblButtonHelp.font.size:=intFontSize;
  lblButtonSearch.font.size:=intFontSize;
  lblButtonOEM.font.size:=intFontSize;
  Screen.MenuFont.Size := intFontSize;
end;

procedure TfrmMenu.LoadLocale();
var
	iniLocaleFile: TINIFile;
begin
  LogWrite('Info', Self.Name, 'Loading locale');

  SetEnvironmentVariable(PChar('PAL:_IgnoreLanguage'), PChar('false'));
	// Check for locale test file
	// Temporary addition to allow testing of .locale files for translations
	if FileExists(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale') then
	begin
		iniLocaleFile:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\App\Locale\'+strLocale+'.locale');
 	  intLocaleID:=StrToInt(iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LocaleID', '1033'));
    strLocaleWinName:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LocaleWinName', 'LANG_ENGLISH');
   	strLocaleCode2:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LocaleCode2', 'en');
    strLocaleCode3:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LocaleCode3', 'eng');
 	  strLanguageCode:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'LanguageCode', 'en-us');
  	strLocaleglibc:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'Localeglibc', 'en-us');
    strLocaleDirection:=iniLocaleFile.ReadString('PortableApps.comLocaleDetails', 'Direction', 'LTR');

    if strLocaleDirection = 'LTR' then
      frmMenu.BiDiMode:=bdLeftToRight
    else
      frmMenu.BiDiMode:=bdRightToLeft;

    if strLocale = 'ChineseSimplified' then
      strLanguageName:='SimpChinese'
    else if strLocale = 'ChineseTraditional' then
      strLanguageName:='TradChinese'
    else if strLocale = 'PortugueseBrazilian' then
      strLanguageName:='PortugueseBR'
    else
      strLanguageName:=strLocale;

    // Updater/App Directory/Backup Environment Variables
  	SetEnvironmentVariable(PChar('PortableApps.comLanguageCode_INTERNAL'), PChar(strLanguageCode));
    SetEnvironmentVariable(PChar('PortableApps.comLanguageLCID_INTERNAL'), PChar(IntToStr(intLocaleID)));
	  SetEnvironmentVariable(PChar('PortableApps.comLanguageCode2_INTERNAL'), PChar(strLocaleCode2));
    SetEnvironmentVariable(PChar('PortableApps.comLanguageCode3_INTERNAL'), PChar(strLocaleCode3));
    SetEnvironmentVariable(PChar('PortableApps.comLanguageGlibc_INTERNAL'), PChar(strLocaleglibc));
    SetEnvironmentVariable(PChar('PortableApps.comLanguageNSIS_INTERNAL'), PChar(strLocaleWinName));
    SetEnvironmentVariable(PChar('PortableApps.comLanguageName_INTERNAL'), PChar(strLanguageName));

    // Updater/App Directory/Backup Environment Variables (Deprecated Names)
    SetEnvironmentVariable(PChar('PortableApps.comLocaleID_INTERNAL'), PChar(IntToStr(intLocaleID)));
    SetEnvironmentVariable(PChar('PortableApps.comLocaleWinName_INTERNAL'), PChar(strLocaleWinName));
	  SetEnvironmentVariable(PChar('PortableApps.comLocaleCode2_INTERNAL'), PChar(strLocaleCode2));
 		SetEnvironmentVariable(PChar('PortableApps.comLocaleCode3_INTERNAL'), PChar(strLocaleCode3));
 	  SetEnvironmentVariable(PChar('PortableApps.comLocaleglibc_INTERNAL'), PChar(strLocaleglibc));

  	if not bolDisableAppLanguageSwitching then begin
      // Environment Variables
 	  	SetEnvironmentVariable(PChar('PortableApps.comLanguageCode'), PChar(strLanguageCode));
      SetEnvironmentVariable(PChar('PortableApps.comLanguageLCID'), PChar(IntToStr(intLocaleID)));
 		  SetEnvironmentVariable(PChar('PortableApps.comLanguageCode2'), PChar(strLocaleCode2));
      SetEnvironmentVariable(PChar('PortableApps.comLanguageCode3'), PChar(strLocaleCode3));
      SetEnvironmentVariable(PChar('PortableApps.comLanguageGlibc'), PChar(strLocaleglibc));
      SetEnvironmentVariable(PChar('PortableApps.comLanguageNSIS'), PChar(strLocaleWinName));
      SetEnvironmentVariable(PChar('PortableApps.comLanguageName'), PChar(strLanguageName));

      // Environment Variables (Deprecated Names)
      SetEnvironmentVariable(PChar('PortableApps.comLocaleID'), PChar(IntToStr(intLocaleID)));
      SetEnvironmentVariable(PChar('PortableApps.comLocaleWinName'), PChar(strLocaleWinName));
		  SetEnvironmentVariable(PChar('PortableApps.comLocaleCode2'), PChar(strLocaleCode2));
  		SetEnvironmentVariable(PChar('PortableApps.comLocaleCode3'), PChar(strLocaleCode3));
 		  SetEnvironmentVariable(PChar('PortableApps.comLocaleglibc'), PChar(strLocaleglibc));
    end
    else begin
      // Environment Variables
 	  	SetEnvironmentVariable(PChar('PortableApps.comLanguageCode'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLanguageLCID'), '');
 		  SetEnvironmentVariable(PChar('PortableApps.comLanguageCode2'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLanguageCode3'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLanguageGlibc'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLanguageNSIS'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLanguageName'), '');

      // Environment Variables (Deprecated Names)
      SetEnvironmentVariable(PChar('PortableApps.comLocaleID'), '');
      SetEnvironmentVariable(PChar('PortableApps.comLocaleWinName'), '');
		  SetEnvironmentVariable(PChar('PortableApps.comLocaleCode2'), '');
  		SetEnvironmentVariable(PChar('PortableApps.comLocaleCode3'), '');
 		  SetEnvironmentVariable(PChar('PortableApps.comLocaleglibc'), '');
    end;

    strLabelDocuments:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_DOCUMENTS', '&Documents');
		strLabelMusic:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_MUSIC', '&Music');
		strLabelPictures:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_PICTURES', '&Pictures');
		strLabelVideos:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_VIDEOS', '&Videos');
		strLabelExplore:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_EXPLORE', '&Explore');
		strLabelBackup:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_BACKUP', '&Backup');
		strLabelOptions:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_OPTIONS', '&Options');
 		strLabelManageApps:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_MANAGE_APPS', '&Apps');
    strTrayApps:=iniLocaleFile.ReadString('FORM_MAIN', 'TRAY_APPS', '&Apps');
    miTrayApplications.Caption:=strTrayApps;
    strTrayFavorites:=iniLocaleFile.ReadString('FORM_MAIN', 'TRAY_FAVORITES', '&Favorites');
    miTrayFavorites.Caption:=strTrayFavorites;
		strLabelHelp:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_HELP', '&Help');
		strLabelSearch:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_SEARCH', '&Search');
    edtLiveSearch.TextHint:=StringReplace(strLabelSearch, '&', '', [rfReplaceAll, rfIgnoreCase]);
    strKB:=iniLocaleFile.ReadString('GENERAL', 'KILOBYTE', 'KB');
    strMB:=iniLocaleFile.ReadString('GENERAL', 'MEGABYTE', 'MB');
    strGB:=iniLocaleFile.ReadString('GENERAL', 'GIGABYTE', 'GB');
    btnDocuments.Caption:=strLabelDocuments;
    btnMusic.Caption:=strLabelMusic;
    btnPictures.Caption:=strLabelPictures;
    btnVideos.Caption:=strLabelVideos;
    btnExplore.Caption:=strLabelExplore;
    btnBackup.Caption:=strLabelBackup;
    btnOptions.Caption:=strLabelOptions;
    btnManageApps.Caption:=strLabelManageApps;
    btnHelp.Caption:=strLabelHelp;
    btnSearch.Caption:=strLabelSearch;
		lblButtonDocuments.Caption:=StringReplace(strLabelDocuments, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonMusic.Caption:=StringReplace(strLabelMusic, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonPictures.Caption:=StringReplace(strLabelPictures, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonVideos.Caption:=StringReplace(strLabelVideos, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonExplore.Caption:=StringReplace(strLabelExplore, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonBackup.Caption:=StringReplace(strLabelBackup, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonOptions.Caption:=StringReplace(strLabelOptions, '&', '', [rfReplaceAll, rfIgnoreCase]);
 		lblButtonManageApps.Caption:=StringReplace(strLabelManageApps, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonHelp.Caption:=StringReplace(strLabelHelp, '&', '', [rfReplaceAll, rfIgnoreCase]);
		lblButtonSearch.Caption:=StringReplace(strLabelSearch, '&', '', [rfReplaceAll, rfIgnoreCase]);
    pmnuitemTrayBackup.Caption:=strLabelBackup;
    pmnuitemTrayApps.Caption:=strLabelManageApps;
    pmnuitemTrayOptions.Caption:=strLabelOptions;
		pmnuitmOptionsSmallFonts.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_SMALL_FONTS', '&Small Fonts');
		pmnuitmOptionsLargeFonts.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_LARGE_FONTS', '&Large Fonts');
    if strLocaleDirection = 'LTR' then
  		pmnuitmManageAppsInstallAnApp.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_ADD_APP', '&Install a New App') + ' (paf.exe)'
    else
   		pmnuitmManageAppsInstallAnApp.Caption:='(paf.exe) '+ iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_ADD_APP', '&Install a New App');
    pmnuitemTrayAppsInstall.Caption:=pmnuitmManageAppsInstallAnApp.Caption;
		pmnuitmManageAppsRefresh.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_REFRESH_ICONS', '&Refresh App Icons');
		pmnuitmManageAppsGetMoreApps.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_GET_APPS', '&Get More Apps...');

    pmnuitmManageAppsGetMoreAppsCategory.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_BY_CATEGORY', 'By Category');
    pmnuitemTrayAppsGetMoreCategory.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_BY_CATEGORY', 'By Category');
    pmnuitmManageAppsGetMoreAppsTitle.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_BY_TITLE', 'By Title');
    pmnuitemTrayAppsGetMoreTitle.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_BY_TITLE', 'By Title');
    pmnuitmManageAppsGetMoreAppsNew.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_NEW_APPS', 'New Releases');
    pmnuitemTrayAppsGetMoreNew.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_NEW_APPS', 'New Releases');
    pmnuitmManageAppsGetMoreAppsUpdated.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_RECENTLY_UPDATED', 'Recently Updated');
    pmnuitemTrayAppsGetMoreUpdated.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_GET_MORE_APPS_RECENTLY_UPDATED', 'Recently Updated');

    pmnuitemTrayAppsGetMore.Caption:=pmnuitmManageAppsGetMoreApps.Caption;
 		pmnuitmManageAppsUpdate.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_CHECK_FOR_UPDATES', 'Check For &Updates');
    pmnuitmHelpUpdateClick.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_MANAGE_APPS_CHECK_FOR_UPDATES', 'Check For &Updates');
    pmnuitemTrayAppsUpdates.Caption:=pmnuitmManageAppsUpdate.Caption;
		pmnuitmOptionsLanguage.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_LANGUAGE', 'L&anguage');
    pmnuitmOptionsHideDesktopIcons.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_HIDE_DESKTOP_ICONS', '&Hide Desktop Icons');
    pmnuitmOptionsCheckDrive.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'CHECK_DRIVE', '&Check Drive For Errors');
    pmnuitmOptionsTheme.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_THEME', '&Theme');
    pmnuitmOptionsThemeRed.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_THEME_DEFAULT', 'PortableApps.com &Default Theme');
    pmnuitmOptionsThemeBronze.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BRONZE', 'Bronze');
    pmnuitmOptionsThemeGreen.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_GREEN', 'Green');
    pmnuitmOptionsThemeBlue.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BLUE', 'Blue');
    pmnuitmOptionsThemeViolet.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_VIOLET', 'Violet');
    pmnuitmOptionsThemeBlack.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_BLACK', 'Black');
    pmnuitmOptionsThemeSilver.Caption:=iniLocaleFile.ReadString('GENERAL', 'COLOR_SILVER', 'Silver');
    pmnuitmOptionsTransparency.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_OPTIONS_TRANSPARENCY', 'Transparency');

    strDriveSpace:=iniLocaleFile.ReadString('FORM_MAIN', 'DRIVE_SPACE', '$DRIVEFREE free of $DRIVETOTAL');
    strAutoRunChangeWarning:=iniLocaleFile.ReadString('FORM_MAIN', 'AUTORUN_CHANGE_WARNING', 'The PortableApps.com Platform has detected that the autorun of this device has changed.  These changes may be caused by malware or by an application modifying the autorun.inf.  If you did not make these changes, you should scan this device for viruses.');
    strAutoRunChangeWarningTitle:=iniLocaleFile.ReadString('FORM_MAIN', 'AUTORUN_CHANGE_WARNING_TITLE', 'Warning: Autorun Changed');
    strDialogAppsStillRunningEject:=iniLocaleFile.ReadString('FORM_MAIN', 'DIALOG_EJECT_FAIL', 'The following portable apps are still running:%RUNNINGAPPS%Please close all portable apps before ejecting your device.');
    strDialogAppsStillRunning:=iniLocaleFile.ReadString('FORM_MAIN', 'DIALOG_APPS_STILL_RUNNING', strDialogAppsStillRunningEject);

    pmnuitmAppRightClickRun.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_RUN', '&Run');
    pmnuitmAppRightClickRunAsAdmin.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_RUN_AS_ADMIN', 'Run As &Administrator');
    pmnuitmAppRightClickExploreHere.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_EXPLORE_HERE', '&Explore Here');
    pmnuitmAppRightClickPinToTaskbar.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_PIN_TO_TASKBAR', '&Pin to Taskbar');
    pmnuitmAppRightClickAddToStart.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_ADD_TO_START', '&Add to Start programs');
    pmnuitmAppRightClickRename.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_RENAME', 'Re&name');
    pmnuitmAppRightClickRefresh.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_REFRESH', 'Re&fresh');
    pmnuitmAppRightClickDonate.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_DONATE', 'Donate');
    pmnuitmAppRightClickWebsite.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_WEBSITE', 'Website');
    pmnuitmAppRightClickHideFromMenu.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_HIDE', '&Hide');
    pmnuitmAppRightClickShowHiddenIcons.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_SHOW_HIDDEN', 'Show Hidden &Icons');
    pmnuitmManageAppsShowHiddenIcons.Caption:=pmnuitmAppRightClickShowHiddenIcons.Caption;
    pmnuitmAppRightClickFavorite.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_FAVORITE', '&Favorite');
    pmnuitmAppRightClickAutomaticallyStart.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_START_AUTOMATICALLY', '&Start Automatically');
    pmnuitmAppRightClickUninstall.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_UNINSTALL', '&Uninstall');
    pmnuitmAppRightClickHelp.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_HELP', 'Help');
    pmnuitmAppRightClickCategory.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY', 'Category');
    strAppPrefix:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_PREFIX_APP', 'App');
    strCategoryPrefix:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY', 'Category'), '&', '', [rfReplaceAll, rfIgnoreCase]);

		pmnuitmBackupBackup.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_BACKUP', '&Backup Files');
    pmnuitemTrayBackupBackup.Caption:=pmnuitmBackupBackup.Caption;
		pmnuitmBackupRestore.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_RESTORE', '&Restore From Backup');
    pmnuitemTrayBackupRestore.Caption:=pmnuitmBackupRestore.Caption;

    pmnuitmHelpCheckDrive.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'CHECK_DRIVE', 'Check Drive for Errors');
    pmnuitmHelpPortableAppsSupport.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HELP_SUPPORT', 'Support');
    pmnuitmHelpDonate.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HELP_DONATE', 'Donate to PortableApps.com');
    pmnuitmHelpAbout.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HELP_ABOUT', '&About');
    pmnuitmSearchInstalledApps.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_SEARCH_INSTALLED_APPS', 'Search Installed &Apps');
		pmnuitmSearchDrive.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_SEARCH_DRIVE', 'Search This &Drive');
		pmnuitmSearchComputer.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_SEARCH_COMPUTER', 'Search This &Computer');
		pmnuitmSearchWeb.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_SEARCH_WEB', 'Search The &Web');
    pmnuitmOEMHomepage.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_HOMEPAGE', '&Homepage');
    pmnuitmOEMStore.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_STORE', 'S&tore');
    pmnuitmOEMSupport.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_SUPPORT', '&Support');
		pmnuitmTrayExit.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_TRAY_EXIT', 'E&xit');
    strEjectButton:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_TRAY_EJECT', 'E&ject');
    strPowerButton:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_TRAY_POWER', '&Shut down / Log Out');
    if bolRunningOnRemovableDrive or bolAlwaysShowEject then
      pmnuitmTrayEject.Caption:=strEjectButton
    else
      pmnuitmTrayEject.Caption:=strPowerButton;

    pmnuitmLeftButtonEject.Caption:=strEjectButton;
    pmnuitmLeftButtonPower.Caption:=strPowerButton;
    pmnuitmLeftButtonAutomatic.Caption:=iniLocaleFile.ReadString('FORM_MAIN', 'MENU_TRAY_AUTOMATIC', iniLocaleFile.ReadString('FORM_OPTIONS', 'CONNECTION_TYPE_AUTOMATIC', '&Automatic'));

		strRenameMenuItem:=iniLocaleFile.ReadString('FORM_RENAME_MENU_ITEM', 'CAPTION', 'Rename');
    strUninstallTitle:=iniLocaleFile.ReadString('FORM_UNINSTALL_DIALOG', 'TITLE', 'Uninstall %APPNAME%?');
    strUninstallMessage:=iniLocaleFile.ReadString('FORM_UNINSTALL_DIALOG', 'MESSAGE', 'WARNING: Uninstalling will remove the portable app and all of its settings (preferences, bookmarks, etc).  Documents or files saved to your Documents or other folders will not be affected, but all files within this directory will be deleted:');
    strUninstallQuestion:=iniLocaleFile.ReadString('FORM_UNINSTALL_DIALOG', 'QUESTION', 'Are you sure you wish to uninstall %APPNAME%?');
    strUninstallingTitle:=iniLocaleFile.ReadString('FORM_UNINSTALLING_DIALOG', 'TITLE', 'Uninstalling %APPNAME%');
    strUninstallingMessage:=iniLocaleFile.ReadString('FORM_UNINSTALLING_DIALOG', 'MESSAGE', 'Uninstalling %APPNAME%.  Please wait...');
    strUninstallFailMessage:=iniLocaleFile.ReadString('FORM_UNINSTALL_DIALOG', 'FAILMESSAGE', 'Unable to install %APPNAME%.');
    strOK:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_OK', '&OK');
    strCancel:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_CANCEL', '&Cancel');
    strYes:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_YES', '&Yes');
    strNo:=iniLocaleFile.ReadString('GENERAL', 'BUTTON_NO', '&No');
    strCategoryAccessibility:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_ACCESSIBILITY', 'Accessibility'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryDevelopment:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_DEVELOPMENT', 'Development'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryEducation:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_EDUCATION', 'Education'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryGames:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_GAMES', 'Games'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryGraphicsPictures:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_GRAPHICS_AND_PICTURES', 'Graphics and Pictures'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryInternet:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_INTERNET', 'Internet'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryMusicVideo:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_MUSIC_AND_VIDEO', 'Music and Video'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryOffice:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_OFFICE', 'Office'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategorySecurity:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_SECURITY', 'Security'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryUtilities:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_UTILITIES', 'Utilities'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strCategoryOther:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_OTHER', 'Other'),'&','',[rfReplaceAll, rfIgnoreCase]);
    strAllPortableApps:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_ALL_APPS', 'All Portable Apps'),'&','',[rfReplaceAll, rfIgnoreCase]);
    miTrayApplications.Caption:=strAllPortableApps;
    strBackToPageOne:=StringReplace(iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_BACK', 'Back'),'&','',[rfReplaceAll, rfIgnoreCase]);
    arrAppCategories[0].DisplayName:=strCategoryAccessibility;
    arrAppCategories[1].DisplayName:=strCategoryDevelopment;
    arrAppCategories[2].DisplayName:=strCategoryEducation;
    arrAppCategories[3].DisplayName:=strCategoryGames;
    arrAppCategories[4].DisplayName:=strCategoryGraphicsPictures;
    arrAppCategories[5].DisplayName:=strCategoryInternet;
    arrAppCategories[6].DisplayName:=strCategoryMusicVideo;
    arrAppCategories[7].DisplayName:=strCategoryOffice;
    arrAppCategories[8].DisplayName:=strCategorySecurity;
    arrAppCategories[9].DisplayName:=strCategoryUtilities;
    arrAppCategories[10].DisplayName:=strCategoryOther;
    strAddANewCategory:=iniLocaleFile.ReadString('FORM_MAIN', 'APP_MENU_CATEGORY_ADD', 'Add a New Category');
    strCloseAppsOnPlatformExit:=iniLocaleFile.ReadString('FORM_MAIN', 'CLOSE_APPS_ON_EXIT_QUERY', 'BLANK');
    strCloseAppsOnPlatformExitHeader:=iniLocaleFile.ReadString('FORM_MAIN', 'CLOSE_APPS_ON_EXIT_QUERY_HEADER', 'PortableApps.com');
    imgPersonalPicture.Hint:=iniLocaleFile.ReadString('FORM_MAIN', 'ICON_PERSONAL_PICTURE', 'NONE');
    if imgPersonalPicture.Hint='NONE' then
      imgPersonalPicture.Hint:=''
    else
      imgPersonalPicture.Hint:=imgPersonalPicture.Hint + #13#10 + iniLocaleFile.ReadString('FORM_MAIN', 'ICON_PERSONAL_PICTURE_HINT2', 'Click to change, right-click to clear');


    // Security warnings
    strSecurityWarningUnexpectedDLLs:=iniLocaleFile.ReadString('FORM_MAIN', 'SECURITY_UNEXPECTED_DLLS', 'One or more unexpected DLL files were found in the same directory as %LAUNCHERFILE%. This could be an indication of a covert attempt to hijack the application using DLL injection. Please check the application before using it.');
    strSecurityWarningHashFailure:=iniLocaleFile.ReadString('FORM_MAIN', 'SECURITY_HASH_FAILED_ON_FILE', 'The file %HASHEDFILE% has been altered or should not exist in this location. This could be an indication of a covert attempt to hijack the application using DLL injection. Please check the application before using it.');

    strTaskbarLinkCreated:=iniLocaleFile.ReadString('FORM_MAIN', 'TASKBAR_LINK_CREATED', 'In the Explorer window that will open, please drag the shortcut %SHORTCUTNAME% to the taskbar to pin your portable app. You may close the Explorer window afterward.');
    strTaskbarLinkCreatedWin11:=iniLocaleFile.ReadString('FORM_MAIN', 'TASKBAR_LINK_CREATED_WIN_11', '%SHORTCUTNAME% has been added to your Windows Start programs. To pin it to your taskbar, please click the Windows Start icon then All Apps. Right-click on %SHORTCUTNAME%, select More, then click Pin to taskbar.');
    strStartLinkCreated:=iniLocaleFile.ReadString('FORM_MAIN', 'START_MENU_LINK_CREATED', '%SHORTCUTNAME% has been added to your Windows Start menu programs.');

    // .NET framework checks
    strRequiresDotNetFramework:=iniLocaleFile.ReadString('FORM_MAIN', 'DIALOG_NET_FRAMEWORK_DOWNLOAD', 'This application requires the Microsoft .NET Framework %VERSION% installed on the local PC to run. Please run Windows Update or visit update.microsoft.com within Internet Explorer to download and install it.');

    // Shared strings
    pmnuitmTrayDocuments.Caption:=lblButtonDocuments.Caption;
    pmnuitmTrayMusic.Caption:=lblButtonMusic.Caption;
    pmnuitmTrayPictures.Caption:=lblButtonPictures.Caption;
    pmnuitmTrayVideos.Caption:=lblButtonVideos.Caption;
    pmnuitmTrayExplore.Caption:=lblButtonExplore.Caption;
 		FreeAndNil(iniLocaleFile);
	end;
end;

procedure TfrmMenu.SetupMenus();
// Set up the language menu
// Acknowledgement: http://delphi.about.com/od/kbcurt/a/dynamicmenuitem.htm for the handy tutorial
var
  pmnuitmTemp: TMenuItemExtended;
  tsrchDirectory: TSearchRec;
begin
  LogWrite('Info', Self.Name, 'Setting up submenus');

  // Clear the menus
  pmnuitmOptionsLanguage.Clear;
  // Set up locale menu
  if FindFirst(ExtractFileDir(Application.ExeName) + '\App\Locale\*.locale',faAnyFile,tsrchDirectory)=0 then
  begin
    repeat
      pmnuitmTemp:=TMenuItemExtended.Create(pmnuitmOptionsLanguage);
      pmnuitmTemp.Value:=ExtractFileDir(Application.ExeName) + '\App\Locale\' + tsrchDirectory.FindData.cFileName;
      pmnuitmTemp.Caption:=LeftStr(ExtractFileName(pmnuitmTemp.Value), Length(ExtractFileName(pmnuitmTemp.Value))-7);
      pmnuitmTemp.OnClick:=pmnuitmLocaleClick;
      pmnuitmTemp.RadioItem:=True;
      // If it's the currently enabled locale, enable it's menu option
      if AnsiLowerCase(pmnuitmTemp.Caption)=AnsiLowerCase(strLocale) then
        pmnuitmTemp.Checked:=true;
      pmnuitmOptionsLanguage.Add(pmnuitmTemp);
    Until FindNext(tsrchDirectory)<>0;
    FindClose(tsrchDirectory);
  end
  else
  begin
    // Insert dummy item to make it look like a submenu
    pmnuitmTemp:=TMenuItemExtended.Create(pmnuitmOptionsLanguage);
    pmnuitmOptionsLanguage.Add(pmnuitmTemp);
    pmnuitmOptionsLanguage.Enabled:=False;
  end;
end;

procedure TfrmMenu.pmnuitmLeftButtonAutomaticClick(Sender: TObject);
begin
  bolAlwaysShowEject:=false;
  bolAlwaysShowPower:=false;
  pmnuitmLeftButtonAutomatic.Checked:=true;
  LoadTheme;
end;

procedure TfrmMenu.pmnuitmLeftButtonEjectClick(Sender: TObject);
begin
  bolAlwaysShowEject:=true;
  bolAlwaysShowPower:=false;
  pmnuitmLeftButtonEject.Checked:=true;
  LoadTheme;
end;

procedure TfrmMenu.pmnuitmLeftButtonPowerClick(Sender: TObject);
begin
  bolAlwaysShowEject:=false;
  bolAlwaysShowPower:=true;
  pmnuitmLeftButtonPower.Checked:=true;
    LoadTheme;
end;

procedure TfrmMenu.pmnuitmLocaleClick(Sender : TObject);
// Click handler for the locale menu
begin
  //Get the locale name from the menu caption

  strLocale:=StringReplace(TMenuItemExtended(Sender).Caption, '&', '', [rfReplaceAll, rfIgnoreCase]);
  TMenuItemExtended(Sender).Checked:=true;
  // ShowMessage(strLocale);
  LoadLocale();
end;

procedure TfrmMenu.GetMoreAppsClick(Sender: TObject);
var
  strOptions: string;
begin
  strOptions:='/MODE=ADD';
  if bolAppDirectoryShowOpenSourceOnly then
    strOptions:=strOptions + ' /OPENSOURCEONLY=true'
  else
    strOptions:=strOptions + ' /OPENSOURCEONLY=false';

  if bolKeyboardFriendly then
    strOptions:=strOptions + ' /KEYBOARDFRIENDLY=true'
  else
    strOptions:=strOptions + ' /KEYBOARDFRIENDLY=false';

  if bolAppDirectoryShowAdvancedApps then
    strOptions:=strOptions + ' /ADVANCED=true'
  else
    strOptions:=strOptions + ' /ADVANCED=false';

  if bolShowInstalledApps then
    strOptions:=strOptions + ' /SHOWINSTALLEDAPPS=true'
  else
    strOptions:=strOptions + ' /SHOWINSTALLEDAPPS=false';

  if bolHidePortableInAppNames then
    strOptions:=strOptions + ' /HIDEPORTABLE=true'
  else
    strOptions:=strOptions + ' /HIDEPORTABLE=false';

  if bolBetaPlatformReleases then
    strOptions:=strOptions + ' /BETA=true'
  else
    strOptions:=strOptions + ' /BETA=false';

  if ((strShow64BitOnlyApps = 'Never') or ((SysUtils.TOSVersion.Architecture = arIntelX86) and (strShow64BitOnlyApps = 'Automatic'))) then
    strOptions:=strOptions + ' /HIDE64BIT=true'
  else
    strOptions:=strOptions + ' /HIDE64BIT=false';


  if (TObject(pmnuitmManageAppsGetMoreAppsCategory) = Sender) or (TObject(pmnuitemTrayAppsGetMoreCategory) = Sender) then
    strOptions:=strOptions + ' /ORDER=category';

  if (TObject(pmnuitmManageAppsGetMoreAppsTitle) = Sender) or (TObject(pmnuitemTrayAppsGetMoreTitle) = Sender) then
    strOptions:=strOptions + ' /ORDER=title';

  if (TObject(pmnuitmManageAppsGetMoreAppsNew) = Sender) or (TObject(pmnuitemTrayAppsGetMoreNew) = Sender) then
    strOptions:=strOptions + ' /ORDER=new';

  if (TObject(pmnuitmManageAppsGetMoreAppsUpdated) = Sender) or (TObject(pmnuitemTrayAppsGetMoreUpdated) = Sender) then
    strOptions:=strOptions + ' /ORDER=updated';

      if strConnectionType='Automatic' then
        strOptions:=strOptions + ' /CONNECTION=Automatic';
      if strConnectionType='Direct' then
        strOptions:=strOptions + ' /CONNECTION=Direct';
      if strConnectionType='Proxy' then
      begin
        strOptions:=strOptions + ' /CONNECTION=Proxy';
        strOptions:=strOptions + ' /PROXYIP=' + strConnectionProxyIP;
        strOptions:=strOptions + ' /PROXYPORT=' + strConnectionProxyPort;
      end;

  ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\PortableAppsUpdater.exe'), PChar(strOptions), Nil, SW_SHOWNORMAL);

  //frmAppStore.show;
end;

procedure TfrmMenu.pmnuitmManageAppsRefreshClick(Sender: TObject);
begin
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
end;

procedure TfrmMenu.pmnuitmManageAppsShowHiddenIconsClick(Sender: TObject);
begin
  if bolShowHiddenIcons then
  begin
    bolShowHiddenIcons:=false;
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
  end
  else
  begin
    bolShowHiddenIcons:=true;
		intFirstButton:=0;
		ClearButtons();
		SetupButtons();
    SortButtons();
    DisplayButtons();
    if not bolLiveSearchResults then
      RebuildTrayAppIcons();
  end;
end;

procedure TfrmMenu.pmnuitmManageAppsUpdateClick(Sender: TObject);
var
  strOptions: string;
begin
  strOptions:='/STARTUP=false /MODE=UPDATE';

  if bolKeyboardFriendly then
    strOptions:=strOptions + ' /KEYBOARDFRIENDLY=true'
  else
    strOptions:=strOptions + ' /KEYBOARDFRIENDLY=false';

  if bolHidePortableInAppNames then
    strOptions:=strOptions + ' /HIDEPORTABLE=true'
  else
    strOptions:=strOptions + ' /HIDEPORTABLE=false';

  if bolBetaPlatformReleases then
    strOptions:=strOptions + ' /BETA=true'
  else
    strOptions:=strOptions + ' /BETA=false';

      if strConnectionType='Automatic' then
        strOptions:=strOptions + ' /CONNECTION=Automatic';
      if strConnectionType='Direct' then
        strOptions:=strOptions + ' /CONNECTION=Direct';
      if strConnectionType='Proxy' then
      begin
        strOptions:=strOptions + ' /CONNECTION=Proxy';
        strOptions:=strOptions + ' /PROXYIP=' + strConnectionProxyIP;
        strOptions:=strOptions + ' /PROXYPORT=' + strConnectionProxyPort;
      end;

  ShellExecute(0,'open', PChar(ExtractFileDir(Application.ExeName) + '\PortableAppsUpdater.exe'), PChar(strOptions), Nil, SW_SHOWNORMAL);
end;

procedure TFrmMenu.LoadSettings ();
var
	iniSettingsFile: TINIFile;
begin
  // Create Data if it doesn't exist
  if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then
    ForceDirectories(PChar(ExtractFileDir(Application.ExeName) + '\Data'));

  // Setup default settings if they don't exist
  if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini')) then
    CopyFile(PChar(ExtractFileDir(Application.ExeName) + '\App\bin\blankutf16lefile.txt'), PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini'), true);

  iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  try
    bolFadeMenu:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'FadeMenu', 'false'));
    bolHideDesktopIcons:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'HideDesktopIcons', 'false'));
    bolLargeFonts:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'LargeFonts', 'false'));
    bolRemainVisible:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'RemainVisible', 'false'));
    bolShowSingleIconForMultiIconApps:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'ShowSingleIconForMultiIconApps', 'false'));
    bolStartMinimized:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'StartMinimized', 'false'));
    bolShowAllApps:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'ShowAllApps', 'true'));
    bolWindows7TaskbarIcon:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'Windows7TaskbarIcon', 'true'));
    bolWindows7TaskbarIconNextLaunch:=bolWindows7TaskbarIcon;
    bolUseCategories:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'UseCategories', 'true'));
    bolCollapseOtherFoldersOnExpand:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'CollapseOtherFoldersOnExpand', 'false'));
    bolExpandCategoriesByDefault:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'ExpandCategoriesByDefault', 'false'));
    bolCollapseCategoriesOnMinimize:=StringToBoolean(iniSettingsFile.ReadString('DisplayOptions', 'CollapseCategoriesOnMinimize', 'false'));

    bolDisableAppLanguageSwitching:=StringToBoolean(iniSettingsFile.ReadString('Localization', 'DisableAppLanguageSwitching', 'false'));






    if ansiLowerCase(iniSettingsFile.ReadString('Protection', 'AutoRun', 'true'))='true' then
      bolAutoRunProtection:=True
    else
      bolAutoRunProtection:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'KeyboardFriendly', 'false'))='true' then
      bolKeyboardFriendly:=True
    else
      bolKeyboardFriendly:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Updater', 'UpdateAutomatically', 'true'))='true' then
      bolUpdateAutomatically:=True
    else
      bolUpdateAutomatically:=False;
    if (ansiLowerCase(iniSettingsFile.ReadString('Updater', 'BetaPlatformReleases', 'false'))='true') or BOLRUNNINGBETA then
      bolBetaPlatformReleases:=True
    else
      bolBetaPlatformReleases:=False;
    if (ansiLowerCase(iniSettingsFile.ReadString('Updater', 'ShowStartupModeErrors', 'false'))='true') then
      bolShowUpdaterStarupErrors:=True
    else
      bolShowUpdaterStarupErrors:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('AppDirectory', 'ShowOpenSourceOnly', 'false'))='true' then
      bolAppDirectoryShowOpenSourceOnly:=True
    else
      bolAppDirectoryShowOpenSourceOnly:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('AppDirectory', 'ShowAdvancedApps', 'false'))='true' then
      bolAppDirectoryShowAdvancedApps:=True
    else
      bolAppDirectoryShowAdvancedApps:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'DisableScrollBar', 'false'))='true' then
      bolDisableScrollBar:=True
    else
      bolDisableScrollBar:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'HidePortableInAppNames', 'true'))='true' then
      bolHidePortableInAppNames:=True
    else
      bolHidePortableInAppNames:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'DisableSplashScreens', 'false'))='true' then
      bolDisableSplashScreens:=True
    else
      bolDisableSplashScreens:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'BoldFolderNames', 'false'))='true' then
      bolBoldFolderNames:=True
    else
      bolBoldFolderNames:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'BoldFavorites', 'false'))='true' then
      bolBoldFavorites:=True
    else
      bolBoldFavorites:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'AlwaysShowEject', 'false'))='true' then
      bolAlwaysShowEject:=True
    else
      bolAlwaysShowEject:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'AlwaysShowPower', 'false'))='true' then
      bolAlwaysShowPower:=True
    else
      bolAlwaysShowPower:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'ShowAppPathsInToolTips', 'false'))='true' then
      bolShowAppPathsInToolTips:=True
    else
      bolShowAppPathsInToolTips:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'ShowAppPublishersInToolTips', 'false'))='true' then
      bolShowAppPublishersInToolTips:=True
    else
      bolShowAppPublishersInToolTips:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('DisplayOptions', 'HideLogoDecorations', 'false'))='true' then
      bolHideLogoDecorations:=True
    else
      bolHideLogoDecorations:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('AppDirectory', 'ShowInstalledApps', 'false'))='true' then
      bolShowInstalledApps:=True
    else
      bolShowInstalledApps:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Automation', 'CloseAppsOnPlatformExit', 'false'))='true' then
      bolCloseAppsOnPlatformExit:=True
    else
      bolCloseAppsOnPlatformExit:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Automation', 'AskCloseAppsOnPlatformExit', 'false'))='true' then
      bolAskCloseAppsOnPlatformExit:=True
    else
      bolAskCloseAppsOnPlatformExit:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Search', 'SearchWithinAppDescriptions', 'false'))='true' then
      bolSearchWithinAppDescriptions:=True
    else
      bolSearchWithinAppDescriptions:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Search', 'HideSearchWhenNotInUse', 'false'))='true' then
      bolHideSearchWhenNotInUse:=True
    else
      bolHideSearchWhenNotInUse:=False;
    if ansiLowerCase(iniSettingsFile.ReadString('Logging', 'EnableLogging', 'false'))='true' then
      bolLogging:=True
    else
      bolLogging:=False;

    strConnectionType:=iniSettingsFile.ReadString('Connection', 'ConnectionType', 'Automatic');
    strConnectionProxyIP:=iniSettingsFile.ReadString('Connection', 'ProxyIP', '127.0.0.1');
    strConnectionProxyPort:=iniSettingsFile.ReadString('Connection', 'ProxyPort', '8080');

    strGlobalHotKey:=iniSettingsFile.ReadString('DisplayOptions', 'GlobalHotKey', 'CTRL-ALT-SPACE');
    intAlphaBlendMain:=iniSettingsFile.ReadInteger('DisplayOptions', 'AlphaBlendMain', 255);
    strLocale:=iniSettingsFile.ReadString('DisplayOptions', 'Language', 'English');
    if strOEM<>'' then
        strCurrentTheme:=iniSettingsFile.ReadString('DisplayOptions', 'Theme', 'OEM')
    else
      strCurrentTheme:=iniSettingsFile.ReadString('DisplayOptions', 'Theme', 'Default');
    strCurrentThemeColor:=iniSettingsFile.ReadString('DisplayOptions', 'ThemeColor', 'Default');
    strTaskbarIcon:=iniSettingsFile.ReadString('DisplayOptions', 'TaskbarIcon', 'Default');
    strThemeCustomColor:=iniSettingsFile.ReadString('DisplayOptions', 'ThemeCustomColor', '888888');
    strStartPositionHorizontal:=iniSettingsFile.ReadString('DisplayOptions', 'StartPositionHorizontal', 'Right');
    strStartPositionVertical:=iniSettingsFile.ReadString('DisplayOptions', 'StartPositionVertical', 'Bottom');

    strLastVersion:=iniSettingsFile.ReadString('PlatformInternal', 'LastVersion', '0.0.0.0');

    strShow64BitOnlyApps:=iniSettingsFile.ReadString('AppDirectory', 'Show64BitOnlyApps', 'Automatic');

    if ansiLowerCase(iniSettingsFile.ReadString('SystemIntegration', 'SystemWideEnvironmentVariables', 'false'))='true' then
      bolSystemWideEnvironmentVariables:=True
    else
      bolSystemWideEnvironmentVariables:=False;

  finally
    FreeAndNil(iniSettingsFile);
  end;
end;

procedure TFrmMenu.SaveStatistics ();
var
	bolWriteable: boolean;
	intFileAttributes: Integer;
	iniSettingsFile: TINIFile;
  intCounter: integer;
begin
  LogWrite('Info', Self.Name, 'Saving statistics');

	if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
    // Create the Data directory if it is missing
    ForceDirectories(PChar(ExtractFileDir(Application.ExeName) + '\Data'));
  end;
	if DirectoryExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini')) then begin
			intFileAttributes := FileGetAttr(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
      if (intFileAttributes and faReadOnly)>0 then
	      bolWriteable:=false
      else
      	bolWriteable:=true
    end
    else
    	bolWriteable:=true;
		if bolWriteable then begin
			iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
      for intCounter := 0 to Length(arrAppItems)-1 do
        if arrAppItems[intCounter].TimesRun > arrAppItems[intCounter].TimesRunLast then
          iniSettingsFile.WriteString('TimesRun',MakePathIntoINIKey(RightStr(arrAppItems[intCounter].CommandLine,Length(arrAppItems[intCounter].CommandLine)-Length(ExtractFileDir(ExtractFileDir(Application.ExeName))+'\'))),IntToStr(arrAppItems[intCounter].TimesRun));
			iniSettingsFile.UpdateFile();
			FreeAndNil(iniSettingsFile);
		end;
  end;
end;

procedure TfrmMenu.scrollAppListScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  intFirstButton:=scrollAppList.Position;
  DisplayButtons();
end;

procedure TFrmMenu.SaveSettings ();
var
  strEndPositionHorizontal: String;
	strEndPositionVertical: String;
	bolWriteable: boolean;
	intFileAttributes: Integer;
	iniSettingsFile: TINIFile;
begin
  LogWrite('Info', Self.Name, 'Saving settings');

	if Not FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
    // Create the Data directory if it is missing
    ForceDirectories(PChar(ExtractFileDir(Application.ExeName) + '\Data'));
  end;
	if DirectoryExists(PChar(ExtractFileDir(Application.ExeName) + '\Data')) then begin
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini')) then begin
			intFileAttributes := FileGetAttr(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
      if (intFileAttributes and faReadOnly)>0 then
	      bolWriteable:=false
      else
      	bolWriteable:=true
    end
    else begin
      CopyFile(PChar(ExtractFileDir(Application.ExeName) + '\App\bin\blankutf16lefile.txt'), PChar(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini'), true);
    	bolWriteable:=true
    end;
		if bolWriteable then begin
			iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
      iniSettingsFile.WriteString('DisplayOptions', 'LargeFonts', BooleanToString(bolLargeFonts));


			if bolHideDesktopIcons then
				iniSettingsFile.WriteString('DisplayOptions', 'HideDesktopIcons', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'HideDesktopIcons', 'False');
			if bolUseCategories then
				iniSettingsFile.WriteString('DisplayOptions', 'UseCategories', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'UseCategories', 'False');
			if bolDisableAppLanguageSwitching then
				iniSettingsFile.WriteString('Localization', 'DisableAppLanguageSwitching', 'True')
			else
				iniSettingsFile.WriteString('Localization', 'DisableAppLanguageSwitching', 'False');
			if bolShowAllApps then
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAllApps', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAllApps', 'False');
			if bolKeyboardFriendly then
				iniSettingsFile.WriteString('DisplayOptions', 'KeyboardFriendly', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'KeyboardFriendly', 'False');
			if bolCollapseOtherFoldersOnExpand then
				iniSettingsFile.WriteString('DisplayOptions', 'CollapseOtherFoldersOnExpand', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'CollapseOtherFoldersOnExpand', 'False');
			if bolExpandCategoriesByDefault then
				iniSettingsFile.WriteString('DisplayOptions', 'ExpandCategoriesByDefault', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'ExpandCategoriesByDefault', 'False');
			if bolCollapseCategoriesOnMinimize then
				iniSettingsFile.WriteString('DisplayOptions', 'CollapseCategoriesOnMinimize', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'CollapseCategoriesOnMinimize', 'False');
			if bolStartMinimized then
				iniSettingsFile.WriteString('DisplayOptions', 'StartMinimized', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'StartMinimized', 'False');
			if bolUpdateAutomatically then
				iniSettingsFile.WriteString('Updater', 'UpdateAutomatically', 'True')
			else
				iniSettingsFile.WriteString('Updater', 'UpdateAutomatically', 'False');
			if bolBetaPlatformReleases then
				iniSettingsFile.WriteString('Updater', 'BetaPlatformReleases', 'True')
			else
				iniSettingsFile.WriteString('Updater', 'BetaPlatformReleases', 'False');
			if bolShowUpdaterStarupErrors then
				iniSettingsFile.WriteString('Updater', 'ShowStartupModeErrors', 'True')
			else
				iniSettingsFile.WriteString('Updater', 'ShowStartupModeErrors', 'False');
			if bolDisableScrollbar then
				iniSettingsFile.WriteString('DisplayOptions', 'DisableScrollBar', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'DisableScrollBar', 'False');
			if bolHidePortableInAppNames then
				iniSettingsFile.WriteString('DisplayOptions', 'HidePortableInAppNames', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'HidePortableInAppNames', 'False');
			if bolBoldFolderNames then
				iniSettingsFile.WriteString('DisplayOptions', 'BoldFolderNames', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'BoldFolderNames', 'False');
			if bolDisableSplashScreens then
				iniSettingsFile.WriteString('DisplayOptions', 'DisableSplashScreens', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'DisableSplashScreens', 'False');
			if bolBoldFavorites then
				iniSettingsFile.WriteString('DisplayOptions', 'BoldFavorites', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'BoldFavorites', 'False');
      if bolShowAppPathsInToolTips then
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAppPathsInToolTips', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAppPathsInToolTips', 'False');
      if bolShowAppPublishersInToolTips then
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAppPublishersInToolTips', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'ShowAppPublishersInToolTips', 'False');
			if bolAlwaysShowEject then
				iniSettingsFile.WriteString('DisplayOptions', 'AlwaysShowEject', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'AlwaysShowEject', 'False');
			if bolAlwaysShowPower then
				iniSettingsFile.WriteString('DisplayOptions', 'AlwaysShowPower', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'AlwaysShowPower', 'False');
 			if bolHideLogoDecorations then
				iniSettingsFile.WriteString('DisplayOptions', 'HideLogoDecorations', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'HideLogoDecorations', 'False');
      if bolCloseAppsOnPlatformExit then
				iniSettingsFile.WriteString('Automation', 'CloseAppsOnPlatformExit', 'True')
			else
				iniSettingsFile.WriteString('Automation', 'CloseAppsOnPlatformExit', 'False');

      if bolAskCloseAppsOnPlatformExit then
				iniSettingsFile.WriteString('Automation', 'AskCloseAppsOnPlatformExit', 'True')
			else
				iniSettingsFile.WriteString('Automation', 'AskCloseAppsOnPlatformExit', 'False');

      if bolAppDirectoryShowOpenSourceOnly then
				iniSettingsFile.WriteString('AppDirectory', 'ShowOpenSourceOnly', 'True')
			else
				iniSettingsFile.WriteString('AppDirectory', 'ShowOpenSourceOnly', 'False');
      if bolAppDirectoryShowAdvancedApps then
				iniSettingsFile.WriteString('AppDirectory', 'ShowAdvancedApps', 'True')
			else
				iniSettingsFile.WriteString('AppDirectory', 'ShowAdvancedApps', 'False');
      if bolShowInstalledApps then
				iniSettingsFile.WriteString('AppDirectory', 'ShowInstalledApps', 'True')
			else
				iniSettingsFile.WriteString('AppDirectory', 'ShowInstalledApps', 'False');
      if bolAutoRunProtection then
				iniSettingsFile.WriteString('Protection', 'AutoRun', 'True')
			else
				iniSettingsFile.WriteString('Protection', 'AutoRun', 'False');

      if bolSearchWithinAppDescriptions then
				iniSettingsFile.WriteString('Search', 'SearchWithinAppDescriptions', 'True')
			else
				iniSettingsFile.WriteString('Search', 'SearchWithinAppDescriptions', 'False');

      if bolHideSearchWhenNotInUse then
				iniSettingsFile.WriteString('Search', 'HideSearchWhenNotInUse', 'True')
			else
				iniSettingsFile.WriteString('Search', 'HideSearchWhenNotInUse', 'False');

      if bolRemainVisible then
				iniSettingsFile.WriteString('DisplayOptions', 'RemainVisible', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'RemainVisible', 'False');

      if bolWindows7TaskbarIconNextLaunch then
        iniSettingsFile.WriteString('DisplayOptions', 'Windows7TaskbarIcon', 'True')
			else
				iniSettingsFile.WriteString('DisplayOptions', 'Windows7TaskbarIcon', 'False');

      if bolLogging then
				iniSettingsFile.WriteString('Logging', 'EnableLogging', 'True')
      else
 				iniSettingsFile.WriteString('Logging', 'EnableLogging', 'False');

       if bolFadeMenu then
          iniSettingsFile.WriteString('DisplayOptions', 'FadeMenu', 'True')
        else
          iniSettingsFile.WriteString('DisplayOptions', 'FadeMenu', 'False');

      iniSettingsFile.WriteString('Connection', 'ConnectionType', strConnectionType);
      iniSettingsFile.WriteString('Connection', 'ProxyIP', strConnectionProxyIP);
      iniSettingsFile.WriteString('Connection', 'ProxyPort', strConnectionProxyPort);

 			iniSettingsFile.WriteString('DisplayOptions', 'GlobalHotKey', strGlobalHotKey);
			iniSettingsFile.WriteString('DisplayOptions', 'Language', strLocale);
      iniSettingsFile.WriteString('DisplayOptions', 'Theme', strCurrentTheme);
      iniSettingsFile.WriteString('DisplayOptions', 'ThemeColor', strCurrentThemeColor);
      iniSettingsFile.WriteString('DisplayOptions', 'ThemeCustomColor', strThemeCustomColor);
      iniSettingsFile.WriteString('DisplayOptions', 'TaskbarIcon', strTaskbarIcon);

      iniSettingsFile.WriteString('PlatformInternal', 'LastVersion', strLastVersion);

      iniSettingsFile.WriteString('AppDirectory', 'Show64BitOnlyApps', strShow64BitOnlyApps);

			// Figure out menu position
			if Left < screen.WorkAreaRect.Left+100 then
				strEndPositionHorizontal:='Left'
			else if Left > Screen.WorkAreaRect.Right-Width-100 then
				strEndPositionHorizontal:='Right'
			else if (Left > (Screen.WorkAreaRect.Right div 2) - (Width div 2) - 200) and (Left < (Screen.WorkAreaRect.Right div 2) - (Width div 2) + 200) then
				strEndPositionHorizontal:='Center'
			else
				strEndPositionHorizontal:=strStartPositionHorizontal;

			if Top > Screen.WorkAreaRect.Bottom-Height-100 then
				strEndPositionVertical:='Bottom'
			else if Top < screen.WorkAreaRect.Top+100 then
				strEndPositionVertical:='Top'
			else if (Top > (Screen.WorkAreaRect.Bottom div 2) - (Height div 2) - 200) and (Top < (Screen.WorkAreaRect.Bottom div 2) - (Height div 2) + 200) then
				strEndPositionVertical:='Middle'
			else
				strEndPositionVertical:=strStartPositionVertical;

			iniSettingsFile.WriteString('DisplayOptions', 'StartPositionHorizontal', strEndPositionHorizontal);
			iniSettingsFile.WriteString('DisplayOptions', 'StartPositionVertical', strEndPositionVertical);
			iniSettingsFile.WriteInteger('DisplayOptions', 'AlphaBlendMain', intAlphaBlendMain);

      if bolSystemWideEnvironmentVariables then
				iniSettingsFile.WriteString('SystemIntegration', 'SystemWideEnvironmentVariables', 'True')
      else
 				iniSettingsFile.WriteString('SystemIntegration', 'SystemWideEnvironmentVariables', 'False');

			iniSettingsFile.UpdateFile();
			FreeAndNil(iniSettingsFile);
		end;
  end;
end;

procedure TFrmMenu.SetupButtons();
// Search for the installed apps and index them in the list and button arrays
var
	tsrchDirectory: TSearchRec;
	tsrchSubDirectory: TSearchRec;
	strTempSubDir: String;
	strCurrentAppName: String;
	strCurrentAppPath: String;
	//intCounter: integer;
	ptrFileInfo: pointer;
	lngFileInfoSize: Longint;
	dwdFileInfoLength: DWORD;
	ptrFileInfoLanguage : Pointer;
	ptrFileInfoData: Pointer;
	strFileInfoQuery: String;
	uintFileInfoDataLength: Uint;
	//FileInfo: TSHFileInfo;
  //ticoTemp: TIcon;
  hicoLarge: Hicon;
  hicoSmall: Hicon;
	intCounter, intPAFIcons, intPAFIconCounter: integer;
	iniAppInfo: TINIFile;
	strPAFPublisher, strPAFDescription, strPAFPackageVersion, strPAFDisplayVersion, strPortableAppName, strCategory: string;
  strPAFHomepageURL, strPAFDonateURL: string;
  intCategory: integer;
	strPAFStart, strPAFStartBase: string;
	iniSettingsFile: TINIFile;
  intAppsToLoad, intCurrentAppLoading: Integer;
  strExtractIconPath: string;
  strExtractDisplayNamePath: string;
  strBaseAppName: string;
  strDotNetVersion: string;
  strBaseAppID: string;
begin
  LogWrite('Info', Self.Name, 'Setting up app list');

	iniSettingsFile:=TINIFile.Create(ExtractFileDir(Application.ExeName) + '\Data\PortableAppsMenu.ini');
  bolMenuBusy:=true;

  // Reset Category Array to the default set of 10 + other
  if Length(arrAppCategories)>11 then
    for intCounter := 11 to Length(arrAppCategories)-1 do
      arrAppCategories[intCounter].Destroy;
  SetLength(arrAppCategories,11);

  // Setup Buttons
  arrAppButtonLabels[0]:=lblAppButton01;
  arrAppButtonLabels[1]:=lblAppButton02;
  arrAppButtonLabels[2]:=lblAppButton03;
  arrAppButtonLabels[3]:=lblAppButton04;
  arrAppButtonLabels[4]:=lblAppButton05;
  arrAppButtonLabels[5]:=lblAppButton06;
  arrAppButtonLabels[6]:=lblAppButton07;
  arrAppButtonLabels[7]:=lblAppButton08;
  arrAppButtonLabels[8]:=lblAppButton09;
  arrAppButtonLabels[9]:=lblAppButton10;
  arrAppButtonLabels[10]:=lblAppButton11;
  arrAppButtonLabels[11]:=lblAppButton12;
  arrAppButtonLabels[12]:=lblAppButton13;
  arrAppButtonLabels[13]:=lblAppButton14;
  arrAppButtonLabels[14]:=lblAppButton15;
  arrAppButtonLabels[15]:=lblAppButton16;
  arrAppButtonLabels[16]:=lblAppButton17;
  arrAppButtonLabels[17]:=lblAppButton18;
  arrAppButtonLabels[18]:=lblAppButton19;
  arrAppButtonLabels[19]:=lblAppButton20;

  arrAppButtonBackgrounds[0]:=imgAppButtonBackground01;
  arrAppButtonBackgrounds[1]:=imgAppButtonBackground02;
  arrAppButtonBackgrounds[2]:=imgAppButtonBackground03;
  arrAppButtonBackgrounds[3]:=imgAppButtonBackground04;
  arrAppButtonBackgrounds[4]:=imgAppButtonBackground05;
  arrAppButtonBackgrounds[5]:=imgAppButtonBackground06;
  arrAppButtonBackgrounds[6]:=imgAppButtonBackground07;
  arrAppButtonBackgrounds[7]:=imgAppButtonBackground08;
  arrAppButtonBackgrounds[8]:=imgAppButtonBackground09;
  arrAppButtonBackgrounds[9]:=imgAppButtonBackground10;
  arrAppButtonBackgrounds[10]:=imgAppButtonBackground11;
  arrAppButtonBackgrounds[11]:=imgAppButtonBackground12;
	arrAppButtonBackgrounds[12]:=imgAppButtonBackground13;
  arrAppButtonBackgrounds[13]:=imgAppButtonBackground14;
  arrAppButtonBackgrounds[14]:=imgAppButtonBackground15;
  arrAppButtonBackgrounds[15]:=imgAppButtonBackground16;
  arrAppButtonBackgrounds[16]:=imgAppButtonBackground17;
  arrAppButtonBackgrounds[17]:=imgAppButtonBackground18;
  arrAppButtonBackgrounds[18]:=imgAppButtonBackground19;
  arrAppButtonBackgrounds[19]:=imgAppButtonBackground20;

  arrAppButtonForegrounds[0]:=imgAppButtonForeground01;
  arrAppButtonForegrounds[1]:=imgAppButtonForeground02;
  arrAppButtonForegrounds[2]:=imgAppButtonForeground03;
  arrAppButtonForegrounds[3]:=imgAppButtonForeground04;
  arrAppButtonForegrounds[4]:=imgAppButtonForeground05;
  arrAppButtonForegrounds[5]:=imgAppButtonForeground06;
  arrAppButtonForegrounds[6]:=imgAppButtonForeground07;
  arrAppButtonForegrounds[7]:=imgAppButtonForeground08;
  arrAppButtonForegrounds[8]:=imgAppButtonForeground09;
  arrAppButtonForegrounds[9]:=imgAppButtonForeground10;
  arrAppButtonForegrounds[10]:=imgAppButtonForeground11;
  arrAppButtonForegrounds[11]:=imgAppButtonForeground12;
  arrAppButtonForegrounds[12]:=imgAppButtonForeground13;
  arrAppButtonForegrounds[13]:=imgAppButtonForeground14;
  arrAppButtonForegrounds[14]:=imgAppButtonForeground15;
  arrAppButtonForegrounds[15]:=imgAppButtonForeground16;
  arrAppButtonForegrounds[16]:=imgAppButtonForeground17;
  arrAppButtonForegrounds[17]:=imgAppButtonForeground18;
  arrAppButtonForegrounds[18]:=imgAppButtonForeground19;
  arrAppButtonForegrounds[19]:=imgAppButtonForeground20;

  arrAppButtonIcons[0]:=imgAppButtonIcon01;
  arrAppButtonIcons[1]:=imgAppButtonIcon02;
  arrAppButtonIcons[2]:=imgAppButtonIcon03;
	arrAppButtonIcons[3]:=imgAppButtonIcon04;
  arrAppButtonIcons[4]:=imgAppButtonIcon05;
  arrAppButtonIcons[5]:=imgAppButtonIcon06;
  arrAppButtonIcons[6]:=imgAppButtonIcon07;
  arrAppButtonIcons[7]:=imgAppButtonIcon08;
  arrAppButtonIcons[8]:=imgAppButtonIcon09;
  arrAppButtonIcons[9]:=imgAppButtonIcon10;
	arrAppButtonIcons[10]:=imgAppButtonIcon11;
  arrAppButtonIcons[11]:=imgAppButtonIcon12;
  arrAppButtonIcons[12]:=imgAppButtonIcon13;
  arrAppButtonIcons[13]:=imgAppButtonIcon14;
  arrAppButtonIcons[14]:=imgAppButtonIcon15;
  arrAppButtonIcons[15]:=imgAppButtonIcon16;
  arrAppButtonIcons[16]:=imgAppButtonIcon17;
  arrAppButtonIcons[17]:=imgAppButtonIcon18;
  arrAppButtonIcons[18]:=imgAppButtonIcon19;
  arrAppButtonIcons[19]:=imgAppButtonIcon20;

  arrAppButtonButtons[0]:=btnAppButton01;
  arrAppButtonButtons[1]:=btnAppButton02;
  arrAppButtonButtons[2]:=btnAppButton03;
	arrAppButtonButtons[3]:=btnAppButton04;
  arrAppButtonButtons[4]:=btnAppButton05;
  arrAppButtonButtons[5]:=btnAppButton06;
  arrAppButtonButtons[6]:=btnAppButton07;
  arrAppButtonButtons[7]:=btnAppButton08;
  arrAppButtonButtons[8]:=btnAppButton09;
  arrAppButtonButtons[9]:=btnAppButton10;
	arrAppButtonButtons[10]:=btnAppButton11;
  arrAppButtonButtons[11]:=btnAppButton12;
  arrAppButtonButtons[12]:=btnAppButton13;
  arrAppButtonButtons[13]:=btnAppButton14;
  arrAppButtonButtons[14]:=btnAppButton15;
  arrAppButtonButtons[15]:=btnAppButton16;
  arrAppButtonButtons[16]:=btnAppButton17;
  arrAppButtonButtons[17]:=btnAppButton18;
  arrAppButtonButtons[18]:=btnAppButton19;
  arrAppButtonButtons[19]:=btnAppButton20;

  arrAppDividers[0]:=shapeAppDivider01;
  arrAppDividers[1]:=shapeAppDivider02;
  arrAppDividers[2]:=shapeAppDivider03;
	arrAppDividers[3]:=shapeAppDivider04;
  arrAppDividers[4]:=shapeAppDivider05;
  arrAppDividers[5]:=shapeAppDivider06;
  arrAppDividers[6]:=shapeAppDivider07;
  arrAppDividers[7]:=shapeAppDivider08;
  arrAppDividers[8]:=shapeAppDivider09;
  arrAppDividers[9]:=shapeAppDivider10;
	arrAppDividers[10]:=shapeAppDivider11;
  arrAppDividers[11]:=shapeAppDivider12;
  arrAppDividers[12]:=shapeAppDivider13;
  arrAppDividers[13]:=shapeAppDivider14;
  arrAppDividers[14]:=shapeAppDivider15;
  arrAppDividers[15]:=shapeAppDivider16;
  arrAppDividers[16]:=shapeAppDivider17;
  arrAppDividers[17]:=shapeAppDivider18;
  arrAppDividers[18]:=shapeAppDivider19;

  intAppsToLoad:=0;

  FreeAndNil(strlstFullAppReportPAF);
  FreeAndNil(strlstFullAppReportNonPAF);

  strlstFullAppReportPAF:=TStringList.Create;
  strlstFullAppReportNonPAF:=TStringList.Create;

  If FindFirst(strPortableAppsPath+'\*',faAnyFile,tsrchDirectory)=0 Then
	begin
		Repeat
			If ((tsrchDirectory.Attr And faDirectory)<>0) Then
      begin
        strTempSubDir:=tsrchDirectory.FindData.cFileName;
				// Filter out the parent, current, PortableApps.com directories
				if (strTempSubDir <> '.') and (strTempSubDir <> '..') and (strTempSubDir <> 'PortableApps.com') then
          intAppsToLoad:=intAppsToLoad+1;
      end;
    Until FindNext(tsrchDirectory)<>0;
    FindClose(tsrchDirectory);
  end;
  intCurrentAppLoading:=0;
  imgAppLoading.Width:=1;
  imgAppLoading.visible:=true;
  imgAppLoadingBackground.Visible:=true;
  imgapploading.Repaint;
  imgAppLoadingBackground.Repaint;
  //lblAppLoading.Caption:='0 / ' + IntToStr(intAppsToLoad);
  //lblAppLoadingShadow.Caption:=lblAppLoading.Caption;
  //lblAppLoading.Visible:=true;
  //lblAppLoadingShadow.Visible:=true;

  if CheckWin32Version(6, 1) and Assigned(TaskbarList3) then
  begin
    TaskbarList3.SetProgressState(hndMainForm, TBPF_NORMAL);
    TaskbarList3.SetProgressValue(hndMainForm, 0, 100);
  end;

	// process each directory 'next to' the PortableApps.com directory
	If FindFirst(strPortableAppsPath+'\*',faAnyFile,tsrchDirectory)=0 Then
	begin
		Repeat
			If ((tsrchDirectory.Attr And faDirectory)<>0) Then
			begin
				strTempSubDir:=tsrchDirectory.FindData.cFileName;
				// Filter out the parent, current, PortableApps.com directories
				if (strTempSubDir <> '.') and (strTempSubDir <> '..') and (strTempSubDir <> 'PortableApps.com') then
				begin
          LogWrite('Info', Self.Name, 'Processing directory: ' + strTempSubDir);
          intCurrentAppLoading:=intCurrentAppLoading+1;
          //lblAppLoading.Caption:=IntToStr(intCurrentAppLoading) + ' / ' + IntToStr(intAppsToLoad);
          //lblAppLoading.Repaint;
          //lblAppLoadingShadow.Caption:=lblAppLoading.Caption;
          //lblAppLoadingShadow.Repaint;

          imgAppLoading.Width:=Round(intCurrentAppLoading/intAppsToLoad*131);
          imgAppLoading.Repaint;

          if CheckWin32Version(6, 1) and Assigned(TaskbarList3) then
          begin
            TaskbarList3.SetProgressValue(hndMainForm, Round(intCurrentAppLoading/intAppsToLoad*100), 100);
          end;

          //showmessage(lblAppLoading.caption);
					If FileExists(strPortableAppsPath + '\' + strTempSubDir + '\' + 'App\AppInfo\appinfo.ini') then
					begin
						// PortableApps.com Format App
						strCurrentAppPath:=strPortableAppsPath + '\' + strTempSubDir;
						iniAppInfo:=TINIFile.Create(strCurrentAppPath + '\' + 'App\AppInfo\appinfo.ini');
						strPortableAppName:=iniAppInfo.ReadString('Details', 'Name', '[PAF Error - Missing Name]');
            strBaseAppName:=iniAppInfo.ReadString('Details', 'BaseAppName', '');
            strBaseAppID:=iniAppInfo.ReadString('Control', 'BaseAppID', '');
            if SysUtils.TOSVersion.Architecture = arIntelX64 then
              strBaseAppID:=iniAppInfo.ReadString('Control', 'BaseAppID64', strBaseAppID);
						strPAFPublisher:=iniAppInfo.ReadString('Details', 'Publisher', '');
 						strPAFDescription:=iniAppInfo.ReadString('Details', 'Description', '');
 						strPAFHomepageURL:=iniAppInfo.ReadString('Details', 'Homepage', '');
            if (AnsiLowerCase(LeftStr(strPAFHomepageURL,4))<>'http') and (length(strPAFHomepageURL)>0) then
              strPAFHomepageURL:='http://' + strPAFHomepageURL;
            strPAFDonateURL:=iniAppInfo.ReadString('Details', 'Donate', '');
            if (AnsiLowerCase(LeftStr(strPAFDonateURL,4))<>'http') and (length(strPAFDonateURL)>0) then
              strPAFDonateURL:='http://' + strPAFDonateURL;
						strPAFDisplayVersion:=iniAppInfo.ReadString('Version', 'DisplayVersion', '');
						strPAFPackageVersion:=iniAppInfo.ReadString('Version', 'PackageVersion', '');
 						strPAFPackageVersion:=iniAppInfo.ReadString('Version', 'PackageVersion', '');
						intPAFIcons:=iniAppInfo.ReadInteger('Control', 'Icons', 1);
            strExtractIconPath:=iniAppInfo.ReadString('Control', 'ExtractIcon', '');
            strExtractDisplayNamePath:=iniAppInfo.ReadString('Control', 'ExtractName', '');
            strDotNetVersion:=iniAppInfo.ReadString('Dependencies', 'UsesDotNetVersion', '');

            strDotNetVersion:=ValidateDotNetVersion(strDotNetVersion);

            strlstFullAppReportPAF.Add(strPortableAppName + ' ' + strPAFDisplayVersion + ' (' +  strTempSubDir + ')');

						strPAFStartBase:=iniAppInfo.ReadString('Control', 'Start', '[PAF Error - Missing Start]');

						if ((intPAFIcons=1) or bolShowSingleIconForMultiIconApps) then
						begin
							strPAFStart:=strPAFStartBase;
							if (not (iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart))) or bolShowHiddenIcons) then
							begin
								SetLength(arrAppItems, Length(arrAppItems)+1);
								arrAppItems[Length(arrAppItems)-1]:=TAppListItem.Create;
								arrAppItems[Length(arrAppItems)-1].CommandLine:=strCurrentAppPath + '\' + strPAFStart;
								arrAppItems[Length(arrAppItems)-1].WorkingDirectory:=strCurrentAppPath;
								arrAppItems[Length(arrAppItems)-1].DefaultName:=iniAppInfo.ReadString('Details', 'Name', '[PAF Error - Missing Name]');
								arrAppItems[Length(arrAppItems)-1].PortableAppName:=arrAppItems[Length(arrAppItems)-1].DefaultName;
								arrAppItems[Length(arrAppItems)-1].Publisher:=strPAFPublisher;
 								arrAppItems[Length(arrAppItems)-1].Description:=strPAFDescription;
                arrAppItems[Length(arrAppItems)-1].HomepageURL:=strPAFHomepageURL;
                arrAppItems[Length(arrAppItems)-1].DonateURL:=strPAFDonateURL;
                arrAppItems[Length(arrAppItems)-1].DotNetVersion:=strDotNetVersion;
								arrAppItems[Length(arrAppItems)-1].PackageVersion:=strPAFPackageVersion;
 								arrAppItems[Length(arrAppItems)-1].BaseAppID:=StringReplace(strBaseAppID,'%BASELAUNCHERPATH%',strCurrentAppPath,[rfReplaceAll, rfIgnoreCase]);
								arrAppItems[Length(arrAppItems)-1].DisplayVersion:=strPAFDisplayVersion;
                arrAppItems[Length(arrAppItems)-1].IsFavorite:=iniSettingsFile.ReadBool('AppsFavorite',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),False);
                arrAppItems[Length(arrAppItems)-1].AutoStart:=iniSettingsFile.ReadBool('AppsAutoStart',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),False);

                if iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
                  arrAppItems[Length(arrAppItems)-1].IsHidden:=true;


                // Switch to Base App Name if there is one
                if strBaseAppName<>'' then
                  arrAppItems[Length(arrAppItems)-1].DefaultName:=strBaseAppName;


                // Extract the name if necessary
                if (strExtractDisplayNamePath <> '') and FileExists(strPortableAppsPath + '\' + strTempSubDir + '\' + strExtractDisplayNamePath) then
                begin
                	// Store our current EXE for use
									strCurrentAppPath:=strPortableAppsPath + '\' + strTempSubDir + '\' + strExtractDisplayNamePath;
									strCurrentAppName:='';

									if StrCurrentAppName='' then
									begin
										// Ensure that the current file has file info associated
										lngFileInfoSize:=GetFileVersionInfoSize(PChar(strCurrentAppPath), dwdFileInfoLength);
										if (lngFileInfoSize > 0) then
										begin
											GetMem(ptrFileInfo, lngFileInfoSize);
											try
												// Check if the current app has a ProductName
												if GetFileVersionInfo(PChar(strCurrentAppPath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
													begin
														strFileInfoQuery:='ProductName';
														if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
															strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
																HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
														if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
																strCurrentAppName:=strPas(PChar(ptrFileInfoData));
													end;
												finally
													FreeMem(ptrFileInfo, lngFileInfoSize);
											end;
										end;
										if strCurrentAppName='' then
										begin
											GetMem(ptrFileInfo, lngFileInfoSize);
											try
												// Check if the current app has a FileDescription
												if GetFileVersionInfo(PChar(strCurrentAppPath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
												begin
													strFileInfoQuery:='FileDescription';
													if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
														strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
																HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
													if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
														strCurrentAppName := strPas(PChar(ptrFileInfoData));
													end;
											finally
												FreeMem(ptrFileInfo, lngFileInfoSize);
											end;
										end;
									end;
									// If still no App Name, use the filename without the .exe
									if strCurrentAppName='' then
									begin
										strCurrentAppName:=tsrchSubDirectory.FindData.cFileName;
										strCurrentAppName:=LeftStr(strCurrentAppName,length(strCurrentAppName)-4);
									end;
                  arrAppItems[Length(arrAppItems)-1].DefaultName:=strCurrentAppName;
                end;



								if iniSettingsFile.ValueExists('AppsRenamed',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
									arrAppItems[Length(arrAppItems)-1].Caption:=iniSettingsFile.ReadString('AppsRenamed',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),arrAppItems[Length(arrAppItems)-1].DefaultName)
								else
									arrAppItems[Length(arrAppItems)-1].Caption:=arrAppItems[Length(arrAppItems)-1].DefaultName;

								if iniSettingsFile.ValueExists('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
									arrAppItems[Length(arrAppItems)-1].TimesRun:=StrToInt(iniSettingsFile.ReadString('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),'0'))
								else
									arrAppItems[Length(arrAppItems)-1].TimesRun:=0;
                arrAppItems[Length(arrAppItems)-1].TimesRunLast:=arrAppItems[Length(arrAppItems)-1].TimesRun;

								if iniSettingsFile.ValueExists('AppsRecategorized',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
                begin
									strCategory:=iniSettingsFile.ReadString('AppsRecategorized',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),arrAppItems[Length(arrAppItems)-1].DefaultName);
                  intCategory:=-1;
                  for intCounter := 0 to Length(arrAppCategories)-1 do
                    if strCategory=arrAppCategories[intCounter].InternalName then
                      intCategory:=intCounter;
                  if intCategory=-1 then
                  begin
                    SetLength(arrAppCategories,Length(arrAppCategories)+1);
                    arrAppCategories[Length(arrAppCategories)-1]:=TCategoryListItem.Create(strCategory);
                    intCategory:=Length(arrAppCategories)-1;
                  end
                end
								else
                begin
			 						strCategory:=iniAppInfo.ReadString('Details', 'Category', 'Other');
                  strCategory:=StringReplace(strCategory,'&','and',[rfReplaceAll, rfIgnoreCase]);
                  strCategory:=StringReplace(strCategory,'Utility','Utilities',[rfReplaceAll, rfIgnoreCase]);
                  intCategory:=-1;
                  for intCounter := 0 to Length(arrAppCategories)-1 do
                    if strCategory=arrAppCategories[intCounter].InternalName then
                      intCategory:=intCounter;
                  if intCategory=-1 then intCategory:=10;
                end;
                arrAppItems[Length(arrAppItems)-1].CategoryIndex:=intCategory;
                arrAppItems[Length(arrAppItems)-1].InternalCategory:=iniAppInfo.ReadString('Details', 'Category', 'Other');


                // Load or extract the appropriate icon
                if (strExtractIconPath <> '') and FileExists(strPortableAppsPath + '\' + strTempSubDir + '\' + strExtractIconPath) then
                begin
                  // Extract the icon from the indicated EXE
                  ExtractIconEx(PChar(strPortableAppsPath + '\' + strTempSubDir + '\' + strExtractIconPath), 0, hicoLarge, hicoSmall, 1);
                end
                else
                begin
                  // Load the icon normally
                  ExtractIconEx(PChar(strCurrentAppPath + '\' + 'App\AppInfo\appicon.ico'), 0, hicoLarge, hicoSmall, 1);
                end;

								arrAppItems[Length(arrAppItems)-1].Icon:=TIcon.Create;

								if hicoSmall > 1 then
                begin
                  // Use small icon
									arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoSmall)
                end
								else if hicoLarge > 1 then
                begin
                  // Use large icon and indicate it as such
 									arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoLarge);
                  arrAppItems[Length(arrAppItems)-1].IconIsLarge:=true;
                end
                else
                begin
                  // No icon :(
									arrAppItems[Length(arrAppItems)-1].Icon.Handle:=0;
                end;
                DestroyIcon(hicoLarge);
                DestroyIcon(hicoSmall);
							end;
						end
						else
						begin
								for intPAFIconCounter := 1 to intPAFIcons do
								begin
    							strPAFStart:=iniAppInfo.ReadString('Control', 'Start' + IntToStr(intPAFIconCounter), '[PAF Error - Missing Start]');
									if (not iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart))) or bolShowHiddenIcons then
									begin
										SetLength(arrAppItems, Length(arrAppItems)+1);
										arrAppItems[Length(arrAppItems)-1]:=TAppListItem.Create;
										arrAppItems[Length(arrAppItems)-1].CommandLine:=strCurrentAppPath + '\' + strPAFStart;
										arrAppItems[Length(arrAppItems)-1].WorkingDirectory:=strCurrentAppPath;
										arrAppItems[Length(arrAppItems)-1].DefaultName:=iniAppInfo.ReadString('Control', 'Name' + IntToStr(intPAFIconCounter), '[PAF Error - Missing Name]');
										arrAppItems[Length(arrAppItems)-1].PortableAppName:=strPortableAppName;
										arrAppItems[Length(arrAppItems)-1].Publisher:=strPAFPublisher;
										arrAppItems[Length(arrAppItems)-1].PackageVersion:=strPAFPackageVersion;
                    if strPAFStart = strPAFStartBase then
                      arrAppItems[Length(arrAppItems)-1].BaseAppID:=StringReplace(strBaseAppID,'%BASELAUNCHERPATH%',strCurrentAppPath,[rfReplaceAll, rfIgnoreCase]);
										arrAppItems[Length(arrAppItems)-1].DisplayVersion:=strPAFDisplayVersion;
                    arrAppItems[Length(arrAppItems)-1].HomepageURL:=strPAFHomepageURL;
                    arrAppItems[Length(arrAppItems)-1].DonateURL:=strPAFDonateURL;
                    arrAppItems[Length(arrAppItems)-1].DotNetVersion:=strDotNetVersion;
                    arrAppItems[Length(arrAppItems)-1].IsFavorite:=iniSettingsFile.ReadBool('AppsFavorite',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),False);
                    arrAppItems[Length(arrAppItems)-1].AutoStart:=iniSettingsFile.ReadBool('AppsAutoStart',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),False);

                    if iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
                      arrAppItems[Length(arrAppItems)-1].IsHidden:=true;

										if iniSettingsFile.ValueExists('AppsRenamed',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
											arrAppItems[Length(arrAppItems)-1].Caption:=iniSettingsFile.ReadString('AppsRenamed',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),arrAppItems[Length(arrAppItems)-1].DefaultName)
										else
											arrAppItems[Length(arrAppItems)-1].Caption:=arrAppItems[Length(arrAppItems)-1].DefaultName;

     								if iniSettingsFile.ValueExists('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
    									arrAppItems[Length(arrAppItems)-1].TimesRun:=StrToInt(iniSettingsFile.ReadString('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),'0'))
		    						else
				    					arrAppItems[Length(arrAppItems)-1].TimesRun:=0;
                    arrAppItems[Length(arrAppItems)-1].TimesRunLast:=arrAppItems[Length(arrAppItems)-1].TimesRun;

     								if iniSettingsFile.ValueExists('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
    									arrAppItems[Length(arrAppItems)-1].TimesRun:=StrToInt(iniSettingsFile.ReadString('TimesRun',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),'0'))
		    						else
				    					arrAppItems[Length(arrAppItems)-1].TimesRun:=0;

                    if iniSettingsFile.ValueExists('AppsRecategorized',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart)) then
                    begin
                      strCategory:=iniSettingsFile.ReadString('AppsRecategorized',MakePathIntoINIKey(strTempSubDir+'\'+strPAFStart),arrAppItems[Length(arrAppItems)-1].DefaultName);
                      intCategory:=-1;
                      for intCounter := 0 to Length(arrAppCategories)-1 do
                        if strCategory=arrAppCategories[intCounter].InternalName then
                          intCategory:=intCounter;
                      if intCategory=-1 then
                      begin
                        SetLength(arrAppCategories,Length(arrAppCategories)+1);
                        arrAppCategories[Length(arrAppCategories)-1]:=TCategoryListItem.Create(strCategory);
                        intCategory:=Length(arrAppCategories)-1;
                      end
                    end
                    else
                    begin
                      strCategory:=iniAppInfo.ReadString('Details', 'Category', 'Other');
                      strCategory:=StringReplace(strCategory,'&','and',[rfReplaceAll, rfIgnoreCase]);
                      intCategory:=-1;
                      for intCounter := 0 to Length(arrAppCategories)-1 do
                        if strCategory=arrAppCategories[intCounter].InternalName then
                          intCategory:=intCounter;
                      if intCategory=-1 then intCategory:=10;
                    end;
                    arrAppItems[Length(arrAppItems)-1].CategoryIndex:=intCategory;
                    arrAppItems[Length(arrAppItems)-1].InternalCategory:=iniAppInfo.ReadString('Details', 'Category', 'Other');


                    If FileExists(strPortableAppsPath + '\' + strTempSubDir + '\' + 'App\AppInfo\appinfo.ini') then
                      ExtractIconEx(PChar(strCurrentAppPath + '\' + 'App\AppInfo\appicon' + IntToStr(intPAFIconCounter) + '.ico'), 0, hicoLarge, hicoSmall, 1);
										arrAppItems[Length(arrAppItems)-1].Icon:=TIcon.Create;
										if hicoSmall > 1 then
											arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoSmall)
								    else if hicoLarge > 1 then
                    begin
 									    arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoLarge);
                      arrAppItems[Length(arrAppItems)-1].IconIsLarge:=true;
                    end
                    else
											arrAppItems[Length(arrAppItems)-1].Icon.Handle:=0;
                    DestroyIcon(hicoLarge);
                    DestroyIcon(hicoSmall);
									end;
								end;
						end;
						FreeAndNil(iniAppInfo);
            DestroyIcon(hicoLarge);
            DestroyIcon(hicoSmall);
					end
					else
					begin
						// process each EXE in the current subdirectory
						If FindFirst(strPortableAppsPath+ '\'+tsrchDirectory.FindData.cFileName+'\*.exe',faAnyFile,tsrchSubDirectory)=0 Then
						begin
							Repeat
							// Ensure it's a directory and not an uninstaller
							If (LowerCase(tsrchSubDirectory.FindData.cFileName) <> 'uninstall.exe') AND (NOT iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+tsrchSubDirectory.FindData.cFileName)) OR bolShowHiddenIcons) AND ((tsrchSubDirectory.Attr And faDirectory)=0) Then
								begin
									// Store our current EXE for use
									strCurrentAppPath:=strPortableAppsPath+ '\'+tsrchDirectory.FindData.cFileName+'\'+tsrchSubDirectory.FindData.cFileName;
									strCurrentAppName:='';

									if StrCurrentAppName='' then
									begin
										// Ensure that the current file has file info associated
										lngFileInfoSize:=GetFileVersionInfoSize(PChar(strCurrentAppPath), dwdFileInfoLength);
										if (lngFileInfoSize > 0) then
										begin
											GetMem(ptrFileInfo, lngFileInfoSize);
											try
												// Check if the current app has a ProductName
												if GetFileVersionInfo(PChar(strCurrentAppPath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
													begin
														strFileInfoQuery:='ProductName';
														if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
															strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
																HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
														if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
																strCurrentAppName:=strPas(PChar(ptrFileInfoData));
													end;
												finally
													FreeMem(ptrFileInfo, lngFileInfoSize);
											end;
										end;
										if strCurrentAppName='' then
										begin
											GetMem(ptrFileInfo, lngFileInfoSize);
											try
												// Check if the current app has a FileDescription
												if GetFileVersionInfo(PChar(strCurrentAppPath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
												begin
													strFileInfoQuery:='FileDescription';
													if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
														strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
																HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
													if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
														strCurrentAppName := strPas(PChar(ptrFileInfoData));
													end;
											finally
												FreeMem(ptrFileInfo, lngFileInfoSize);
											end;
										end;
									end;
									// If still no App Name, use the filename without the .exe
									if strCurrentAppName='' then
									begin
										strCurrentAppName:=tsrchSubDirectory.FindData.cFileName;
										strCurrentAppName:=LeftStr(strCurrentAppName,length(strCurrentAppName)-4);
									end;

									SetLength(arrAppItems, Length(arrAppItems)+1);
									arrAppItems[Length(arrAppItems)-1]:=TAppListItem.Create;
									arrAppItems[Length(arrAppItems)-1].CommandLine:=strCurrentAppPath;
									arrAppItems[Length(arrAppItems)-1].WorkingDirectory:=ExtractFileDir(strCurrentAppPath);
									arrAppItems[Length(arrAppItems)-1].Caption:=strCurrentAppName;
                  arrAppItems[Length(arrAppItems)-1].PortableAppName:=LowerCase(strTempSubDir);
									arrAppItems[Length(arrAppItems)-1].DefaultName:=strCurrentAppName;
                  arrAppItems[Length(arrAppItems)-1].CategoryIndex:=10; //Other
                  arrAppItems[Length(arrAppItems)-1].InternalCategory:='Other';
                  arrAppItems[Length(arrAppItems)-1].IsFavorite:=iniSettingsFile.ReadBool('AppsFavorite',MakePathIntoINIKey(strTempSubDir+'\'+tsrchSubDirectory.FindData.cFileName),False);
                  arrAppItems[Length(arrAppItems)-1].AutoStart:=iniSettingsFile.ReadBool('AppsAutoStart',MakePathIntoINIKey(strTempSubDir+'\'+tsrchSubDirectory.FindData.cFileName),False);
                  if iniSettingsFile.ValueExists('AppsHidden',MakePathIntoINIKey(strTempSubDir+'\'+tsrchSubDirectory.FindData.cFileName)) then
                    arrAppItems[Length(arrAppItems)-1].IsHidden:=true;

                  strlstFullAppReportNonPAF.Add(strCurrentAppName + ' (' +  StringReplace(strCurrentAppPath, strPortableAppsPath+ '\', '', [rfReplaceAll, rfIgnoreCase]) + ')');

									// Check for renamed app
									arrAppItems[Length(arrAppItems)-1].Caption:=iniSettingsFile.ReadString('AppsRenamed',MakePathIntoINIKey(RightStr(strCurrentAppPath,(Length(strCurrentAppPath)-Length((strPortableAppsPath+ '\'))))),strCurrentAppName);

   								if iniSettingsFile.ValueExists('TimesRun',MakePathIntoINIKey(RightStr(strCurrentAppPath,(Length(strCurrentAppPath)-Length((strPortableAppsPath+ '\')))))) then
  									arrAppItems[Length(arrAppItems)-1].TimesRun:=StrToInt(iniSettingsFile.ReadString('TimesRun',MakePathIntoINIKey(RightStr(strCurrentAppPath,(Length(strCurrentAppPath)-Length((strPortableAppsPath+ '\'))))),'0'))
	  							else
		  							arrAppItems[Length(arrAppItems)-1].TimesRun:=0;
                  arrAppItems[Length(arrAppItems)-1].TimesRunLast:=arrAppItems[Length(arrAppItems)-1].TimesRun;



								if iniSettingsFile.ValueExists('AppsRecategorized',MakePathIntoINIKey(RightStr(strCurrentAppPath,(Length(strCurrentAppPath)-Length((strPortableAppsPath+ '\')))))) then
                begin
									strCategory:=iniSettingsFile.ReadString('AppsRecategorized',MakePathIntoINIKey(RightStr(strCurrentAppPath,(Length(strCurrentAppPath)-Length((strPortableAppsPath+ '\'))))),'Other');
                  intCategory:=-1;
                  for intCounter := 0 to Length(arrAppCategories)-1 do
                    if strCategory=arrAppCategories[intCounter].InternalName then
                      intCategory:=intCounter;
                  if intCategory=-1 then
                  begin
                    SetLength(arrAppCategories,Length(arrAppCategories)+1);
                    arrAppCategories[Length(arrAppCategories)-1]:=TCategoryListItem.Create(strCategory);
                    intCategory:=Length(arrAppCategories)-1;
                  end
                end
								else
                begin
			 						strCategory:='Other';
                  strCategory:=StringReplace(strCategory,'&','and',[rfReplaceAll, rfIgnoreCase]);
                  intCategory:=-1;
                  for intCounter := 0 to Length(arrAppCategories)-1 do
                    if strCategory=arrAppCategories[intCounter].InternalName then
                      intCategory:=intCounter;
                  if intCategory=-1 then intCategory:=10;
                end;
                arrAppItems[Length(arrAppItems)-1].CategoryIndex:=intCategory;
                arrAppItems[Length(arrAppItems)-1].InternalCategory:='Other';
									ExtractIconEx(PChar(strCurrentAppPath), 0, hicoLarge, hicoSmall, 1);
									arrAppItems[Length(arrAppItems)-1].Icon:=TIcon.Create;
									if hicoSmall > 1 then
										arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoSmall)
								  else if hicoLarge > 1 then
 									  arrAppItems[Length(arrAppItems)-1].Icon.Handle:=CopyIcon(hicoLarge)
                  else
										arrAppItems[Length(arrAppItems)-1].Icon.Handle:=0;
                  DestroyIcon(hicoLarge);
                  DestroyIcon(hicoSmall);
								end;
							Until FindNext(tsrchSubDirectory)<>0;
							FindClose(tsrchSubDirectory);
						End;
					End;
				End;
			end;
			Until FindNext(tsrchDirectory)<>0;
			FindClose(tsrchDirectory);
	end;

	// Sort the applications into alphabetical order
	//for intCounter:=0 to Length(arrAppItems)-1 do begin
   //	intMin:=intCounter;
		//for intLook:=intCounter+1 to Length(arrAppItems)-1 do
		//	if ansiLowerCase(arrAppItems[intLook].Caption)<ansiLowerCase(arrAppItems[intMin].Caption) then intMin:=intLook;
		//		TempAppListItem:=arrAppItems[intMin];
     //   arrAppItems[intMin]:=arrAppItems[intCounter];
		 //	arrAppItems[intCounter]:=TempAppListItem;
		//end;

  if CheckWin32Version(6, 1) and Assigned(TaskbarList3) then
  begin
    TaskbarList3.SetProgressState(hndMainForm, TBPF_NOPROGRESS);
  end;

	// If we have more applications that app icon positions, enable scrolling
	if Length(arrMenuItems) > Length( arrAppButtonLabels ) then
		imgButtonScrollDown.Visible:=True;

	FreeAndNil(iniSettingsFile);
  imgAppLoadingBackground.Visible:=false;
  lblAppLoading.Visible:=false;
  lblAppLoadingShadow.Visible:=false;
  imgAppLoading.Visible:=false;
  bolMenuBusy:=false;

  LogWrite('Info', Self.Name, 'Completed app list');
end;

procedure TfrmMenu.SortButtons();
var
	intCounter : integer;
  intMin : integer;
  intLook : integer;
  TempMenuListItem: TMenuListItem;
  strCurrentSortString: string;
  strCurrentFindString: string;
//    bolUseCategories: boolean;
  //bolShowAllApps: boolean;
//  bolSecondAppPage: boolean;
begin
  LogWrite('Info', Self.Name, 'Sorting app list');

  // Reset our app list array
  for intCounter:=0 to Length(arrMenuItems)-1 do begin
    arrMenuItems[intCounter].Destroy;
  end;
  SetLength(arrMenuItems,0);

  // Reset our shown category list array
  for intCounter:=0 to Length(arrAppCategories)-1 do begin
    arrAppCategories[intCounter].Shown:=false;
  end;

  // Prepare app menu items
  for intCounter:=0 to Length(arrAppItems)-1 do begin
    strCurrentSortString:='';
    if (bolLiveSearchResults) or (not bolUseCategories) or (not bolSecondAppPage and not bolShowAllApps) or (not bolSecondAppPage and not bolShowAllApps) or arrAppCategories[arrAppItems[intCounter].CategoryIndex].Expanded or (arrAppItems[intCounter].IsFavorite and not bolSecondAppPage) then
    begin
      if arrAppItems[intCounter].IsFavorite and not bolSecondAppPage and not bolLiveSearchResults then
        strCurrentSortString:=strCurrentSortString+'0~'
      else
        strCurrentSortString:=strCurrentSortString+'1~';
      if (bolUseCategories and ((bolShowAllApps and not arrAppItems[intCounter].IsFavorite) or bolSecondAppPage)) and not bolLiveSearchResults then
        strCurrentSortString:=strCurrentSortString+arrAppCategories[arrAppItems[intCounter].CategoryIndex].DisplayName+'~';
      if not bolSecondAppPage and not bolShowAllApps and not arrAppItems[intCounter].IsFavorite and not bolLiveSearchResults then
        strCurrentSortString:=strCurrentSortString+Format('%.10d', [(2147483647 - arrAppItems[intCounter].TimesRun)])+'~';
      if bolHidePortableInAppNames then begin
        strCurrentSortString:=strCurrentSortString+StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(arrAppItems[intCounter].Caption,', Portable Edition','',[]),', Portable','',[]),' PortableApps.com',' XXX^^^XXX^^^',[]),' Portable','',[]),' XXX^^^XXX^^^',' PortableApps.com',[]);
        strCurrentFindString:=StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(arrAppItems[intCounter].Caption,', Portable Edition','',[]),', Portable','',[]),' PortableApps.com',' XXX^^^XXX^^^',[]),' Portable','',[]),' XXX^^^XXX^^^',' PortableApps.com',[]);
      end
      else begin
        strCurrentSortString:=strCurrentSortString+arrAppItems[intCounter].Caption;
        strCurrentFindString:=arrAppItems[intCounter].Caption;
      end;
      if (bolLiveSearchResults and bolSearchWithinAppDescriptions) then
        strCurrentFindString:=strCurrentFindString+arrAppItems[intCounter].Description;
      if (not bolLiveSearchResults and (bolSecondAppPage or bolShowAllApps or arrAppItems[intCounter].IsFavorite or (arrAppItems[intCounter].TimesRun>-1))) or (bolLiveSearchResults and ((Length(edtLiveSearch.text)=0) or (Pos(LowerCase(edtLiveSearch.text), LowerCase(strCurrentFindString))>0))) then
      begin
        SetLength(arrMenuItems,Length(arrMenuItems)+1);
        arrMenuItems[Length(arrMenuItems)-1]:=TMenuListItem.Create();
        arrMenuItems[Length(arrMenuItems)-1].Folder:=false;
        arrMenuItems[Length(arrMenuItems)-1].ListIndex:=intCounter;
        arrMenuItems[Length(arrMenuItems)-1].SortBy:=strCurrentSortString;
        if not arrAppItems[intCounter].IsFavorite or bolSecondAppPage then
          arrAppCategories[arrAppItems[intCounter].CategoryIndex].Shown:=true;
      end;
    end
    else
        arrAppCategories[arrAppItems[intCounter].CategoryIndex].Shown:=true;
  end;

  // Prepare folder menu items
  if (bolUseCategories and (bolSecondAppPage or bolShowAllApps)) and not bolLiveSearchResults then
    for intCounter:=0 to Length(arrAppCategories)-1 do
      if arrAppCategories[intCounter].Shown then begin
        SetLength(arrMenuItems,Length(arrMenuItems)+1);
        arrMenuItems[Length(arrMenuItems)-1]:=TMenuListItem.Create();
        arrMenuItems[Length(arrMenuItems)-1].Folder:=true;
        arrMenuItems[Length(arrMenuItems)-1].ListIndex:=intCounter;
        if bolSecondAppPage then
          arrMenuItems[Length(arrMenuItems)-1].SortBy:='1~'+arrAppCategories[intCounter].DisplayName+'~'
        else
          arrMenuItems[Length(arrMenuItems)-1].SortBy:='1~'+arrAppCategories[intCounter].DisplayName+'~';
      end;

  // Sort the menu items
    for intCounter:=0 to Length(arrMenuItems)-1 do begin
  	intMin:=intCounter;
		for intLook:=intCounter+1 to Length(arrMenuItems)-1 do
			//if LowerCase(arrMenuItems[intLook].SortBy)<LowerCase(arrMenuItems[intMin].SortBy) then intMin:=intLook;
      if AnsiCompareText(LowerCase(arrMenuItems[intLook].SortBy),LowerCase(arrMenuItems[intMin].SortBy))<0 then intMin:=intLook;
      TempMenuListItem:=arrMenuItems[intMin];
      arrMenuItems[intMin]:=arrMenuItems[intCounter];
  		arrMenuItems[intCounter]:=TempMenuListItem;
		end;

    if bolSecondAppPage and (Length(arrMenuItems)>18) then
    begin
      SetLength(arrMenuItems,Length(arrMenuItems)+1);
      arrMenuItems[Length(arrMenuItems)-1]:=TMenuListItem.Create();
      arrMenuItems[Length(arrMenuItems)-1].Folder:=false;
      arrMenuItems[Length(arrMenuItems)-1].ListIndex:=0;
      arrMenuItems[Length(arrMenuItems)-1].SortBy:='Hidden';
    end;
    
    //TempMenuListItem.Destroy();

   // for intCounter:=0 to Length(arrMenuItems)-1 do showmessage(arrMenuItems[intCounter].SortBy);


	// OUDATED: Sort the applications into alphabetical order
  //for intCounter:=0 to Length(arrAppItems)-1 do begin
  //	intMin:=intCounter;
	//	for intLook:=intCounter+1 to Length(arrAppItems)-1 do
	//		if (arrAppItems[intLook].IsFavorite>arrAppItems[intMin].IsFavorite) or ((arrAppItems[intLook].IsFavorite=arrAppItems[intMin].IsFavorite) and (ansiLowerCase(arrAppItems[intLook].Caption)<ansiLowerCase(arrAppItems[intMin].Caption))) then intMin:=intLook;
	//			TempAppListItem:=arrAppItems[intMin];
  //      arrAppItems[intMin]:=arrAppItems[intCounter];
	//		arrAppItems[intCounter]:=TempAppListItem;
	//	end;

  if (length(arrMenuItems)>20) and (bolSecondAppPage or bolShowAllApps) and (not bolDisableScrollBar) then
  begin
    scrollAppList.Min:=0;
    if bolSecondAppPage then
      scrollAppList.Max:=length(arrMenuItems)-20
    else
      scrollAppList.Max:=length(arrMenuItems)-20;
    //scrollAppList.PageSize:=Round((20 / (length(arrMenuItems)-20)) * scrollAppList.Max)+1;
//    ShowMessage(inttostr ( scrollAppList.PageSize) + '-' + inttostr (  scrollAppList.Max));
    scrollAppList.Visible:=true;
    arrAppButtonBackgrounds[0].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[1].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[2].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[3].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[4].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[5].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[6].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[7].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[8].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[9].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[10].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[11].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[12].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[13].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[14].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[15].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[16].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[17].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[18].Width:=PixelsAdjusted(224);
    arrAppButtonBackgrounds[19].Width:=PixelsAdjusted(224);
    scrollAppList.Position:=intFirstButton;
  end
  else begin
    scrollAppList.Visible:=false;
    arrAppButtonBackgrounds[0].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[1].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[2].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[3].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[4].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[5].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[6].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[7].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[8].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[9].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[10].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[11].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[12].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[13].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[14].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[15].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[16].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[17].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[18].Width:=PixelsAdjusted(240);
    arrAppButtonBackgrounds[19].Width:=PixelsAdjusted(240);
  end;
end;

procedure TfrmMenu.AddMenuItemExtended(aParentMI: TMenuItem; aAppItem: TAppListItem; aTag: Integer);
var
  bmpTemp        : TBitmap;
  mi             : TMenuItemExtended;
  strDescription : String;
begin
  mi := TMenuItemExtended.Create(aParentMI);
  { Set caption to the name and hint to the location }
  if bolHidePortableInAppNames then
    mi.Caption := StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(aAppItem.Caption,', Portable Edition','',[]),', Portable','',[]),' PortableApps.com',' XXX^^^XXX^^^',[]),' Portable','',[]),' XXX^^^XXX^^^',' PortableApps.com',[])
  else
    mi.Caption := aAppItem.Caption;
  mi.Caption := StringReplace(mi.Caption,'&','&&',[]);
  { Set hint }
  if (aAppItem.Publisher <> '') then
    begin
      mi.Hint := aAppItem.PortableAppName +' ' +aAppItem.DisplayVersion +#13#10 +aAppItem.Publisher +#13#10;
      if (aAppItem.Description <> '') and ((strLocale = 'English') or (strLocale = 'EnglishGB')) then
        if (Length(aAppItem.Description) > 80) then
          begin
            strDescription := aAppItem.Description;
            SetLength(strDescription, 80);
            mi.Hint := mi.Hint +strDescription +'...' +#13#10
          end
        else
          mi.Hint := mi.Hint +aAppItem.Description +#13#10;
      mi.Hint := mi.Hint +aAppItem.WorkingDirectory;
    end
  else
    mi.Hint := aAppItem.CommandLine;
  { Set image }
  if not aAppItem.Icon.Empty then
    try
      bmpTemp := TBitmap.Create;
      bmpTemp.Assign(aAppItem.Icon);
      if (bmpTemp.Width=16) and (bmpTemp.Height=16) then
        mi.ImageIndex := imglstSubmenuIcons.Add(bmpTemp, nil)
      else
        mi.ImageIndex := imglstSubmenuIcons.Add(nil, nil);
    finally
      FreeAndNil(bmpTemp);
    end;
  { Set OnClick event }
  mi.Tag     := aTag;
  mi.OnClick := pmnuitmAppRightClickRunClick;
  aParentMI.Add(mi);
end{AddMenuItem};

function ListSortCompare_MenuItemCaption(p1, p2: Pointer): Integer;
begin
  Result := AnsiCompareText(TMenuItem(p1).Caption, TMenuItem(p2).Caption);
end;

procedure SortChildMenuItems(aParent: TMenuItem; aRecursive: Boolean);
// put the child MenuItems in a TList and use TList.Sort to sort the list
// Then walk through the list and set Items' MenuIndex property accordingly
var
  lst : TList;
  i   : Integer;
begin
  lst := TList.Create;
  try
    for i := 0 to aParent.Count -1 do
      begin
        if aRecursive and (aParent.Items[i].Count > 0) then
          SortChildMenuItems(aParent.Items[i], True);
        lst.Add(aParent.Items[i]);
      end;
    lst.Sort(ListSortCompare_MenuItemCaption);
    for i := 0 to lst.Count -1 do
      TMenuItem(lst[i]).MenuIndex := i;
  finally
    FreeAndNil(lst);
  end;
end;

procedure TfrmMenu.DisplayButtons();
// Draw the icons onto the menu buttons
var
	intCurrentButton: integer;
  bmpTemp : TBitmap;
  brshIcon: hBrush;
  strDescription: string;

begin
  LogWrite('Info', Self.Name, 'Displaying app list');

  // Check app page
  if not bolSecondAppPage and not bolShowAllApps then
    intFirstButton:=0;

  // Double check the first button overflow
  if length(arrMenuItems)<20 then
    intFirstButton:=0
  else
    if intFirstButton+20>Length(arrMenuItems) then
      intFirstButton:=Length(arrMenuItems)-20;
    if intFirstButton<0 then
      intFirstButton:=0;

  brshIcon:= CreateSolidBrush(tclrAppIconTransparent);
	// Loop through the set of buttons
	for intCurrentButton := 0 to length(arrAppButtonLabels)-1 do
	begin
		// If we have an app for this button...
		if intCurrentButton < length(arrMenuItems) then
		begin
			// Ensure the button is visible
			arrAppButtonLabels[intCurrentButton].Visible:= True;
      arrAppButtonButtons[intCurrentButton].Enabled:=True;
      arrAppButtonButtons[intCurrentButton].Visible:=True;
    	arrAppButtonBackgrounds[intCurrentButton].Visible:= True;
			arrAppButtonForegrounds[intCurrentButton].Visible:= True;
			arrAppButtonIcons[intCurrentButton].Visible:= True;
      if intCurrentButton<19 then
        arrAppDividers[intCurrentButton].visible:=false;

      if arrMenuItems[intCurrentButton+intFirstButton].Folder then
      begin
        arrAppButtonLabels[intCurrentButton].Caption:=arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].DisplayName;
        arrAppButtonLabels[intCurrentButton].Caption:=StringReplace(arrAppButtonLabels[intCurrentButton].Caption,'&','&&',[]);
        arrAppButtonButtons[intCurrentButton].Caption:=arrAppButtonLabels[intCurrentButton].Caption;
        arrAppButtonForegrounds[intCurrentButton].Hint:='';
        arrAppButtonButtons[intCurrentButton].Hint:='';
        if bolBoldFolderNames then
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style+[fsBold]
        else
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style-[fsBold];
        arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style-[fsStrikeOut];
        arrAppButtonButtons[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style;
        arrAppButtonIcons[intCurrentButton].Picture:=nil;
        if arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Expanded then
          if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\' + arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].InternalName + 'Open.png')) then
            arrAppButtonIcons[intCurrentButton].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\' + arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].InternalName + 'Open.png')
          else arrAppButtonIcons[intCurrentButton].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\OtherOpen.png')
        else
          if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\' + arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].InternalName + '.png')) then
            arrAppButtonIcons[intCurrentButton].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\' + arrAppCategories[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].InternalName + '.png')
          else arrAppButtonIcons[intCurrentButton].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuCategories\Other.png');
        arrAppButtonLabels[intCurrentButton].Left:=PixelsAdjusted(37);
        arrAppButtonLabels[intCurrentButton].Width:=PixelsAdjusted(218);
        arrAppButtonIcons[intCurrentButton].Left:=PixelsAdjusted(17);
        if strLocaleDirection = 'LTR' then
          arrAppButtonLabels[intCurrentButton].BiDiMode:=bdLeftToRight
        else
          arrAppButtonLabels[intCurrentButton].BiDiMode:=bdRightToLeft;

      end
      else
      begin
        arrAppButtonLabels[intCurrentButton].BiDiMode:=bdLeftToRight;
        if bolUseCategories and (bolShowAllApps or bolSecondAppPage) and (not bolLiveSearchResults) and not (not bolSecondAppPage and arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IsFavorite) then
        begin
          arrAppButtonLabels[intCurrentButton].Left:=PixelsAdjusted(54);
          arrAppButtonLabels[intCurrentButton].Width:=PixelsAdjusted(201);
          arrAppButtonIcons[intCurrentButton].Left:=PixelsAdjusted(34);
        end
        else
        begin
          arrAppButtonLabels[intCurrentButton].Left:=PixelsAdjusted(37);
          arrAppButtonLabels[intCurrentButton].Width:=PixelsAdjusted(218);
          arrAppButtonIcons[intCurrentButton].Left:=PixelsAdjusted(17);
        end;
        // Set caption to the name and hint to the location
        if bolHidePortableInAppNames then
          arrAppButtonLabels[intCurrentButton].Caption:=StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Caption,', Portable Edition','',[]),', Portable','',[]),' PortableApps.com',' XXX^^^XXX^^^',[]),' Portable','',[]),' XXX^^^XXX^^^',' PortableApps.com',[])
        else
          arrAppButtonLabels[intCurrentButton].Caption:=arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Caption;
        arrAppButtonLabels[intCurrentButton].Caption:=StringReplace(arrAppButtonLabels[intCurrentButton].Caption,'&','&&',[]);
        arrAppButtonButtons[intCurrentButton].Caption:=arrAppButtonLabels[intCurrentButton].Caption;
        arrAppButtonIcons[intCurrentButton].Picture:=nil;
        if arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IsFavorite and bolBoldFavorites then
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style+[fsBold]
        else
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style-[fsBold];
        //if arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IsFavorite and not bolLiveSearchResults and not bolShowAllApps and not bolUseCategories then
        //    arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style+[fsBold];

        if (intCurrentButton<19) and ((intCurrentButton+1)<length(arrMenuItems)) and arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IsFavorite and not bolSecondAppPage and not bolLiveSearchResults then
          if arrMenuItems[intCurrentButton+intFirstButton+1].Folder then
            arrAppDividers[intCurrentButton].visible:=true
          else if not arrAppItems[arrMenuItems[intCurrentButton+intFirstButton+1].ListIndex].IsFavorite then
            arrAppDividers[intCurrentButton].visible:=true;

        if arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IsHidden=true then
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style+[fsStrikeOut]
        else
          arrAppButtonLabels[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style-[fsStrikeOut];

        arrAppButtonButtons[intCurrentButton].Font.Style:=arrAppButtonLabels[intCurrentButton].Font.Style;

        if arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].IconIsLarge or bolRunningUnderWine then
        begin
          //arrAppButtonIcons[intCurrentButton].Canvas.Rectangle(0,0,16,16);
          //DrawIconEx(arrAppButtonIcons[intCurrentButton].Canvas.Handle, 0, 0, arrAppItems[intCurrentButton+intFirstButton].Icon.Handle, 16, 16, 0, brshIcon, DI_NORMAL);
          //arrAppButtonIcons[intCurrentButton].Canvas.Refresh;

          bmpTemp := TBitmap.Create;
          bmpTemp.Width := arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon.Width;
          bmpTemp.Height := arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon.Height;
          //bmpTemp.pixelformat:=pf16bit;
          //bmpTemp.Transparent:=true;
          //bmpTemp.TransparentColor:=clRed;
          //bmpTemp.Canvas.Brush.Color:=clRed;
          DrawIconEx(bmpTemp.Canvas.Handle, 0, 0, arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon.Handle, arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon.Width, arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon.Height, 0, brshIcon, DI_NORMAL);
          //bmpTemp.pixelformat:=pf16bit;
          bmpTemp.Canvas.Refresh;
          //bmpTemp.Canvas.Draw(0, 0, arrAppItems[intCurrentButton+intFirstButton].Icon);
          arrAppButtonIcons[intCurrentButton].Canvas.StretchDraw(Rect(0,0,arrAppButtonIcons[intCurrentButton].Width,arrAppButtonIcons[intCurrentButton].height),bmpTemp);
          //arrAppButtonIcons[intCurrentButton].Picture.Bitmap.PixelFormat:=pf32bit;
          FreeAndNil(bmpTemp);


          //bmpTemp := TBitmap.Create;
          //bmpTemp.Width := arrAppItems[intCurrentButton+intFirstButton].Icon.Width;
          //bmpTemp.Height := arrAppItems[intCurrentButton+intFirstButton].Icon.Height;
          //bmpTemp.TransparentColor:=clBlack;
          //bmpTemp.Canvas.Brush.Color:=clBlack;
          //bmpTemp.Canvas.Draw(0, 0, arrAppItems[intCurrentButton+intFirstButton].Icon);
          //arrAppButtonIcons[intCurrentButton].Canvas.StretchDraw(Rect(0,0,arrAppButtonIcons[intCurrentButton].Width,arrAppButtonIcons[intCurrentButton].height),bmpTemp);
          //bmpTemp.Free;
        end
        else
          arrAppButtonIcons[intCurrentButton].Picture.Assign(arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Icon);

        if arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Publisher<>'' then begin
          arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].PortableAppName + ' ' + arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].DisplayVersion;
          if bolShowAppPublishersInToolTips then
            arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppButtonForegrounds[intCurrentButton].Hint+#13#10 + arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Publisher;
          if (arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Description<>'') and ((strLocale = 'English') or (strLocale = 'EnglishGB')) then
            if Length(arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Description)>80 then begin
              strDescription:=arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Description;
              SetLength(strDescription,80);
              arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppButtonForegrounds[intCurrentButton].Hint+#13#10+strDescription+'...'
            end
            else
              arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppButtonForegrounds[intCurrentButton].Hint+#13#10+arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].Description;
          if bolShowAppPathsInToolTips then
            arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppButtonForegrounds[intCurrentButton].Hint+#13#10+arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].WorkingDirectory;
        end
        else
          arrAppButtonForegrounds[intCurrentButton].Hint:=arrAppItems[arrMenuItems[intCurrentButton+intFirstButton].ListIndex].CommandLine;
      end;

		end else
    begin
			// hide the button if we have no app for it
			arrAppButtonLabels[intCurrentButton].Visible:= False;
      arrAppButtonButtons[intCurrentButton].Visible:=False;
      arrAppButtonButtons[intCurrentButton].Enabled:=False;
    	arrAppButtonBackgrounds[intCurrentButton].Visible:= False;
			arrAppButtonForegrounds[intCurrentButton].Visible:= False;
     	arrAppButtonIcons[intCurrentButton].Visible:= False;
      if intCurrentButton<19 then
        arrAppDividers[intCurrentButton].visible:=false;
    end;
	end;
  DeleteObject(brshIcon);
  if (intFirstButton >= (Length(arrMenuItems)-length(arrAppButtonLabels))) or (not bolSecondAppPage and not bolShowAllApps) then
    imgButtonScrollDown.Visible:=False
  else
    imgButtonScrollDown.Visible:=True;
  if intFirstButton = 0 then
    imgButtonScrollUp.Visible:=False
  else
    imgButtonScrollUp.Visible:=True;

  if not bolSecondAppPage and not bolShowAllApps and not bolLiveSearchResults then
  begin
    arrAppDividers[18].visible:=true;
    arrAppButtonLabels[19].Caption:=strAllPortableApps;
    arrAppButtonForegrounds[19].Hint:='';
    arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style-[fsStrikeOut];
    arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style+[fsBold];
    //arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style+[fsItalic];
    arrAppButtonIcons[19].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\forward.png');
		arrAppButtonLabels[19].Visible:= True;
  	arrAppButtonBackgrounds[19].Visible:= True;
  	arrAppButtonForegrounds[19].Visible:= True;
   	arrAppButtonIcons[19].Visible:= True;
    arrAppButtonLabels[19].Left:=PixelsAdjusted(37);
    arrAppButtonLabels[19].Width:=PixelsAdjusted(218);
    arrAppButtonIcons[19].Left:=PixelsAdjusted(17);
    arrAppButtonButtons[19].Caption:=arrAppButtonLabels[19].Caption;
    arrAppButtonButtons[19].Visible:=true;
    arrAppButtonButtons[19].Enabled:=true;
    arrAppButtonButtons[19].Font.Style:=arrAppButtonLabels[19].Font.Style;
  end;

  if bolSecondAppPage and not bolLiveSearchResults then
  begin
    arrAppDividers[18].visible:=true;
    arrAppButtonLabels[19].Caption:=strBackToPageOne;
    arrAppButtonForegrounds[19].Hint:='';
    arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style-[fsStrikeOut];
    arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style+[fsBold];
    //arrAppButtonLabels[19].Font.Style:=arrAppButtonLabels[19].Font.Style+[fsItalic];
    arrAppButtonIcons[19].Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Misc\back.png');
		arrAppButtonLabels[19].Visible:= True;
  	arrAppButtonBackgrounds[19].Visible:= True;
  	arrAppButtonForegrounds[19].Visible:= True;
   	arrAppButtonIcons[19].Visible:= True;
    arrAppButtonLabels[19].Left:=PixelsAdjusted(37);
    arrAppButtonLabels[19].Width:=PixelsAdjusted(218);
    arrAppButtonIcons[19].Left:=PixelsAdjusted(17);
    arrAppButtonButtons[19].Caption:=arrAppButtonLabels[19].Caption;
    arrAppButtonButtons[19].Visible:=true;
    arrAppButtonButtons[19].Enabled:=true;
    arrAppButtonButtons[19].Font.Style:=arrAppButtonLabels[19].Font.Style;
  end;


  frmMenu.Refresh;
end;

procedure TfrmMenu.RebuildTrayAppIcons();
// Draw the icons onto the menu buttons
var
  bmpTemp : TBitmap;
  Nr      : Integer;
  cNr     : Integer;
  cmi     : TMenuItemExtended;
  pngTemp : TPNGImage;
begin
  LogWrite('Info', Self.Name, 'Rebuilding tray icons');

   if not bolLiveSearchResults then
   begin
  // Cascading Menu
    { Clear old application icons in image list }
  while (imglstSubmenuIcons.Count > imglstIndexMHL) do
    imglstSubmenuIcons.Delete(imglstSubmenuIcons.Count -1);
  { Initialize tray menu item favorites }
  miTrayFavorites.Clear;
  for Nr := 0 to High(arrAppItems) do
    if arrAppItems[Nr].IsFavorite then
      AddMenuItemExtended(miTrayFavorites, arrAppItems[Nr], Nr);
  miTrayFavorites.Visible := (miTrayFavorites.Count > 0);
  if miTrayFavorites.Visible then
    SortChildMenuItems(miTrayFavorites, True);
  { Initialize tray menu item applications }
  miTrayApplications.Clear;
  for cNr := 0 to Length(arrAppCategories) -1 do
    if arrAppCategories[cNr].Shown then
      begin
        cmi := TMenuItemExtended.Create(miTrayApplications);
        cmi.Caption := arrAppCategories[cNr].DisplayName;

        pngTemp := TPNGImage.Create;
        bmpTemp := TBitmap.Create;
        try
          if FileExists(PChar(ExtractFileDir(Application.ExeName) +'\App\Graphics\MenuCategories\' +arrAppCategories[cNr].InternalName +'.png')) then
            pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) +'\App\Graphics\MenuCategories\' +arrAppCategories[cNr].InternalName +'.png')
          else
            pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) +'\App\Graphics\MenuCategories\Other.png');
          pngTemp.AssignTo(bmpTemp);
          bmpTemp.AlphaFormat := afDefined;
          if (bmpTemp.Width=16) and (bmpTemp.Height=16) then
            cmi.ImageIndex := imglstSubmenuIcons.Add(bmpTemp, nil)
          else
            cmi.ImageIndex := imglstSubmenuIcons.Add(nil, nil);
        finally
          FreeAndNil(bmpTemp);
          FreeAndNil(pngTemp);
        end;

        for Nr := 0 to High(arrAppItems) do
          if (arrAppItems[Nr].CategoryIndex = cNr) then
            AddMenuItemExtended(cmi, arrAppItems[Nr], Nr);
        miTrayApplications.Add(cmi);
      end;  { if arrAppCategories[cNr].Shown then }
  miTrayApplications.Visible := (miTrayApplications.Count > 0);
  if miTrayApplications.Visible then
    SortChildMenuItems(miTrayApplications, True);
  // Cascading Menu End

  frmMenu.Refresh;
   end;
end;

procedure TfrmMenu.edtDriveNameKeyPress(Sender: TObject; var Key: Char);
begin
  if HiWord(GetKeyState(VK_ESCAPE)) <> 0 then
  begin
		edtDriveName.Visible:=false;
		btnChangeDriveName.Visible:=false;
  end
  else if HiWord(GetKeyState(VK_RETURN)) <> 0 then
  begin
	  Key := #0;
   	btnChangeDriveName.Click;
  end;
end;

procedure TfrmMenu.edtLiveSearchChange(Sender: TObject);
begin
  if edtLiveSearch.Text <> '' then
  begin
    bolLiveSearchResults:=true;
   // edtLiveSearch.Width:=234;
    imgLiveSearchClose.Visible:=true;
        imgLiveSearchIcon.Visible:=false;
  end
  else
  begin
    bolLiveSearchResults:=false;
    //edtLiveSearch.Width:=254;
    imgLiveSearchClose.Visible:=false;
        imgLiveSearchIcon.Visible:=true;
  end;

  intFirstButton:=0;
  SortButtons;
  DisplayButtons;
end;

procedure TfrmMenu.edtLiveSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DOWN:
      SelectNext(Sender as TWinControl,True,True);
    VK_UP:
      SelectNext(btnDocuments as TWinControl,False,True);
  end;
end;

procedure TfrmMenu.edtLiveSearchKeyPress(Sender: TObject; var Key: Char);
var
  bolAppRun: boolean;
begin
  if ((HiWord(GetKeyState(vk_Back)) <> 0) and (HiWord(GetKeyState(vk_Control)) <> 0)) then
  begin
    Key := #0;
    edtLiveSearch.Text:='';
  end;
  if (HiWord(GetKeyState(VK_ESCAPE)) <> 0) then
  begin
    Key := #0;
    edtLiveSearch.Text:='';
    bolLiveSearchResults:=false;

    //edtLiveSearch.Visible:=false;
   // edtLiveSearch.Width:=254;
    imgLiveSearchClose.Visible:=false;
    imgLiveSearchIcon.Visible:=true;
    intFirstButton:=0;
    SortButtons;
    DisplayButtons;
    if bolHideSearchWhenNotInUse then
    begin
      pnlLiveSearchBorder.Visible:=false;
      SelectNext(edtLiveSearch as TWinControl,True,True);
    end
  end
  else if HiWord(GetKeyState(VK_RETURN)) <> 0 then
  begin
    Key := #0;
    if length(arrMenuItems)>0 then
    begin
      arrAppItems[arrMenuItems[0].ListIndex].TimesRun:=arrAppItems[arrMenuItems[0].ListIndex].TimesRun+1;

      bolAppRun:=StartPortableApp(arrAppItems[arrMenuItems[0].ListIndex].CommandLine, arrAppItems[arrMenuItems[0].ListIndex].WorkingDirectory, false, arrAppItems[arrMenuItems[0].ListIndex].DotNetVersion);
      if ((not bolRemainVisible) and bolAppRun) then FadeInOut(False);
      edtLiveSearch.Text:='';
      bolLiveSearchResults:=false;
      if bolHideSearchWhenNotInUse then
      begin
        pnlLiveSearchBorder.Visible:=false;
        if edtLiveSearch.Focused and frmMenu.Showing then
          SelectNext(edtLiveSearch as TWinControl,True,True);
      end;
      //edtLiveSearch.Visible:=false;
     // edtLiveSearch.Width:=254;
      imgLiveSearchClose.Visible:=false;
      imgLiveSearchIcon.Visible:=true;
      intFirstButton:=0;
      SortButtons;
      DisplayButtons;
    end
    end;
end;

procedure TfrmMenu.ClearButtons();
// Clear out our set of icons and release the associated memory
var
	intCounter: integer;
begin
  LogWrite('Info', Self.Name, 'Clearing app buttons');

  SaveStatistics();

	// Destroy each icon in the array
	for intCounter:=0 to Length(arrAppItems) - 1 do
  begin
//    arrAppItems[intCounter].Icon.Free;
  //  DestroyIcon(arrAppItems[intCounter].Icon.Handle);
    arrAppItems[intCounter].Destroy;
  end;

  SetLength(arrAppItems,0);

  lblAppButton01.Caption:='';
  lblAppButton02.Caption:='';
  lblAppButton03.Caption:='';
  lblAppButton04.Caption:='';
  lblAppButton05.Caption:='';
  lblAppButton06.Caption:='';
  lblAppButton07.Caption:='';
  lblAppButton08.Caption:='';
  lblAppButton09.Caption:='';
  lblAppButton10.Caption:='';
  lblAppButton11.Caption:='';
  lblAppButton12.Caption:='';
  lblAppButton13.Caption:='';
  lblAppButton14.Caption:='';
  lblAppButton15.Caption:='';
  lblAppButton16.Caption:='';
  lblAppButton17.Caption:='';
  lblAppButton18.Caption:='';
  lblAppButton19.Caption:='';
  lblAppButton20.Caption:='';

  shapeAppDivider01.Visible:=false;
  shapeAppDivider02.Visible:=false;
  shapeAppDivider03.Visible:=false;
  shapeAppDivider04.Visible:=false;
  shapeAppDivider05.Visible:=false;
  shapeAppDivider06.Visible:=false;
  shapeAppDivider07.Visible:=false;
  shapeAppDivider08.Visible:=false;
  shapeAppDivider09.Visible:=false;
  shapeAppDivider10.Visible:=false;
  shapeAppDivider11.Visible:=false;
  shapeAppDivider12.Visible:=false;
  shapeAppDivider13.Visible:=false;
  shapeAppDivider14.Visible:=false;
  shapeAppDivider15.Visible:=false;
  shapeAppDivider16.Visible:=false;
  shapeAppDivider17.Visible:=false;
  shapeAppDivider18.Visible:=false;
  shapeAppDivider19.Visible:=false;

  imgAppButtonIcon01.Picture:=nil;
  imgAppButtonIcon02.Picture:=nil;
  imgAppButtonIcon03.Picture:=nil;
  imgAppButtonIcon04.Picture:=nil;
  imgAppButtonIcon05.Picture:=nil;
  imgAppButtonIcon06.Picture:=nil;
  imgAppButtonIcon07.Picture:=nil;
  imgAppButtonIcon08.Picture:=nil;
  imgAppButtonIcon09.Picture:=nil;
  imgAppButtonIcon10.Picture:=nil;
  imgAppButtonIcon11.Picture:=nil;
  imgAppButtonIcon12.Picture:=nil;
  imgAppButtonIcon13.Picture:=nil;
  imgAppButtonIcon14.Picture:=nil;
  imgAppButtonIcon15.Picture:=nil;
  imgAppButtonIcon16.Picture:=nil;
  imgAppButtonIcon17.Picture:=nil;
  imgAppButtonIcon18.Picture:=nil;
  imgAppButtonIcon19.Picture:=nil;
  imgAppButtonIcon20.Picture:=nil;

	// Reset Scroll Buttons
	imgButtonScrollUp.Visible:=false;
	imgButtonScrollDown.Visible:=false;
  frmMenu.Repaint;
end;

procedure TfrmMenu.LoadTheme();
var
  iniTheme: TINIFile;
  clrFolderButtons, clrDriveSpace, clrDriveSpaceShadow: TColor;
  strThemeName, strTempColor, strChrome, strBackground, strMatte, strLayout, strFolderButtonsColor: string;
  strAnimationLeft, strAnimationTop, strAnimationWidth, strAnimationHeight: string;
  intAnimationLeft, intAnimationTop, intAnimationWidth, intAnimationHeight: integer;
  intControl: integer;
  bmpTemp: TBitmap;
	pngTemp: TPngImage;
  //imgTemp: TImage;
  //lblTemp: TLabel;
begin
  LogWrite('Info', Self.Name, 'Loading theme');

  if FileExists(PChar(ExtractFileDir(Application.ExeName)+'\' + strThemePath +'\PATheme.ini')) then
  	iniTheme:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\' + strThemePath +'\PATheme.ini')
  else
  	iniTheme:=TINIFile.Create(ExtractFileDir(Application.ExeName)+'\App\Graphics\Themes\Default\PATheme.ini');

  strChrome:=iniTheme.ReadString('Menu', 'Chrome', 'none');
  strBackground:=iniTheme.ReadString('Menu', 'Background', 'custom');
  strMatte:=iniTheme.ReadString('Menu', 'Matte', 'standard');
  strLayout:=iniTheme.ReadString('Menu', 'Layout', 'classic');

  if strLayout = 'classic' then
  begin
    if (frmMenu.Showing) and (frmMenu.Height<>PixelsAdjusted(573)) and ((Screen.WorkAreaRect.Height-frmMenu.Height) = frmMenu.top) then
    begin
      frmMenu.Height:=PixelsAdjusted(573);
      frmMenu.Top:=Screen.WorkAreaRect.Height - frmMenu.Height;
    end
    else
      frmMenu.Height:=PixelsAdjusted(573);
    if strLastThemeLayout='modern' then
      for intControl := 0 to ComponentCount-1 do
      begin
        if (Components[intControl] is TShape) then
          TShape(Components[intControl]).Top:=TShape(Components[intControl]).Top+PixelsAdjusted(15);
        if (Components[intControl] is TLabel) then
          TLabel(Components[intControl]).Top:=TLabel(Components[intControl]).Top+PixelsAdjusted(15);
        if (Components[intControl] is TImage) then
          TImage(Components[intControl]).Top:=TImage(Components[intControl]).Top+PixelsAdjusted(15);
        if (Components[intControl] is TButton) then
          TButton(Components[intControl]).Top:=TButton(Components[intControl]).Top+PixelsAdjusted(15);
        if (Components[intControl] is TEdit) then
          TEdit(Components[intControl]).Top:=TEdit(Components[intControl]).Top+PixelsAdjusted(15);

      end;
      pnlLiveSearchBorder.Top:=PixelsAdjusted(30);
    intDriveSpaceWidth:=PixelsAdjusted(235);
    imgDriveSpace.Left:=PixelsAdjusted(15);
    imgDriveSpace.Top:=PixelsAdjusted(549);
    imgDriveSpace.height:=PixelsAdjusted(13);
    lblDriveSpace.Left:=PixelsAdjusted(20);
    lblDriveSpaceShadow.Left:=PixelsAdjusted(21);
    imgEject.Left:=PixelsAdjusted(263);
    imgButtonLeftIcon.Left:=PixelsAdjusted(291);
    imgEject.Top:=PixelsAdjusted(544);
    imgButtonLeftIcon.Top:=PixelsAdjusted(549);
    imgEject.Height:=PixelsAdjusted(22);
    imgEject.Width:=PixelsAdjusted(68);
    imgClose.Left:=PixelsAdjusted(331);
    imgButtonRightIcon.Left:=PixelsAdjusted(359);
    imgClose.Top:=PixelsAdjusted(544);
    imgButtonRightIcon.Top:=PixelsAdjusted(549);
    imgClose.Height:=PixelsAdjusted(22);
    imgClose.Width:=PixelsAdjusted(68);
    scrollAppList.Top:=PixelsAdjusted(70);
    imgPersonalPicture.Top:=PixelsAdjusted(8);
    imgOEMLogoTopRight.Top:=PixelsAdjusted(15);
    strLastThemeLayout:='classic';
    pnlLiveSearchBackground.Top:=PixelsAdjusted(1);
    imgLiveSearchClose.Top:=PixelsAdjusted(2);
    imgLiveSearchIcon.Top:=PixelsAdjusted(2);
    edtLiveSearch.Top:=PixelsAdjusted(2);
  end
  else
  begin
    if (frmMenu.Showing) and (frmMenu.Height<>PixelsAdjusted(558)) and ((Screen.WorkAreaRect.Height-frmMenu.Height) = frmMenu.top) then
    begin
      frmMenu.Height:=PixelsAdjusted(558);
      frmMenu.Top:=Screen.WorkAreaRect.Height - frmMenu.Height;
    end
    else
      frmMenu.Height:=PixelsAdjusted(558);
    if strLastThemeLayout='classic' then
      for intControl := 0 to ComponentCount-1 do
      begin
        if (Components[intControl] is TShape) then
          TShape(Components[intControl]).Top:=TShape(Components[intControl]).Top-PixelsAdjusted(15);
        if (Components[intControl] is TLabel) then
          TLabel(Components[intControl]).Top:=TLabel(Components[intControl]).Top-PixelsAdjusted(15);
        if (Components[intControl] is TImage) then
          TImage(Components[intControl]).Top:=TImage(Components[intControl]).Top-PixelsAdjusted(15);
        if (Components[intControl] is TButton) then
          TButton(Components[intControl]).Top:=TButton(Components[intControl]).Top-PixelsAdjusted(15);
        if (Components[intControl] is TEdit) then
          TEdit(Components[intControl]).Top:=TEdit(Components[intControl]).Top-PixelsAdjusted(15);

      end;
      pnlLiveSearchBorder.Top:=PixelsAdjusted(15);
    strLastThemeLayout:='modern';
    intDriveSpaceWidth:=PixelsAdjusted(250);
    imgDriveSpace.Left:=PixelsAdjusted(11);
    imgDriveSpace.Top:=PixelsAdjusted(532);
    imgDriveSpace.height:=PixelsAdjusted(17);
    lblDriveSpace.Left:=PixelsAdjusted(13);
    lblDriveSpaceShadow.Left:=PixelsAdjusted(14);
    imgEject.Left:=PixelsAdjusted(270);
    imgButtonLeftIcon.Left:=PixelsAdjusted(295);
    imgEject.Top:=PixelsAdjusted(530);
    imgButtonLeftIcon.Top:=PixelsAdjusted(534);
    imgEject.Height:=PixelsAdjusted(21);
    imgEject.Width:=PixelsAdjusted(62);
    imgClose.Left:=PixelsAdjusted(333);
    imgButtonRightIcon.Left:=PixelsAdjusted(358);
    imgClose.Top:=PixelsAdjusted(530);
    imgButtonRightIcon.Top:=PixelsAdjusted(534);
    imgClose.Height:=PixelsAdjusted(21);
    imgClose.Width:=PixelsAdjusted(62);
    scrollAppList.Top:=PixelsAdjusted(55);
    imgPersonalPicture.Top:=PixelsAdjusted(8);
    imgOEMLogoTopRight.Top:=PixelsAdjusted(8);
    pnlLiveSearchBackground.Top:=PixelsAdjusted(1);
    imgLiveSearchClose.Top:=PixelsAdjusted(2);
    imgLiveSearchIcon.Top:=PixelsAdjusted(2);
    edtLiveSearch.Top:=PixelsAdjusted(2);
  end;
  imgBackground.Top:=0;
  imgBackgroundChrome.Top:=0;
  imgBackground.Height:=frmMenu.Height;
  imgBackgroundChrome.Height:=frmMenu.Height;

  if strMatte = 'standard' then
    if (bolRunningUnderWin9x or bolRunningUnderWine) then
      imgMatte.Picture.Graphic:=nil
    else
      imgMatte.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\matte.png');

  if strBackground = 'custom' then
    if (bolRunningUnderWin9x or bolRunningUnderWine) then
      if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background_opaque.png')) then
        imgBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background_opaque.png')
      else if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background.png')) then
        imgBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background.png')
      else
        imgBackground.Picture.Graphic:=nil
    else if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background.png')) then
        imgBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background.png')
      else
        imgBackground.Picture.Graphic:=nil
  else
    imgBackground.Picture.Graphic:=nil;

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\animation.gif')) then
      //begin
       // TempGIF := TGifImage.Create;
        //try
          //TempGIF.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\animation.gif');
          //TempGIF.Animate := True;
          //imgAnimation.Picture.Graphic.Assign(TempGIF);
          //imgAnimation.Visible:=true;
        //finally
        //  TempGIF.Free;
        //end;
//        imgBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\background.png')
      //end
      begin
        imgAnimation.Visible:=true;
        imgAnimation.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\animation.gif');
        strAnimationLeft:=iniTheme.ReadString('Menu', 'AnimationLeft', '0');
        strAnimationTop:=iniTheme.ReadString('Menu', 'AnimationTop', '0');
        strAnimationWidth:=iniTheme.ReadString('Menu', 'AnimationWidth', 'full');
        strAnimationHeight:=iniTheme.ReadString('Menu', 'AnimationHeight', 'full');

        if TryStrToInt(strAnimationLeft,intAnimationLeft) then
          imgAnimation.Left:=PixelsAdjusted(intAnimationLeft)
        else
          imgAnimation.Left:=0;

        if TryStrToInt(strAnimationTop,intAnimationTop) then
          imgAnimation.Top:=PixelsAdjusted(intAnimationTop)
        else
          imgAnimation.Top:=0;

        imgAnimation.AutoSize:=false;

        if strAnimationWidth='auto' then
          imgAnimation.autosize:=true
        else if TryStrToInt(strAnimationWidth,intAnimationWidth) then
          imgAnimation.Width:=PixelsAdjusted(intAnimationWidth)
        else
          imgAnimation.Width:=frmMenu.Width;

        if strAnimationHeight='auto' then
          imgAnimation.autosize:=true
        else if TryStrToInt(strAnimationHeight,intAnimationHeight) then
          imgAnimation.Height:=PixelsAdjusted(intAnimationHeight)
        else
          imgAnimation.Height:=frmMenu.Height;
      end
  else
    begin
      imgAnimation.Picture.Graphic:=nil;
      imgAnimation.Visible:=false;
    end;

  if strChrome = 'custom' then
    if (bolRunningUnderWin9x or bolRunningUnderWine) then
      begin
        if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome_opaque.png')) then
          imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome_opaque.png')
        else if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome.png')) then
          imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome.png')
        else
          imgBackgroundChrome.Picture.Graphic:=nil;
      end
      else
      begin
        if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome.png')) then
          imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\chrome.png')
       else
          imgBackgroundChrome.Picture.Graphic:=nil;
      end
  else
    if ansiLowerCase(strChrome) = 'none' then
      imgBackgroundChrome.Picture.Graphic:=nil
    else
    if (bolRunningUnderWin9x or bolRunningUnderWine) then
    begin
      if FileExists(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '_opaque.png') then
        imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '_opaque.png')
      else
        if FileExists(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png') then
          imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png');
    end
    else
      if FileExists(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png') then
        imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\' + strChrome + '.png')
      else
        imgBackgroundChrome.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\Chrome\default_white.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\live_search_close.png')) then
  	imgLiveSearchClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\live_search_close.png')
  else
   	imgLiveSearchClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\live_search_close.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\drive_space_slider.png')) then
  	imgDriveSpace.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\drive_space_slider.png')
  else
   	imgDriveSpace.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\drive_space_slider.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\drive_space_slider.png')) then
  	imgAppLoading.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\drive_space_slider.png')
  else
   	imgAppLoading.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\drive_space_slider.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\app_progress_background.png')) then
  	imgAppLoadingBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\app_progress_background.png')
  else
   	imgAppLoadingBackground.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\app_progress_background.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')) then
  	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_left_normal.png')
  else
   	imgEject.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_left_normal.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')) then
  	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_right_normal.png')
  else
   	imgClose.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_right_normal.png');

  if (bolRunningOnRemovableDrive or bolAlwaysShowEject) and not bolAlwaysShowPower then
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_eject.png')) then
      imgButtonLeftIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_eject.png')
    else
      imgButtonLeftIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_icon_eject.png')
  else
    if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_power.png')) then
      imgButtonLeftIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_power.png')
    else
      imgButtonLeftIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_icon_power.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_close.png')) then
  	imgButtonRightIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_icon_close.png')
  else
   	imgButtonRightIcon.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_icon_close.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\appbutton_hover.png')) then
  	imgAppButtonHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\appbutton_hover.png')
  else
   	imgAppButtonHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\appbutton_hover.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_hover.png')) then
  	imgFolderButtonHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_hover.png')
  else
   	imgFolderButtonHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\folderbutton_hover.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_divider.png')) then
  begin
  	imgDivider1.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_divider.png');
    imgDivider2.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_divider.png');
    imgDivider3.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\folderbutton_divider.png');
  end
  else
    begin
  	imgDivider1.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\folderbutton_divider.png');
    imgDivider2.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\folderbutton_divider.png');
    imgDivider3.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\folderbutton_divider.png');
  end;

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrollup_hover.png')) then
  	imgScrollUpHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrollup_hover.png')
  else
   	imgScrollUpHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_scrollup_hover.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrollup_normal.png')) then
  	imgScrollUpNormal.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrollup_normal.png')
  else
   	imgScrollUpNormal.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_scrollup_normal.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrolldown_hover.png')) then
  	imgScrollDownHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrolldown_hover.png')
  else
   	imgScrollDownHover.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_scrolldown_hover.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrolldown_normal.png')) then
  	imgScrollDownNormal.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\button_scrolldown_normal.png')
  else
   	imgScrollDownNormal.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuButtons\button_scrolldown_normal.png');

  imgButtonScrollUp.Picture:=imgScrollUpNormal.Picture;
  imgButtonScrollDown.Picture:=imgScrollDownNormal.Picture;

  // Temporary hard-coding of submenu image icons
  pngTemp:=TPNGImage.Create;
  bmpTemp:=TBitmap.Create;
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\explore_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(25,bmpTemp,nil);
  //if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\documents_16.png')) then
  //  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\documents_16.png')
  //else
    pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\documents_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(26,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\music_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(27,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\pictures_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(28,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\videos_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(29,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\backup_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(30,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\manage_apps_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(31,bmpTemp,nil);
  pngTemp.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\options_16.png');
  pngTemp.AssignTo(bmpTemp);
  bmpTemp.AlphaFormat:=afIgnored;
  imglstSubmenuIcons.Replace(32,bmpTemp,nil);
//  bmpTemp.FreeImage;
 // pngTemp.Free;


	// Load Icons (temporarily hard-coded to App\DefaultData until theme setup finalized)
	// **TODO - Check data directory first, add icon theme loader
  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\backup.png')) then
  	imgBackup.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\backup.png')
  else
   	imgBackup.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\backup.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\documents.png')) then
  	imgDocuments.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\documents.png')
  else
   	imgDocuments.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\documents.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\explore.png')) then
  	imgExplore.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\explore.png')
  else
   	imgExplore.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\explore.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\help.png')) then
  	imgHelp.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\help.png')
  else
   	imgHelp.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\help.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\music.png')) then
  	imgMusic.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\music.png')
  else
   	imgMusic.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\music.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\options.png')) then
  	imgOptions.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\options.png')
  else
   	imgOptions.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\options.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\manage_apps.png')) then
  	imgManageApps.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\manage_apps.png')
  else
   	imgManageApps.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\manage_apps.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\pictures.png')) then
  	imgPictures.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\pictures.png')
  else
   	imgPictures.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\pictures.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\search.png')) then
  	imgSearch.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\search.png')
  else
   	imgSearch.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\search.png');

  if FileExists(PChar(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\videos.png')) then
  	imgVideos.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\' + strThemePath +'\menu_icons\videos.png')
  else
   	imgVideos.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\App\Graphics\MenuIcons\videos.png');

  tclrAppIconFont:=HexColorToTColor(iniTheme.ReadString('ButtonApplications', 'FontColor', '000000'));
  tclrAppIconFadedFont:=HexColorToTColor(iniTheme.ReadString('ButtonApplications', 'FadedFontColor', '999999'));
  tclrAppIconTransparent:=HexColorToTColor(iniTheme.ReadString('ButtonApplications', 'IconTransparentColor', 'FFFFFF'));

  lblAppButton01.Font.Color:=tclrAppIconFont;
  lblAppButton02.Font.Color:=tclrAppIconFont;
  lblAppButton03.Font.Color:=tclrAppIconFont;
  lblAppButton04.Font.Color:=tclrAppIconFont;
  lblAppButton05.Font.Color:=tclrAppIconFont;
  lblAppButton06.Font.Color:=tclrAppIconFont;
  lblAppButton07.Font.Color:=tclrAppIconFont;
  lblAppButton08.Font.Color:=tclrAppIconFont;
  lblAppButton09.Font.Color:=tclrAppIconFont;
  lblAppButton10.Font.Color:=tclrAppIconFont;
  lblAppButton11.Font.Color:=tclrAppIconFont;
  lblAppButton12.Font.Color:=tclrAppIconFont;
  lblAppButton13.Font.Color:=tclrAppIconFont;
  lblAppButton14.Font.Color:=tclrAppIconFont;
  lblAppButton15.Font.Color:=tclrAppIconFont;
  lblAppButton16.Font.Color:=tclrAppIconFont;
  lblAppButton17.Font.Color:=tclrAppIconFont;
  lblAppButton18.Font.Color:=tclrAppIconFont;
  lblAppButton19.Font.Color:=tclrAppIconFont;
  lblAppButton20.Font.Color:=tclrAppIconFont;


  // Temporary addition
  if strCurrentThemeColor='Default' then
    strCurrentThemeColor:=iniTheme.ReadString('Menu', 'DefaultBackgroundColor', 'Red');


  edtLiveSearch.Font.Color:=HexColorToTColor(iniTheme.ReadString('SearchBox', 'FontColor', '000000'));
  edtLiveSearch.Color:=HexColorToTColor(iniTheme.ReadString('SearchBox', strCurrentThemeColor+'BackgroundColor', iniTheme.ReadString('SearchBox', 'BackgroundColor', 'FFFFFF')));
  pnlLiveSearchBackground.Color:=edtLiveSearch.Color;
  pnlLiveSearchBorder.Color:=HexColorToTColor(iniTheme.ReadString('SearchBox', 'BorderColor', '000000'));

  strFolderButtonsColor:=iniTheme.ReadString('ButtonFolders', 'FontColor', 'FFFFFF');
  strFolderButtonsColor:=iniTheme.ReadString('ButtonFolders', 'FontColor'+strCurrentThemeColor, strFolderButtonsColor);
  clrFolderButtons:=HexColorToTColor(strFolderButtonsColor);
  lblButtonDocuments.Font.Color:=clrFolderButtons;
  lblButtonMusic.Font.Color:=clrFolderButtons;
  lblButtonPictures.Font.Color:=clrFolderButtons;
  lblButtonVideos.Font.Color:=clrFolderButtons;
  lblButtonExplore.Font.Color:=clrFolderButtons;
  lblButtonBackup.Font.Color:=clrFolderButtons;
  lblButtonOptions.Font.Color:=clrFolderButtons;
  lblButtonManageApps.Font.Color:=clrFolderButtons;
  lblButtonSearch.Font.Color:=clrFolderButtons;
  lblButtonHelp.Font.Color:=clrFolderButtons;
  lblButtonOEM.Font.Color:=clrFolderButtons;
	clrDriveSpace:=HexColorToTColor(iniTheme.ReadString('DriveSpace', 'FontColor', 'FFFFFF'));
  lblDriveSpace.Font.Color:=clrDriveSpace;
 	clrDriveSpaceShadow:=HexColorToTColor(iniTheme.ReadString('DriveSpace', 'FontShadowColor', '888888'));
  lblDriveSpaceShadow.Font.Color:=clrDriveSpaceShadow;
  shapeAppDivider01.Pen.Color:=HexColorToTColor(iniTheme.ReadString('ButtonApplications', 'DividerColor', 'C0C0C0'));
  shapeAppDivider02.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider03.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider04.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider05.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider06.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider07.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider08.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider09.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider10.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider11.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider12.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider13.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider14.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider15.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider16.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider17.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider18.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider19.Pen.Color:=shapeAppDivider01.Pen.Color;
  shapeAppDivider01.Pen.Color:=HexColorToTColor(iniTheme.ReadString('ButtonFolders', 'DividerColor', 'C0C0C0'));

  if strCurrentThemeColor='Custom' then
    strTempColor:=strThemeCustomColor
  else
  begin
    strTempColor:=iniTheme.ReadString('Menu', strCurrentThemeColor+'BackgroundColor', 'BLANK');
    if strTempColor='BLANK' then
      strTempColor:=iniTheme.ReadString('Menu', 'BackgroundColor', 'FFFFFF');
  end;

  frmMenu.Color:=HexColorToTColor(strTempColor);

  if ansiLowerCase(iniTheme.ReadString('DriveSpace', 'StretchImage', 'true'))='true' then
    imgDriveSpace.Stretch:=true
  else
  	imgDriveSpace.Stretch:=false;
  imgAppLoading.Stretch:=imgDriveSpace.Stretch;
  if strCurrentTheme='Custom' then
  begin
    strThemeName:=iniTheme.ReadString('ThemeDetails', 'Name', 'Custom');
    pmnuitmOptionsThemeCustom.Caption:='... (' + strThemeName + ')';
  end
  else
    pmnuitmOptionsThemeCustom.Caption:='...';

  iniTheme.Destroy;

    LogWrite('Info', Self.Name, 'Theme loaded');
end;

function TfrmMenu.DoesSHA256HashMatchIfExists(strFilePath: string; strHash: string): boolean;
// compares file to hash, returns true if file doesn't exist
var
  strFileHash: string;

begin
  if not FileExists(strFilePath) then
    Result:=true
  else
  begin
    strFileHash:=GetSHA256Hash(strFilePath);
    if AnsiLowerCase(strFileHash) = AnsiLowerCase(strHash) then
      Result:=true
    else
      Result:=false;
  end;
end;

function TfrmMenu.GetSHA256Hash(strFilePath: string): string;
begin
  if not FileExists(strFilePath) then
    Result:='ERRORDOESNOTEXIST'
  else
    Result:=LowerCase(System.Hash.THashSHA2.GetHashStringFromFile(strFilePath));
end;

function TfrmMenu.StartPortableApp(strFilePath: string; strWorkingDirectory: string; bolAdmin: boolean; strDotNetVersion: string): boolean;
var
  bolAppAppearsClean: boolean;
  strSecurityMessage, strDotNetMessage: string;
  strFileInfoQuery: String;
  ptrFileInfo: pointer;
	lngFileInfoSize: Longint;
	dwdFileInfoLength: DWORD;
	ptrFileInfoLanguage : Pointer;
	ptrFileInfoData: Pointer;
	uintFileInfoDataLength: Uint;
  strProductName, strCompanyName: string;
  searchDLLsInPath: TSearchRec;
  strPackageVersion: string;
  strLauncherName: string;
  iniAppInfo: TINIFile;
  strInvalidDLL: string;
  bolRunApp: boolean;
  strDownloadPath: string;
  intDotNetRelease: integer;
begin
  // Barring any baddies, we start the app
  bolAppAppearsClean:=true;

  // We should run the app
  bolRunApp:=true;

  if not FileExists(strFilePath) then
  begin
    // This should not happen. Translate later.
    Application.MessageBox(PChar('Could not find: '+strFilePath+'.'), 'PortableApps.com Platform' ,MB_ICONEXCLAMATION);
    Result:=false;
    exit
  end
  else
  begin
    // Portable app exists
    strProductName:='';
    strCompanyName:='';
    lngFileInfoSize:=GetFileVersionInfoSize(PChar(strFilePath), dwdFileInfoLength);
    if (lngFileInfoSize > 0) then
    begin
      GetMem(ptrFileInfo, lngFileInfoSize);
      try
      // Check if the current app has a ProductName
      if GetFileVersionInfo(PChar(strFilePath), dwdFileInfoLength, lngFileInfoSize, ptrFileInfo) then
      begin
        strFileInfoQuery:='ProductName';
        if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
          strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
          HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
        if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
          strProductName:=strPas(PChar(ptrFileInfoData));
        strFileInfoQuery:='CompanyName';
        if VerQueryValue(ptrFileInfo,'\VarFileInfo\Translation',ptrFileInfoLanguage, uintFileInfoDataLength) then
          strFileInfoQuery:=Format('\StringFileInfo\%0.4x%0.4x\%s'#0,[LoWord(LongInt(ptrFileInfoLanguage^)),
          HiWord(LongInt(ptrFileInfoLanguage^)), strFileInfoQuery]);
        if VerQueryValue(ptrFileInfo,PChar(strFileInfoQuery),ptrFileInfoData,uintFileInfoDataLength) then
          strCompanyName:=strPas(PChar(ptrFileInfoData));
      end;
      finally
        FreeMem(ptrFileInfo, lngFileInfoSize);
      end;
    end;


    if (strCompanyName = 'PortableApps.com') then
    begin
      // Check for added DLLs in base
      if findfirst(ExtractFilePath(strFilePath) + '*.dll', faAnyFile, searchDLLsInPath) = 0 then
        begin
          FindClose(searchDLLsInPath);
          bolAppAppearsClean:=false;
          strSecurityMessage:=stringreplace(strSecurityWarningUnexpectedDLLs, '%LAUNCHERFILE%', strFilePath, [rfReplaceAll, rfIgnoreCase]);
          Application.MessageBox(PCHAR(strSecurityMessage),'PortableApps.com Platform',MB_ICONEXCLAMATION)
        end;

      // Check for replaced DLLs in app
      strLauncherName:=AnsiLowerCase(ExtractFileName(strFilePath));
      strInvalidDLL:='';

      if MatchStr(strLauncherName, ['2048portable.exe','babelpadportable.exe','clamwinportable.exe','foxitreaderportable.exe','googlechromeportable.exe','kasperskytdsskillerportable.exe','libreofficeportable.exe','mcafeestingerportable.exe','operamailportable.exe','operaportable.exe','skypeportable.exe','thunderbirdportable.exe']) then
      begin
        if FileExists(ExtractFilePath(strFilePath) + 'App\AppInfo\Appinfo.ini') then
        begin
          iniAppInfo:=TINIFile.Create(ExtractFilePath(strFilePath) + 'App\AppInfo\Appinfo.ini');
          strPackageVersion:=iniAppInfo.ReadString('Version', 'PackageVersion', '0.0.0.0');
          FreeAndNil(iniAppInfo);
        end
        else
          strPackageVersion:='0.0.0.0';

        //ClamWin Portable
        if (strLauncherName = 'clamwinportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'App\ClamWin\bin\quserex.DLL') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'App\ClamWin\bin\quserex.DLL';
        end;

        //2048 Portable
        if (strLauncherName = '2048portable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'App\2048\D3dCompiler_46.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'App\2048\D3dCompiler_46.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'App\2048\dbgcore.DLL') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'App\2048\dbgcore.DLL';
        end;

        //Opera Mail Portable
        if (strLauncherName = 'operamailportable.exe') then
        begin
          ShowMessage(ExtractFilePath(strFilePath));
          if FileExists(ExtractFilePath(strFilePath) + 'app\operamail\MSIMG32.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\operamail\MSIMG32.dll';
          if (strPackageVersion = '1.0.1044.0') and not DoesSHA256HashMatchIfExists(ExtractFilePath(strFilePath) + 'App\operamail\operamail.dll', '52a7aa30375878ebdebc87c03e2cbcd080d9bc92d601e02a7bde43b779f2451f') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'App\operamail\operamail.dll';
        end;

        //LibreOffice Portable
        if (strLauncherName = 'libreofficeportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\libreoffice\program\MSIMG32.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\libreoffice\program\MSIMG32.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'app\libreoffice\program\dbgcore.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\libreoffice\program\dbgcore.dll';
        end;

        //McAfee Stinger Portable
        if (strLauncherName = 'mcafeestingerportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\stinger\DWrite.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\stinger\DWrite.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'app\stinger\DXGIDebug.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\stinger\DXGIDebug.dll';
        end;

        //Skype Portable
        if (strLauncherName = 'skypeportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\skype\phone\DWrite.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\skype\phone\DWrite.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'app\skype\phone\api-ms-win-core-winrt-string-l1-1-0.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\skype\phone\api-ms-win-core-winrt-string-l1-1-0.dll';
        end;

        //Kaspersky TDSSKiller Portable
        if (strLauncherName = 'kasperskytdsskillerportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\TDSSKiller\riched20.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\TDSSKiller\riched20.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'app\TDSSKiller\version.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\TDSSKiller\version.dll';
        end;

        //Google Chrome Portable
        if (strLauncherName = 'googlechromeportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\chrome-bin\DWrite.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\chrome-bin\DWrite.dll';
        end;

        //Opera Portable
        if (strLauncherName = 'operaportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\opera\' + strPackageVersion + '\DWrite.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\opera\' + strPackageVersion + '\DWrite.dll';
        end;

        //BabelPad Portable
        if (strLauncherName = 'babelpadportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\babelpad\msimg32.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\babelpad\msimg32.dll';
        end;

        //Thunderbird Portable
        if (strLauncherName = 'thunderbirdportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\thunderbird\DWrite.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\thunderbird\DWrite.dll';
        end;

        //Foxit Reader Portable
        if (strLauncherName = 'foxitreaderportable.exe') then
        begin
          if FileExists(ExtractFilePath(strFilePath) + 'app\Foxit Reader\plugins\UpdaterLOC.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\Foxit Reader\plugins\UpdaterLOC.dll';
          if FileExists(ExtractFilePath(strFilePath) + 'app\Foxit Reader\msimg32.dll') then
            strInvalidDLL:=ExtractFilePath(strFilePath) + 'app\Foxit Reader\msimg32.dll';
        end;

        // Show message and set variable
        if strInvalidDLL <> '' then
        begin
          bolAppAppearsClean:=false;
          strSecurityMessage:=stringreplace(strSecurityWarningHashFailure, '%HASHEDFILE%', strInvalidDLL, [rfReplaceAll, rfIgnoreCase]);
          Application.MessageBox(PCHAR(strSecurityMessage),'PortableApps.com Platform',MB_ICONEXCLAMATION)
        end;
      end;
    end;
  end;
  //strSecurityWarningHashFailure

  if strDotNetVersion<>'' then CheckDotNetVersions;

  if (strDotNetVersion='1') and not bolDotNet1 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '1.0', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#1.0';
  end;

  if (strDotNetVersion='1.1') and not bolDotNet1_1 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '1.1', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#1.1';
  end;

  if (strDotNetVersion='2') and not bolDotNet2 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '2.0', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#2.0';
  end;

  if (strDotNetVersion='3') and not bolDotNet3 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '3.0', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#3.0';
  end;

  if (strDotNetVersion='3.5') and not bolDotNet3_5 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '3.5', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#3.5';
  end;

  if (strDotNetVersion='4') and not bolDotNet4 then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '4.x', [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#4';
  end;

  if (LeftStr(strDotNetVersion,2)='4.') then
  begin
    intDotNetRelease:=GetDotNetReleaseFromVersion(strDotNetVersion);
    if intDotNetRelease>intDotNet4Release then
      if ((Win32MajorVersion = 6) and (Win32MinorVersion = 2) and ((strDotNetVersion='4.7') or (strDotNetVersion='4.8'))) then
      begin
        bolRunApp:=false;
        strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '[Windows 8.1]', [rfReplaceAll, rfIgnoreCase]);
        strDownloadPath:='https://portableapps.com/support/dotnet#4.x';
      end
      else
      begin
        bolRunApp:=false;
        strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', strDotNetVersion, [rfReplaceAll, rfIgnoreCase]);
        //strDownloadPath:='https://portableapps.com/support/dotnet#' + strDotNetVersion;
        strDownloadPath:='https://portableapps.com/support/dotnet#4.x';
      end;
  end;

  if strDotNetVersion='4or2' then
  begin
    if not bolDotNet2 and not bolDotNet4 then
    begin
      bolRunApp:=false;
      strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '2.0/4.0+', [rfReplaceAll, rfIgnoreCase]);
      strDownloadPath:='https://portableapps.com/support/dotnet#4or2';
    end;
  end;

  if strDotNetVersion='4or3' then
  begin
    if not (bolDotNet3 or bolDotNet3_5) and not bolDotNet4 then
    begin
      bolRunApp:=false;
      strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '3.0/4.0+', [rfReplaceAll, rfIgnoreCase]);
      strDownloadPath:='https://portableapps.com/support/dotnet#4or3';
    end;
  end;

  if strDotNetVersion='4or3.5' then
  begin
    if not bolDotNet3_5 and not bolDotNet4 then
    begin
      bolRunApp:=false;
      strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '3.5/4.0+', [rfReplaceAll, rfIgnoreCase]);
      strDownloadPath:='https://portableapps.com/support/dotnet#4or3.5';
    end;
  end;

  if (strDotNetVersion='5bundle') or (strDotNetVersion='6bundle') or (strDotNetVersion='7bundle') then
  begin
    if not bolDotNetBundle and bolRunningUnderWin7 then
    // Assume the app itself is set to require Windows 7 or higher and will alert the user
    begin
      bolRunApp:=false;

      if ((Win32MajorVersion = 6) and (Win32MinorVersion = 2)) then
      begin
        strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '[Windows 8.1]', [rfReplaceAll, rfIgnoreCase]);
        strDownloadPath:='https://portableapps.com/support/dotnet#bundles';
      end
      else
      begin
        strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', '[Platform Update for Windows 7]', [rfReplaceAll, rfIgnoreCase]);
        strDownloadPath:='https://portableapps.com/support/dotnet#bundles';
      end;


    end;
  end;

  if ((strDotNetVersion='1core') and not bolDotNetCore1) or ((strDotNetVersion='1.1core') and not bolDotNetCore1_1)
    or ((strDotNetVersion='2core') and not bolDotNetCore2) or ((strDotNetVersion='2core') and not bolDotNetCore2)
    or ((strDotNetVersion='2.1core') and not bolDotNetCore2_1) or ((strDotNetVersion='2.2core') and not bolDotNetCore2_2)
    or ((strDotNetVersion='3core') and not bolDotNetCore3) or ((strDotNetVersion='3core') and not bolDotNetCore3_1)
    or ((strDotNetVersion='5') and not bolDotNet5) or ((strDotNetVersion='6') and not bolDotNet6) or ((strDotNetVersion='7') and not bolDotNet7) then
  begin
    bolRunApp:=false;
    strDotNetMessage:=stringreplace(strRequiresDotNetFramework, '%VERSION%', strDotNetVersion, [rfReplaceAll, rfIgnoreCase]);
    strDownloadPath:='https://portableapps.com/support/dotnet#netorcore'
  end;

  if (not bolRunApp) and (strDotNetMessage<>'') then
  begin
    frmDialog.strTitle:='PortableApps.com Platform';
    frmDialog.strMessage:=strDotNetMessage;
    frmDialog.strIconType:='DOWNLOAD';
    frmDialog.bolButtons:=true;
    frmDialog.strButtonOK:=strYes;
    frmDialog.strButtonCancel:=strNo;
    frmDialog.bolOKDefault:=true;
    frmDialog.bolOKOnly:=false;
    frmDialog.ShowModal;
    if frmDialog.strButton='OK' then
        OpenURL(strDownloadPath);
    //Application.MessageBox(PCHAR(strDotNetMessage),'PortableApps.com Platform',MB_ICONEXCLAMATION)
    frmDialog.Close;
    frmDialog.Destroy;
    frmDialog:=TfrmDialog.Create(nil);
  end;


  // If no baddies and we should run it, we start the app
  if (bolAppAppearsClean and bolRunApp) then
  begin
    if (bolAdmin) then
      ShellExecute(0, 'runas', PChar(strFilePath+#0), Nil, PChar(strWorkingDirectory+#0), SW_SHOWNORMAL)
    else
      ShellExecute(0, 'open', PChar(strFilePath+#0), Nil, PChar(strWorkingDirectory+#0), SW_SHOWNORMAL);
    Result:=true
  end
  else
    Result:=false;
end;

// ... and that's all folks... (aka app end)
end.

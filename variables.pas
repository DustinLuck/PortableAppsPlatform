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

unit variables;

interface
uses Classes, Windows;

const
  // Also update project properties
	APPVERSIONFRIENDLY='22.0.1'; // For display to the user
	APPVERSION='22.0.1.0'; // 4 number dotted version
  // IMPORTANT: Set beta to true or false for each build
  BOLRUNNINGBETA=false;
  VK_P=$50;
  VK_M=$4D;

  DOTNET_4_5_RELEASEVALUE=378389;
  DOTNET_4_5_1_RELEASEVALUE=378675;
  DOTNET_4_5_2_RELEASEVALUE=379893;
  DOTNET_4_6_RELEASEVALUE=393295;
  DOTNET_4_6_1_RELEASEVALUE=394254;
  DOTNET_4_6_2_RELEASEVALUE=394802;
  DOTNET_4_7_RELEASEVALUE=460798;
  DOTNET_4_7_1_RELEASEVALUE=461308;
  DOTNET_4_7_2_RELEASEVALUE=461808;
  DOTNET_4_8_RELEASEVALUE=528040;

var
	intWindowsMessageRefresh: LongWord;
	intWindowsMessageRecallInstance: LongWord;
  intWindowsMessageCloseForUpdate: LongWord;
  GIFImageDefaultAnimate : boolean;
  strLocale : string;
  bolLargeFonts: boolean;
  bolHideDesktopIcons: boolean;
  intAlphaBlendMain: integer;
  intDriveSpaceWidth: integer;
  bolBoldFavorites: boolean;
  bolCollapseOtherFoldersOnExpand: boolean;
  bolCollapseCategoriesOnMinimize: boolean;
  bolUseCategories: boolean;
  bolShowAllApps: boolean;
  bolShowInstalledApps: boolean;
  bolExpandCategoriesByDefault: boolean;
  bolUpdateAutomatically: boolean;
  bolAppDirectoryShowOpenSourceOnly: boolean;
  bolAppDirectoryShowAdvancedApps: boolean;
  bolSecondAppPage: boolean;
  bolLiveSearchResults: boolean;
  bolDisableAppLanguageSwitching: boolean;
  strCurrentTheme, strThemePath, strCurrentThemeColor, strThemeCustomColor, strLastThemeLayout: string;
  strOEM: string;
  strOEMThemeName: string;
  bolDisableScrollBar: boolean;
  bolDisableSplashScreens: boolean;
  bolHidePortableInAppNames: boolean;
  bolMenuBusy: boolean;
  bolBoldFolderNames: boolean;
  bolBetaPlatformReleases: boolean;
  bolAutoRunProtection: boolean;
  bolShowUpdaterStarupErrors: boolean;
  strlstFullAppReportPAF, strlstFullAppReportNonPAF: TStringList;
  bolUninstalling: boolean;
  hndMainForm: THandle;
  bolKeyboardFriendly: boolean;
  strGlobalHotKey: string;
  bolOptionsChangeRequiringAppRefresh: boolean;
  bolCloseAppsOnPlatformExit: boolean;
  bolSearchWithinAppDescriptions: boolean;
  bolClosingForPlatformUpdate: boolean;
  bolOpeningFromPlatformUpdate: boolean;
  bolAskCloseAppsOnPlatformExit: boolean;
  bolHideSearchWhenNotInUse: boolean;
  bolRunningFromUNCPath: boolean;
  bolRunningOnRemovableDrive: boolean;
  bolAlwaysShowEject, bolAlwaysShowPower: boolean;
  bolInitializationComplete: boolean;
  bolShowAppPathsInToolTips, bolShowAppPublishersInToolTips: boolean;
  strConnectionType, strConnectionProxyIP, strConnectionProxyPort, strConnectionProxyLogin, strConnectionProxyPassword: string;
  bolHelpWhatsNew: boolean;
  strLastVersion: string;
  strSystemTEMPPath: string;
  hwndOtherInstance: THandle;
  bolHighContrastTheme: boolean;
  bolDotNet1, bolDotNet1_1, bolDotNet2, bolDotNet3, bolDotNet3_5, bolDotNet4: boolean;
  strDotNet1, strDotNet1_1, strDotNet2, strDotNet3, strDotNet3_5, strDotNet4: string;
  bolDotNetCore1, bolDotNetCore1_1, bolDotNetCore2, bolDotNetCore2_1, bolDotNetCore2_2, bolDotNetCore3, bolDotNetCore3_1, bolDotNet5, bolDotNet6, bolDotNet7: boolean;
  strDotNetCore1, strDotNetCore2, strDotNetCore3, strDotNet5, strDotNet6, strDotNet7: string;
  intDotNet4Release: integer;
  bolDotNetBundle: boolean;
  bolLogging: boolean;
  bolRemainVisible: boolean;
	bolStartMinimized: boolean;
  bolWindows7TaskbarIconNextLaunch: boolean;
  bolDriveEjectExit: boolean;
  strLocaleDirection: string;
  bolHideLogoDecorations: boolean;
  bolFadeMenu: boolean;
  strShow64BitOnlyApps: string;
  strTaskbarIcon: string;
  strPortableAppsPath: string;
  strPortableAppsRootPath: string;
  strProgramFilesPath: string;
  strProgramFilesx86Path: string;
  bolSystemWideEnvironmentVariables: boolean;

  // OS
  bolRunningUnderWine: boolean;
  bolRunningUnderWin9x: boolean;
  bolRunningUnderWin7: boolean;
  bolRunningUnderWin8: boolean;
  bolRunningUnderWin8_1: boolean;
  bolRunningUnderWin10: boolean;
  bolRunningUnderWin11: boolean;
  bolRunningUnder64bitWin: boolean;
implementation
end.

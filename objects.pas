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

unit objects;

interface

uses
	Windows, Graphics, ExtCtrls, variables, SysUtils;

type
	TAppListItem = class(TObject)
  	private
    	strCaption: string;
			strDefaultName: string;
			strPortableAppName: string;
			strCommandLine: string;
			strWorkingDirectory: string;
			strPublisher: string;
      strDescription: string;
			strPackageVersion: string;
			strDisplayVersion: string;
      strHomepageURL: string;
      strDonateURL: string;
      bolIconIsLarge: boolean;
      bolIsFavorite: boolean;
      bolIsHidden: boolean;
      bolAutoStart: boolean;
      intCategoryIndex: integer;
      strInternalCategory: string;
      intTimesRun: integer;
      intTimesRunLast: integer;
      icoAppIcon: TIcon;
      strDotNetVersion: string;
      strBaseAppID: string;
  	public
			Property Caption: String Read strCaption Write strCaption;
			Property DefaultName: String Read strDefaultName Write strDefaultName;
			Property PortableAppName: String Read strPortableAppName Write strPortableAppName;
			Property CommandLine: String Read strCommandLine Write strCommandLine;
      Property WorkingDirectory: String Read strWorkingDirectory Write strWorkingDirectory;
      Property Publisher: String Read strPublisher Write strPublisher;
      Property Description: String Read strDescription Write strDescription;
      Property DotNetVersion: String Read strDotNetVersion Write strDotNetVersion;
      Property HomepageURL: String Read strHomepageURL Write strHomepageURL;
      Property DonateURL: String Read strDonateURL Write strDonateURL;
			Property PackageVersion: String Read strPackageVersion Write strPackageVersion;
 			Property DisplayVersion: String Read strDisplayVersion Write strDisplayVersion;
      Property Icon: TIcon Read icoAppIcon Write icoAppIcon;
      Property IconIsLarge: boolean Read bolIconIsLarge Write bolIconIsLarge;
      Property IsFavorite: boolean Read bolIsFavorite Write bolIsFavorite;
      Property IsHidden: boolean Read bolIsHidden Write bolIsHidden;
      Property AutoStart: boolean Read bolAutoStart Write bolAutoStart;
      Property CategoryIndex: integer Read intCategoryIndex Write intCategoryIndex;
      Property InternalCategory: string Read strInternalCategory Write strInternalCategory;
      Property TimesRun: integer Read intTimesRun Write intTimesRun;
      Property TimesRunLast: integer Read intTimesRunLast Write intTimesRunLast;
      Property BaseAppID: String Read strBaseAppID Write strBaseAppID;
      destructor Destroy(); override;
      constructor Create();
  end;
  TCategoryListItem = class(TObject)
    private
      strDisplayName: string;
      strInternalName: string;
      bolCustom: boolean;
      bolExpanded: boolean;
      bolShown: boolean;
    public
      Property DisplayName: string Read strDisplayName Write strDisplayName;
      Property InternalName: string Read strInternalName Write strInternalName;
      Property Custom: boolean Read bolCustom Write bolCustom;
      Property Expanded: boolean Read bolExpanded Write bolExpanded;
      Property Shown: boolean Read bolShown Write bolShown;
      constructor Create(strSetName: string);
  end;

  TMenuListItem = class(TObject)
    private
      bolFolder: boolean;
      intListIndex: integer;
      strSortBy: string;
      bolSpecial: boolean;
    public
      Property Folder: boolean Read bolFolder Write bolFolder;
      Property Special: boolean Read bolSpecial Write bolSpecial;
      Property ListIndex: integer Read intListIndex Write intListIndex;
      Property SortBy: string Read strSortBy Write strSortBy;
  end;
implementation
  constructor TCategoryListItem.Create(strSetName: string);
  begin
    bolCustom:=false;
    if bolExpandCategoriesByDefault then
      bolExpanded:=true
    else
      bolExpanded:=false;
    bolShown:=false;
    strDisplayName:=strSetName;
    strInternalName:=strSetName;
  end;
  constructor TAppListItem.Create();
  begin
    icoAppIcon:=TIcon.Create;
  end;
  destructor TAppListItem.Destroy;
  begin
    //icoAppIcon.ReleaseHandle;
    //DestroyIcon(icoAppIcon.Handle);
    FreeAndNil(icoAppIcon);
  end;
end.

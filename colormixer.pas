unit colormixer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, functions;

type
  TfrmColorMixer = class(TForm)
    trackBarRed: TTrackBar;
    lblRed: TLabel;
    trackBarGreen: TTrackBar;
    lblGreen: TLabel;
    trackBarBlue: TTrackBar;
    lblBlue: TLabel;
    edtColor: TEdit;
    btnApply: TButton;
    lblColorHex: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmColorMixer: TfrmColorMixer;

implementation

uses main;

{$R *.dfm}

procedure TfrmColorMixer.btnApplyClick(Sender: TObject);
begin
  if btnApply.Enabled then
  begin
    frmMenu.Color:=RGB(trackBarRed.Position,trackBarGreen.Position,trackBarBlue.Position);
    edtColor.Text:=TColorToHexColor(frmMenu.color);
  end;
end;

procedure TfrmColorMixer.FormCreate(Sender: TObject);
begin
  edtColor.Text:=TColorToHexColor(frmMenu.color);
  trackBarRed.Position:=StrToInt('$'+Copy(edtColor.Text, 1, 2));
  trackBarGreen.Position:=StrToInt('$'+Copy(edtColor.Text, 3, 2));
  trackBarBlue.Position:=StrToInt('$'+Copy(edtColor.Text, 5, 2));
  btnApply.Enabled:=true;
end;

end.

unit desktop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmDesktop = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDesktop: TfrmDesktop;

implementation

{$R *.dfm}

procedure TfrmDesktop.FormActivate(Sender: TObject);
begin
begin
with Self do {Form1,...}
  SetWindowPos(Handle, // handle to window
               HWND_BOTTOM, // placement-order handle {*}
               Left,  // horizontal position
               Top,   // vertical position
               Width,
               Height,
               // window-positioning options
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;
end;

procedure TfrmDesktop.FormCreate(Sender: TObject);
begin
with Self do {Form1,...}
  SetWindowPos(Handle, // handle to window
               HWND_BOTTOM, // placement-order handle {*}
               Left,  // horizontal position
               Top,   // vertical position
               Width,
               Height,
               // window-positioning options
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

{* Other Values: }
end;

end.

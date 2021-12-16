unit applicUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TapplicForm = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
  connectionDBString:string;
    { Public declarations }
  end;

var
  applicForm: TapplicForm;

implementation
uses connectSQL;

{$R *.dfm}

procedure TapplicForm.FormHide(Sender: TObject);
begin
application.Terminate;
end;

procedure TapplicForm.FormShow(Sender: TObject);
begin
memo1.Text:= connectionDBString;
end;

end.

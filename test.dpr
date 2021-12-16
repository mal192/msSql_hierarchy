program test;

uses
  Vcl.Forms,
  connectSQL in 'connectSQL.pas' {connectServerForm},
  applicUnit in 'applicUnit.pas' {applicForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TconnectServerForm, connectServerForm);
  Application.CreateForm(TapplicForm, applicForm);
  Application.Run;
end.

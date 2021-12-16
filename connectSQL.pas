unit connectSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Data.DB, Data.Win.ADODB, applicUnit;

type
  TconnectServerForm = class(TForm)
    ServerNameEdit: TLabeledEdit;
    UserNameEdit: TLabeledEdit;
    PassEdit: TLabeledEdit;
    AutNTCheck: TCheckBox;
    ConnectDB: TButton;
    addDB: TCheckBox;
    ADOQuery: TADOQuery;
    ListDBName: TComboBox;
    procedure addDBClick(Sender: TObject);
    procedure ConnectDBClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  connectServerForm: TconnectServerForm;
  conStr:string;



implementation

{$R *.dfm}

function AllFields (conDB:boolean):boolean;
begin

  if (connectServerForm.ServerNameEdit.Text <> '' ) and
     (connectServerForm.UserNameEdit.Text   <> '' ) and
     (connectServerForm.PassEdit.Text<>'')
  then
  begin
   AllFields:=true;
   if (conDB)and (connectServerForm.ListDBName.Text = '') then AllFields:=false
   end else
  begin
    AllFields:= false;
    messagedlg('«аполните все пол€',mterror,[mbOk],0);
  end;
end;

function stringConnect(autNT, conDB:boolean):string;
var tempConStr:string;
begin
  tempConStr:='Provider=SQLOLEDB.1;';
  if autNT then tempConStr:= tempConStr + 'Integrated Security=SSPI;';
  tempConStr:= tempConStr + 'Persist Security Info=False;';
  tempConStr:= tempConStr + 'User ID='+connectServerForm.UserNameEdit.Text+';';
  tempConStr:= tempConStr + 'Password='+connectServerForm.PassEdit.Text+';';
  if conDB then tempConStr:=  tempConStr+ 'Initial Catalog=' + connectServerForm.ListDBName.Text+';';
  tempConStr:= tempConStr + 'Data Source=' + connectServerForm.ServerNameEdit.Text;
  stringConnect:= tempConStr;
end;



procedure TconnectServerForm.addDBClick(Sender: TObject);
  var forCycle:integer;
begin
if addDB.Checked then
  ListDBName.Hide
else
  begin
    //отображение баз данных серера
    if AllFields(false) then
      begin
        ListDBName.Show;
        ADOQuery.ConnectionString:=
            stringConnect(connectServerForm.AutNTCheck.Checked, false);
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('EXEC sp_helpdb');
        ListDBName.Clear;
        ADOQuery.Active:=true;
        for forCycle := 0 to ADOQuery.RecordCount-1 do
          begin
            ListDBName.Items.Add(ADOQuery.FieldByName('name').AsString);
            ADOQuery.Next;
          end;
        ADOQuery.Active:=false;


      end else
         addDB.Checked:=true;
    end;


end;

procedure TconnectServerForm.ConnectDBClick(Sender: TObject);
begin
if (connectServerForm.addDB.Checked = false)and(AllFields(true)) then begin
  applicForm.connectionDBString:=stringConnect(AutNTCheck.Checked, true);
  connectServerForm.Hide;
  applicForm.show;
end;

if (connectServerForm.addDB.Checked = true)and(AllFields(false)) then begin
  connectServerForm.ListDBName.Text:= inputBox('им€ новой DB','введите им€ новой базы данных','test');
  applicForm.connectionDBString:=stringConnect(AutNTCheck.Checked, true);
        //создание новой бд
        ADOQuery.ConnectionString:=
            stringConnect(connectServerForm.AutNTCheck.Checked, false);
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('CREATE DATABASE '+ connectServerForm.ListDBName.Text);
        ADOQuery.Active:=true;
                ADOQuery.Active:=false;
  connectServerForm.Hide;
  applicForm.show;
end;

end;

end.

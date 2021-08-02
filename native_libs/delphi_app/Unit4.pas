unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Math.Vectors, FMX.Controls3D,
  FMX.Layers3D, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  FMX.Edit;

type
  TForm4 = class(TForm)
    Button1: TButton;
    SolidLayer3D1: TSolidLayer3D;
    IdTCPClient1: TIdTCPClient;
    Button2: TButton;
    editMsg: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.Button1Click(Sender: TObject);
begin
  IdTCPClient1.Socket.Write(editMsg.Text);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  IdTCPClient1.Connect;
  if (IdTCPClient1.Connected) then
  begin
    Button2.Enabled := False;
    Button1.Enabled := True;
    editMsg.Enabled := True;
  end;
end;

end.

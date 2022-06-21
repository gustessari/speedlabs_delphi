unit SpeedLabsDemo.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    pgcMain: TPageControl;
    procedure FormCreate(Sender: TObject);
  private
    procedure AddFrame(const Caption: string; FrameClass: TControlClass);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  SpeedLabsDemo.RequisicaoFrame, SpeedLabsDemo.CriptoMessageFrame;

{ TMainForm }

procedure TMainForm.AddFrame(const Caption: string;
  FrameClass: TControlClass);
var
  TabSheet: TTabSheet;
  AFrame: TControl;
begin
  TabSheet := TTabSheet.Create(pgcMain);
  TabSheet.Caption := Caption;
  TabSheet.PageControl := pgcMain;

  AFrame := FrameClass.Create(Application);
  AFrame.Parent := TabSheet;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AddFrame('Requisição', TRequisicaoFrame);
  AddFrame('Criptografia', TCriptoMessageFrame);
end;

end.

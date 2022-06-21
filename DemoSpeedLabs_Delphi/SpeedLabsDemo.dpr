program SpeedLabsDemo;

uses
  Vcl.Forms,
  SpeedLabsDemo.MainForm in 'SpeedLabsDemo.MainForm.pas' {MainForm},
  SpeedLabsDemo.CriptoMessageFrame in 'SpeedLabsDemo.CriptoMessageFrame.pas' {CriptoMessageFrame: TFrame},
  SpeedLabsDemo.RequisicaoFrame in 'SpeedLabsDemo.RequisicaoFrame.pas' {RequisicaoFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

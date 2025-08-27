object DataModule1: TDataModule1
  Height = 708
  Width = 1131
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=ERP_Oficina'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    Left = 544
    Top = 344
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\Gustavo Erthal\Desktop\ProjetoFinal Delphi\lib\libpq.dl' +
      'l'
    Left = 640
    Top = 344
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 472
    Top = 344
  end
end

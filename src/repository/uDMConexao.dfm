object DataModule1: TDataModule1
  Height = 918
  Width = 1131
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=ERP_Oficina'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    Left = 496
    Top = 288
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Users\vplgu\Desktop\ProjetoFinalDelphi\src\lib\libpq.dll'
    Left = 597
    Top = 289
  end
  object FDQuery: TFDQuery
    Connection = FDConnection1
    Left = 400
    Top = 288
  end
end

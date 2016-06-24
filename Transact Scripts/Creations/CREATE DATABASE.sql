USE master ;
GO
CREATE DATABASE MushVsGrump
ON 
( NAME = [MushVsGrump_dat],
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\MushVsGrump_dat.mdf',
    SIZE = 16,
    MAXSIZE = 128,
    FILEGROWTH = 16 )
LOG ON
( NAME = [MushVsGrump_log],
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\MushVsGrump_log.ldf',
    SIZE = 4MB,
    MAXSIZE = 16MB,
    FILEGROWTH = 4MB ) ;
GO
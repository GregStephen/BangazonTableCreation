IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Employee')
BEGIN
	CREATE TABLE [Employee] 
	(
		[Id] int primary key identity(1,1),
		[Name] nvarchar(250) not null,
		[DepartmentId] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Department')
BEGIN
	CREATE TABLE [Department]
	(
		[Id] int primary key identity(1,1),
		[SupervisorId] int not null,
		[ExpenseBudget] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Computer')
BEGIN
	CREATE TABLE [Computer]
	(
		[Id] int primary key identity(1,1),
		[PurchasedOn] datetime not null,
		[IsWorking] bit not null,
		[DecomissionedOn] datetime null,
		[EmployeeId] int null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'EmployeeTrainingProgram')
BEGIN
	CREATE TABLE [EmployeeTrainingProgram]
	(
		[Id] int primary key identity(1,1),
		[EmployeeId] int not null,
		[TrainingProgramId] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'TrainingProgram')
BEGIN
	CREATE TABLE [TrainingProgram]
	(
		[Id] int primary key identity(1,1),
		[Name] nvarchar(250) not null,
		[StartDate] datetime not null,
		[EndDate] datetime not null,
		[MaxAttend] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'PaymentType')
BEGIN
	CREATE TABLE [PaymentType]
	(
		[Id] int primary key identity(1,1),
		[Type] nvarchar(250) not null,
		[CustomerId] int not null,
		[AccountNumber] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Customer')
BEGIN
	CREATE TABLE [Customer]
	(
		[Id] int primary key identity(1,1),
		[FirstName] nvarchar(250) not null,
		[LastName] nvarchar(250) not null,
		[DateCreated] datetime not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Product')
BEGIN
	CREATE TABLE [Product]
	(
		[Id] int primary key identity(1,1),
		[ProductTypeId] int not null,
		[Price] int not null,
		[Title] nvarchar(250) not null,
		[Description] nvarchar(500) null,
		[Quantity] int not null,
		[SellerId] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'ProductType')
BEGIN
	CREATE TABLE [ProductType]
	(
		[Id] int primary key identity(1,1),
		[Name] nvarchar(250) not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'ProductOrder')
BEGIN
	CREATE TABLE [ProductOrder]
	(
		[Id] int primary key identity(1,1),
		[ProductId] int not null,
		[OrderId] int not null,
		[Quantity] int not null
	)
END

IF not exists (SELECT * FROM sys.tables WHERE [name] = 'Order')
BEGIN
	CREATE TABLE [Order]
	(
		[Id] int primary key identity(1,1),
		[TotalCost] int not null,
		[CustomerId] int not null,
		[isCompleted] bit not null,
		[PaymentTypeId] int null
	)
END

alter table Employee
	add constraint FK_Employee_Department foreign key (DepartmentId)
		references Department (Id)

alter table Department
	add constraint FK_Department_Employee foreign key (SupervisorId)
		references Employee (Id)

alter table Computer
	add constraint FK_Computer_Employee foreign key (EmployeeId)
		references Employee (Id)

alter table EmployeeTrainingProgram
	add constraint FK_EmployeeTrainingProgram_Employee foreign key (EmployeeId)
		references Employee (Id)

alter table EmployeeTrainingProgram
	add constraint FK_EmployeeTrainingProgram_TrainingProgram foreign key (TrainingProgramId)
		references TrainingProgram (Id)

alter table Product
	add constraint FK_Product_ProductType foreign key (ProductTypeId)
		references ProductType (Id)

alter table ProductOrder
	add constraint FK_ProductOrder_Product foreign key (ProductId)
		references Product (Id)

alter table ProductOrder
	add constraint FK_ProductOrder_Order foreign key (OrderId)
		references [Order] (Id)

alter table PaymentType
	add constraint FK_PaymentType_Customer foreign key (CustomerId)
		references Customer (Id)

alter table [Order]
	add constraint FK_Order_Customer foreign key (CustomerId)
		references Customer (Id)

alter table [Order]
	add constraint FK_Order_PaymentType foreign key (PaymentTypeId)
		references PaymentType (Id)




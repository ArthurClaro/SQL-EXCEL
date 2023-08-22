-- 1- total de vendas iternet por categoria
-- 2- receita total internet por mes do pedido
-- 3- receita e custo total internet por país
-- 4- total de vendas internet por sexo

-- o ano de análise será apenas 2013 (ano do pedido)
-- indicadores , cima

-- tabelas : 
select * from FactInternetSales --principal chave
select * from DimProductCategory
select * from DimSalesTerritory
select * from DimCustomer

CREATE OR ALTER VIEW VENDAS_INTERNET AS
select
fis.SalesOrderNumber as 'N PEDIDO',
fis.OrderDate as 'DATA PEDIDO',
dpc.EnglishProductCategoryName as 'CATEGORIA PEDIDO',
dc.FirstName + ' ' + dc.LastName as 'NOME CLIENTE',
Gender as 'SEXO',
SalesTerritoryCountry as 'PAÍS',
fis.OrderQuantity as 'QNTD. VENDIDA',
fis.TotalProductCost as 'CUSTO VENDA',
fis.SalesAmount as 'RECEITA VENDA'
from FactInternetSales fis
inner join DimProduct dp on fis.ProductKey = dp.ProductKey
	inner join DimProductSubcategory dps on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		inner join DimProductCategory dpc on dps.ProductCategoryKey = dpc.ProductCategoryKey
inner join DimCustomer dc on fis.CustomerKey= dc.CustomerKey
inner join DimSalesTerritory dst on fis.SalesTerritoryKey = dst.SalesTerritoryKey
where year(OrderDate) = 2013

select * from VENDAS_INTERNET

BEGIN TRANSACTION T1
	update FactInternetSales
	--set OrderQuantity = 1
	set OrderQuantity = 20
	where ProductKey = 361 -- categoria bikes
commit transaction t1

select * from FactInternetSales
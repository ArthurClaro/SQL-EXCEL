-- ##################################################
--     PROJETO DE INTEGRAÇÃO SQL SERVER e EXCEL
-- ##################################################

-- 1. Apresentação


-- 2. Download Banco de Dados AdventureWorks 2014

/*
https://docs.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms
*/

-- 3. Definindo os indicadores do projeto

-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por Mês do Pedido
-- iii) Receita e Custo Total Internet por País
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE ANÁLISE SERÁ APENAS 2013 (ANO DO PEDIDO)


SELECT * FROM FactInternetSales
SELECT * FROM DimProductSubCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimProduct


-- 4. Definindo as tabelas a serem analisadas

-- TABELA 1: FactInternetSales
-- TABELA 2: DimCustomer
-- TABELA 3: DimSalesTerritory
-- TABELA 4: DimProductCategory ***


-- 5. Definindo as colunas da view VENDAS_INTERNET


-- VIEW FINAL VENDAS_INTERNET

-- Colunas:

-- SalesOrderNumber                (TABELA 1: FactInternetSales)
-- OrderDate                       (TABELA 1: FactInternetSales)
-- EnglishProductCategoryName      (TABELA 4: DimProductCategory)
-- FirstName + LastName            (TABELA 2: DimCustomer)
-- Gender                          (TABELA 2: DimCustomer)
-- SalesTerritoryCountry           (TABELA 3: DimSalesTerritory)
-- OrderQuantity                   (TABELA 1: FactInternetSales)
-- TotalProductCost                (TABELA 1: FactInternetSales)
-- SalesAmount                     (TABELA 1: FactInternetSales)

-- 6. Criando o código da view VENDAS_INTERNET

-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por Mês do Pedido
-- iii) Receita e Custo Total Internet por País
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE ANÁLISE SERÁ APENAS 2013 (ANO DO PEDIDO)


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



-- Alterando o banco de dados e atualizando no Excel


BEGIN TRANSACTION T1
	update FactInternetSales
	--set OrderQuantity = 1
	set OrderQuantity = 20
	where ProductKey = 361 -- Categoria Bike
commit transaction t1

select * from FactInternetSales
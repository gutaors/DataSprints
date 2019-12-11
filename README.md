# Desafio Datasrpints
Este trabalho consiste de quatro partes:
	1-ETL que importa json para o banco sql server
	2-An�lise pr�via em queries sql server 
	3-Exporta��o dos resultados das queries e views para arquivos csv
	4-Tratamento e modelagem dos csvs em cadernos Jupyter Notebook.


1-ETL
	Importa os arquivos Json fornecidos para o sql server usando pacotes do Integation services. 
	Estes pacotes produziram tabelas com a mesma estrutura dos Json originais. 

2-Scriipt SQL
	O arquivo scripts_banco.sql deve ser executado no banco de dados contendo as tabelas originalmente fornecidas (Json). 
	Este script � dividido em blocos que devem ser executados na ordem em que aparecem, de cima pra baixo. 
	Neste script temos ajustes e convers�es de tipos de dados, cria��o de views, queries e, finalmente, cria��o dos datasets com os resultados das an�lises. 

3-Exporta��o dos resultados
	Ap�s executar os scripts, exporte os resultados dos mesmos para arquivos csv.
	Copie estes csv no mesmo diret�rio onde se encontra o caderno Jupyter datasprints.ipynb
	Os nomes dos arquivos devem ser aqueles expl�citos no coment�rio da query. 

4-Caderno DataSprints.ipynb
	Utilize o Jupyter notebook para executar o caderno DataSprints.ipynb, este caderno executa modelos, an�lises estat�sticas e gr�ficos. 

* Para os dados at� 2012, basta abrir o arquivo satasprints.html que cont�m as an�lises. 

**Para fontes de dados futuras, as tecnologias escolhidas s�o facilmente automatiz�veis, utilizando o pr�prio Integation services e um orquestrador como por exemplo o airflow.  

Este  foi um trabalho executado de forma r�pida, por isto n�o tive tempo de automatizar, mesmo assim busquei utilizar as tecnologias sugeridas para demonstrar que consigo produzir resultados satisfat�rios com estas tecnologias. 


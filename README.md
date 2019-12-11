# Desafio Datasrpints
Este trabalho consiste de quatro partes:
	1-ETL que importa json para o banco sql server
	2-Análise prévia em queries sql server 
	3-Exportação dos resultados das queries e views para arquivos csv
	4-Tratamento e modelagem dos csvs em cadernos Jupyter Notebook.


1-ETL
	Importa os arquivos Json fornecidos para o sql server usando pacotes do Integation services. 
	Estes pacotes produziram tabelas com a mesma estrutura dos Json originais. 

2-Scriipt SQL
	O arquivo scripts_banco.sql deve ser executado no banco de dados contendo as tabelas originalmente fornecidas (Json). 
	Este script é dividido em blocos que devem ser executados na ordem em que aparecem, de cima pra baixo. 
	Neste script temos ajustes e conversões de tipos de dados, criação de views, queries e, finalmente, criação dos datasets com os resultados das análises. 

3-Exportação dos resultados
	Após executar os scripts, exporte os resultados dos mesmos para arquivos csv.
	Copie estes csv no mesmo diretório onde se encontra o caderno Jupyter datasprints.ipynb
	Os nomes dos arquivos devem ser aqueles explícitos no comentário da query. 

4-Caderno DataSprints.ipynb
	Utilize o Jupyter notebook para executar o caderno DataSprints.ipynb, este caderno executa modelos, análises estatísticas e gráficos. 

* Para os dados até 2012, basta abrir o arquivo satasprints.html que contém as análises. 

**Para fontes de dados futuras, as tecnologias escolhidas são facilmente automatizáveis, utilizando o próprio Integation services e um orquestrador como por exemplo o airflow.  

Este  foi um trabalho executado de forma rápida, por isto não tive tempo de automatizar, mesmo assim busquei utilizar as tecnologias sugeridas para demonstrar que consigo produzir resultados satisfatórios com estas tecnologias. 


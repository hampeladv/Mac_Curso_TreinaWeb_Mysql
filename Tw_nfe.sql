    CREATE DATABASE tw_nfe;
    USE tw_nfe;	
    
    SELECT DATABASE();
    -- O MySQL é um banco de dados principalmente relacional e, por isso, suas estruturas seguem justamente o modelo relacional. 
    -- O elemento principal deste modelo é a relação. Portanto, pode-se dizer que um banco de dados relacional é composto por um 
    -- conjunto de relações.
    -- A relação se apresenta em uma tabela, a qual representa, no modelo E-R (entidade-relação), a entidade. 
    -- Atributo: trata-se de cada uma das colunas da tabela. 
    -- Tupla: trata-se de cada uma das linhas da tabela. 
	-- No MySQL, uma tabela pode ser criada com a cláusula CREATE TABLE. Ela possui a sintaxe abaixo:
    -- Na criação da tabela, é necessário definir o tipo de dado de cada coluna. O tipo de dado define quais valores cada campo pode receber.
    
    -- Restrição NOT NULL: simplesmente especifica que uma coluna não pode conter o valor nulo.
    -- Restrição UNIQUE: o MySQL analisa todos os outros valores existentes nessa coluna e, se já existir esse valor para alguma das tuplas, 
    -- um erro será apresentado.
    
    -- Definição de valores-padrão com a cláusula DEFAULT:
    -- Por padrão, ao inserir um registro e deixar um campo em branco, o MySQL verifica se aquela coluna aceita NULL. 
    -- Se confirmado, ele insere um valor NULL para esse campo. Com a cláusula DEFAULT, podemos definir outro valor padrão caso o campo não seja 
    -- preenchido. 
    
    -- Chaves primárias: Um campo que serve explicitamente para identificar uma tupla de uma tabela de maneira única com relação às demais.
    -- Chaves estrangeiras: Para manter a integridade referencial entre duas tabelas relacionadas (ou seja, a validade de dados entre duas 
    -- tabelas diferentes que estão correlacionados), possuímos a restrição de chave estrangeira. 
    -- Ela especifica que o valor de uma coluna (ou grupo de colunas) deve corresponder a algum valor existente em uma linha de outra tabela.
    
    /*
    NOME | ENDERECO | DATA NASCIMENTO
    ---------------------------------
    Tw.  | Rua xpto.| 01/01/2008
    Zé.  | Rua xptz.| 01/01/2000
    
    Precisão/Escala:
    10.000: Precisão = quantidade de dígitos suportados(5); Escala = representa a parte decinal(3).
    */
    
    CREATE TABLE cli_clientes
    (
		-- cli_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        cli_id SERIAL PRIMARY KEY,  --  resume toda a linha acima (BIGINT NOT NULL AUTO_INCREMENT UNSIGNET UNIQUE)
        cli_nome VARCHAR(50) NOT NULL,
        cli_data_nascimento DATE,
        cli_logradouro VARCHAR(200)
        );
    
    DROP TABLE cli_clientes;  -- apaga a tabela
    
    /*
    Inserindo dados:
    No MySQL, existem algumas maneiras para inserirmos dados em uma tabela. A primeira sintaxe é a mesma utilizada por todos os bancos de dados:
    INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor 1, ...);
    
    Também é possível declarar os campos apenas uma vez e inserir várias linhas de uma vez. A sintaxe é a seguinte:
    INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor linha 1, ...), (valor linha 2, ...);
    
    Exibindo os dados de uma tabela
    O comando responsável por realizar consultas em banco dados relacionais que usam SQL é o SELECT. 
    Com ele, podemos recuperar as tuplas existentes em uma tabela.
    SELECT coluna1,coluna2,coluna3,... colunaN FROM nome_tabela [WHERE condição];
    O WHERE permite que se defina um filtro para a pesquisa, com isso refinando mais o seu resultado.
    Por exemplo: para verificarmos se um modelo de carro é igual a Celta, podemos utilizar o operador de igualdade:
    SELECT * FROM carro WHERE modelo = 'Celta';
    
    Alterando dados:
    Para alterar os dados em uma tabela, podemos utilizar o comando UPDATE. Veja a sintaxe:
    UPDATE nome_tabela
    SET nome_coluna1= novo_valor1,
    nome_coluna2 =  novo_valor2,
    ...
    nome_colunaN = novo_valorN
    [WHERE condição];
    Note que a cláusula WHERE também está disponível no comando UPDATE. Mesmo que ela seja opcional, sempre deverá ser utilizada.
    
    Excluindo dados:
    O comando que permite excluir tuplas de uma tabela é o DELETE. A sintaxe básica desse comando é:
    DELETE FROM nome_tabela [WHERE condição];
    Do mesmo modo que no comando UPDATE, a cláusula WHERE não é obrigatória para o comando DELETE. 
    Mas, igualmente ao primeiro, se você omiti-la, o comando irá afetar todos os registros, ou seja: irá apagar todos os registros da sua tabela. 
    Evite utilizar este comando sem a cláusula WHERE.
    
    Aliases:
    Os nomes das colunas apresentados no resultado de uma consulta podem ser diferentes dos rótulos de colunas originais, definidos na fase de 
    criação da tabela na qual a consulta foi realizada. Esses nomes diferentes são chamados de “alias” ("apelido") e são gerados usando a 
    palavra-chave AS no enunciado que faz a consulta. Por exemplo:
    SELECT CodFor AS 'Código do Fornecedor', RazSoc AS 'Razão Social' FROM Fornecedores;
    
    Na consulta acima, os resultados das colunas codfor e razsoc serão exibidos respectivamente, com os cabeçalhos “Código do Fornecedor” e 
    “Razão Social”.
    
    A cláusula DISTINCT:
    
    Se precisarmos obter os valores de uma coluna ignorando-se o que for duplicado, podemos utilizar uma cláusula adicional à clausula SELECT: 
    a cláusula DISTINCT. O DISTINCT deve ser informado após o SELECT, não importando quantas colunas forem definidas na consulta:
    SELECT DISTINCT rua, cidade FROM fornecedores;
    
    Ordenação de registros com a cláusula ORDER BY:
    A cláusula ORDER BY é usada para ordenar os valores do resultado de uma consulta. Ela deve ser colocada no final do comando.
    Sua sintaxe é:
    ORDER BY critério_de_classificação [ASC | DESC];
    
    O critério_de_classificação é constituído por uma ou várias colunas da tabela de origem e pode ser especificado usando os nomes dos campos 
    ou seus respectivos alias. As colunas usadas como critério de classificação são chamadas de chaves de classificação no jargão dos bancos de 
    dados. As palavras-chave ASC e DESC especificam o tipo de classificação e são, respectivamente, abreviações das palavras em inglês ascending
    e descending, ou seja: classificação crescente (do menor para o maior) ou decrescente (do maior para o menor). A ordenação ascendente é tida 
    como padrão quando não se especificar nenhum tipo. Por exemplo:
    SELECT DISTINCT estado, cidade FROM Fornecedores 
    ORDER BY estado;
    
    Acima, estamos ordenando a consulta de modo crescente pelo campo estado. E como o campo estado é do tipo cadeia de caracteres, o SQL o 
    ordena alfabeticamente.
    
    Caso fosse necessário ordenar de modo decrescente, o DESC deveria ser especificado:
    SELECT DISTINCT estado, cidade FROM fornecedoreS
    ORDER BY estado DESC;
    
    A cláusula ORDER BY pode se referir a mais de uma coluna da tabela de origem. Para isso, basta separá-las por vírgula:
    SELECT * FROM tabela ORDER BY coluna1, coluna2 ... colunaN;
    
    Explorando a cláusula WHERE:
    Já tivemos alguns contatos com o comando WHERE e vimos que ele pode ser utilizado para filtrar os resultados de uma pesquisa. 
    Nos exemplos mostrados anteriormente, este comando foi utilizado em conjunto com os operadores de comparação. Nesta situação, o filtro é 
    aplicado com uma expressão lógica. Mas, é possível adicionar mais de uma expressão através de operadores lógicos. Além desses operadores, 
    esta cláusula suporta outros tipos de operadores que veremos a seguir. Assim, em um exemplo como o abaixo:
    SELECT * FROM carro WHERE cod = 1 AND placa = 'asd0989';
    A consulta só retornará dados se o campo cod for igual a 1 e se o campo placa for igual a “asd0989”. As duas condições precisam ser verdadeiras ao mesmo tempo.
    
    Operador OR 
    O operador OR (OU) retorna verdadeiro quando uma ou as duas expressões são verdadeiras. 
    
    Operador NOT 
    O operador NOT inverte o resultado da expressão.
    
    Condições IS NULL e IS NOT NULL
    Como o NULL é uma expressão especial, ele não pode ser utilizado em uma comparação. Ou seja: para obtermos os registros com valores nulos, 
    não é possível realizar a consulta abaixo:
    SELECT * FROM fornecedores
    WHERE CEP = NULL;
    
    Assim, o SQL também introduziu o operador IS NULL. Com ele é possível verificar se o campo possui valores NULL. Veja o exemplo:
    SELECT * FROM fornecedores
    WHERE CEP IS NULL;
    A consulta acima, irá retornar todos os registros cujo o campo CEP possua o valor NULL.
    
    O operador IS NOT NULL realiza o filtro contrário, trazendo apenas os registros que NÃO são NULL. Por exemplo:
    SELECT * FROM fornecedores
    WHERE CEP IS NOT NULL;
    
    Operador BETWEEN
    Podemos também selecionar elementos que estejam dentro de um intervalo de valores com o operador BETWEEN. A sintaxe desse comparador é a 
    seguinte:
    SELECT * FROM tabela WHERE campo BETWEEN valor_inicial AND valor_final;
    Geralmente o operador BETWEEN é utilizado para comparar um intervalo de datas, mas pode ser utilizado com qualquer tipo de dado.
    
    Operador IN
    Outro operador que podemos usar é o IN. Ele retorna apenas elementos que sejam iguais a um dos valores apresentados na lista. Veja seu uso:
    SELECT * FROM fornecedores WHERE codigo IN (1, 5, 9);
    Acima, são selecionados os registros com código igual a 1, 5 ou 9.
    
    O IN também pode ser utilizado com uma sub-consulta:
    SELECT * FROM tabela WHERE campo IN (SELECT campo FROM tabela2);
    
    Operador LIKE
    O operador LIKE é outro operador que pode ser utilizado com o comando WHERE. Porém, diferente dos operadores que vimos anteriormente, este só
    pode ser utilizado em cadeias de caracteres(string). Com ele, é possível verificar se a cadeia de caracteres corresponde a um padrão 
    especificado. Para definir este padrão, podemos utilizar uma série de caracteres curinga listados na tabela abaixo:
    
    Operador REGEXP ou RLIKE
    O REGEXP é parecido com o LIKE. Ele só pode ser utilizado em cadeias de caracteres(string) e verifica se a cadeia de caracteres corresponde 
    ao padrão especificado. Este operador também possui um operador sinônimo que é o RLIKE. Ambos são equivalentes. Nesses dois operadores 
    pode-se utilizar expressões regulares para especificar o padrão da pesquisa.
    
    PAREI NO VÍDEO INSERINDO REGISTROS EM TABELAS.
    */
    
    
    
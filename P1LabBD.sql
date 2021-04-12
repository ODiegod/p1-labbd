CREATE DATABASE campeonatoFutebol
GO
USE campeonatoFutebol

CREATE TABLE times(
	CodigoTime INT NOT NULL,
	NomeTime VARCHAR(50) NOT NULL,
	Cidade VARCHAR(50),
	Estadio VARCHAR(100),
	PRIMARY KEY(CodigoTime)
)

CREATE TABLE grupos(
	Grupo CHAR(1),
	CodigoTime INT NOT NULL,
	CONSTRAINT chk_Grupo CHECK (Grupo IN ('A','B','C','D')),
	PRIMARY KEY(CodigoTime),
	FOREIGN KEY (CodigoTime) REFERENCES times(CodigoTime)
)

CREATE TABLE jogos(
	CodigoTimeA INT NOT NULL,
	CodigoTimeB INT NOT NULL,
	GolsTimeA INT,
	GolsTimeB INT,
	DataJogo DATE,
	PRIMARY KEY(CodigoTimeA, CodigoTimeB),
	FOREIGN KEY(CodigoTimeA) REFERENCES times(CodigoTime),
	FOREIGN KEY(CodigoTimeB) REFERENCES times(CodigoTime)
)

CREATE PROCEDURE distribui_times
AS
	DECLARE @letra_grupo CHAR(1)
	DECLARE @cont AS INT
	SET @cont = 0
	SET @letra_grupo = 'A'
	
	TRUNCATE TABLE grupos 
	
	WHILE(@cont < 1)
	BEGIN 
		INSERT INTO grupos(Grupo, CodigoTime) VALUES
			(@letra_grupo, (SELECT TOP 1 times.CodigoTime FROM times 
			LEFT JOIN grupos ON grupos.CodigoTime = times.CodigoTime
			WHERE grupos.CodigoTime IS NULL))
		SET @cont = @cont + 1
		IF (@cont = 1)
		BEGIN
			IF(@letra_grupo = 'A')
			BEGIN 
				SET @letra_grupo = 'B'
				SET @cont = 0
			END
			ELSE 
			BEGIN 
				IF(@letra_grupo = 'B')
				BEGIN 
					SET @letra_grupo = 'C'
					SET @cont = 0
				END
				ELSE 
				BEGIN 
					IF(@letra_grupo = 'C')
					BEGIN 
						SET @letra_grupo = 'D'
						SET @cont = 0
					END
					ELSE 
						IF(@letra_grupo = 'D')
						BEGIN 
							SET @letra_grupo = 'A'
						END
				END
			END
		END
	END
	SET @cont = 0
	
	WHILE(@cont < 3)
	BEGIN
		INSERT INTO grupos(Grupo, CodigoTime) VALUES
			(@letra_grupo, (SELECT TOP 1 times.CodigoTime FROM times 
			LEFT JOIN grupos ON grupos.CodigoTime = times.CodigoTime
			WHERE grupos.CodigoTime IS NULL
			ORDER BY NEWID()))
		SET @cont = @cont + 1
		IF (@cont = 3)
		BEGIN
			IF(@letra_grupo = 'A')
			BEGIN 
				SET @letra_grupo = 'B'
				SET @cont = 0
			END
			ELSE 
			BEGIN 
				IF(@letra_grupo = 'B')
				BEGIN 
					SET @letra_grupo = 'C'
					SET @cont = 0
				END
				ELSE 
				BEGIN 
					IF(@letra_grupo = 'C')
					BEGIN 
						SET @letra_grupo = 'D'
						SET @cont = 0
					END
				END
			END
		END
	END
	

SELECT * FROM times t 

EXEC distribui_times
SELECT * FROM grupos g 

CREATE PROCEDURE vincula_data_jogos
AS
	CREATE TABLE #tabela 
	(indice int null , numTime int null)
	create table #tabela2
	(indice int null , numTime int null)
	declare @vetorGrupos as varchar(5)
	declare @cont  int
	declare @cont2  int
	declare @contTimeB  int 
	declare @timeA as int
	declare @timeB as int
	declare @diaJogo as date
	declare @contTimeA int
	declare @dataJogo date
	declare @contData int
	declare @qnt int
	set @vetorGrupos = 'ABCD'
	set @cont = 1
	Delete from Jogos
	while @cont <= 3
	BEGIN
		--define a data inicial
		if (SUBSTRING(@vetorGrupos, @cont, 1) = 'B')
		BEGIN
			set @dataJogo = '2019-02-17'
			
		END
		ELSE
		BEGIN
			set @dataJogo = '2019-01-20'
		END
		--carrega a tabela 1 (Time A)
		set @cont2 = @cont + 1
		set @contTimeA = 1
		Delete from #tabela
		insert into #tabela (indice,numTime) select ROW_NUMBER() OVER(ORDER BY g.CodigoTime) as indice,g.CodigoTime as numTime from Grupos g where g.Grupo = SUBSTRING(@vetorGrupos, @cont, 1)
		
		while @cont2 <= 4
		BEGIN
			--carrega a tabela 2 (time B)
			DELETE from #tabela2
			insert into #tabela2 (indice,numTime) select ROW_NUMBER() OVER(ORDER BY g.CodigoTime) as indice,g.CodigoTime as numTime from Grupos g where g.Grupo = SUBSTRING(@vetorGrupos, @cont2, 1)
			set @contTimeA = 1
			while @contTimeA <= 4
			BEGIN
				--carrega um time da tabela 1 na variável @timeA
				print SUBSTRING(@vetorGrupos, @cont, 1)+ 'x' + SUBSTRING(@vetorGrupos, @cont2, 1)
				set @timeA = (select numTime from #tabela where indice = @contTimeA)
				set @contTimeB = 1
				set @diaJogo = @dataJogo
				while @contTimeB <= 4
				BEGIN
					--carrega 1 time da tabela 2 na variavel @timeB e faz um jogo vs o @timeA
					set @timeB = (SELECT numTime FROM #tabela2 where indice = @contTimeB)
					set @qnt = (select COUNT(*) from Jogos j where j.Data_Jogo = @diaJogo and (j.CodigoTimeA = @timeA or j.CodigoTimeB = @timeB or j.CodigoTimeA = @timeB or j.CodigoTimeB = @timeA))
					if @qnt < 1
					BEGIN
						--caso n tenha nenhum jogo de ambos os times na data @diaJogo, a partida é inserida
						Insert into Jogos Values(@timeA,@timeB,0,0,@diaJogo)
						print 'Inserindo jogo ' + Cast(@timeA as varchar) + ' x '+ Cast(@timeB as varchar) + ' no dia ' + Cast(@diaJogo as varchar)
						set @contTimeB = @contTimeB + 1
						set @diaJogo = @dataJogo
					END
					ELSE
					BEGIN
						--se já existir um jogo a próxima data é carregada
						if (DATEPART(weekday,@diaJogo) = 1)
						BEGIN
							set @diaJogo = DATEADD(day, 3, @diaJogo);
						END
						ELSE
						BEGIN
							set @diaJogo = DATEADD(day, 4, @diaJogo);
						END
					END
				END
				set @contTimeA = @contTimeA + 1
			END
			--define a proxima data inicial
			set @contData = 1
			if (SUBSTRING(@vetorGrupos, @cont, 1) = 'B')
			BEGIN
				while @contData <= 4
				BEGIN
					if DATEPART(weekday,@dataJogo) = 1
				BEGIN
					set @dataJogo = DATEADD(day, -3, @dataJogo);
				END
				ELSE
				BEGIN
					set @dataJogo = DATEADD(day, -4, @dataJogo);
				END
					set @contData = @contData + 1
				END
			END
			ELSE
			BEGIN
				while @contData <= 3
				BEGIN
					if DATEPART(weekday,@dataJogo) = 1
					BEGIN
						set @dataJogo = DATEADD(day, 3, @dataJogo);
					END
					ELSE
					BEGIN
						set @dataJogo = DATEADD(day, 4, @dataJogo);
					END
					set @contData = @contData + 1	
				END
			END

			print @dataJogo
			set @cont2 = @cont2 + 1
		END
		set @cont = @cont + 1
	END
	
EXEC vincula_data_jogos
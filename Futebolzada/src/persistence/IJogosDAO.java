package persistence;

import java.sql.SQLException;
import java.util.List;

import entity.Jogos;

public interface IJogosDAO { 
	public List<Jogos> buscarJogos(String data) throws SQLException; 
	public void gerarJogos() throws SQLException;
}

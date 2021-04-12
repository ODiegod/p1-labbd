package persistence;

import java.sql.SQLException;
import java.util.List;

import entity.Grupos;

public interface IGruposDAO {
	
	public List<Grupos> buscarGrupos() throws SQLException; 
	public void gerarGrupos() throws SQLException;
	
	}

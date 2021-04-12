package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Grupos;

public class GruposDAO implements IGruposDAO{

	private Connection c;
	
	public GruposDAO() throws SQLException {
		GenericDAO gDAO = GenericDAO.getInstance();
		c = gDAO.getConnection();
	}

	@Override
	public ArrayList<Grupos> buscarGrupos() throws SQLException {

		ArrayList<Grupos> listaGrupos = new ArrayList<Grupos>();
		String sql = "SELECT g.CodigoTime, g.Grupo,t.NomeTime FROM grupos g \r\n"
					+ "inner join times t\r\n"
					+ "on g.CodigoTime = t.CodigoTime";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Grupos gp = new Grupos();
			gp.setGrupo(rs.getString("Grupo"));
			gp.setCodigoTime(rs.getInt("CodigoTime"));
			gp.setNomeTime(rs.getString("NomeTime"));
			
			listaGrupos.add(gp);
		}
		
		rs.close();
		ps.close();

		return listaGrupos;	

	}

	@Override
	public void gerarGrupos() throws SQLException {
		String sql = "{Call sp_gerar_grupos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
	}

}

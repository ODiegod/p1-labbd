package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Jogos;


public class JogosDAO implements IJogosDAO{

private Connection c;
	
	public JogosDAO() throws SQLException {
		GenericDAO gDAO = GenericDAO.getInstance();
		c = gDAO.getConnection();
	}
	

	@Override
	public ArrayList<Jogos> buscarJogos(String data) throws SQLException {
		
		ArrayList<Jogos> listaJogos = new ArrayList<Jogos>();
		String sql = "SELECT jogos.CodigoTimeA, jogos.CodigoTimeB, jogos.GolsTimeA, jogos.GolsTimeB, jogos.DataJogo,\r\n"
				+ "        (SELECT times.NomeTime FROM times WHERE times.CodigoTime = jogos.CodigoTimeA) AS NomeTimeA,\r\n"
				+ "        (SELECT times.NomeTime FROM times WHERE times.CodigoTime = jogos.CodigoTimeB) AS NomeTimeB\r\n"
				+ "        FROM jogos WHERE jogos.DataJogo = (?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data);
		
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogos jg = new Jogos();
			jg.setCodigoTimeA(rs.getInt("CodigoTimeA"));
			jg.setCodigoTimeB(rs.getInt("CodigoTimeB"));
			jg.setGolsTimeA(rs.getInt("GolsTimeA"));
			jg.setGolsTimeB(rs.getInt("GolsTimeB"));
			jg.setDataJogo(rs.getDate("DataJogo").toLocalDate());
			jg.setNomeTimeA(rs.getString("NomeTimeA"));
			jg.setNomeTimeB(rs.getString("NomeTimeB"));
			listaJogos.add(jg);
		}
		
		rs.close();
		ps.close();

		return listaJogos;	}


	@Override
	public void gerarJogos() throws SQLException {
		String sql = "{Call sp_gerar_grupos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
	}
}

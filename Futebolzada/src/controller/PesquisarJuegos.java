package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Jogos;
import persistence.JogosDAO;

/**
 * Servlet implementation class PesquisarJuegos
 */
@WebServlet("/PesquisarData")
public class PesquisarJuegos extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PesquisarJuegos() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String dataJogos = request.getParameter("data");
		ArrayList<Jogos> listaJogos = new ArrayList<Jogos>();
		
		
		try {
			JogosDAO jDAO = new JogosDAO();
			listaJogos = jDAO.buscarJogos(dataJogos);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("lista", listaJogos);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}

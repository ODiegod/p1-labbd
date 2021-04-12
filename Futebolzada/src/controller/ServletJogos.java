package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.JogosDAO;

@WebServlet("/GeraJogos")
public class ServletJogos extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServletJogos() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			JogosDAO jDAO = new JogosDAO();
			jDAO.gerarJogos();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			String saida = "";
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("saida", saida);
			rd.forward(request, response);	
		}
	}

}

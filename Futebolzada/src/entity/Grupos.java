package entity;

public class Grupos {

	private String Grupo;
	private int CodigoTime;
	private String NomeTime;
	
	public String getGrupo() {
		return Grupo;
	}


	public void setGrupo(String grupo) {
		Grupo = grupo;
	}


	public int getCodigoTime() {
		return CodigoTime;
	}


	public void setCodigoTime(int codigoTime) {
		CodigoTime = codigoTime;
	}

	public String getNomeTime() {
		return NomeTime;
	}


	public void setNomeTime(String nomeTime) {
		NomeTime = nomeTime;
	}


	@Override
	public String toString() {
		return "Grupos [Grupo=" + Grupo + ", CodigoTime=" + CodigoTime + "]";
	}
	
}

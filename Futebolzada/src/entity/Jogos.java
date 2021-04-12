package entity;

import java.time.LocalDate;

public class Jogos {

	int CodigoTimeA;
	int CodigoTimeB;
	int GolsTimeA;
	int GolsTimeB;
	LocalDate DataJogo;	
	String nomeTimeA;
	String nomeTimeB;
	
	public int getCodigoTimeA() {
		return CodigoTimeA;
	}




	public void setCodigoTimeA(int codigoTimeA) {
		CodigoTimeA = codigoTimeA;
	}




	public int getCodigoTimeB() {
		return CodigoTimeB;
	}




	public void setCodigoTimeB(int codigoTimeB) {
		CodigoTimeB = codigoTimeB;
	}




	public int getGolsTimeA() {
		return GolsTimeA;
	}




	public void setGolsTimeA(int golsTimeA) {
		GolsTimeA = golsTimeA;
	}




	public int getGolsTimeB() {
		return GolsTimeB;
	}




	public void setGolsTimeB(int golsTimeB) {
		GolsTimeB = golsTimeB;
	}




	public LocalDate getDataJogo() {
		return DataJogo;
	}




	public void setDataJogo(LocalDate dataJogo) {
		DataJogo = dataJogo;
	}


	public String getNomeTimeA() {
		return nomeTimeA;
	}




	public void setNomeTimeA(String nomeTimeA) {
		this.nomeTimeA = nomeTimeA;
	}




	public String getNomeTimeB() {
		return nomeTimeB;
	}




	public void setNomeTimeB(String nomeTimeB) {
		this.nomeTimeB = nomeTimeB;
	}




	@Override
	public String toString() {
		return "Jogos [CodigoTimeA=" + CodigoTimeA + ", CodigoTimeB=" + CodigoTimeB + ", GolsTimeA=" + GolsTimeA
				+ ", GolsTimeB=" + GolsTimeB + ", DataJogo=" + DataJogo + "]";
	}
	
	
}

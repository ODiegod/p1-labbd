package persistence;

import java.sql.SQLException;
import java.util.List;

import entity.Times;

public interface ITimesDAO {

	public List<Times> buscarTimes() throws SQLException; 
}

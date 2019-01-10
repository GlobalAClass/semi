package db;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DB {
 
 static DataSource ds;
 
 static {
  
  try {
   Context initContext = new InitialContext();
   Context envContext  = (Context)initContext.lookup("java:/comp/env");
   ds = (DataSource)envContext.lookup("jdbc/myoracle");
  } catch (NamingException e) {
   e.printStackTrace();
  }
 }
 
 public static Connection getConn() throws Exception{
   return ds.getConnection();
 } 
}
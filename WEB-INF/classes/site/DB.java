package site;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.naming.InitialContext;
import java.util.ArrayList;

public class DB {
	String dbName;
	String dbConn;
	String dbDriver;
	String dbUser;
	String dbPass;
	String sSQL;
	Connection conn;
	Statement st;
	ResultSet rs = null;
	String id = "";
	String sql = "";
	PreparedStatement ps = null;
	boolean rsBeforeFirst = false;
	ArrayList<String> qryArgs = new ArrayList<String>();
	ArrayList<String> qryArgsType = new ArrayList<String>();
	Integer recs = 0;
	
	public DB () {		
		try {
			InitialContext ic = new InitialContext();
			dbName = (String) ic.lookup("java:comp/env/dbName");
			dbConn = (String) ic.lookup("java:comp/env/dbConn");
			dbDriver = (String) ic.lookup("java:comp/env/dbDriver");
			dbUser = (String) ic.lookup("java:comp/env/dbUser");
			dbPass = (String) ic.lookup("java:comp/env/dbPass");
		} catch (Exception e) {
		} 
    }

	
	public String postSubjectConvert (String sub) {
		sub = sub.toLowerCase();

		String s = "";
		String outStr = "";
		String comp = "abcdefghijklmnopqrstuvwxyz1234567890";
		String c = "";
		boolean match = false;
		for (int i = 0; i < sub.length(); i++){
			s = sub.substring(i,i+1);
			for (int ii=0;ii<comp.length();ii++) {
				c = comp.substring(ii,ii+1);
				if (s.equals(c)) {
					match = true;
					break;
				}
			}
			if (match) {
				outStr += c;
			} else {
				outStr += " ";
			}
			match = false;
		}
		
		while (outStr.contains("  ")) {
			outStr = outStr.replace("  "," ");
		}
		
		outStr = outStr.trim();
		outStr = outStr.replace(" ","-");
		
		if (outStr.length()>70) {
			outStr = outStr.substring(0,70);
		}
		
		return outStr;
	}
	
	public String postNew (String usrName, String postSubject, String postBody ) {
		String result = "failed";
		recs = 0;
		
		if (postSubject.length()>90) {
			postSubject = postSubject.substring(0,90);
		}
		
		String postSubjectURL = this.postSubjectConvert(postSubject);
		
		//sql = "INSERT INTO post (postUsrName, postSubject, postSubjectURL, postBody) VALUES ('"+usrName+"', '"+postSubject+"', '"+postSubjectURL+"', '"+postBody+"'); ";		
		sql = "INSERT INTO post (postUsrName, postSubject, postSubjectURL, postBody) VALUES (?,?,?,?);";	
		//sql = "INSERT INTO post (postUsrName) VALUES (?);";	
		
		qryArgs.add(usrName);
		qryArgsType.add("s");
		qryArgs.add(postSubject);
		qryArgsType.add("s");
		qryArgs.add(postSubjectURL);
		qryArgsType.add("s");
		qryArgs.add(postBody);
		qryArgsType.add("s");

		recs = this.execUpdate(sql);
		
		if (recs > 0) {
			result = id;
		}
		
		return result;
	}
	
	
	public String postComment (String postId, String usrName, String postBody ) {
		String result = "failed";
		
		//add some max postBody length validation
		
		sql = "INSERT INTO post (postIdParent, postUsrName, postBody) VALUES (?,?,?)";		
		
		
		qryArgs.add(postId);
		qryArgsType.add("l");
		qryArgs.add(usrName);
		qryArgsType.add("s");
		qryArgs.add(postBody);
		qryArgsType.add("s");
		
		
		recs = this.execUpdate(sql);
		
		if (recs <= 0) {
			result = "not posted";
		} else {
			result = "posted";
		}
		
		return result;
	}
	
	
	
	
    public Integer execUpdate (String sqlUpdate) {		
		try {
			Class.forName(dbDriver).newInstance(); 
			conn = DriverManager.getConnection(dbConn, dbUser, dbPass);    
			ps = conn.prepareStatement(sqlUpdate, Statement.RETURN_GENERATED_KEYS);
			for (int i=0;i<qryArgsType.size();i++) {
				if (qryArgsType.get(i).equals("s")) {
					System.out.println(i+1);
					System.out.println(qryArgs.get(i));
					ps.setString(i+1,qryArgs.get(i));
				} else if (qryArgsType.get(i).equals("l")) {
					ps.setLong(i+1,Long.parseLong(qryArgs.get(i)));
				}
			}
			//st = conn.createStatement(); 
			//recs = st.executeUpdate(sqlUpdate, Statement.RETURN_GENERATED_KEYS);
			recs = ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()){
				id = Long.toString(rs.getLong(1));
			}
			
			conn.close();		
		} catch (Exception e) {
			e.printStackTrace();
        }
		return recs;
    }
	
    private void execQuery(String sqlQuery) {		
		try {
			Class.forName(dbDriver).newInstance(); 
			conn = DriverManager.getConnection(dbConn, dbUser, dbPass);    
			st = conn.createStatement(); 
			rs = st.executeQuery(sqlQuery);
			rsBeforeFirst = rs.isBeforeFirst();
		} catch (Exception ex) {
        }
    }
	
	public String postQuery(String postId) {		
		
		String sql = "SELECT *, Date_Format(postTime,'%Y %b %e at %l:%i %p') as postDate  FROM post WHERE postId = "+postId + " OR postIdParent= "+postId + "  ORDER BY postId asc " ;
		this.execQuery(sql);
		
		if (!rsBeforeFirst) {
			return "No Recs";
		} 
		
		try {
		rs.close();
		conn.close();
		} catch (Exception ex) {
        }
		return "Some Recs";
    }
}
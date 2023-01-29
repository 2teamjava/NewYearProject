
import java.sql.*;

public class jdbcClass {
	
	public static void main(String[] args) {
		String DataBaseName="newyear";
		String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";  
		String DB_URL="jdbc:mysql://localhost:3306/"+DataBaseName+"?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
		String USER="newyear";
	    String PASSWORD="newyear";
	    try {
        	Class.forName(JDBC_DRIVER);
        	Connection connect=DriverManager.getConnection(DB_URL,USER,PASSWORD);
        	Statement statement=connect.createStatement();
        	String sql="SELECT * FROM member";
        	ResultSet resultset=statement.executeQuery(sql);
        	System.out.println("============================");
        	while(resultset.next()) {
        		int member_index=resultset.getInt("member_index");
        		String name=resultset.getString("name");
        		String phone=resultset.getString("phone");
        		String address=resultset.getString("address");
        		String account=resultset.getString("account");
        		String password=resultset.getString("password");
        		System.out.println("document.write('"+member_index+"');");
        		System.out.println("document.write('"+name+"');");
        		System.out.println("document.write('"+phone+"');");
        		System.out.println("document.write('"+address+"');");
        		System.out.println("document.write('"+account+"');");
        		System.out.println("document.write('"+password+"');");
        		System.out.println("============================");
        	}
        }
        catch(Exception e) {
        	e.printStackTrace();
        }
	}//main method
}//main class

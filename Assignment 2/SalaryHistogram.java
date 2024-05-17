import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.HashMap;
import java.lang.Math;


public class SalaryHistogram {
    public static void main(String[] args) {
      if (args.length != 6) {
            System.out.println("Please input 6 argument (database name, username, password, lowerbound, upperbound, bin) "); 
            return;
        }
        

        

        try {
            String dbName = args[0];
            String loginId = args[1];
            String password = args[2];
            double startSalary =Double.parseDouble(args[3]);
            double endSalary = Double. parseDouble(args[4]);
            double binNumber = Integer.parseInt(args[5]);
            double binSize = (endSalary - startSalary) / binNumber;
            HashMap<Double, Integer> map = new HashMap<Double, Integer>();
            Class.forName("com.ibm.db2.jcc.DB2Driver");
            Connection connection = DriverManager.getConnection("jdbc:db2://localhost:25000/" + dbName, loginId, password);
            String db2Query = "select salary as salary from employee where salary >= ? and salary < ?";

            PreparedStatement preparedStatement = connection.prepareStatement(db2Query);
            preparedStatement.setDouble(1, startSalary);
            preparedStatement.setDouble(2, endSalary);

            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
               double salary = resultSet.getInt("salary");
               double target_bin= Math.ceil((salary- startSalary)/binSize);
               if((salary - startSalary) % binSize == 0){
                target_bin=target_bin+1;
               }
               if(map.containsKey(target_bin)){
                  int res= map.get(target_bin)+1;
                  map.put(target_bin, res);
               }
               else{
                  map.put(target_bin, 1);
               }
                   
            }
      
            System.out.println("binnum  #   frequency  #   binstart  #  binend");
            for (double i=1;i<=binNumber;i++){
            
              System.out.println((i)+" # "+( map.containsKey(i)?map.get(i):0)+" # "+(startSalary+(i-1)*binSize)+" # "+((startSalary+(i-1)*binSize)+binSize));
            }
            preparedStatement.close();
            connection.close();
        } 
        catch (ClassNotFoundException |NumberFormatException | SQLException e) {
            System.out.println("YOUR INPUT IS NOT CORRECT");
            
        }
    }
}

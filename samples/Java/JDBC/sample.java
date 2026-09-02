import java.sql.*;

class sample {
    public static void main (String argv[]) {
        try {

    /*  Note:  The format is

jdbc:vortex://userid/password/driver:configfile@port:hostname!databaseid

        For example 
        (using defaults for driver, configfile, port, and databaseid):

jdbc:vortex://system/manager/gds10:acuxdbc.cfg@20222:myserver!acuxdbc04

    */

            String connectionURL =     
                "jdbc:vortex://system/manager/xvision:" + 
                "acuxdbc.cfg" + 
                "@20222:localhost" +  
                "!acuxdbc04";

            String sqlStatement =   
                "  SELECT                           \n" +
                "      patient_id,                  \n" +
                "      patient_name,                \n" +
                "      animal_type                  \n" +
                "    FROM                           \n" +
                "       pets                        \n" +
                "    WHERE                          \n" +
                "       LCASE(animal_type) = 'dog'  \n" +
                "    ORDER BY                       \n" +
                "       patient_name";

            System.out.println("\nConnection URL: \n" + connectionURL);
            System.out.println("\nSQL Statement:  \n" + sqlStatement);

            Class.forName("vortex.sql.vortexDriver");
            Connection conn = 
                DriverManager.getConnection(connectionURL);

            Statement stmt = 
                conn.createStatement(   ResultSet.TYPE_FORWARD_ONLY,
                                        ResultSet.CONCUR_UPDATABLE );
            ResultSet data;
            data = stmt.executeQuery(sqlStatement);

            System.out.print("\nRESULTS:\n\n");
            System.out.print(
                "Patient ID   Patient Name         Animal Type\n" +
                "============ ==================== ====================\n");
            while (data.next()) {
                System.out.printf( "%-12s %-20s %-20s\n",  
                                    data.getString(1),
                                    data.getString(2),
                                    data.getString(3));
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }
}
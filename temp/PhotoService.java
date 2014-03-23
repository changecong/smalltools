/**
 * File Name: PhotoService.java
 * Created By: Zhicong Chen
 * Creation Date: [2012-11-10 12:46]
 * Last Modified: [2012-11-23 22:10]
 * Licence: chenzc (c) 2012 | all rights reserved
 * Description: program for hw7 of CS5200
 */

import java.sql.*;

public class PhotoService
{

  // main start
  public static void main(String[] args) {

    if (args.length == 0) {
      printUsage();
      System.exit(0);
    }

    jdbcDriver();
     
    // commands
    if (args[0].equals("newPhoto") && args.length == 7) {
        
      // initialize vars
      String strTimeAndData = args[1];
      String strNameOfGrapher = args[2];
      String strTypeOfPhoto = args[3];
      String strCity = args[4];
      String strState = args[5];
      String strCountry = args[6];

      // call newPhoto
      newPhoto(strTimeAndData, strNameOfGrapher,
               strTypeOfPhoto, strCity,
               strState, strCountry);

      System.exit(1);
    }
    else if (args[0].equals("newAppearance") && args.length == 3) {
    
      // initialize vars
      String strId = args[1];
      String strNameOfPerson = args[2];

      // call newAppearance
      newAppearance(strId, strNameOfPerson);
    }
    else if (args[0].equals("firePhotographer") && args.length == 2) {

      // initialize vars
      String strid = args[1];
     
      // call firePhotographer
      firePhotoGrapher(strid);
    }
    else {
      printUsage();
    }

    System.exit(0);
  }  // main end

  /**
   * The printUsage() method of the PhotoService
   * This method is called to display the usage info
   */
  private static void printUsage() {

    String usage = "Usage: java PhotoService [METHOD] [PARAMETER_1]...[PARAMETER_n]\n" +
                   "Use to operate the MYSQL database \'photo\'.\n" +
                   "Example: java PhotoService newAppearance 12 Jhon\n\n" +
                   "Method selection:\n" +
                   " newPhoto \t\t parameters are: time and date of photo\n" +
                   "\t\t\t\t\t name of photographer\n" + 
                   "\t\t\t\t\t type of photo\n" + 
                   "\t\t\t\t\t city\n" + 
                   "\t\t\t\t\t state\n" + 
                   "\t\t\t\t\t country\n" +
                   " newAppearance \t\t parameters are: photo id\n" +
                   "\t\t\t\t\t name of person\n" +
                   " firePhotographer \t parameter is:   photographer id\n\n" +
                   "ChenZC <http://changecong.com>\n"; 
    System.out.println(usage);
  }

  /**
   * The jdbcDriver() method of the PhotoService
   * This method is called to load the driver of jdbc
   */
  private static void jdbcDriver() {
    // driver
    try {
      Class.forName("com.mysql.jdbc.Driver"); 
    } catch (ClassNotFoundException e) {  
      e.printStackTrace();  
    }
  }  // jdbcDriver end

  /**
   * The newPhoto() method of the PhotoService
   * This method is called to create a new photo
     * If there is no such photographer or if there are several with the
     * specified name, then the request fails
     * Create any other as needed
   * @param time
   * time and date of when the photo is token.
   * @param name
   * name of the photographer who take the photo.
   * @param type
   * type of photo, also the type of the photographer.
   * @param city
   * name of the city where the photo is taken.
   * @param state
   * name of the state where the photo is taken.
   * @param country
   * name of the country whre the photo is taken.
   */
  private static void newPhoto(String time, String name,
                       String type, String city,
                       String state, String country) {

    // initialize connection
    Connection conn = null;
    // connection
    try {
      // database
      String url = "jdbc:mysql://localhost:3306/photo";
      // username: photo; password: photo
      conn = DriverManager.getConnection(url, "photo", "photo");
      if (conn != null) {
        System.out.println("Connect Successfully.");
      }
    } catch(SQLException e) {
      e.printStackTrace();
    }

    // execute SQL
    try {
      // initialize statement
      Statement statement = conn.createStatement();
      // check if there is such photographer
      String q_photographerExist = "SELECT count(Pg.id) as num, Pg.id as id FROM Photographer Pg JOIN Person P ON Pg.id = P.id where P.name = \"" + name + "\"";

      ResultSet result = statement.executeQuery(q_photographerExist);
      
      int num_pg = 0;
      int pg_id = 0;
      while (result.next()) {
        num_pg = result.getInt("num");
        pg_id = result.getInt("id");
      }
      // none or more than one
      if (num_pg == 1) {
        // check if there is such place
        String q_locationExist = "SELECT id FROM Location WHERE city= \"" + city +"\" AND state=\"" + state + "\" AND country=\"" + country + "\"";
        result = statement.executeQuery(q_locationExist);
       
        int l_id;
        if (result.next()) { // does exist
          l_id = result.getInt("id");
        } else { // insert a new one
          String q_maxLocationId = "SELECT MAX(id) as id FROM Location";
          result = statement.executeQuery(q_maxLocationId);
          if (result.next()) {
            l_id = result.getInt("id");
          } else {
            l_id = 0;
          }

          //String l_id_s = String.valueOf(l_id + 1);
          l_id++;
          String q_insertLocation = "INSERT INTO Location value(" + l_id + "," +
                                    "\"" + city + "\"," +
                                    "\"" + state + "\"," +
                                    "\"" + country + "\")";

          statement.executeUpdate(q_insertLocation);
          System.out.println("New location info created.");
        }

        // insert photo
		String q_maxPhotoId = "SELECT MAX(id) as id FROM Photo";
        result = statement.executeQuery(q_maxPhotoId);
        
        int p_id;
        if (result.next()) {
          p_id = result.getInt("id");
        } else {
          p_id = 0;
        }

        String p_id_s = String.valueOf(p_id+1);

        String q_insertPhoto = "INSERT INTO Photo VALUE(" + p_id_s + ", " +
                               "\"" + time + "\"," +
                               pg_id + ", " +
                               l_id + ", " +
                               "\"" + type + "\")";

        statement.executeUpdate(q_insertPhoto);

        System.out.println("Create a new photo.");
      
      } else {
        System.out.println("Request fail. The photographer \"" + name + "\" does not exist nor it is not an unique name.");
      }

    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (conn != null) {
          conn.close();
          System.out.println("Disconnected");
        }
      } catch(SQLException e) {
        e.printStackTrace();
      }
    }
  }

  /**
   * The newAppearance() Method of the PhotoService
   * The method is called to specify that the person appears in the photo
     * If there is no such person, then create a new record for the person
     * If there are two persons with the specified name, then the request 
     * fails
   * @param id
   * the photo id
   * @param name
   * name of the person who appears in the photo
   */
  private static void newAppearance(String id, String name) {
    
    // initialize connection
    Connection conn = null;
    // connection
    try {
      // database
      String url = "jdbc:mysql://localhost:3306/photo";
      // username: photo; password: photo
      conn = DriverManager.getConnection(url, "photo", "photo");
      if (conn != null) {
        System.out.println("Connect Successfully.");
      }
    } catch(SQLException e) {
      e.printStackTrace();
    }

    // execute SQL
    try {
      // initialize statement
      Statement statement = conn.createStatement();

      String q_photoExist = "SELECT id FROM Photo WHERE id=" + id;
      ResultSet result = statement.executeQuery(q_photoExist);
     
      if (result.next()) { // exist
        // check if there is such person exist
        String q_personExist = "SELECT count(P.id) as num, P.id as id FROM Person P WHERE name =\"" + name + "\"";
        result = statement.executeQuery(q_personExist);

        int p_num = 0;
        int p_id = 0;
        while (result.next()) {
          p_num = result.getInt("num");
          p_id = result.getInt("id");
        }    

        if (p_num > 1) {
          System.out.println("Request fail. \"" + name + "\" is not an unique name.");
        } else {
          // no this person, create one
          if (p_num == 0) {
            // get the max person id
            String q_maxPersonId = "SELECT MAX(id) as id FROM Person";
            result = statement.executeQuery(q_maxPersonId);
            if (result.next()) {
              p_id = result.getInt("id");
              p_id++; // next id
            } else {
              p_id = 1; // new person
            }

            // create a person
            String q_insertPerson = "INSERT INTO Person VALUE(" + p_id + ", \"" +  name + "\")";
            statement.executeUpdate(q_insertPerson);
         
            System.out.println("Create a new person's record.");

          }
          // now the pereson exist
          String q_insertAppearance = "INSERT INTO Appearance VALUE(" + p_id + "," + id + ")";
          statement.executeUpdate(q_insertAppearance); 

          System.out.println("\"" + name + "\" appears in the photo No." + id + " now.");

        }
      } else { // photo do not exist
        System.out.println("The photo does not exist.");
      }

    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (conn != null) {
          conn.close();
          System.out.println("Disconnected");
        }
      } catch(SQLException e) {
        e.printStackTrace();
      }
    }    
  }


  /**
   * The firePhotoGrapher() method of the PhotoService
   * The method is called to change a photographer to being just a person
     * All photos taken by the photographer are to be updated so that 
     * they are taken by a photographer named "staff" who lives in Boston
     * If there is no such photographer then create one
   * @param id
   * id of photographer who is fired.
   */
  private static void firePhotoGrapher(String id) {

    // initialize connection
    Connection conn = null;
    // connection
    try {
      // database
      String url = "jdbc:mysql://localhost:3306/photo";
      // username: photo; password: photo
      conn = DriverManager.getConnection(url, "photo", "photo");
      if (conn != null) {
        System.out.println("Connect Successfully.");
      }
    } catch(SQLException e) {
      e.printStackTrace();
    }

    // execute SQL
    try {
      // initialize statement
      Statement statement = conn.createStatement();
      // check if there is such photographer 
      String q_photographerExist = "SELECT * FROM Photographer WHERE id=" + id;
      ResultSet result = statement.executeQuery(q_photographerExist);
     
      if (result.next()) {  // the photographer exist;
        // check if there is a person named "Staff"
        String q_staffExistInPerson = "SELECT id FROM Person WHERE name=\"Staff\" ";
        result = statement.executeQuery(q_staffExistInPerson);
       
        int staff_id = 0;
        if (result.next()) { // staff exist as a person
          staff_id = result.getInt("id");
          // check if there is a photographer named "Staff"
          String q_staffExistInPhotographer = "SELECT id FROM Photographer WHERE id=" + staff_id;
          result = statement.executeQuery(q_staffExistInPhotographer);
          if (result.next()) {  // there is
             
          } else {  // there is not
            // create a new one
            String q_insertNewStaff = "INSERT INTO Photographer SELECT " + staff_id + ", L.id FROM Location L WHERE L.city=\"Boston\"";
            statement.executeUpdate(q_insertNewStaff);
            System.out.println("Create a new Staff record.");
          }
        } else {  // staff do not exist
          String q_maxPersonId = "SELECT MAX(id) as id FROM Person";
          result = statement.executeQuery(q_maxPersonId);
          if (result.next()) {
            staff_id = result.getInt("id");
            staff_id++;
          } else {
            // empty set
            staff_id = 1;
          }

          // insert into person
          String q_insertIntoPerson = "INSERT INTO Person VALUE("+ staff_id + ", \"Staff\")";
          statement.executeUpdate(q_insertIntoPerson);

          // insert into Photograhper
          String q_insertIntoPhotographer = "INSERT INTO Photographer SELECT " + staff_id + ", L.id FROM Location L WHERE L.city=\"Boston\"";
          statement.executeUpdate(q_insertIntoPhotographer);
          System.out.println("Create a new Staff record.");
        }

        // now we hava "Staff"
        // update photos
        String q_updatePhotos = "UPDATE Photo SET takenBy=" + staff_id + " WHERE takenBy=" + id;
        statement.executeUpdate(q_updatePhotos);
        // now that all the photos up to date.

        // fire the photographer
        String q_deletePhotographer = "DELETE FROM Photographer WHERE id=" + id;
        statement.executeUpdate(q_deletePhotographer);
        // now the photographer is fired

        System.out.println("The Photographer is fired");
      } else {
        System.out.println("There is no such a photographer");
      }
    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (conn != null) {
          conn.close();
          System.out.println("Disconnected");
        }
      } catch(SQLException e) {
        e.printStackTrace();
      }
    }
  }
}






<?php
header("Access-Control-Allow-Origin: *");

class Constants
{
    //DATABASE DETAILS
    static $DB_SERVER = "localhost";
    static $DB_NAME = "almed";
    static $USERNAME = "root";
    static $PASSWORD = "";

    //STATEMENTS
    static $SQL_SELECT_ALL = "SELECT * FROM product LIMIT ?, ?";
}

class Spacecrafts
{
    /*******************************************************************************************************************************************/
    /*
       1.CONNECT TO DATABASE.
       2. RETURN CONNECTION OBJECT
    */
    public function connect()
    {
        $con = new mysqli(Constants::$DB_SERVER, Constants::$USERNAME, Constants::$PASSWORD, Constants::$DB_NAME);
        if ($con->connect_error) {
            // echo "Unable To Connect"; - For debug
            return null;
        } else {
            //echo "Connected"; - For debug
            return $con;
        }
    }

    /*******************************************************************************************************************************************/
    /*
       1.SELECT FROM DATABASE.
    */
    public function select($start, $limit)
    {
        $con = $this->connect();
        if ($con != null) {
            $stmt = $con->prepare(Constants::$SQL_SELECT_ALL);
            $stmt->bind_param('ii', $start, $limit);
            $stmt->execute();

            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $spacecrafts = array();
                while ($row = $result->fetch_assoc()) {
                    array_push($spacecrafts, array(
                        "id" => $row['id'],
                        "name" => $row['pname'],
                        "content" => $row['content'],
                        "therapeautic" => $row['therapeautic'],
                        "strength" => $row['strength'],
                        "form" => $row['form'],
                        "company" => $row['company'],
                        "gst" => $row['gst'],
                        "quantity" => $row['pgms'],
                        "mrp" => $row['pprice'],
                        "image_url" => $row['pimg'],
                        "discount" => $row['mprice']
                    ));
                }
                print(json_encode(array_reverse($spacecrafts)));
            } else {
                print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
            }
            $stmt->close();
            $con->close();
        } else {
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }
}

$spacecrafts = new Spacecrafts();

// Check if start and limit parameters are set in the request
$start = isset($_GET['start']) ? (int)$_GET['start'] : 0;
$limit = isset($_GET['limit']) ? (int)$_GET['limit'] : PHP_INT_MAX;

$spacecrafts->select($start, $limit);

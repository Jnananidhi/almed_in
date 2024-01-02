<?php

if($_SERVER['REQUEST_METHOD']=='POST'){
     include 'gms_conn.php';
     $permit_no = (int)$_POST['permitNo'];
    
    
    
     $check5 = "SELECT STATUS from permit_request where CO_NO = $permit_no and STATUS = 'CLOSED'";
    $resultcheck5 = mysqli_query($conn, $check5) or die("query $check5 failed in sendFarmerData because". mysqli_error($conn));				
    $recordcheck5 = mysqli_fetch_assoc($resultcheck5);
    $FLAG = "";
    
    if($recordcheck5)
    {
        $FLAG="-1";
        $details = array();
    $temp=[
        'flag'=>$FLAG,
        'farmer_code'=>" ",
        'farmer_name'=>" ",
        'plot_no'=>" ",
         'village'=>" ",
        'distance'=>" "        
        ];
    //pushing array into hero array
    array_push($details,$temp);
echo json_encode($details);  
        exit;
    }
    
    $check = "SELECT FARMER_CODE,PLOT_NO from permit_request where CO_NO = $permit_no and STATUS = 'APPROVED'";
    $resultcheck = mysqli_query($conn, $check) or die("query $check failed in sendFarmerData because". mysqli_error($conn));				
    $recordcheck = mysqli_fetch_assoc($resultcheck);
    $FARMER_CODE="";
    $PLOT_N0="";
    
    if($recordcheck)
    {
        $FARMER_CODE=$recordcheck['FARMER_CODE'];
        $PLOT_NO = $recordcheck['PLOT_NO'];
    }
    else
    {
        echo "Permit not approved or not found";
        exit;
    }
    
    $check1 = "select NAME from master_farmer where FARMER_CODE = '$FARMER_CODE'";
    $resultcheck1 = mysqli_query($conn, $check1) or die("query $check1 failed in fetchPermit because". mysqli_error($conn));				
    $recordcheck1 = mysqli_fetch_assoc($resultcheck1);
    if($recordcheck1)
    {
        $NAME=$recordcheck1['NAME'];
        
    }
    
    $check3 = "select VILLAGE from cane_plantation where PLOT_NO = '$PLOT_NO'";
    $resultcheck3 = mysqli_query($conn, $check3) or die("query $check3 failed in fetchPermit because". mysqli_error($conn));				
    $recordcheck3 = mysqli_fetch_assoc($resultcheck3);
    if($recordcheck3)
    {
        $VILLAGE = $recordcheck3['VILLAGE'];        
    }
            
    $check2 = "select DISTANCE,STATUS from master_village where VILLAGE = '$VILLAGE'";
    $resultcheck1 = mysqli_query($conn, $check2) or die("query $check1 failed in fetchPermit because". mysqli_error($conn));				
    $recordcheck1 = mysqli_fetch_assoc($resultcheck1);
    if($recordcheck1)
    {
        $DIST=$recordcheck1['DISTANCE'];
        $STATUS = $recordcheck1['STATUS'];
        
    }
    if($STATUS=='LOCKED')
    {
        $FLAG="-2";
        $details = array();
    $temp=[
        'flag'=>$FLAG,
        'farmer_code'=>" ",
        'farmer_name'=>" ",
        'plot_no'=>" ",
         'village'=>" ",
        'distance'=>" "        
        ];
    //pushing array into hero array
    array_push($details,$temp);
        echo json_encode($details);  
        exit;
    }
    $FLAG="1";
    $details = array();
    $temp=[
        'flag'=>$FLAG,
        'farmer_code'=>$FARMER_CODE,
        'farmer_name'=>$NAME,
        'plot_no'=>$PLOT_NO,
         'village'=>$VILLAGE,
        'distance'=>$DIST        
        ];
    //pushing array into hero array
    array_push($details,$temp);
echo json_encode($details);  
    

}
 ?>
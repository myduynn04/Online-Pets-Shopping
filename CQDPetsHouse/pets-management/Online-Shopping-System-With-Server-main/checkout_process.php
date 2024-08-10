<?php  // file xử lý thông tin đặt hàng và chi tiết đơn hàng từ người dùng đã login
session_start();
include "db.php";
if (isset($_SESSION["uid"])) {

	$f_name = $_POST["firstname"];
	$email = $_POST['email'];
	$address = $_POST['address'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $zip= $_POST['zip'];
    $cardname= $_POST['cardname'];
    $cardnumber= $_POST['cardNumber'];
    $expdate= $_POST['expdate'];
    $cvv= $_POST['cvv'];
    $user_id=$_SESSION["uid"];
    $cardnumberstr=(string)$cardnumber;
    $total_count=$_POST['total_count'];
    $prod_total = $_POST['total_price'];
    
    $sql0="SELECT order_id from orders_info";
    $runquery=sqlsrv_query($con,$sql0);
    if (sqlsrv_has_rows($runquery) === false) {
        echo( print_r(sqlsrv_errors(), true));
        $order_id=1;
    } else {
        $sql2="SELECT MAX(order_id) AS max_val from orders_info";
        $runquery1=sqlsrv_query($con,$sql2);
        $row = sqlsrv_fetch_array($runquery1);
        $order_id= $row["max_val"];
        $order_id=$order_id+1;
        echo( print_r(sqlsrv_errors(), true));
    }

	$sql = "INSERT INTO orders_info
	(order_id,user_id,f_name, email,address, 
	city, state, zip, cardname,cardnumber,expdate,prod_count,total_amt,cvv) 
	VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $params = array($order_id, $user_id, $f_name, $email, 
        $address, $city, $state, $zip, $cardname, $cardnumberstr, $expdate, $total_count, $prod_total, $cvv);

    $result = sqlsrv_query($con, $sql, $params);
    
    if ($result){
        $i=1;
        $prod_id_=0;
        $prod_price_=0;
        $prod_qty_=0;
        while($i<=$total_count){
            $str=(string)$i;
            $prod_id_+$str = $_POST['prod_id_'.$i];
            $prod_id=$prod_id_+$str;		
            $prod_price_+$str = $_POST['prod_price_'.$i];
            $prod_price=$prod_price_+$str;
            $prod_qty_+$str = $_POST['prod_qty_'.$i];
            $prod_qty=$prod_qty_+$str;
            $sub_total=(int)$prod_price*(int)$prod_qty;
           
            $sql1 = "INSERT INTO order_products (order_id, product_id, qty, amt) VALUES (?, ?, ?, ?)";
            $params1 = array($order_id, $prod_id, $prod_qty, $sub_total);

            $result1 = sqlsrv_query($con, $sql1, $params1);

            
            if($result1){
                $del_sql="DELETE from cart where user_id=?";
                $params_del = array($user_id);
                $result_del = sqlsrv_query($con, $del_sql, $params_del);

                if($result_del){
                    echo"<script>window.location.href='store.php'</script>";
                } else {
                    echo(print_r(sqlsrv_errors(), true));
                }
            } else {
                echo(print_r(sqlsrv_errors(), true));
            }
            $i++;
        }
    } else {
        echo(print_r(sqlsrv_errors(), true));
    }
    
} else {
    echo"<script>window.location.href='index.php'</script>";
}
?>
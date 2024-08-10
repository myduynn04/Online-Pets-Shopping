<?php
include "db.php";

session_start();


if (isset($_POST["email"]) && isset($_POST["password"])) {
    $email = $_POST["email"];
    $password = $_POST["password"];

    // Check in user_info table
    //$sql = "SELECT * FROM user_info WHERE email = '$email' AND password = '$password'";
   // $run_query = sqlsrv_query($con, $sql);
    $sql = "SELECT * FROM user_info WHERE email = ? AND password = ?";
    $params = array($email, $password);
    $run_query = sqlsrv_query($con, $sql,$params);
    $count = sqlsrv_has_rows($run_query);
    $row = sqlsrv_fetch_array($run_query, SQLSRV_FETCH_ASSOC);
    if($row){
    $_SESSION["uid"] = $row["user_id"];
    $_SESSION["name"] = $row["first_name"];
    $ip_add = $_SERVER['REMOTE_ADDR'];}
    // Check if the "product_list" cookie is available
    if ($count == 1) {
        if (isset($_COOKIE["product_list"])) {
            $p_list = stripcslashes($_COOKIE["product_list"]);
            // Decode the stored JSON product list cookie to a normal array
            $product_list = json_decode($p_list, true);
            
            // Iterate through the product list
            for ($i = 0; $i < count($product_list); $i++) {
                // Verify if the product is already in the user's cart
                $verify_cart = "SELECT id FROM cart WHERE user_id = $_SESSION[uid] AND p_id = " . $product_list[$i];
                $result = sqlsrv_query($con, $verify_cart);
                
                if (sqlsrv_num_rows($result) < 1) {
                    // If the product is being added for the first time, update the user_id in the database table
                    $update_cart = "UPDATE cart SET user_id = '$_SESSION[uid]' WHERE ip_add = '$ip_add' AND user_id = -1";
                    sqlsrv_query($con, $update_cart);
                } else {
                    // If the product is already in the database table, delete that record
                    $delete_existing_product = "DELETE FROM cart WHERE user_id = -1 AND ip_add = '$ip_add' AND p_id = " . $product_list[$i];
                    sqlsrv_query($con, $delete_existing_product);
                }
            }

            // Destroy the user cookie
            setcookie("product_list", "", strtotime("-1 day"), "/");
            
            // If the user is logging in from the cart page, send "cart_login"
            echo "cart_login";
            exit();
        }

        // If the user is logging in from another page, send "login_success"
        echo "login_success";
        $BackToMyPage = $_SERVER['HTTP_REFERER'];
        if (!isset($BackToMyPage)) {
            header('Location: ' . $BackToMyPage);
            echo "<script type='text/javascript'></script>";
        } else {
            echo "<script> location.href='index.php'; </script>"; // default page
        }
        exit;
    } else {
        
        $email = $_POST["email"];
        $password = md5($_POST["password"]); // Lưu ý: Sử dụng hàm băm mật khẩu không an toàn như MD5, khuyến nghị sử dụng phương pháp băm mạnh mẽ hơn như bcrypt.

        // Sử dụng tham số để tránh SQL injection
        $sql = "SELECT * FROM admin_info WHERE admin_email = ? AND admin_password = ?";
        $params = array($email, $password);

        $run_query = sqlsrv_query($con, $sql, $params);
        $count = sqlsrv_num_rows($run_query);
        if ($run_query === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        


        // If admin record is available in the database, $count will be equal to 1
        if ($count == 1) {
            $row = sqlsrv_fetch_array($run_query);
            $_SESSION["uid"] = $row["admin_id"];
            $_SESSION["name"] = $row["admin_name"];
            $ip_add = $_SERVER['REMOTE_ADDR'];
    //$ip_add = getenv("REMOTE_ADDR");

            // If the user is logging in from another page, send "login_success"
            echo "login_success";
            echo "<script> location.href='admin/add_products.php'; </script>";
            exit;
        } else {
            echo "<span style='color:red;'>Wrong password or Please register before login..!</span>";
            exit();
        }
    }
}
?>

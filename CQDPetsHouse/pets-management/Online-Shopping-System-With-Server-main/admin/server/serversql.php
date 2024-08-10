<?php
session_start();
?>

<?php

// initializing variables
$name = "";
$username = "";
$usn = "";
$email = "";
$errors = array();
$reg_date = date("Y/m/d");

// Define your database connection details
$serverName = "NGUYEN-MY-DUYEN\SQLEXPRESS"; // Replace with your SQL Server host name or IP address
$database = "CDQ2"; // Replace with your database name

// Connection options
$connectionOptions = array(
    "Database" => $database,      // Replace with your SQL Server password
    "Encrypt" => "no",             // Disable connection encryption
    "TrustServerCertificate" => "yes"  // Trust the server certificate
);

// Connect to the database
$db = sqlsrv_connect($serverName, $connectionOptions);

// Check the connection
if (!$db) {
    die(print_r(sqlsrv_errors(), true));
}


// REGISTER USER
if (isset($_POST['reg_user'])) {
    // receive all input values from the form
    $username = sqlsrv_real_escape_string($db, $_POST['admin_name']);
    $email = sqlsrv_real_escape_string($db, $_POST['admin_email']);
    $password_1 = sqlsrv_real_escape_string($db, $_POST['password_1']);
    $password_2 = sqlsrv_real_escape_string($db, $_POST['password_2']);

    // form validation: ensure that the form is correctly filled ...
    // by adding (array_push()) corresponding error unto $errors array
    if (empty($username)) {
        array_push($errors, "Username is required");
    }
    if (empty($email)) {
        array_push($errors, "Email is required");
    }
    if (empty($password_1)) {
        array_push($errors, "Password is required");
    }
    if ($password_1 != $password_2) {
        array_push($errors, "The passwords do not match");
    }

   
     $user_check_query = "SELECT TOP 1 *
                          FROM admin_info
                          WHERE admin_name = '$username' OR admin_email = '$email';
";
  $result = sqlsrv_query($db, $user_check_query);
    $user = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);

    if ($user) { // if user exists
        if ($user['admin_name'] === $username) {
            array_push($errors, "Username already exists");
        }

        if ($user['admin_email'] === $email) {
            array_push($errors, "Email already exists");
        }
    }

    // Finally, register user if there are no errors in the form
    if (count($errors) == 0) {
        $password = md5($password_1); // encrypt the password before saving in the database

        $query = "INSERT INTO admin_info (admin_name, admin_email, admin_password)
                  VALUES('$username', '$email', '$password')";
        sqlsrv_query($db, $query);

        $_SESSION['admin_name'] = $username;
        $_SESSION['admin_email'] = $email;

        $_SESSION['success'] = "You are now logged in";
        header('location: ./admin/');
    }
}

// LOGIN ADMIN
if (isset($_POST['login_admin'])) {
    $admin_username = $_POST['admin_username'];
    $password = $_POST['password'];

    if (empty($admin_username)) {
        array_push($errors, "Username is required");
    }
    if (empty($password)) {
        array_push($errors, "Password is required");
    }

    if (count($errors) == 0) {
        // Use prepared statements to prevent SQL injection
        $query = "SELECT * FROM admin_info WHERE admin_email = ? AND admin_password = ?";
        $params = array($admin_username, $password);
        $options = array("Scrollable" => SQLSRV_CURSOR_KEYSET);

        $results = sqlsrv_query($db, $query, $params, $options);

        if ($results !== false) {
            // Check the number of rows returned
            $num_rows = sqlsrv_num_rows($results);

            if ($num_rows > 0) {
                $user = sqlsrv_fetch_array($results, SQLSRV_FETCH_ASSOC);
                $_SESSION['admin_email'] = $user['admin_email'];
                $_SESSION['admin_name'] = $admin_username;
                $_SESSION['success'] = "You are now logged in";
                header('location: ./admin/');
            } else {
                array_push($errors, "Wrong username/password combination");
            }
        } else {
            // Handle query execution errors
            die(print_r(sqlsrv_errors(), true));
        }
    }
}

?>

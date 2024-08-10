<?php  // file to displays a list of users from a SQL Server database
session_start();
include "sidenav.php";
include "topheader.php";
$serverName = "NGUYEN-MY-DUYEN\SQLEXPRESS";
$database = "CDQ2";


$connection = [
    "Database" => $database,
    "Encrypt" => "no",  // Disable connection encryption
    "TrustServerCertificate" => "yes"  // Trust the server certificate
]; 

$con = sqlsrv_connect($serverName, $connection);

if (!$con) {
    die(print_r(sqlsrv_errors(), true));
}


?>
<!-- End Navbar -->
<div class="content">
    <div class="container-fluid">
        <div class="panel-body">
            <a>
                <?php
                // Success message
                if (isset($_POST['success'])) {
                    $success = $_POST["success"];
                    echo "<div class='col-md-12 col-xs-12' id='product_msg'>
                          <div class='alert alert-success'>
                            <a href='#'' class='close' data-dismiss='alert' aria-label='close'>×</a>
                            <b>Success!</b>
                          </div>
                        </div>";
                }
                ?>
            </a>
        </div>
        <div class="col-md-14">
            <div class="card ">
                <div class="card-header card-header-primary">
                    <h4 class="card-title"> Users List</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive ps">
                        <table class="table table-hover tablesorter " id="">
                            <thead class=" text-primary">
                            <tr><th>ID</th><th>FirstName</th><th>LastName</th><th>Email</th><th>Password</th><th>Contact</th><th>Address</th><th>City</th>
                            </tr></thead>
                            <tbody>
                            <?php
                            $result = sqlsrv_query($con, "SELECT * FROM user_info") or die ("query 1 incorrect.....");

                            while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                                $user_id = $row['user_id'];
                                $first_name = $row['first_name'];
                                $last_name = $row['last_name'];
                                $email = $row['email'];
                                $password = $row['password'];
                                $phone = $row['mobile'];
                                $address1 = $row['address1'];
                                $address2 = $row['address2'];

                                echo "<tr><td>$user_id</td><td>$first_name</td><td>$last_name</td><td>$email</td><td>$password</td><td>$phone</td><td>$address1</td><td>$address2</td></tr>";
                            }
                            ?>
                            </tbody>
                        </table>
                        <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Other sections (Categories, Brands, Subscribers) can be similarly modified -->
    </div>
</div>

<?php
include 'footer.php';
sqlsrv_close($con); // Close the SQL Server connection
?>

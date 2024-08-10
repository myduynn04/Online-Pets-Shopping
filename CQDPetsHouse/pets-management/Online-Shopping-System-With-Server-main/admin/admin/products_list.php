<?php
session_start();
include("includes/db.php");
error_reporting(0);

if(isset($_GET['action']) && $_GET['action'] != "" && $_GET['action'] == 'delete')
{ 
    $product_id = $_GET['product_id'];

    // Lấy tên hình ảnh từ cơ sở dữ liệu
    $sql_select_image = "SELECT product_image FROM products WHERE product_id=?";
    $params_select_image = array($product_id);
    $result_select_image = sqlsrv_query($con, $sql_select_image, $params_select_image);
    
    // Kiểm tra và xử lý kết quả truy vấn
    if ($result_select_image === false) {
        die(print_r(sqlsrv_errors(), true));
    }
    
    list($picture) = sqlsrv_fetch_array($result_select_image, SQLSRV_FETCH_NUMERIC);
    $path = "../product_images/$picture";
    
    // Kiểm tra xóa hình ảnh nếu tồn tại
    if (file_exists($path) == true) {
        unlink($path);
    }
    
    // Thực hiện truy vấn xóa
    $sql = "DELETE FROM products WHERE product_id = ?";
    $params = array($product_id);
    $stmt = sqlsrv_query($con, $sql, $params) or die("query is incorrect...");

  
    }

///pagination


$page=$_GET['page'];

if($page=="" || $page=="1")
{
$page1=0;	
}
else
{
$page1=($page*10)-10;	
} 
include "sidenav.php";
include "topheader.php";
?>
      <!-- End Navbar -->
      <div class="content">
        <div class="container-fluid">
        
        
         <div class="col-md-14">
            <div class="card ">
              <div class="card-header card-header-primary">
                <h4 class="card-title"> Products List</h4>
                
              </div>
              <div class="card-body">
                <div class="table-responsive ps">
                  <table class="table tablesorter " id="page1">
                    <thead class=" text-primary">
                      <tr><th>Image</th><th>Name</th><th>Price</th><th>
	<a class=" btn btn-primary" href="add_products.php">Add New</a></th></tr></thead>
                    <tbody>
                      <?php 

                        // Thực hiện truy vấn SQL Server
                        $sql = "SELECT product_id, product_image, product_title, product_price FROM products ";
                        $result = sqlsrv_query($con, $sql);

                        // Kiểm tra và xử lý kết quả truy vấn
                        while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                            $product_id = $row['product_id'];
                            $image = $row['product_image'];
                            $product_name = $row['product_title'];
                            $price = $row['product_price'];

                            echo "<tr><td><img src='../../product_images/$image' style='width:50px; height:50px; border:groove #000'></td>
                                <td>$product_name</td>
                                <td>$price</td>
                                <td><a class='btn btn-success' href='products_list.php?product_id=$product_id&action=delete'>Delete</a></td></tr>";
                        }




                        ?>
                    </tbody>
                  </table>
                <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div></div></div>
              </div>
            </div>
            
            
           

          </div>
          
          
        </div>
      </div>
      <?php
include "footer.php";
?>
<?php
// Backup of view/login.php on 2026-02-11
// Original content preserved for possible restore.
?>

<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>


	
<!DOCTYPE html>
   <html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <!--=============== REMIXICONS ===============-->
      <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

      <!--=============== CSS ===============-->
      <link rel="stylesheet" href="assets/css/login.css?v=4">

      <title>Login smart parking</title>
   </head>
   <body>
	
	
      <div class="login">
         <?php 
if(isset($_GET['pesan'])){
    $message = "";

    if($_GET['pesan']=="user_tidak_ada"){
        $message = "Username tidak ditemukan!";
    } elseif($_GET['pesan']=="password_salah"){
        $message = "Password salah!";
    } elseif($_GET['pesan']=="gagal"){
        $message = "Username dan Password wajib diisi!";
    }

    if($message != ""){
        echo "
        <div id='loginAlert' class='alert-box'>
            <span>$message</span>
            <button type='button' onclick='closeAlert()'>OK</button>
        </div>
        ";
    }
}
?>
         
         <form action="index.php?page=cek_login" method="post">
            <h1 class="login__title">Login Smart Parking</h1>

            <div class="login__content">
               <div class="login__box">
                  <i class="ri-user-3-line login__icon"></i>

                  <div class="login__box-input">
                     <input type="text" required class="login__input" id="username" name="username" placeholder=" ">
                     <label for="username" class="login__label">Username</label>
                  </div>
               </div>

               <div class="login__box">
                  <i class="ri-lock-2-line login__icon"></i>

                  <div class="login__box-input">
                     <input type="password" required class="login__input" id="login-pass" name="password" placeholder=" ">
                     <label for="login-pass" class="login__label">Password</label>
                     <i class="ri-eye-off-line login__eye" id="login-eye"></i>
                  </div>
               </div>
            </div>

            

            <button type="submit" class="login__button">Login</button>
         </form>
      </div>
      <script src="assets/js/main.js"></script>
      <script>
function closeAlert() {
    var alertBox = document.getElementById("loginAlert");
    if(alertBox){
        alertBox.style.display = "none";
    }
}
</script>
   </body>
</html>
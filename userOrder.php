<?php
session_start();
include 'db_connection.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php'); // Redirect to login if not logged in
    exit();
}

// Fetch orders with user and product details
$query = "
    SELECT o.id AS order_id, u.username, u.address, u.contact_no, u.email, 
           p.name AS product_name, p.price AS product_price, 
           p.image_url, o.order_date, o.status, o.facebook_account
    FROM orders o 
    JOIN users u ON o.user_id = u.id 
    JOIN products p ON o.product_id = p.id
";
$result = mysqli_query($db, $query);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kween P Sports</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="shortcut icon" href="images/headlogo.png" type="image/x-icon">
    <!-- Other styles and links -->
</head>
<style>
    @import url('https://fonts.googleapis.com/css?family=Karla:400,700&display=swap');
    .font-family-karla { font-family: karla; }
    .bg-sidebar { background: orange; }
    .cta-btn { color: black; }
    .upgrade-btn { background: black; }
    .upgrade-btn:hover { background: black; }
    .active-nav-link { background: grey; }
    .nav-item:hover { background: grey; }
</style>
<body class="bg-gray-100 font-family-karla flex">

<aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">
    <div class="p-6">
        <img src="images/logo1.png" alt="">
    </div>
    <nav class="text-white text-base font-semibold pt-3">
        <a href="adminDashboard.php" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
            <i class="fas fa-tachometer-alt mr-3"></i>
            Dashboard
        </a>
        <a href="userOrder.php" class="flex items-center active-nav-link text-white py-4 pl-6 nav-item">
            <i class="fas fa-sticky-note mr-3"></i>
            User Orders
        </a>
        <a href="myProducts.php" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
            <i class="fas fa-table mr-3"></i>
            My Products
        </a>
    </nav>
</aside>

<div class="relative w-full flex flex-col h-screen overflow-hidden">
    <div class="container mx-auto px-4 flex-1">
        <h2 class="text-3xl font-bold mb-4">Order Details</h2>
        <div class="overflow-x-auto h-full">
            <div class="max-h-[calc(100vh-6rem)] overflow-y-auto">
                <table class="min-w-full border border-gray-600">
                    <thead class="bg-gray-600 sticky top-0 z-10">
                        <tr>
                            <th class="px-4 py-2 text-left border-b">Order ID</th>
                            <th class="px-4 py-2 text-left border-b">Customer</th>
                            <th class="px-4 py-2 text-left border-b">Address</th>
                            
                            <th class="px-4 py-2 text-left border-b">Contact No</th>
                            <th class="px-4 py-2 text-left border-b">Facebook Account</th>
                            <th class="px-4 py-2 text-left border-b">Email</th>
                            <th class="px-4 py-2 text-left border-b">Product Name</th>
                            <th class="px-4 py-2 text-left border-b">Product Price</th>
                            <th class="px-4 py-2 text-left border-b">Product Image</th>
                            <th class="px-4 py-2 text-left border-b">Order Date</th>
                            <th class="px-4 py-2 text-left border-b">Status</th>
                             <!-- New column -->
                            <th class="px-4 py-2 text-left border-b">Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-black">
                        <?php while ($row = mysqli_fetch_assoc($result)): ?>
                            <tr>
                                <td class="px-4 py-2 border-b"><?php echo $row['order_id']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo $row['username']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo $row['address']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo $row['contact_no']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo htmlspecialchars($row['facebook_account']); ?></td> <!-- Display Facebook account -->
                                <td class="px-4 py-2 border-b"><?php echo $row['email']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo $row['product_name']; ?></td>
                                <td class="px-4 py-2 border-b"><?php echo number_format($row['product_price'], 2); ?> PHP</td>
                                <td class="px-4 py-2 border-b"><img src="<?php echo $row['image_url']; ?>" alt="<?php echo $row['product_name']; ?>" class="w-16 h-16 object-cover"></td>
                                <td class="px-4 py-2 border-b"><?php echo date('Y-m-d H:i:s', strtotime($row['order_date'])); ?></td>
                                <td class="px-4 py-2 border-b"><?php echo $row['status']; ?></td>
                            
                                <td class="px-4 py-2 border-b">
                                    <a href="editOrder.php?id=<?php echo $row['order_id']; ?>" class="text-blue-600 hover:underline">Edit</a>
                                    <a href="deleteOrder.php?id=<?php echo $row['order_id']; ?>" class="text-red-600 hover:underline">Delete</a>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- AlpineJS -->
<script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@2.x.x/dist/alpine.min.js" defer></script>
<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" integrity="sha256-KzZiKy0DWYsnwMF+X1DvQngQ2/FxF7MF3Ff72XcpuPs=" crossorigin="anonymous"></script>

</body>
</html>

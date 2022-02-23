<?php
$servername = "143.198.177.53"; // server address + port number
$username = "testUser";
$password = "testUser123@!@!";


// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully\n";


$sql = "SELECT * FROM employees.employees LIMIT 50; ";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "Employee ID: " . $row["emp_no"]. " - Name: " . $row["first_name"]. " " . $row["last_name"]. "\n";
  }
} else {
  echo "0 results";
}
$conn->close();

?>
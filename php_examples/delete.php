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


$sql = "DELETE FROM employees.employees WHERE emp_no = 3;";

if ($conn->query($sql) === TRUE) {
  echo "Record deleted successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>
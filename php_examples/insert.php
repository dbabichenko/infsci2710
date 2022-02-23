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


$sql = "INSERT INTO employees.employees (emp_no, birth_date, first_name, last_name, gender, hire_date) ";
$sql = $sql .= "VALUES (3, '1960-1-1', 'Bob', 'Smith', 'M', CURDATE());";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>
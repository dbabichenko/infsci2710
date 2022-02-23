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
$sql = $sql .= "VALUES (?,?,?,?,?, CURDATE());";

// prepare and bind
$stmt = $conn->prepare($sql);
$stmt->bind_param("issss", $emp_no, $birth_date, $first_name, $last_name, $gender);

// set parameters and execute
$emp_no = 5;
$birth_date = '1989-01-05';
$firs_tname = "John";
$last_name = "Doe";

$stmt->execute();


echo "New record created successfully";

$stmt->close();
$conn->close();

?>
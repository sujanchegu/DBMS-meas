<?php

extract($_POST);
$conn = new mysqli("localhost", "inter", "password123", "meas");

if ($conn->connect_errno) {
    printf("Connect failed: %s\n", $conn->connect_error);
    exit();
}

// $query = "Insert into employee values (" . "'$empid'" . "'$fname'" . "'$minit'" . "'$lname'" . "'$age'" . "'$phno'" . "'$pincode'" . ");";
$query = "Insert into employee values ($empid, '$fname', '$minit', '$lname', $age, '$phno', '$pincode')";
echo nl2br($query);

if ($conn->query($query) === TRUE) {
    echo nl2br("\nQuery Executed\n");
}
else
{
    die("Crashed");
}

?>
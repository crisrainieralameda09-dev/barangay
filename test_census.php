<?php
include 'includes/conn.php';

$sql = 'SELECT COUNT(*) as count FROM census WHERE deleted_at IS NULL';
$result = $conn->query($sql);
$row = $result->fetch_assoc();
echo 'Census records: ' . $row['count'] . PHP_EOL;

$sql2 = 'SELECT c.*, COALESCE(u.first_name, c.firstname) as first_name FROM census c LEFT JOIN citizens cit ON c.citizen_id = cit.citizen_id LEFT JOIN users u ON cit.citizen_id = u.id LIMIT 5';
$result2 = $conn->query($sql2);
if ($result2 && $result2->num_rows > 0) {
    while($row2 = $result2->fetch_assoc()) {
        echo 'Record: ' . $row2['first_name'] . PHP_EOL;
    }
} else {
    echo 'No census records found' . PHP_EOL;
}
?>

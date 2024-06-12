const express = require('express');
const app = express();
const PORT = 3000;
const sql = require('mssql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');

app.use(express.json());
app.use(cors());

app.get('/', (req, res) => {
  res.send('Welcome to your Node.js server! SCHOOL MANAGEMENT SYSTEM');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

const config = {
  user: 'sa',
  password: 'affan123',
  server: 'localhost',
  database: 'School_management_system',
  options: {
    encrypt: true,
    trustServerCertificate: true,
  },
};

async function connectToDatabase() {
  try {
    const pool = await sql.connect(config);
    console.log('Connected to SQL Server');
    return pool;
  } catch (error) {
    console.error('Error connecting to SQL Server:', error);
    throw error;
  }
}

app.post('/students', async (req, res) => {
  try {
    const pool = await connectToDatabase();
    const studentData = req.body;
    const request = pool.request();
    const result = await request.query(`
      INSERT INTO Students (
        first_name,
        last_name,
        class,
        section,
        dob,
        roll_no,
        admission_no,
        email,
        father_name,
        mother_name,
        father_occupation,
        mother_occupation,
        father_cell_no,
        mother_cell_no,
        address,
        image_path,
        gender
      ) VALUES (
        '${studentData.first_name}',
        '${studentData.last_name}',
        '${studentData.class}',
        '${studentData.section}',
        '${studentData.dob}',
        '${studentData.roll_no}',
        '${studentData.admission_no}',
        '${studentData.email}',
        '${studentData.father_name}',
        '${studentData.mother_name}',
        '${studentData.father_occupation}',
        '${studentData.mother_occupation}',
        '${studentData.father_cell_no}',
        '${studentData.mother_cell_no}',
        '${studentData.address}',
        '${studentData.image_path}',
        '${studentData.gender}'
      )
    `);
    console.log('Student data saved successfully.');
    res.status(200).json({ message: 'Student data saved successfully.' });
  } catch (err) {
    console.error('Error inserting student data:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});


app.get('/students', async (req, res) => {
  try {
    const pool = await connectToDatabase(); // Establish connection pool

    const request = pool.request();
    const result = await request.query('SELECT * FROM Students');

    res.status(200).json(result.recordset);
  } catch (err) {
    console.error('Error fetching student data:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

connectToDatabase();
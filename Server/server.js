const express = require('express');
const fs = require('fs');
const path = require('path');
const multer = require('multer');
const sql = require('mssql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
const PORT = 3000;

// Ensure 'uploads' directory exists
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
    fs.mkdirSync(uploadsDir);
}

// Middleware
app.use(express.json());
app.use(cors());
app.use('/uploads', express.static(uploadsDir)); // Serve static files from the uploads folder

// Set up multer for file uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, uploadsDir); // Directory to save the uploaded files
    },
    filename: function (req, file, cb) {
        // Generate filename based on student's name
        const studentName = req.body.first_name + '_' + req.body.last_name;
        cb(null, studentName + path.extname(file.originalname)); // Save files with the student's name and the original extension
    }
});

const upload = multer({ storage: storage });

app.get('/', (req, res) => {
    res.send('Welcome to your Node.js server! SCHOOL MANAGEMENT SYSTEM');
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

let poolPromise = sql.connect(config)
    .then(pool => {
        console.log('Connected to SQL Server');
        return pool;
    })
    .catch(error => {
        console.error('Database connection failed:', error);
        throw error;
    });

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

app.post('/students', upload.single('image'), async (req, res) => {
    try {
        const pool = await poolPromise;
        const studentData = req.body;
        const imagePath = req.file ? req.file.path : null; // Get the file path if it exists

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
                '${imagePath}',
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
        const pool = await poolPromise;
        const request = pool.request();
        let query = 'SELECT * FROM Students';

        // Check if there's a search query parameter
        const searchQuery = req.query.search;
        if (searchQuery) {
            query += ` WHERE first_name LIKE '%${searchQuery}%' OR last_name LIKE '%${searchQuery}%'`;
        }

        const result = await request.query(query);
        res.status(200).json(result.recordset);
    } catch (err) {
        console.error('Error fetching student data:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.post('/teachers', upload.single('image'), async (req, res) => {
  try {
    const pool = await poolPromise;
    const teacherData = req.body;
    const imagePath = req.file ? req.file.path : null; // Get the file path if it exists

    // Convert comma-separated strings back to lists
    const classes = teacherData.classes.split(',');
    const subjects = teacherData.subjects.split(',');

    const request = pool.request();
    request.input('first_name', sql.NVarChar, teacherData.first_name);
    request.input('last_name', sql.NVarChar, teacherData.last_name);
    request.input('dob', sql.NVarChar, teacherData.dob); // Store dob as text
    request.input('ID_no', sql.NVarChar, teacherData.ID_no);
    request.input('email', sql.NVarChar, teacherData.email);
    request.input('Cell_no', sql.NVarChar, teacherData.Cell_no);
    request.input('address', sql.NVarChar, teacherData.address);
    request.input('gender', sql.NVarChar, teacherData.gender);
    request.input('classes', sql.NVarChar, classes.join(',')); // Store as comma-separated string in DB
    request.input('subjects', sql.NVarChar, subjects.join(',')); // Store as comma-separated string in DB
    request.input('image_path', sql.NVarChar, imagePath);

    const result = await request.query(`
      INSERT INTO Teachers (
        first_name,
        last_name,
        dob,
        ID_no,
        email,
        Cell_no,
        address,
        gender,
        classes,
        subjects,
        image_path
      ) VALUES (
        @first_name,
        @last_name,
        @dob,
        @ID_no,
        @email,
        @Cell_no,
        @address,
        @gender,
        @classes,
        @subjects,
        @image_path
      )
    `);
    console.log('Teacher data saved successfully.');
    res.status(200).json({ message: 'Teacher data saved successfully.' });
  } catch (err) {
    console.error('Error inserting teacher data:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/teachers', async (req, res) => {
    try {
        const pool = await poolPromise;
        const request = pool.request();
        let query = 'SELECT * FROM Teachers';

        // Check if there's a search query parameter
        const searchQuery = req.query.search;
        if (searchQuery) {
            query += ` WHERE first_name LIKE '%${searchQuery}%' OR last_name LIKE '%${searchQuery}%'`;
        }

        const result = await request.query(query);
        res.status(200).json(result.recordset);
    } catch (err) {
        console.error('Error fetching teacher data:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
});

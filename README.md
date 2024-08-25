# OfficeStore/Assignment PRJ301

## Overview
**OfficeStore** is a Java-based application designed to manage office supplies inventory. This project is developed using **NetBeans 8.2** and **JDK 8** with **Microsoft SQL Server 2022** as the database management system.

## Prerequisites
- **NetBeans 8.2**: The project is developed and tested using NetBeans 8.2.
- **JDK 8**: Ensure that JDK 8 is installed and configured.
- **Microsoft SQL Server 2022**: The application connects to SQL Server 2022 for data storage and management.
- **SQL Server Management Studio (SSMS)**: To manage and execute SQL scripts.

## Getting Started

### Database Setup
1. **Install Microsoft SQL Server 2022** if you haven’t already.
2. **Open `OfficeStore.sql`** file located in the project directory.
3. Execute the SQL script in SQL Server Management Studio (SSMS) to set up the database and required tables.

### Project Setup
1. **Clone the repository**:
    ```sh
    git clone https://github.com/yourusername/OfficeStore.git
    ```
2. **Open NetBeans 8.2**.
3. **Import the project**:
   - Go to `File` -> `Open Project`.
   - Navigate to the cloned repository and select the `OfficeStore` project.
4. **Configure Database Connection**:
   - In the `src` folder, find the `DBConnection.java` file.
   - Update the `DB_URL`, `DB_USER`, and `DB_PASSWORD` constants with your SQL Server credentials.

### Running the Application
1. **Build and Run** the project in NetBeans.
2. The application should now be connected to the SQL Server database and ready for use.

## Features
- **Inventory Management**: Add, update, and remove office supplies from the inventory.
- **Order Processing**: Handle customer orders and manage stock levels accordingly.
- **Reporting**: Generate reports on inventory status, sales, and orders.

## Technologies Used
- **Java (JDK 8)**: Core programming language.
- **NetBeans 8.2**: Integrated Development Environment (IDE) used for development.
- **Microsoft SQL Server 2022**: Database management system.
- **JDBC**: For database connectivity.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact
**Truong Nguyen Ngoc Thach**  
Email: your-email@example.com  
GitHub: [NgocThachTN](https://github.com/NgocThachTN)

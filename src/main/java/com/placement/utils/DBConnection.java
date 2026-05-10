package com.placement.utils;

import java.net.URI;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import io.github.cdimascio.dotenv.Dotenv;

/**
 * DBConnection — Dual-Database Connection Manager
 *
 * Mode selection is driven entirely by the .env file:
 *
 *   OFFLINE (local PostgreSQL)
 *     Set DATABASE_URL=postgresql://user:password@host:port/dbname
 *     → The URL is parsed and used directly; DB_URL / DB_USER / DB_PASSWORD are ignored.
 *
 *   ONLINE (Neon cloud PostgreSQL)
 *     Leave DATABASE_URL absent (or remove/comment it out from .env).
 *     → DB_URL, DB_USER, DB_PASSWORD are used instead.
 */
public class DBConnection {

    private static final String JDBC_URL;
    private static final String DB_USER;
    private static final String DB_PASSWORD;
    private static final String MODE; // "OFFLINE" or "ONLINE"

    static {
        // Load environment variables (ignores missing .env gracefully)
        Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();

        // Load the PostgreSQL JDBC driver once
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "PostgreSQL JDBC Driver not found. Ensure it is in your classpath.", e);
        }

        // ── Detect which database to use ──────────────────────────────────────
        String rawDatabaseUrl = dotenv.get("DATABASE_URL", "").trim();

        if (!rawDatabaseUrl.isEmpty()) {
            // ── OFFLINE MODE: parse postgresql://user:password@host:port/db ──
            MODE = "OFFLINE";
            try {
                // Normalize: replace "postgresql://" → "http://" so URI can parse it
                URI uri = new URI(rawDatabaseUrl.replace("postgresql://", "http://"));

                String host = uri.getHost();
                int    port = (uri.getPort() == -1) ? 5432 : uri.getPort();
                String path = uri.getPath(); // e.g. "/placementjava"

                // Decode percent-encoded characters in userInfo (e.g. %40 → @)
                String userInfo = uri.getRawUserInfo(); // keep raw to decode manually
                String user;
                String password;
                if (userInfo != null && userInfo.contains(":")) {
                    String[] parts = userInfo.split(":", 2);
                    user     = URLDecoder.decode(parts[0], StandardCharsets.UTF_8.name());
                    password = URLDecoder.decode(parts[1], StandardCharsets.UTF_8.name());
                } else {
                    user     = (userInfo != null)
                            ? URLDecoder.decode(userInfo, StandardCharsets.UTF_8.name()) : "";
                    password = "";
                }

                JDBC_URL    = "jdbc:postgresql://" + host + ":" + port + path;
                DB_USER     = user;
                DB_PASSWORD = password;

            } catch (Exception e) {
                throw new RuntimeException(
                        "Failed to parse DATABASE_URL from .env: " + rawDatabaseUrl, e);
            }

        } else {
            // ── ONLINE MODE: use Neon credentials from .env ───────────────────
            MODE = "ONLINE";
            String url = dotenv.get("DB_URL",      "");
            String usr = dotenv.get("DB_USER",     "");
            String pwd = dotenv.get("DB_PASSWORD", "");

            if (url.isEmpty()) {
                throw new RuntimeException(
                        "No database configured. Set DATABASE_URL (offline) or DB_URL (online) in .env");
            }

            JDBC_URL    = url;
            DB_USER     = usr;
            DB_PASSWORD = pwd;
        }

        System.out.println("[DBConnection] Mode: " + MODE
                + " | URL: " + JDBC_URL
                + " | User: " + DB_USER);

        // Auto-initialize schema on startup
        initializeSchema();
    }

    private static boolean schemaInitialized = false;

    private synchronized static void initializeSchema() {
        if (schemaInitialized) return;
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            System.out.println("[DBConnection] Verifying/Updating database schema...");
            java.sql.Statement stmt = conn.createStatement();
            
            String[] queries = {
                "ALTER TABLE students ADD COLUMN IF NOT EXISTS roll_number VARCHAR(50)",
                "ALTER TABLE students ADD COLUMN IF NOT EXISTS semester INT DEFAULT 1",
                "ALTER TABLE students ADD COLUMN IF NOT EXISTS profile_photo_url TEXT",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS website VARCHAR(255)",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS logo_url TEXT",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS industry_type VARCHAR(100)",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS location VARCHAR(255)",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS contact_email VARCHAR(255)",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS contact_phone VARCHAR(50)",
                "ALTER TABLE companies ADD COLUMN IF NOT EXISTS hr_name VARCHAR(100)",
                "ALTER TABLE drives ADD COLUMN IF NOT EXISTS job_description TEXT",
                "ALTER TABLE drives ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP",
                "ALTER TABLE interviews ADD COLUMN IF NOT EXISTS result VARCHAR(50)",
                "ALTER TABLE interviews ADD COLUMN IF NOT EXISTS feedback TEXT",
                "ALTER TABLE interviews ADD COLUMN IF NOT EXISTS meeting_link TEXT",
                "ALTER TABLE applications ADD COLUMN IF NOT EXISTS current_round VARCHAR(100) DEFAULT 'Initial'"
            };
            
            for (String query : queries) {
                try {
                    System.out.println("[DBConnection] Executing: " + query);
                    stmt.execute(query);
                } catch (SQLException e) {
                    // Ignore errors for individual column additions if they already exist 
                    // (PostgreSQL 9.6+ supports IF NOT EXISTS for ADD COLUMN)
                    System.out.println("[DBConnection] Note: " + e.getMessage());
                }
            }
            
            schemaInitialized = true;
            System.out.println("[DBConnection] Schema initialization completed.");
        } catch (SQLException e) {
            System.err.println("[DBConnection] CRITICAL: Schema initialization failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Returns a new JDBC connection based on the active database mode
     * (OFFLINE local or ONLINE Neon), as determined by the .env file.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Returns "OFFLINE" when using the local database,
     * or "ONLINE" when using the Neon cloud database.
     */
    public static String getMode() {
        return MODE;
    }
}

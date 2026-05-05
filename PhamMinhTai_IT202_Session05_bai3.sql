-- RESET
DROP DATABASE IF EXISTS DeliverySystem;
CREATE DATABASE DeliverySystem;
USE DeliverySystem;

-- =========================
-- TABLE
-- =========================
CREATE TABLE Drivers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    driver_name VARCHAR(255),
    status VARCHAR(50),           -- AVAILABLE / BUSY / BLOCKED
    trust_score INT,
    distance_km FLOAT
);

-- =========================
-- DATA
-- =========================
INSERT INTO Drivers (driver_name, status, trust_score, distance_km) VALUES
('Driver A', 'AVAILABLE', 90, 1.5),
('Driver B', 'AVAILABLE', 85, 1.5),
('Driver C', 'AVAILABLE', 70, 1.0),   --  trust thấp
('Driver D', 'BUSY', 95, 0.5),        --  không available
('Driver E', 'AVAILABLE', 88, 2.0),
('Driver F', 'BLOCKED', 99, 0.3);     --  bị khóa

-- =========================
-- PHÂN TÍCH I/O & LUỒNG BACKEND
-- =========================
-- Input:
-- - min_trust_score (từ config, ví dụ: 80)

-- Xử lý ở backend (pseudo):
-- if (min_trust_score < 0) {
--     min_trust_score = 0;  -- chặn bẫy số âm
-- }
-- if (min_trust_score > 100) {
--     min_trust_score = 100; -- optional chặn vượt max
-- }

-- Sau đó mới truyền vào SQL

-- =========================
-- QUERY CHÍNH
-- =========================
-- Lọc:
-- - status = AVAILABLE
-- - trust_score >= min_trust_score
-- Sắp xếp:
-- 1. distance tăng dần (gần nhất)
-- 2. nếu bằng nhau -> trust_score giảm dần

-- giả sử min_trust_score = 80

SELECT driver_name, status, trust_score, distance_km
FROM Drivers
WHERE status = 'AVAILABLE'
  AND trust_score >= 80
ORDER BY distance_km ASC, trust_score DESC;
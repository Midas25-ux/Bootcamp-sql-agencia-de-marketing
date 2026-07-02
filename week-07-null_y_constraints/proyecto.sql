-- ============================================
-- PROYECTO SEMANAL: NULL y Constraints
-- Semana 07 — NOT NULL, UNIQUE, CHECK, FK
-- Dominio: Agencia de Marketing Digital
-- ============================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS services;

-- ============================================
-- PARTE 1: ESQUEMA CON CONSTRAINTS
-- ============================================

CREATE TABLE services (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);

CREATE TABLE campaigns (
    id           INTEGER PRIMARY KEY,
    name         TEXT    NOT NULL,
    code         TEXT    NOT NULL UNIQUE,   -- código único de campaña
    budget       REAL    NOT NULL CHECK (budget > 0),
    start_date   TEXT    NOT NULL,
    end_date     TEXT,                       -- NULL si la campaña sigue activa
    is_active    INTEGER NOT NULL DEFAULT 1,
    service_id   INTEGER NOT NULL
        REFERENCES services (id) ON DELETE RESTRICT
);

-- ============================================
-- PARTE 2: DATOS DE PRUEBA
-- ============================================

INSERT INTO services (id, name) VALUES
    (1, 'Gestion de Google Ads'),
    (2, 'Gestion de Meta Ads'),
    (3, 'Posicionamiento SEO');

-- 30 campañas, al menos 3 con end_date en NULL (campaña sin cerrar)
INSERT INTO campaigns (id, name, code, service_id, budget, start_date, end_date) VALUES
    (1, 'Generacion de Leads - Cliente 005', 'CMP-2026-0001', 2, 3407.73, '2025-08-11', '2025-09-04'),
    (2, 'Temporada Navidad - Cliente 003', 'CMP-2026-0002', 3, 3101.32, '2022-07-26', NULL),
    (3, 'Temporada Verano - Cliente 009', 'CMP-2026-0003', 1, 9802.23, '2022-10-19', '2022-11-29'),
    (4, 'Prelanzamiento - Cliente 004', 'CMP-2026-0004', 2, 3133.23, '2024-02-08', '2024-03-25'),
    (5, 'Dia de la Madre - Cliente 004', 'CMP-2026-0005', 3, 11633.23, '2024-08-12', NULL),
    (6, 'Reapertura - Cliente 001', 'CMP-2026-0006', 1, 8738.87, '2022-03-28', '2022-07-19'),
    (7, 'San Valentin - Cliente 007', 'CMP-2026-0007', 2, 10121.68, '2023-06-23', '2023-09-30'),
    (8, 'Fidelizacion Clientes - Cliente 010', 'CMP-2026-0008', 3, 584.47, '2024-09-05', '2024-10-17'),
    (9, 'Expansion Regional - Cliente 002', 'CMP-2026-0009', 1, 838.71, '2025-01-14', '2025-02-24'),
    (10, 'Dia de la Madre - Cliente 002', 'CMP-2026-0010', 2, 8118.62, '2025-03-22', '2025-06-02'),
    (11, 'Remarketing - Cliente 004', 'CMP-2026-0011', 3, 8764.90, '2025-06-03', '2025-08-17'),
    (12, 'Expansion Regional - Cliente 009', 'CMP-2026-0012', 1, 2258.97, '2024-05-25', NULL),
    (13, 'Dia de la Madre - Cliente 009', 'CMP-2026-0013', 2, 8768.41, '2022-02-22', '2022-04-14'),
    (14, 'Promocion 2x1 - Cliente 002', 'CMP-2026-0014', 3, 2997.14, '2023-07-07', '2023-12-13'),
    (15, 'Expansion Regional - Cliente 007', 'CMP-2026-0015', 1, 3905.25, '2024-03-19', '2024-07-04'),
    (16, 'Regreso a Clases - Cliente 007', 'CMP-2026-0016', 2, 11386.93, '2022-07-20', NULL),
    (17, 'Fidelizacion Clientes - Cliente 002', 'CMP-2026-0017', 3, 7293.88, '2023-12-06', NULL),
    (18, 'Prelanzamiento - Cliente 006', 'CMP-2026-0018', 1, 9244.77, '2023-04-06', '2023-08-12'),
    (19, 'Prelanzamiento - Cliente 010', 'CMP-2026-0019', 2, 6258.69, '2022-09-22', '2023-01-24'),
    (20, 'Aniversario - Cliente 001', 'CMP-2026-0020', 3, 7356.56, '2022-10-02', '2022-11-24'),
    (21, 'Prelanzamiento - Cliente 009', 'CMP-2026-0021', 1, 7119.09, '2023-09-10', NULL),
    (22, 'Expansion Regional - Cliente 004', 'CMP-2026-0022', 2, 9745.84, '2023-07-16', NULL),
    (23, 'Temporada Navidad - Cliente 005', 'CMP-2026-0023', 3, 6890.34, '2025-04-13', '2025-05-02'),
    (24, 'Temporada Navidad - Cliente 002', 'CMP-2026-0024', 1, 6581.30, '2025-08-18', '2025-11-30'),
    (25, 'Descuento Fin de Mes - Cliente 004', 'CMP-2026-0025', 2, 6547.89, '2023-07-13', '2023-07-27'),
    (26, 'Remarketing - Cliente 001', 'CMP-2026-0026', 3, 10724.57, '2022-12-17', '2023-04-22'),
    (27, 'San Valentin - Cliente 004', 'CMP-2026-0027', 1, 2763.32, '2022-05-24', NULL),
    (28, 'Remarketing - Cliente 006', 'CMP-2026-0028', 2, 7200.97, '2024-02-23', '2024-07-26'),
    (29, 'Dia de la Madre - Cliente 004', 'CMP-2026-0029', 3, 5682.17, '2023-11-16', NULL),
    (30, 'Awareness de Marca - Cliente 001', 'CMP-2026-0030', 1, 1693.29, '2023-07-09', '2023-12-16');

-- ============================================
-- PARTE 3: CONSULTAS CON NULL
-- ============================================

-- Campañas que todavía no tienen fecha de cierre (siguen activas)
SELECT id, name
FROM   campaigns
WHERE  end_date IS NULL;

-- Todas las campañas, usando COALESCE para reemplazar el NULL
SELECT
    name,
    COALESCE(end_date, 'En curso') AS fecha_cierre
FROM campaigns;

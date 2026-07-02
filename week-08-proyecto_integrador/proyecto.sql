-- ============================================
-- PROYECTO INTEGRADOR: Etapa 0 — Capstone
-- Semana 08 — DDL + DML + SELECT completo
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- Cadena de relaciones: services -> campaigns -> invoices

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS services;

-- ============================================
-- PARTE 1: ESQUEMA (DDL)
-- ============================================

-- Tabla de referencia: catálogo de servicios de la agencia
CREATE TABLE services (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);

-- Tabla secundaria: campañas, cada una ligada a un servicio
CREATE TABLE campaigns (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    budget      REAL    NOT NULL CHECK (budget > 0),
    status      TEXT    NOT NULL DEFAULT 'planning'
        CHECK (status IN ('planning', 'active', 'paused', 'completed')),
    service_id  INTEGER NOT NULL
        REFERENCES services (id) ON DELETE RESTRICT
);

-- Tabla principal: facturas emitidas por cada campaña
CREATE TABLE invoices (
    id               INTEGER PRIMARY KEY,
    invoice_number   TEXT    UNIQUE,        -- código único de factura
    paid_at          TEXT,                  -- NULL si aún no se ha pagado
    amount           REAL    NOT NULL CHECK (amount > 0),
    is_paid          INTEGER NOT NULL DEFAULT 0,
    issue_date       TEXT    NOT NULL,
    campaign_id      INTEGER NOT NULL
        REFERENCES campaigns (id) ON DELETE RESTRICT
);

-- ============================================
-- PARTE 2: DATOS (DML)
-- ============================================

INSERT INTO services (id, name) VALUES
    (1, 'Gestion de Google Ads'),
    (2, 'Gestion de Meta Ads'),
    (3, 'Gestion de TikTok Ads'),
    (4, 'Gestion de LinkedIn Ads'),
    (5, 'Email Marketing'),
    (6, 'Posicionamiento SEO');

INSERT INTO campaigns (id, name, service_id, budget, status) VALUES
    (1, 'Reapertura - Cliente 005', 2, 5565.73, 'active'),
    (2, 'Regreso a Clases - Cliente 007', 3, 7893.66, 'completed'),
    (3, 'Cyber Monday - Cliente 001', 4, 3607.44, 'completed'),
    (4, 'Reapertura - Cliente 008', 5, 10641.57, 'active'),
    (5, 'Cyber Monday - Cliente 001', 6, 9097.85, 'completed'),
    (6, 'Dia de la Madre - Cliente 003', 1, 10504.72, 'active'),
    (7, 'Nueva Coleccion - Cliente 007', 2, 6690.00, 'completed'),
    (8, 'Descuento Fin de Mes - Cliente 002', 3, 7222.70, 'planning'),
    (9, 'Dia de la Madre - Cliente 005', 4, 3333.41, 'completed'),
    (10, 'Cyber Monday - Cliente 008', 5, 1152.60, 'active'),
    (11, 'Awareness de Marca - Cliente 011', 6, 11772.49, 'planning'),
    (12, 'Expansion Regional - Cliente 001', 1, 3078.25, 'completed');

-- 30 facturas, al menos 2 con paid_at en NULL (aún no pagadas)
INSERT INTO invoices (id, invoice_number, campaign_id, amount, issue_date, paid_at, is_paid) VALUES
    (1, 'INV-2026-0001', 6, 2132.15, '2024-05-05', '2024-05-12', 1),
    (2, 'INV-2026-0002', 5, 529.63, '2024-10-07', '2024-10-30', 1),
    (3, 'INV-2026-0003', 9, 1589.54, '2025-03-12', '2025-03-14', 1),
    (4, 'INV-2026-0004', 6, 2504.59, '2025-11-19', NULL, 0),
    (5, 'INV-2026-0005', 3, 1420.91, '2025-08-04', '2025-08-26', 1),
    (6, 'INV-2026-0006', 1, 1148.96, '2024-03-08', '2024-03-25', 1),
    (7, 'INV-2026-0007', 6, 1332.03, '2024-05-12', NULL, 0),
    (8, 'INV-2026-0008', 1, 463.44, '2024-02-10', NULL, 0),
    (9, 'INV-2026-0009', 8, 2076.84, '2025-05-04', NULL, 0),
    (10, 'INV-2026-0010', 10, 1020.84, '2025-08-18', '2025-08-22', 1),
    (11, 'INV-2026-0011', 11, 3053.91, '2025-12-24', '2025-12-26', 1),
    (12, 'INV-2026-0012', 4, 1040.79, '2025-12-27', '2026-01-13', 1),
    (13, 'INV-2026-0013', 5, 3816.98, '2025-03-02', '2025-03-17', 1),
    (14, 'INV-2026-0014', 4, 688.01, '2024-04-21', '2024-05-06', 1),
    (15, 'INV-2026-0015', 7, 3487.91, '2025-07-18', '2025-08-07', 1),
    (16, 'INV-2026-0016', 8, 2291.66, '2025-01-28', '2025-02-12', 1),
    (17, 'INV-2026-0017', 5, 2650.92, '2025-11-01', NULL, 0),
    (18, 'INV-2026-0018', 7, 444.62, '2024-06-20', '2024-06-25', 1),
    (19, 'INV-2026-0019', 8, 2778.14, '2025-10-16', NULL, 0),
    (20, 'INV-2026-0020', 7, 589.58, '2025-05-28', '2025-06-14', 1),
    (21, 'INV-2026-0021', 5, 2931.81, '2024-05-13', '2024-06-04', 1),
    (22, 'INV-2026-0022', 5, 1582.44, '2024-10-15', '2024-10-18', 1),
    (23, 'INV-2026-0023', 12, 3584.66, '2025-03-16', '2025-04-07', 1),
    (24, 'INV-2026-0024', 10, 3244.81, '2025-07-06', '2025-07-22', 1),
    (25, 'INV-2026-0025', 8, 682.57, '2024-01-19', NULL, 0),
    (26, 'INV-2026-0026', 12, 1917.10, '2024-11-06', NULL, 0),
    (27, 'INV-2026-0027', 8, 3050.39, '2025-03-01', '2025-03-24', 1),
    (28, 'INV-2026-0028', 3, 691.48, '2024-11-25', '2024-12-11', 1),
    (29, 'INV-2026-0029', 9, 218.35, '2024-06-28', '2024-07-19', 1),
    (30, 'INV-2026-0030', 5, 3516.40, '2025-09-11', '2025-09-12', 1);

-- ============================================
-- PARTE 3: REPORTES (SELECT)
-- ============================================

-- REPORTE 1: Totales globales
SELECT
    COUNT(*)      AS total_facturas,
    SUM(amount)   AS monto_total,
    AVG(amount)   AS monto_promedio
FROM invoices;

-- REPORTE 2: Totales por campaña (GROUP BY)
SELECT
    campaign_id,
    COUNT(*)        AS total_facturas,
    AVG(amount)     AS monto_promedio
FROM   invoices
GROUP BY campaign_id
ORDER BY total_facturas DESC;

-- REPORTE 3: Campañas con más de 2 facturas (HAVING)
SELECT
    campaign_id,
    COUNT(*) AS total_facturas
FROM   invoices
GROUP BY campaign_id
HAVING COUNT(*) > 2;

-- REPORTE 4: Facturas sin pagar (NULL + COALESCE)
SELECT
    invoice_number,
    COALESCE(paid_at, 'Pendiente de pago') AS estado_pago
FROM   invoices
WHERE  paid_at IS NULL;

-- REPORTE 5: Búsqueda combinada (rango + estado)
SELECT
    invoice_number,
    amount
FROM   invoices
WHERE  amount BETWEEN 1000 AND 3500
  AND  is_paid = 1
ORDER BY amount DESC
LIMIT 5;

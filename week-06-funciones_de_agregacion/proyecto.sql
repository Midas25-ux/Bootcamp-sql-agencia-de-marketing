-- ============================================
-- PROYECTO SEMANAL: Funciones de Agregación
-- Semana 06 — COUNT, SUM, AVG, GROUP BY, HAVING
-- Dominio: Agencia de Marketing Digital
-- ============================================

DROP TABLE IF EXISTS campaigns;

CREATE TABLE campaigns (
    id      INTEGER PRIMARY KEY,
    name    TEXT    NOT NULL,
    channel TEXT    NOT NULL,
    budget  REAL    NOT NULL CHECK (budget > 0),
    status  TEXT    NOT NULL DEFAULT 'planning'
);

INSERT INTO campaigns (id, name, channel, budget, status) VALUES
    (1, 'Nueva Coleccion - Cliente 005', 'meta_ads', 10722.52, 'active'),
    (2, 'Expansion Regional - Cliente 002', 'seo', 4361.99, 'active'),
    (3, 'Remarketing - Cliente 010', 'email_marketing', 5317.75, 'completed'),
    (4, 'Regreso a Clases - Cliente 001', 'google_ads', 3414.31, 'completed'),
    (5, 'Awareness de Marca - Cliente 010', 'meta_ads', 3455.06, 'active'),
    (6, 'Ultimas Unidades - Cliente 002', 'email_marketing', 7617.93, 'completed'),
    (7, 'Temporada Verano - Cliente 008', 'meta_ads', 6344.12, 'active'),
    (8, 'Descuento Fin de Mes - Cliente 001', 'email_marketing', 8266.85, 'completed'),
    (9, 'Aniversario - Cliente 003', 'tiktok_ads', 1445.66, 'active'),
    (10, 'Fidelizacion Clientes - Cliente 001', 'seo', 1221.27, 'active'),
    (11, 'Prelanzamiento - Cliente 007', 'linkedin_ads', 4872.10, 'planning'),
    (12, 'Lanzamiento - Cliente 002', 'meta_ads', 7781.20, 'active'),
    (13, 'Fidelizacion Clientes - Cliente 008', 'google_ads', 2171.59, 'planning'),
    (14, 'Temporada Verano - Cliente 001', 'seo', 643.77, 'planning'),
    (15, 'Prelanzamiento - Cliente 005', 'tiktok_ads', 611.00, 'active'),
    (16, 'Aniversario - Cliente 001', 'meta_ads', 3613.12, 'active'),
    (17, 'Nueva Coleccion - Cliente 005', 'google_ads', 1633.05, 'completed'),
    (18, 'Expansion Regional - Cliente 002', 'google_ads', 1098.91, 'completed'),
    (19, 'Awareness de Marca - Cliente 005', 'linkedin_ads', 7458.30, 'active'),
    (20, 'Aniversario - Cliente 001', 'seo', 6128.36, 'completed'),
    (21, 'Lanzamiento - Cliente 005', 'meta_ads', 1474.41, 'active'),
    (22, 'Expansion Regional - Cliente 001', 'meta_ads', 6087.00, 'active'),
    (23, 'Lanzamiento - Cliente 004', 'google_ads', 6059.49, 'completed'),
    (24, 'Reapertura - Cliente 004', 'email_marketing', 4465.33, 'active'),
    (25, 'Promocion 2x1 - Cliente 002', 'google_ads', 6131.05, 'paused'),
    (26, 'Reapertura - Cliente 002', 'email_marketing', 4514.30, 'paused'),
    (27, 'Regreso a Clases - Cliente 002', 'meta_ads', 5695.34, 'active'),
    (28, 'Reapertura - Cliente 002', 'seo', 3141.71, 'active'),
    (29, 'Generacion de Leads - Cliente 009', 'tiktok_ads', 4824.75, 'active'),
    (30, 'Fidelizacion Clientes - Cliente 004', 'meta_ads', 3499.85, 'active');

-- ============================================
-- REPORTE 1: Totales globales
-- ============================================

SELECT
    COUNT(*)      AS total_campanas,
    SUM(budget)   AS presupuesto_total,
    AVG(budget)   AS presupuesto_promedio
FROM campaigns;

-- ============================================
-- REPORTE 2: Extremos
-- ============================================

SELECT
    MIN(budget) AS presupuesto_minimo,
    MAX(budget) AS presupuesto_maximo
FROM campaigns;

-- ============================================
-- REPORTE 3: Subtotales por canal (GROUP BY)
-- ============================================

SELECT
    channel       AS canal,
    COUNT(*)      AS total_campanas,
    AVG(budget)   AS presupuesto_promedio
FROM   campaigns
GROUP BY channel
ORDER BY total_campanas DESC;

-- ============================================
-- REPORTE 4: Filtro de grupos (HAVING)
-- ============================================

-- Solo canales con más de 4 campañas activas o históricas
SELECT
    channel  AS canal,
    COUNT(*) AS total_campanas
FROM   campaigns
GROUP BY channel
HAVING COUNT(*) > 4;

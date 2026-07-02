-- ============================================
-- PROYECTO SEMANAL: CTEs y CASE WHEN en tu dominio
-- Semana 12 — Common Table Expressions + Condicionales
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- items        -> campaigns             (price = presupuesto, category = canal)
-- transactions -> campaign_conversions  (conversiones registradas por día)

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS campaign_conversions;
DROP TABLE IF EXISTS campaigns;

CREATE TABLE campaigns (
    id       INTEGER PRIMARY KEY,
    name     TEXT    NOT NULL,
    price    REAL    NOT NULL CHECK (price > 0),  -- presupuesto
    category TEXT    NOT NULL                      -- canal
);

CREATE TABLE campaign_conversions (
    id       INTEGER PRIMARY KEY,
    item_id  INTEGER NOT NULL REFERENCES campaigns (id),
    quantity INTEGER NOT NULL DEFAULT 1,  -- conversiones ese día
    tx_date  TEXT    NOT NULL             -- formato YYYY-MM-DD
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

-- 80 campañas en 6 canales distintos
INSERT INTO campaigns (id, name, price, category) VALUES
    (1, 'Fidelizacion Clientes - Cliente 016', 11449.16, 'google_ads'),
    (2, 'Prelanzamiento - Cliente 030', 9576.37, 'google_ads'),
    (3, 'Aniversario - Cliente 017', 4683.08, 'tiktok_ads'),
    (4, 'Temporada Navidad - Cliente 007', 4006.47, 'tiktok_ads'),
    (5, 'Temporada Verano - Cliente 019', 2845.23, 'google_ads'),
    (6, 'Fidelizacion Clientes - Cliente 033', 5270.24, 'linkedin_ads'),
    (7, 'Dia de la Madre - Cliente 002', 10445.16, 'google_ads'),
    (8, 'Promocion 2x1 - Cliente 025', 10797.58, 'meta_ads'),
    (9, 'Ultimas Unidades - Cliente 028', 10124.17, 'email_marketing'),
    (10, 'San Valentin - Cliente 006', 4896.05, 'google_ads'),
    (11, 'Generacion de Leads - Cliente 039', 4783.59, 'google_ads'),
    (12, 'Prelanzamiento - Cliente 021', 3322.62, 'meta_ads'),
    (13, 'Regreso a Clases - Cliente 018', 8080.86, 'google_ads'),
    (14, 'Awareness de Marca - Cliente 033', 6235.30, 'email_marketing'),
    (15, 'Black Friday - Cliente 021', 6641.04, 'meta_ads'),
    (16, 'Aniversario - Cliente 022', 6468.34, 'meta_ads'),
    (17, 'Generacion de Leads - Cliente 010', 7382.30, 'meta_ads'),
    (18, 'Cyber Monday - Cliente 001', 3068.62, 'tiktok_ads'),
    (19, 'Reapertura - Cliente 016', 7842.50, 'google_ads'),
    (20, 'Black Friday - Cliente 039', 5740.44, 'google_ads'),
    (21, 'Cyber Monday - Cliente 030', 7241.09, 'google_ads'),
    (22, 'Dia de la Madre - Cliente 010', 4143.88, 'meta_ads'),
    (23, 'Nueva Coleccion - Cliente 014', 6481.90, 'linkedin_ads'),
    (24, 'Prelanzamiento - Cliente 040', 1995.93, 'tiktok_ads'),
    (25, 'Temporada Navidad - Cliente 026', 5185.80, 'tiktok_ads'),
    (26, 'Temporada Navidad - Cliente 031', 5536.47, 'google_ads'),
    (27, 'Generacion de Leads - Cliente 001', 4935.98, 'meta_ads'),
    (28, 'Remarketing - Cliente 002', 6181.48, 'tiktok_ads'),
    (29, 'Cyber Monday - Cliente 025', 5746.62, 'tiktok_ads'),
    (30, 'Temporada Verano - Cliente 033', 6841.89, 'google_ads'),
    (31, 'Reapertura - Cliente 011', 11660.35, 'linkedin_ads'),
    (32, 'Temporada Navidad - Cliente 016', 6557.63, 'google_ads'),
    (33, 'Expansion Regional - Cliente 001', 9885.59, 'linkedin_ads'),
    (34, 'Aniversario - Cliente 008', 4486.97, 'linkedin_ads'),
    (35, 'San Valentin - Cliente 006', 3576.19, 'google_ads'),
    (36, 'San Valentin - Cliente 017', 6091.41, 'linkedin_ads'),
    (37, 'Awareness de Marca - Cliente 019', 3827.22, 'tiktok_ads'),
    (38, 'Prelanzamiento - Cliente 022', 1632.48, 'google_ads'),
    (39, 'Remarketing - Cliente 038', 9968.83, 'meta_ads'),
    (40, 'Temporada Navidad - Cliente 035', 3554.93, 'seo'),
    (41, 'Generacion de Leads - Cliente 007', 9603.99, 'meta_ads'),
    (42, 'Temporada Verano - Cliente 018', 7446.50, 'meta_ads'),
    (43, 'Expansion Regional - Cliente 001', 9355.55, 'linkedin_ads'),
    (44, 'Dia de la Madre - Cliente 033', 396.70, 'tiktok_ads'),
    (45, 'Temporada Verano - Cliente 016', 728.21, 'email_marketing'),
    (46, 'Cyber Monday - Cliente 028', 9190.52, 'meta_ads'),
    (47, 'Regreso a Clases - Cliente 026', 6654.43, 'meta_ads'),
    (48, 'Promocion 2x1 - Cliente 006', 11843.07, 'meta_ads'),
    (49, 'Black Friday - Cliente 005', 947.81, 'tiktok_ads'),
    (50, 'Generacion de Leads - Cliente 003', 8417.32, 'google_ads'),
    (51, 'Dia de la Madre - Cliente 027', 810.05, 'meta_ads'),
    (52, 'Temporada Verano - Cliente 038', 6202.40, 'google_ads'),
    (53, 'San Valentin - Cliente 007', 9071.02, 'tiktok_ads'),
    (54, 'Lanzamiento - Cliente 014', 11899.90, 'meta_ads'),
    (55, 'Expansion Regional - Cliente 040', 5709.08, 'google_ads'),
    (56, 'Descuento Fin de Mes - Cliente 001', 11922.54, 'meta_ads'),
    (57, 'Black Friday - Cliente 009', 11247.82, 'google_ads'),
    (58, 'San Valentin - Cliente 018', 8420.11, 'meta_ads'),
    (59, 'Descuento Fin de Mes - Cliente 015', 6212.61, 'meta_ads'),
    (60, 'Temporada Navidad - Cliente 031', 6821.53, 'google_ads'),
    (61, 'Dia de la Madre - Cliente 007', 574.29, 'meta_ads'),
    (62, 'Fidelizacion Clientes - Cliente 004', 2239.36, 'google_ads'),
    (63, 'San Valentin - Cliente 009', 5500.39, 'meta_ads'),
    (64, 'Awareness de Marca - Cliente 010', 4646.19, 'meta_ads'),
    (65, 'Descuento Fin de Mes - Cliente 009', 6972.55, 'linkedin_ads'),
    (66, 'Fidelizacion Clientes - Cliente 029', 8578.54, 'google_ads'),
    (67, 'Nueva Coleccion - Cliente 008', 11230.92, 'meta_ads'),
    (68, 'Regreso a Clases - Cliente 022', 1249.61, 'tiktok_ads'),
    (69, 'Temporada Navidad - Cliente 017', 4947.63, 'google_ads'),
    (70, 'Temporada Navidad - Cliente 016', 11241.78, 'meta_ads'),
    (71, 'Nueva Coleccion - Cliente 022', 10009.05, 'tiktok_ads'),
    (72, 'Promocion 2x1 - Cliente 034', 3908.60, 'meta_ads'),
    (73, 'Cyber Monday - Cliente 029', 6720.59, 'google_ads'),
    (74, 'Remarketing - Cliente 015', 10620.05, 'seo'),
    (75, 'Remarketing - Cliente 019', 3857.56, 'tiktok_ads'),
    (76, 'Prelanzamiento - Cliente 002', 11452.06, 'google_ads'),
    (77, 'Expansion Regional - Cliente 040', 7596.03, 'tiktok_ads'),
    (78, 'Lanzamiento - Cliente 038', 7310.44, 'linkedin_ads'),
    (79, 'Promocion 2x1 - Cliente 018', 4460.00, 'meta_ads'),
    (80, 'Temporada Verano - Cliente 037', 6646.95, 'meta_ads');

-- 169 conversiones distribuidas en 2024-2025
INSERT INTO campaign_conversions (id, item_id, quantity, tx_date) VALUES
    (1, 1, 7, '2025-11-06'), (2, 2, 17, '2024-06-10'), (3, 2, 6, '2025-01-22'),
    (4, 2, 20, '2025-03-01'), (5, 3, 14, '2025-08-19'), (6, 3, 8, '2024-06-06'),
    (7, 4, 4, '2025-04-21'), (8, 4, 14, '2025-03-21'), (9, 5, 4, '2025-01-05'),
    (10, 5, 11, '2025-06-12'), (11, 6, 20, '2024-09-05'), (12, 6, 1, '2025-07-19'),
    (13, 6, 2, '2024-04-25'), (14, 7, 6, '2024-04-23'), (15, 7, 13, '2024-08-19'),
    (16, 7, 20, '2024-01-06'), (17, 8, 7, '2024-11-06'), (18, 9, 12, '2025-11-13'),
    (19, 10, 11, '2025-07-11'), (20, 11, 20, '2025-11-13'), (21, 11, 13, '2025-08-25'),
    (22, 12, 12, '2025-12-16'), (23, 13, 7, '2025-03-21'), (24, 13, 13, '2025-02-03'),
    (25, 13, 2, '2024-11-17'), (26, 14, 16, '2025-08-10'), (27, 14, 6, '2025-03-11'),
    (28, 14, 7, '2025-04-06'), (29, 15, 3, '2024-12-09'), (30, 15, 14, '2025-06-25'),
    (31, 15, 1, '2025-04-17'), (32, 16, 2, '2024-01-08'), (33, 16, 12, '2024-11-18'),
    (34, 17, 19, '2024-12-10'), (35, 17, 4, '2024-11-18'), (36, 17, 19, '2025-08-09'),
    (37, 18, 5, '2024-01-24'), (38, 19, 17, '2024-04-25'), (39, 19, 16, '2024-07-07'),
    (40, 20, 19, '2024-06-05'), (41, 20, 9, '2024-08-18'), (42, 21, 19, '2024-10-13'),
    (43, 21, 15, '2024-12-04'), (44, 21, 12, '2025-09-08'), (45, 22, 13, '2025-09-09'),
    (46, 22, 1, '2024-02-13'), (47, 23, 1, '2025-03-24'), (48, 23, 1, '2025-03-18'),
    (49, 23, 19, '2024-12-11'), (50, 24, 8, '2025-11-17'), (51, 24, 2, '2024-10-10'),
    (52, 24, 19, '2025-07-20'), (53, 25, 6, '2024-07-16'), (54, 25, 1, '2025-05-13'),
    (55, 26, 6, '2025-11-23'), (56, 27, 13, '2024-10-02'), (57, 28, 9, '2024-04-17'),
    (58, 28, 3, '2024-08-25'), (59, 29, 18, '2025-10-02'), (60, 30, 16, '2025-02-27'),
    (61, 31, 5, '2025-09-17'), (62, 31, 17, '2024-02-12'), (63, 31, 8, '2024-07-01'),
    (64, 32, 5, '2024-08-27'), (65, 33, 3, '2025-12-09'), (66, 34, 14, '2024-04-17'),
    (67, 34, 12, '2025-01-24'), (68, 34, 8, '2024-03-24'), (69, 35, 14, '2024-12-15'),
    (70, 36, 17, '2025-07-10'), (71, 36, 13, '2024-06-28'), (72, 36, 16, '2024-05-14'),
    (73, 37, 4, '2025-02-02'), (74, 37, 2, '2024-11-18'), (75, 38, 7, '2024-02-02'),
    (76, 38, 3, '2024-01-03'), (77, 38, 20, '2024-08-18'), (78, 39, 15, '2025-05-02'),
    (79, 40, 18, '2024-09-28'), (80, 40, 7, '2024-04-13'), (81, 40, 16, '2025-10-13'),
    (82, 41, 2, '2024-01-17'), (83, 42, 17, '2024-06-23'), (84, 42, 6, '2024-03-24'),
    (85, 42, 11, '2024-04-18'), (86, 43, 3, '2025-05-17'), (87, 44, 14, '2025-05-01'),
    (88, 44, 7, '2024-07-24'), (89, 45, 18, '2024-05-24'), (90, 45, 1, '2024-05-05'),
    (91, 46, 6, '2024-01-20'), (92, 47, 13, '2024-05-11'), (93, 47, 12, '2024-01-22'),
    (94, 48, 8, '2025-07-26'), (95, 48, 14, '2024-11-07'), (96, 49, 16, '2024-11-28'),
    (97, 49, 2, '2025-04-21'), (98, 49, 16, '2024-04-15'), (99, 50, 3, '2024-10-24'),
    (100, 50, 11, '2025-04-08'), (101, 50, 19, '2025-09-28'), (102, 51, 2, '2024-03-20'),
    (103, 52, 9, '2025-11-02'), (104, 52, 1, '2025-11-14'), (105, 52, 3, '2024-03-10'),
    (106, 53, 7, '2024-12-27'), (107, 53, 1, '2024-08-12'), (108, 53, 13, '2025-11-18'),
    (109, 54, 10, '2024-02-27'), (110, 55, 1, '2025-05-05'), (111, 55, 2, '2024-11-08'),
    (112, 55, 6, '2025-09-04'), (113, 56, 3, '2025-03-09'), (114, 56, 5, '2025-01-07'),
    (115, 57, 2, '2024-07-16'), (116, 57, 17, '2025-08-04'), (117, 58, 6, '2024-05-08'),
    (118, 59, 20, '2025-09-08'), (119, 60, 12, '2025-04-08'), (120, 60, 13, '2024-02-27'),
    (121, 61, 19, '2025-03-23'), (122, 61, 11, '2025-03-11'), (123, 61, 4, '2024-03-06'),
    (124, 62, 7, '2025-02-15'), (125, 63, 19, '2024-02-28'), (126, 63, 3, '2024-12-20'),
    (127, 63, 20, '2025-03-13'), (128, 64, 11, '2024-07-05'), (129, 64, 16, '2024-11-11'),
    (130, 64, 14, '2024-07-11'), (131, 65, 16, '2024-06-11'), (132, 65, 18, '2024-07-01'),
    (133, 65, 20, '2025-02-18'), (134, 66, 15, '2025-11-19'), (135, 66, 15, '2024-12-19'),
    (136, 66, 10, '2025-10-05'), (137, 67, 6, '2024-09-07'), (138, 67, 7, '2024-06-08'),
    (139, 68, 7, '2025-11-14'), (140, 68, 10, '2025-08-12'), (141, 69, 9, '2025-09-23'),
    (142, 69, 13, '2024-08-10'), (143, 70, 18, '2024-12-15'), (144, 70, 6, '2025-04-03'),
    (145, 70, 3, '2024-12-13'), (146, 71, 11, '2025-07-13'), (147, 71, 5, '2025-12-26'),
    (148, 72, 8, '2024-11-18'), (149, 72, 14, '2024-07-08'), (150, 72, 20, '2025-03-02'),
    (151, 73, 12, '2025-08-15'), (152, 73, 20, '2024-03-26'), (153, 74, 13, '2025-02-16'),
    (154, 74, 2, '2024-03-06'), (155, 75, 4, '2025-03-18'), (156, 75, 12, '2024-04-07'),
    (157, 76, 4, '2025-06-25'), (158, 76, 16, '2025-10-19'), (159, 76, 17, '2024-04-13'),
    (160, 77, 18, '2024-08-27'), (161, 77, 11, '2024-08-25'), (162, 77, 11, '2024-08-10'),
    (163, 78, 6, '2024-06-28'), (164, 78, 14, '2025-03-18'), (165, 79, 8, '2025-12-02'),
    (166, 79, 6, '2025-02-03'), (167, 80, 1, '2025-06-20'), (168, 80, 17, '2024-04-04'),
    (169, 80, 6, '2024-05-18');

-- ============================================
-- CONSULTA 1: CTE simple + CASE WHEN de clasificación
-- Clasifica cada campaña según su presupuesto en 3 bandas
-- ============================================

WITH campanas_con_actividad AS (
    SELECT
        i.id,
        i.name,
        i.price,
        i.category,
        COUNT(t.id) AS total_transactions
    FROM campaigns i
    LEFT JOIN campaign_conversions t ON t.item_id = i.id
    GROUP BY i.id, i.name, i.price, i.category
)
SELECT
    name,
    price,
    total_transactions,
    CASE
        WHEN price >= 8000 THEN 'Premium'
        WHEN price >= 4000 THEN 'Estándar'
        ELSE                    'Económico'
    END AS price_band
FROM campanas_con_actividad
ORDER BY price DESC;

-- ============================================
-- CONSULTA 2: Dos CTEs encadenados
-- Primer CTE: total de conversiones por canal
-- Segundo CTE: canales por encima del promedio
-- ============================================

WITH ventas_por_categoria AS (
    SELECT
        i.category,
        SUM(t.quantity) AS total_vendido
    FROM campaigns i
    INNER JOIN campaign_conversions t ON t.item_id = i.id
    GROUP BY i.category
),
categorias_top AS (
    SELECT category
    FROM ventas_por_categoria
    WHERE total_vendido > (SELECT AVG(total_vendido) FROM ventas_por_categoria)
)
SELECT
    vc.category,
    vc.total_vendido
FROM ventas_por_categoria vc
WHERE vc.category IN (SELECT category FROM categorias_top)
ORDER BY vc.total_vendido DESC;

-- ============================================
-- CONSULTA 3: CTE + COUNT condicional por banda
-- Por canal, cuántas campañas hay en cada banda de presupuesto
-- ============================================

WITH clasificados AS (
    SELECT
        name,
        category,
        price,
        CASE
            WHEN price >= 8000 THEN 'Premium'
            WHEN price >= 4000 THEN 'Estándar'
            ELSE                    'Económico'
        END AS price_band
    FROM campaigns
)
SELECT
    category,
    COUNT(CASE WHEN price_band = 'Premium'   THEN 1 END) AS premium_count,
    COUNT(CASE WHEN price_band = 'Estándar'  THEN 1 END) AS estandar_count,
    COUNT(CASE WHEN price_band = 'Económico' THEN 1 END) AS economico_count
FROM clasificados
GROUP BY category
ORDER BY category;

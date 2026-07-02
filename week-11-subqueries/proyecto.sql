-- ============================================
-- PROYECTO SEMANAL: Subqueries en tu dominio
-- Semana 11 — Subqueries (escalar, IN, EXISTS, FROM)
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- main_items    -> campaigns          (campañas, value = presupuesto, category = canal)
-- child_records -> campaign_activity  (registros diarios de conversiones por campaña)

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS campaign_activity;
DROP TABLE IF EXISTS campaigns;

CREATE TABLE campaigns (
    id       INTEGER PRIMARY KEY,
    name     TEXT    NOT NULL,
    value    REAL    NOT NULL CHECK (value > 0),  -- presupuesto de la campaña
    category TEXT    NOT NULL                      -- canal (google_ads, meta_ads, ...)
);

CREATE TABLE campaign_activity (
    id       INTEGER PRIMARY KEY,
    item_id  INTEGER NOT NULL REFERENCES campaigns (id),
    quantity INTEGER NOT NULL DEFAULT 1  -- conversiones registradas ese día
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

-- 80 campañas
INSERT INTO campaigns (id, name, value, category) VALUES
    (1, 'San Valentin - Cliente 039', 5940.12, 'google_ads'),
    (2, 'Awareness de Marca - Cliente 035', 6668.55, 'tiktok_ads'),
    (3, 'Fidelizacion Clientes - Cliente 021', 1660.79, 'linkedin_ads'),
    (4, 'Fidelizacion Clientes - Cliente 006', 7697.77, 'google_ads'),
    (5, 'Fidelizacion Clientes - Cliente 028', 9577.98, 'seo'),
    (6, 'Aniversario - Cliente 018', 4551.54, 'google_ads'),
    (7, 'Reapertura - Cliente 027', 9392.71, 'seo'),
    (8, 'Promocion 2x1 - Cliente 018', 11753.01, 'email_marketing'),
    (9, 'Temporada Verano - Cliente 013', 5820.97, 'google_ads'),
    (10, 'Temporada Navidad - Cliente 029', 1283.30, 'google_ads'),
    (11, 'Remarketing - Cliente 022', 3878.97, 'google_ads'),
    (12, 'Dia de la Madre - Cliente 018', 345.59, 'email_marketing'),
    (13, 'Awareness de Marca - Cliente 010', 4997.97, 'google_ads'),
    (14, 'Dia de la Madre - Cliente 032', 4049.57, 'meta_ads'),
    (15, 'Fidelizacion Clientes - Cliente 033', 3937.29, 'meta_ads'),
    (16, 'San Valentin - Cliente 028', 699.09, 'meta_ads'),
    (17, 'Regreso a Clases - Cliente 006', 1306.42, 'google_ads'),
    (18, 'Fidelizacion Clientes - Cliente 011', 2433.06, 'seo'),
    (19, 'Expansion Regional - Cliente 008', 506.74, 'google_ads'),
    (20, 'Temporada Verano - Cliente 010', 1664.48, 'tiktok_ads'),
    (21, 'Expansion Regional - Cliente 019', 6344.85, 'email_marketing'),
    (22, 'Aniversario - Cliente 033', 1158.55, 'tiktok_ads'),
    (23, 'Black Friday - Cliente 013', 8128.13, 'tiktok_ads'),
    (24, 'Remarketing - Cliente 009', 1269.56, 'meta_ads'),
    (25, 'Lanzamiento - Cliente 007', 1126.25, 'google_ads'),
    (26, 'Remarketing - Cliente 013', 5615.22, 'meta_ads'),
    (27, 'Expansion Regional - Cliente 018', 3198.09, 'tiktok_ads'),
    (28, 'Awareness de Marca - Cliente 011', 11021.81, 'meta_ads'),
    (29, 'Ultimas Unidades - Cliente 032', 8958.60, 'tiktok_ads'),
    (30, 'Generacion de Leads - Cliente 014', 6338.03, 'google_ads'),
    (31, 'Promocion 2x1 - Cliente 012', 769.97, 'linkedin_ads'),
    (32, 'Temporada Verano - Cliente 002', 6697.32, 'meta_ads'),
    (33, 'Regreso a Clases - Cliente 004', 3370.05, 'google_ads'),
    (34, 'Aniversario - Cliente 011', 2567.91, 'meta_ads'),
    (35, 'Dia de la Madre - Cliente 040', 11088.12, 'meta_ads'),
    (36, 'Cyber Monday - Cliente 012', 5130.39, 'google_ads'),
    (37, 'Cyber Monday - Cliente 007', 9335.65, 'google_ads'),
    (38, 'Aniversario - Cliente 026', 3030.70, 'meta_ads'),
    (39, 'Regreso a Clases - Cliente 013', 8266.63, 'tiktok_ads'),
    (40, 'Expansion Regional - Cliente 010', 4364.47, 'meta_ads'),
    (41, 'Regreso a Clases - Cliente 011', 11481.42, 'tiktok_ads'),
    (42, 'Temporada Verano - Cliente 021', 9201.31, 'google_ads'),
    (43, 'Awareness de Marca - Cliente 016', 7510.46, 'tiktok_ads'),
    (44, 'Awareness de Marca - Cliente 036', 5682.98, 'google_ads'),
    (45, 'Expansion Regional - Cliente 034', 8525.32, 'meta_ads'),
    (46, 'Awareness de Marca - Cliente 017', 947.85, 'meta_ads'),
    (47, 'Promocion 2x1 - Cliente 011', 10254.29, 'meta_ads'),
    (48, 'Awareness de Marca - Cliente 017', 582.09, 'meta_ads'),
    (49, 'Prelanzamiento - Cliente 003', 4701.41, 'google_ads'),
    (50, 'Aniversario - Cliente 002', 5882.28, 'meta_ads'),
    (51, 'Lanzamiento - Cliente 003', 9900.61, 'email_marketing'),
    (52, 'Temporada Navidad - Cliente 038', 2192.24, 'tiktok_ads'),
    (53, 'Dia de la Madre - Cliente 006', 7999.44, 'meta_ads'),
    (54, 'Dia de la Madre - Cliente 007', 1873.04, 'google_ads'),
    (55, 'Remarketing - Cliente 029', 4064.62, 'meta_ads'),
    (56, 'Awareness de Marca - Cliente 004', 7163.05, 'email_marketing'),
    (57, 'Promocion 2x1 - Cliente 034', 6357.87, 'tiktok_ads'),
    (58, 'Black Friday - Cliente 023', 6285.49, 'tiktok_ads'),
    (59, 'Black Friday - Cliente 019', 714.20, 'google_ads'),
    (60, 'Fidelizacion Clientes - Cliente 021', 9226.56, 'email_marketing'),
    (61, 'San Valentin - Cliente 015', 3507.73, 'meta_ads'),
    (62, 'Remarketing - Cliente 028', 7092.72, 'seo'),
    (63, 'Promocion 2x1 - Cliente 026', 2362.88, 'meta_ads'),
    (64, 'Reapertura - Cliente 014', 323.01, 'seo'),
    (65, 'San Valentin - Cliente 031', 2818.90, 'google_ads'),
    (66, 'Cyber Monday - Cliente 010', 9895.16, 'tiktok_ads'),
    (67, 'Black Friday - Cliente 014', 883.74, 'seo'),
    (68, 'Regreso a Clases - Cliente 026', 453.03, 'google_ads'),
    (69, 'Nueva Coleccion - Cliente 004', 2181.04, 'tiktok_ads'),
    (70, 'Temporada Verano - Cliente 038', 1247.58, 'google_ads'),
    (71, 'Reapertura - Cliente 032', 7140.69, 'linkedin_ads'),
    (72, 'Generacion de Leads - Cliente 001', 1076.25, 'seo'),
    (73, 'Ultimas Unidades - Cliente 032', 9002.26, 'meta_ads'),
    (74, 'Lanzamiento - Cliente 012', 11145.73, 'google_ads'),
    (75, 'Temporada Navidad - Cliente 023', 2769.52, 'email_marketing'),
    (76, 'Lanzamiento - Cliente 040', 10232.22, 'meta_ads'),
    (77, 'Lanzamiento - Cliente 029', 6834.31, 'tiktok_ads'),
    (78, 'Remarketing - Cliente 037', 1875.73, 'tiktok_ads'),
    (79, 'Promocion 2x1 - Cliente 035', 2420.73, 'seo'),
    (80, 'Generacion de Leads - Cliente 035', 7818.89, 'email_marketing');

-- 161 registros de actividad; 12 campañas quedan sin ningún registro
-- (para practicar NOT EXISTS)
INSERT INTO campaign_activity (id, item_id, quantity) VALUES
    (1, 28, 12), (2, 41, 15), (3, 41, 23), (4, 64, 5), (5, 64, 19),
    (6, 25, 19), (7, 25, 22), (8, 25, 19), (9, 25, 16), (10, 51, 19),
    (11, 54, 5), (12, 54, 25), (13, 22, 18), (14, 22, 19), (15, 77, 12),
    (16, 77, 2), (17, 77, 15), (18, 75, 12), (19, 30, 19), (20, 24, 14),
    (21, 60, 8), (22, 60, 23), (23, 60, 7), (24, 72, 4), (25, 72, 17),
    (26, 72, 13), (27, 72, 13), (28, 50, 21), (29, 50, 4), (30, 36, 9),
    (31, 36, 4), (32, 36, 14), (33, 49, 7), (34, 49, 3), (35, 29, 16),
    (36, 29, 9), (37, 29, 2), (38, 29, 1), (39, 52, 8), (40, 52, 14),
    (41, 46, 2), (42, 47, 18), (43, 58, 9), (44, 58, 12), (45, 58, 7),
    (46, 67, 11), (47, 67, 6), (48, 67, 14), (49, 23, 9), (50, 23, 20),
    (51, 23, 18), (52, 32, 13), (53, 32, 17), (54, 63, 19), (55, 63, 14),
    (56, 63, 4), (57, 3, 24), (58, 3, 18), (59, 3, 7), (60, 3, 19),
    (61, 21, 4), (62, 21, 22), (63, 21, 1), (64, 44, 17), (65, 44, 16),
    (66, 65, 23), (67, 53, 9), (68, 53, 18), (69, 53, 20), (70, 16, 3),
    (71, 16, 25), (72, 37, 3), (73, 37, 1), (74, 37, 10), (75, 78, 22),
    (76, 78, 9), (77, 27, 19), (78, 5, 2), (79, 5, 15), (80, 5, 12),
    (81, 5, 14), (82, 80, 11), (83, 80, 10), (84, 80, 18), (85, 33, 22),
    (86, 7, 9), (87, 19, 7), (88, 43, 18), (89, 43, 10), (90, 43, 25),
    (91, 43, 20), (92, 74, 9), (93, 74, 15), (94, 71, 24), (95, 14, 24),
    (96, 14, 17), (97, 40, 13), (98, 59, 7), (99, 59, 7), (100, 59, 23),
    (101, 59, 9), (102, 76, 14), (103, 76, 17), (104, 2, 13), (105, 2, 2),
    (106, 2, 22), (107, 34, 15), (108, 34, 5), (109, 34, 17), (110, 34, 13),
    (111, 61, 15), (112, 61, 15), (113, 61, 14), (114, 61, 22), (115, 68, 8),
    (116, 68, 24), (117, 17, 5), (118, 17, 15), (119, 17, 9), (120, 17, 16),
    (121, 56, 10), (122, 56, 10), (123, 69, 19), (124, 69, 9), (125, 69, 25),
    (126, 10, 21), (127, 10, 16), (128, 10, 14), (129, 10, 25), (130, 70, 21),
    (131, 70, 6), (132, 66, 5), (133, 66, 14), (134, 66, 7), (135, 73, 8),
    (136, 73, 21), (137, 73, 11), (138, 73, 21), (139, 26, 17), (140, 26, 23),
    (141, 26, 18), (142, 18, 14), (143, 4, 7), (144, 4, 1), (145, 4, 25),
    (146, 20, 23), (147, 62, 22), (148, 1, 7), (149, 6, 8), (150, 45, 3),
    (151, 45, 15), (152, 45, 3), (153, 45, 23), (154, 11, 16), (155, 11, 16),
    (156, 13, 15), (157, 13, 13), (158, 13, 2), (159, 13, 17), (160, 8, 23),
    (161, 8, 10);

-- ============================================
-- CONSULTA 1: Subquery escalar en WHERE
-- Campañas cuyo presupuesto supera el promedio de su canal
-- ============================================

SELECT
    name,
    value,
    category
FROM campaigns m
WHERE value > (
    SELECT AVG(m2.value)
    FROM campaigns m2
    WHERE m2.category = m.category
)
ORDER BY category, value DESC;

-- ============================================
-- CONSULTA 2: Subquery escalar en SELECT
-- Muestra el promedio global de presupuesto junto a cada campaña
-- ============================================

SELECT
    name,
    value,
    ROUND((SELECT AVG(value) FROM campaigns), 2) AS overall_avg
FROM campaigns
ORDER BY value DESC;

-- ============================================
-- CONSULTA 3: NOT EXISTS — campañas sin actividad
-- ============================================

SELECT
    name AS campana_sin_actividad
FROM campaigns m
WHERE NOT EXISTS (
    SELECT 1
    FROM campaign_activity cr
    WHERE cr.item_id = m.id
);

-- ============================================
-- CONSULTA 4: Tabla derivada en FROM
-- Canales con más de 20 conversiones acumuladas
-- ============================================

SELECT
    cat_stats.category,
    cat_stats.total_records
FROM (
    SELECT
        mi.category,
        COALESCE(SUM(cr.quantity), 0) AS total_records
    FROM campaigns  mi
    LEFT JOIN campaign_activity cr ON cr.item_id = mi.id
    GROUP BY mi.category
) AS cat_stats
WHERE cat_stats.total_records > 20
ORDER BY cat_stats.total_records DESC;

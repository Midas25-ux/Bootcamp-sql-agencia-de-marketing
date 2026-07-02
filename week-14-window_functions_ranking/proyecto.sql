-- ============================================
-- PROYECTO SEMANAL: Ranking con Window Functions
-- Semana 14 — Window Functions (ROW_NUMBER, RANK, DENSE_RANK)
-- PostgreSQL 16
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- categories -> channels (canales de pauta: Google Ads, Meta Ads, ...)
-- items      -> ads      (creativos publicitarios, value = total_clicks)

DROP TABLE IF EXISTS ads CASCADE;
DROP TABLE IF EXISTS channels CASCADE;

CREATE TABLE channels (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE ads (
    id           SERIAL         PRIMARY KEY,
    name         TEXT           NOT NULL,
    format       TEXT           NOT NULL,  -- image, video, carousel, text
    total_clicks NUMERIC(10, 2) NOT NULL,
    channel_id   INT            REFERENCES channels (id),
    is_active    BOOLEAN        NOT NULL DEFAULT TRUE
);

INSERT INTO channels (name) VALUES
    ('Google Ads'),
    ('Meta Ads'),
    ('TikTok Ads'),
    ('LinkedIn Ads'),
    ('Email Marketing'),
    ('SEO');

-- 205 anuncios (200 + 5 duplicados intencionales por nombre para
-- demostrar la deduplicación con ROW_NUMBER). Múltiples empates
-- de total_clicks entre anuncios para ilustrar RANK vs DENSE_RANK.
INSERT INTO ads (name, format, total_clicks, channel_id, is_active) VALUES
    ('Anuncio Oferta #1', 'image', 1200, 1, TRUE),
    ('Anuncio Oferta #2', 'carousel', 1100, 6, TRUE),
    ('Anuncio Detras de Camaras #3', 'image', 800, 6, TRUE),
    ('Anuncio Producto #4', 'carousel', 1500, 1, TRUE),
    ('Anuncio Edicion Limitada #5', 'video', 620, 4, FALSE),
    ('Anuncio Producto #6', 'video', 1000, 5, FALSE),
    ('Anuncio Testimonio #7', 'video', 300, 4, TRUE),
    ('Anuncio Unboxing #8', 'video', 1350, 6, FALSE),
    ('Anuncio Unboxing #9', 'text', 1000, 5, TRUE),
    ('Anuncio Testimonio #10', 'image', 2000, 3, TRUE),
    ('Anuncio Tutorial #11', 'image', 300, 1, TRUE),
    ('Anuncio Antes y Despues #12', 'image', 1000, 2, TRUE),
    ('Anuncio Novedad #13', 'video', 1500, 4, TRUE),
    ('Anuncio Detras de Camaras #14', 'image', 620, 5, TRUE),
    ('Anuncio Detras de Camaras #15', 'image', 750, 6, TRUE),
    ('Anuncio Beneficios #16', 'image', 1350, 4, TRUE),
    ('Anuncio Promocion #17', 'carousel', 320, 2, TRUE),
    ('Anuncio Lanzamiento #18', 'image', 300, 3, TRUE),
    ('Anuncio Promocion #19', 'carousel', 500, 2, TRUE),
    ('Anuncio Edicion Limitada #20', 'carousel', 50, 3, TRUE),
    ('Anuncio Producto #21', 'video', 750, 6, TRUE),
    ('Anuncio Beneficios #22', 'video', 500, 2, TRUE),
    ('Anuncio Comparativa #23', 'carousel', 2200, 4, TRUE),
    ('Anuncio Comparativa #24', 'carousel', 300, 1, TRUE),
    ('Anuncio Detras de Camaras #25', 'image', 400, 2, TRUE),
    ('Anuncio Novedad #26', 'image', 250, 5, TRUE),
    ('Anuncio Tutorial #27', 'video', 250, 6, FALSE),
    ('Anuncio Oferta #28', 'image', 500, 4, TRUE),
    ('Anuncio Novedad #29', 'video', 950, 1, TRUE),
    ('Anuncio Producto #30', 'image', 800, 5, TRUE),
    ('Anuncio Tutorial #31', 'video', 950, 5, TRUE),
    ('Anuncio Testimonio #32', 'video', 320, 6, TRUE),
    ('Anuncio Unboxing #33', 'carousel', 1350, 3, TRUE),
    ('Anuncio Edicion Limitada #34', 'image', 700, 2, FALSE),
    ('Anuncio Tutorial #35', 'text', 180, 1, TRUE),
    ('Anuncio Edicion Limitada #36', 'image', 450, 6, TRUE),
    ('Anuncio Oferta #37', 'video', 800, 1, TRUE),
    ('Anuncio Tutorial #38', 'video', 800, 6, TRUE),
    ('Anuncio Lanzamiento #39', 'image', 2200, 6, TRUE),
    ('Anuncio Tutorial #40', 'image', 750, 1, FALSE),
    ('Anuncio Antes y Despues #41', 'video', 1200, 3, TRUE),
    ('Anuncio Antes y Despues #42', 'carousel', 1200, 5, TRUE),
    ('Anuncio Comparativa #43', 'carousel', 320, 6, TRUE),
    ('Anuncio Unboxing #44', 'image', 1500, 4, TRUE),
    ('Anuncio Detras de Camaras #45', 'image', 950, 3, TRUE),
    ('Anuncio Antes y Despues #46', 'video', 320, 3, TRUE),
    ('Anuncio Edicion Limitada #47', 'image', 620, 3, FALSE),
    ('Anuncio Lanzamiento #48', 'image', 2500, 1, TRUE),
    ('Anuncio Oferta #49', 'text', 120, 2, FALSE),
    ('Anuncio Beneficios #50', 'carousel', 950, 4, TRUE),
    ('Anuncio Antes y Despues #51', 'carousel', 300, 3, TRUE),
    ('Anuncio Antes y Despues #52', 'image', 1650, 1, FALSE),
    ('Anuncio Promocion #53', 'video', 750, 3, TRUE),
    ('Anuncio Unboxing #54', 'video', 1500, 4, TRUE),
    ('Anuncio Unboxing #55', 'image', 120, 3, TRUE),
    ('Anuncio Promocion #56', 'image', 620, 5, TRUE),
    ('Anuncio Novedad #57', 'carousel', 900, 5, TRUE),
    ('Anuncio Historia de Cliente #58', 'carousel', 950, 3, TRUE),
    ('Anuncio Edicion Limitada #59', 'video', 50, 6, TRUE),
    ('Anuncio Detras de Camaras #60', 'video', 120, 4, FALSE),
    ('Anuncio Producto #61', 'image', 120, 4, FALSE),
    ('Anuncio Descuento #62', 'text', 1350, 4, TRUE),
    ('Anuncio Lanzamiento #63', 'image', 1100, 6, FALSE),
    ('Anuncio Tutorial #64', 'carousel', 620, 3, TRUE),
    ('Anuncio Testimonio #65', 'image', 400, 5, TRUE),
    ('Anuncio Detras de Camaras #66', 'video', 1350, 6, TRUE),
    ('Anuncio Lanzamiento #67', 'video', 1200, 2, TRUE),
    ('Anuncio Descuento #68', 'image', 900, 6, TRUE),
    ('Anuncio Testimonio #69', 'video', 700, 1, TRUE),
    ('Anuncio Promocion #70', 'video', 1000, 4, TRUE),
    ('Anuncio Novedad #71', 'video', 1200, 1, FALSE),
    ('Anuncio Novedad #72', 'video', 1800, 4, TRUE),
    ('Anuncio Testimonio #73', 'text', 1650, 2, FALSE),
    ('Anuncio Novedad #74', 'video', 1500, 4, TRUE),
    ('Anuncio Tutorial #75', 'image', 50, 1, TRUE),
    ('Anuncio Comparativa #76', 'image', 120, 4, TRUE),
    ('Anuncio Beneficios #77', 'carousel', 300, 3, FALSE),
    ('Anuncio Promocion #78', 'image', 1350, 6, TRUE),
    ('Anuncio Historia de Cliente #79', 'image', 180, 3, TRUE),
    ('Anuncio Lanzamiento #80', 'video', 120, 5, TRUE),
    ('Anuncio Descuento #81', 'video', 2500, 1, TRUE),
    ('Anuncio Testimonio #82', 'video', 450, 2, TRUE),
    ('Anuncio Beneficios #83', 'image', 120, 5, TRUE),
    ('Anuncio Beneficios #84', 'video', 250, 5, FALSE),
    ('Anuncio Historia de Cliente #85', 'video', 1100, 5, TRUE),
    ('Anuncio Historia de Cliente #86', 'image', 1200, 1, TRUE),
    ('Anuncio Detras de Camaras #87', 'image', 1500, 1, FALSE),
    ('Anuncio Comparativa #88', 'image', 900, 1, TRUE),
    ('Anuncio Descuento #89', 'carousel', 1000, 3, TRUE),
    ('Anuncio Comparativa #90', 'video', 1800, 3, TRUE),
    ('Anuncio Unboxing #91', 'image', 700, 5, TRUE),
    ('Anuncio Lanzamiento #92', 'carousel', 1350, 2, TRUE),
    ('Anuncio Tutorial #93', 'video', 700, 3, TRUE),
    ('Anuncio Edicion Limitada #94', 'carousel', 2000, 3, TRUE),
    ('Anuncio Unboxing #95', 'video', 1500, 6, TRUE),
    ('Anuncio Historia de Cliente #96', 'video', 950, 2, TRUE),
    ('Anuncio Lanzamiento #97', 'image', 300, 6, TRUE),
    ('Anuncio Tutorial #98', 'video', 1000, 5, TRUE),
    ('Anuncio Descuento #99', 'image', 300, 5, FALSE),
    ('Anuncio Producto #100', 'video', 800, 4, TRUE),
    ('Anuncio Edicion Limitada #101', 'text', 250, 1, TRUE),
    ('Anuncio Testimonio #102', 'image', 400, 3, TRUE),
    ('Anuncio Unboxing #103', 'video', 1100, 5, TRUE),
    ('Anuncio Antes y Despues #104', 'video', 750, 5, TRUE),
    ('Anuncio Oferta #105', 'video', 2200, 2, TRUE),
    ('Anuncio Comparativa #106', 'video', 2000, 6, FALSE),
    ('Anuncio Novedad #107', 'video', 900, 1, FALSE),
    ('Anuncio Oferta #108', 'image', 620, 2, TRUE),
    ('Anuncio Testimonio #109', 'video', 120, 6, TRUE),
    ('Anuncio Novedad #110', 'text', 1100, 3, TRUE),
    ('Anuncio Beneficios #111', 'image', 620, 1, TRUE),
    ('Anuncio Promocion #112', 'image', 1100, 5, TRUE),
    ('Anuncio Producto #113', 'image', 500, 3, TRUE),
    ('Anuncio Unboxing #114', 'image', 400, 6, TRUE),
    ('Anuncio Historia de Cliente #115', 'image', 1650, 6, TRUE),
    ('Anuncio Edicion Limitada #116', 'text', 450, 4, FALSE),
    ('Anuncio Oferta #117', 'carousel', 250, 3, TRUE),
    ('Anuncio Descuento #118', 'video', 250, 2, TRUE),
    ('Anuncio Detras de Camaras #119', 'video', 800, 6, TRUE),
    ('Anuncio Comparativa #120', 'carousel', 750, 6, TRUE),
    ('Anuncio Descuento #121', 'text', 900, 5, TRUE),
    ('Anuncio Testimonio #122', 'carousel', 1650, 6, TRUE),
    ('Anuncio Testimonio #123', 'image', 400, 2, FALSE),
    ('Anuncio Antes y Despues #124', 'carousel', 900, 3, TRUE),
    ('Anuncio Edicion Limitada #125', 'image', 400, 6, TRUE),
    ('Anuncio Comparativa #126', 'image', 1800, 2, TRUE),
    ('Anuncio Unboxing #127', 'image', 400, 6, TRUE),
    ('Anuncio Tutorial #128', 'carousel', 320, 2, TRUE),
    ('Anuncio Tutorial #129', 'image', 2200, 6, TRUE),
    ('Anuncio Descuento #130', 'image', 900, 6, TRUE),
    ('Anuncio Antes y Despues #131', 'image', 950, 5, TRUE),
    ('Anuncio Tutorial #132', 'video', 1650, 4, FALSE),
    ('Anuncio Promocion #133', 'video', 1350, 6, FALSE),
    ('Anuncio Lanzamiento #134', 'carousel', 620, 5, FALSE),
    ('Anuncio Producto #135', 'text', 2000, 6, FALSE),
    ('Anuncio Edicion Limitada #136', 'video', 1100, 1, TRUE),
    ('Anuncio Testimonio #137', 'image', 1350, 2, TRUE),
    ('Anuncio Oferta #138', 'image', 2000, 2, TRUE),
    ('Anuncio Detras de Camaras #139', 'video', 180, 4, TRUE),
    ('Anuncio Oferta #140', 'image', 400, 5, FALSE),
    ('Anuncio Unboxing #141', 'image', 400, 3, TRUE),
    ('Anuncio Comparativa #142', 'video', 620, 6, FALSE),
    ('Anuncio Tutorial #143', 'image', 2500, 2, TRUE),
    ('Anuncio Edicion Limitada #144', 'image', 2500, 2, TRUE),
    ('Anuncio Unboxing #145', 'text', 800, 1, TRUE),
    ('Anuncio Antes y Despues #146', 'image', 450, 3, TRUE),
    ('Anuncio Promocion #147', 'video', 320, 6, TRUE),
    ('Anuncio Producto #148', 'carousel', 2200, 1, TRUE),
    ('Anuncio Producto #149', 'image', 1100, 4, FALSE),
    ('Anuncio Detras de Camaras #150', 'image', 1650, 2, TRUE),
    ('Anuncio Detras de Camaras #151', 'carousel', 180, 2, TRUE),
    ('Anuncio Producto #152', 'carousel', 1350, 5, TRUE),
    ('Anuncio Lanzamiento #153', 'video', 250, 6, TRUE),
    ('Anuncio Historia de Cliente #154', 'video', 300, 3, TRUE),
    ('Anuncio Promocion #155', 'image', 620, 6, TRUE),
    ('Anuncio Novedad #156', 'carousel', 1200, 2, TRUE),
    ('Anuncio Detras de Camaras #157', 'carousel', 800, 5, TRUE),
    ('Anuncio Detras de Camaras #158', 'image', 400, 1, TRUE),
    ('Anuncio Descuento #159', 'video', 1800, 2, TRUE),
    ('Anuncio Edicion Limitada #160', 'image', 700, 5, TRUE),
    ('Anuncio Edicion Limitada #161', 'image', 950, 2, TRUE),
    ('Anuncio Promocion #162', 'text', 1500, 3, TRUE),
    ('Anuncio Comparativa #163', 'image', 2500, 1, FALSE),
    ('Anuncio Historia de Cliente #164', 'carousel', 180, 4, TRUE),
    ('Anuncio Descuento #165', 'image', 1650, 1, TRUE),
    ('Anuncio Antes y Despues #166', 'carousel', 1500, 3, TRUE),
    ('Anuncio Detras de Camaras #167', 'image', 450, 1, TRUE),
    ('Anuncio Novedad #168', 'image', 1000, 6, TRUE),
    ('Anuncio Promocion #169', 'text', 1800, 1, TRUE),
    ('Anuncio Oferta #170', 'image', 2500, 4, TRUE),
    ('Anuncio Antes y Despues #171', 'carousel', 2200, 4, TRUE),
    ('Anuncio Historia de Cliente #172', 'image', 1350, 1, TRUE),
    ('Anuncio Unboxing #173', 'video', 180, 6, TRUE),
    ('Anuncio Beneficios #174', 'image', 1350, 4, TRUE),
    ('Anuncio Detras de Camaras #175', 'video', 620, 5, TRUE),
    ('Anuncio Beneficios #176', 'video', 2200, 1, TRUE),
    ('Anuncio Oferta #177', 'text', 400, 1, TRUE),
    ('Anuncio Beneficios #178', 'image', 180, 2, TRUE),
    ('Anuncio Promocion #179', 'carousel', 900, 6, TRUE),
    ('Anuncio Producto #180', 'video', 1100, 6, TRUE),
    ('Anuncio Beneficios #181', 'image', 700, 2, TRUE),
    ('Anuncio Tutorial #182', 'image', 120, 6, FALSE),
    ('Anuncio Testimonio #183', 'image', 1800, 4, TRUE),
    ('Anuncio Historia de Cliente #184', 'image', 1200, 1, TRUE),
    ('Anuncio Comparativa #185', 'image', 620, 4, TRUE),
    ('Anuncio Antes y Despues #186', 'image', 1800, 3, TRUE),
    ('Anuncio Antes y Despues #187', 'image', 1650, 6, TRUE),
    ('Anuncio Tutorial #188', 'image', 1200, 1, TRUE),
    ('Anuncio Descuento #189', 'carousel', 1200, 5, TRUE),
    ('Anuncio Lanzamiento #190', 'carousel', 1800, 6, TRUE),
    ('Anuncio Testimonio #191', 'image', 120, 6, TRUE),
    ('Anuncio Historia de Cliente #192', 'image', 50, 5, TRUE),
    ('Anuncio Tutorial #193', 'image', 1650, 6, TRUE),
    ('Anuncio Beneficios #194', 'video', 1650, 6, TRUE),
    ('Anuncio Novedad #195', 'video', 700, 4, TRUE),
    ('Anuncio Producto #196', 'carousel', 800, 2, TRUE),
    ('Anuncio Novedad #197', 'image', 1000, 4, FALSE),
    ('Anuncio Historia de Cliente #198', 'image', 620, 4, TRUE),
    ('Anuncio Lanzamiento #199', 'video', 250, 4, TRUE),
    ('Anuncio Edicion Limitada #200', 'carousel', 250, 6, TRUE),
    -- Duplicados intencionales por nombre (mismo anuncio subido dos
    -- veces al gestor de campañas) para practicar la deduplicación
    ('Anuncio Oferta #1', 'image', 1450, 1, TRUE),
    ('Anuncio Oferta #2', 'carousel', 1300, 6, TRUE),
    ('Anuncio Testimonio #10', 'image', 1900, 3, FALSE),
    ('Anuncio Producto #4', 'carousel', 1600, 1, TRUE),
    ('Anuncio Lanzamiento #48', 'image', 2400, 1, TRUE);

-- ============================================
-- CONSULTA 1: Eliminar duplicados con ROW_NUMBER()
-- Nos quedamos con el registro más reciente (mayor id) por nombre
-- ============================================

WITH deduplicados AS (
    SELECT
        id,
        name,
        total_clicks,
        channel_id,
        ROW_NUMBER() OVER (PARTITION BY name ORDER BY id DESC) AS rn
    FROM ads
)
SELECT
    id,
    name,
    total_clicks AS value,
    channel_id AS category_id
FROM deduplicados
WHERE rn = 1
ORDER BY id;

-- ============================================
-- CONSULTA 2: RANK y DENSE_RANK por canal
-- Clasifica los anuncios por clics dentro de cada canal
-- ============================================

SELECT
    name,
    total_clicks,
    channel_id,
    RANK()       OVER (PARTITION BY channel_id ORDER BY total_clicks DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY channel_id ORDER BY total_clicks DESC) AS dense_rnk
FROM ads
ORDER BY channel_id, rnk;

-- ============================================
-- CONSULTA 3: Top-2 anuncios por canal (CTE + DENSE_RANK)
-- ============================================

WITH ranking_por_canal AS (
    SELECT
        name,
        total_clicks,
        channel_id,
        DENSE_RANK() OVER (
            PARTITION BY channel_id ORDER BY total_clicks DESC
        ) AS dense_rnk
    FROM ads
)
SELECT
    name,
    total_clicks,
    channel_id,
    dense_rnk
FROM ranking_por_canal
WHERE dense_rnk <= 2
ORDER BY channel_id, dense_rnk;

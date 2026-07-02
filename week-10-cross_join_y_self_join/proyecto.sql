-- ============================================
-- PROYECTO SEMANAL: SELF JOIN en tu dominio
-- Semana 10 — CROSS JOIN y SELF JOIN
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- Jerarquía: catálogo de servicios de la agencia.
-- Nivel 1 (raíz) -> área de servicio      (ej. Paid Media, SEO)
-- Nivel 2        -> servicio concreto      (ej. Google Ads, SEO Técnico)
-- Nivel 3 (hoja) -> entregable específico  (ej. Reels, Backlinks)

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS service_categories;

CREATE TABLE service_categories (
    id        INTEGER PRIMARY KEY,
    name      TEXT    NOT NULL UNIQUE,
    parent_id INTEGER REFERENCES service_categories (id)  -- auto-referencial
);

-- 80 categorías: 6 raíces, 19 de nivel 2, 55 hojas de nivel 3
INSERT INTO service_categories (id, name, parent_id) VALUES
    (1, 'Paid Media', NULL),
    (2, 'SEO', NULL),
    (3, 'Redes Sociales', NULL),
    (4, 'Contenido y Branding', NULL),
    (5, 'Email Marketing', NULL),
    (6, 'Analitica y Datos', NULL),
    (7, 'Google Ads', 1),
    (8, 'Meta Ads', 1),
    (9, 'TikTok Ads', 1),
    (10, 'LinkedIn Ads', 1),
    (11, 'SEO Tecnico', 2),
    (12, 'SEO Local', 2),
    (13, 'Link Building', 2),
    (14, 'Gestion de Comunidad', 3),
    (15, 'Influencer Marketing', 3),
    (16, 'Social Ads', 3),
    (17, 'Diseno Grafico', 4),
    (18, 'Copywriting', 4),
    (19, 'Produccion Audiovisual', 4),
    (20, 'Identidad de Marca', 4),
    (21, 'Automatizacion', 5),
    (22, 'Newsletters', 5),
    (23, 'Segmentacion', 5),
    (24, 'Reportes de Rendimiento', 6),
    (25, 'Seguimiento de Conversiones', 6),
    (26, 'Newsletter Semanal', 14),
    (27, 'Datos Estructurados', 21),
    (28, 'Fotografia', 19),
    (29, 'UTM Tracking', 11),
    (30, 'Tipografia', 24),
    (31, 'Reels', 8),
    (32, 'Flujos de Bienvenida', 14),
    (33, 'Google Analytics', 23),
    (34, 'Busqueda', 16),
    (35, 'Banners', 25),
    (36, 'Display', 17),
    (37, 'Moderacion', 23),
    (38, 'Backlinks', 17),
    (39, 'Testimonios', 24),
    (40, 'Shopping', 18),
    (41, 'Editorial', 22),
    (42, 'Auditoria', 19),
    (43, 'Macro Influencers', 8),
    (44, 'Reporte Semanal', 10),
    (45, 'Resenas', 16),
    (46, 'Encuestas', 20),
    (47, 'Manual de Marca', 15),
    (48, 'Guion', 14),
    (49, 'Motion Graphics', 20),
    (50, 'SEO On-page', 23),
    (51, 'Pixel de Conversion', 22),
    (52, 'Remarketing', 25),
    (53, 'Paleta de Color', 15),
    (54, 'Stories', 11),
    (55, 'Carrito Abandonado', 8),
    (56, 'Segmentos por Interes', 25),
    (57, 'Logotipo', 17),
    (58, 'Calendario Editorial', 12),
    (59, 'Blog', 8),
    (60, 'Directorios', 15),
    (61, 'Video', 10),
    (62, 'Micro Influencers', 8),
    (63, 'SEO Off-page', 14),
    (64, 'Feed', 16),
    (65, 'Reporte Mensual', 23),
    (66, 'Casos de Exito', 13),
    (67, 'Carrusel', 25),
    (68, 'Branding Kit', 18),
    (69, 'Dashboard', 17),
    (70, 'Landing Pages', 21),
    (71, 'Listas', 7),
    (72, 'Heatmaps', 10),
    (73, 'Ficha de Google', 22),
    (74, 'Velocidad de Carga', 13),
    (75, 'A/B Testing', 23),
    (76, 'Palabras Clave', 10),
    (77, 'Newsletter Semanal 2', 13),
    (78, 'Datos Estructurados 2', 8),
    (79, 'Fotografia 2', 19),
    (80, 'UTM Tracking 2', 10);

-- ============================================
-- CONSULTA 1: SELF JOIN básico (INNER JOIN)
-- Muestra categoría hija y su categoría padre. Excluye raíces.
-- ============================================

SELECT
    child.name  AS categoria,
    parent.name AS categoria_padre
FROM service_categories child
INNER JOIN service_categories parent ON child.parent_id = parent.id;

-- ============================================
-- CONSULTA 2: Incluir la raíz con LEFT JOIN
-- Usa COALESCE para etiquetar la raíz
-- ============================================

SELECT
    child.name                          AS categoria,
    COALESCE(parent.name, 'Área raíz')  AS categoria_padre
FROM service_categories child
LEFT JOIN service_categories parent ON child.parent_id = parent.id
ORDER BY categoria_padre, categoria;

-- ============================================
-- CONSULTA 3: Contar hijos por padre
-- Cuántas subcategorías directas tiene cada categoría
-- ============================================

SELECT
    parent.name       AS categoria_padre,
    COUNT(child.id)   AS total_subcategorias
FROM service_categories parent
LEFT JOIN service_categories child ON child.parent_id = parent.id
GROUP BY parent.id, parent.name
HAVING COUNT(child.id) > 0
ORDER BY total_subcategorias DESC;

-- ============================================
-- CONSULTA 4: Tres niveles jerárquicos
-- categoría → servicio → área de servicio (raíz)
-- ============================================

SELECT
    child.name       AS categoria,
    parent.name      AS servicio,
    grandparent.name AS area_de_servicio
FROM service_categories child
LEFT JOIN service_categories parent      ON child.parent_id  = parent.id
LEFT JOIN service_categories grandparent ON parent.parent_id = grandparent.id
ORDER BY area_de_servicio, servicio, categoria;

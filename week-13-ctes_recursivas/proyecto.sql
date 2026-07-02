-- ============================================
-- PROYECTO SEMANAL: Jerarquías con CTEs Recursivas
-- Semana 13 — WITH RECURSIVE
-- PostgreSQL 16
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- Jerarquía: catálogo de servicios de la agencia (3 niveles)
--   Nivel 1: área de servicio   (ej. Paid Media, SEO)
--   Nivel 2: servicio concreto  (ej. Google Ads, SEO Técnico)
--   Nivel 3: entregable         (ej. Reels, Backlinks)

DROP TABLE IF EXISTS service_categories CASCADE;

CREATE TABLE service_categories (
    id        SERIAL  PRIMARY KEY,
    name      TEXT    NOT NULL,
    parent_id INT     REFERENCES service_categories (id)
);

-- 200 categorías: 6 raíces, 25 de nivel 2, 169 hojas de nivel 3
-- (el orden del INSERT determina el id SERIAL, por eso los
-- parent_id se referencian por posición dentro de esta misma lista)
INSERT INTO service_categories (name, parent_id) VALUES
    ('Paid Media', NULL),
    ('SEO', NULL),
    ('Redes Sociales', NULL),
    ('Contenido y Branding', NULL),
    ('Email Marketing', NULL),
    ('Analitica y Datos', NULL),
    ('Google Ads', 1),
    ('Meta Ads', 1),
    ('TikTok Ads', 1),
    ('LinkedIn Ads', 1),
    ('X Ads', 1),
    ('SEO Tecnico', 2),
    ('SEO Local', 2),
    ('Link Building', 2),
    ('SEO de Contenidos', 2),
    ('Gestion de Comunidad', 3),
    ('Influencer Marketing', 3),
    ('Social Ads', 3),
    ('Diseno de Contenido Social', 3),
    ('Diseno Grafico', 4),
    ('Copywriting', 4),
    ('Produccion Audiovisual', 4),
    ('Identidad de Marca', 4),
    ('Fotografia de Producto', 4),
    ('Automatizacion', 5),
    ('Newsletters', 5),
    ('Segmentacion', 5),
    ('Landing Pages', 5),
    ('Reportes de Rendimiento', 6),
    ('Seguimiento de Conversiones', 6),
    ('Investigacion de Mercado', 6),
    ('Proyecciones de Gasto', 14),
    ('Encuestas', 7),
    ('Ebooks', 23),
    ('SEO Off-page', 24),
    ('Manual de Marca', 28),
    ('Focus Groups', 30),
    ('Pixel de Conversion', 20),
    ('Programas de Referidos', 13),
    ('Testimonios', 22),
    ('Paneles en Tiempo Real', 22),
    ('Anuncios en Reels', 14),
    ('Logotipo', 8),
    ('Segmentacion RFM', 13),
    ('Anuncios en Historias', 23),
    ('Recuperacion de Carrito', 21),
    ('Velocidad de Carga', 9),
    ('Casos de Exito', 31),
    ('Plantillas Social', 27),
    ('Remarketing', 16),
    ('Busqueda', 30),
    ('Carrito Abandonado', 19),
    ('Atribucion Multicanal', 8),
    ('Analisis de Competencia', 7),
    ('SEO On-page', 7),
    ('Anuncios en Feed', 16),
    ('Cupones', 26),
    ('Ficha de Google', 8),
    ('Segmentos por Interes', 15),
    ('Optimizacion CRO', 11),
    ('Auditoria', 11),
    ('A/B Testing', 21),
    ('Chatbots', 7),
    ('Benchmarking', 29),
    ('Stories', 21),
    ('Directorios', 12),
    ('Cupones Digitales', 7),
    ('Alertas de Rendimiento', 20),
    ('UTM Tracking', 15),
    ('Paletas Secundarias', 14),
    ('Editorial', 21),
    ('Backlinks', 25),
    ('Flujos de Bienvenida', 23),
    ('Pruebas Multivariantes', 26),
    ('Automatizacion de Bienvenida', 23),
    ('Reporte Mensual', 13),
    ('Mapas de Calor', 11),
    ('Transmisiones', 7),
    ('Analisis de Embudo', 10),
    ('Palabras Clave', 21),
    ('Video Largo', 21),
    ('Encuestas NPS', 8),
    ('Formularios', 30),
    ('Reporte Semanal', 27),
    ('Google Analytics', 10),
    ('Fidelizacion', 30),
    ('Calendario Editorial', 7),
    ('Motion Graphics', 29),
    ('Carrusel', 29),
    ('Pop-ups', 9),
    ('Branding Kit', 13),
    ('Reportes por Cliente', 23),
    ('Guiones de Venta', 28),
    ('Iconografia', 29),
    ('Guion', 10),
    ('Guias de Estilo', 20),
    ('Infografias', 22),
    ('Micro Influencers', 8),
    ('Macro Influencers', 10),
    ('Colaboraciones de Marca', 27),
    ('Paleta de Color', 14),
    ('Plantillas', 27),
    ('Eventos en Vivo', 23),
    ('Anuncios de Catalogo', 30),
    ('Webinars', 14),
    ('Resenas', 29),
    ('Heatmaps', 31),
    ('Datos Estructurados', 12),
    ('Tipografia', 20),
    ('Moderacion', 9),
    ('Listas', 21),
    ('Reels', 28),
    ('Podcasts', 14),
    ('Programas VIP', 30),
    ('Fotografia', 29),
    ('Campanas de Reactivacion', 30),
    ('Shopping', 18),
    ('Blog', 20),
    ('Video Corto', 12),
    ('Segmentacion Geografica', 19),
    ('Display', 27),
    ('Newsletter Semanal', 23),
    ('Regalos Promocionales', 7),
    ('Banners', 8),
    ('Video', 8),
    ('Reportes Ejecutivos', 30),
    ('Analisis de Cohortes', 31),
    ('Dashboard', 23),
    ('Feed', 21),
    ('Proyecciones de Gasto 2', 28),
    ('Encuestas 2', 31),
    ('Ebooks 2', 29),
    ('SEO Off-page 2', 8),
    ('Manual de Marca 2', 8),
    ('Focus Groups 2', 14),
    ('Pixel de Conversion 2', 22),
    ('Programas de Referidos 2', 11),
    ('Testimonios 2', 20),
    ('Paneles en Tiempo Real 2', 29),
    ('Anuncios en Reels 2', 28),
    ('Logotipo 2', 8),
    ('Segmentacion RFM 2', 12),
    ('Anuncios en Historias 2', 11),
    ('Recuperacion de Carrito 2', 19),
    ('Velocidad de Carga 2', 19),
    ('Casos de Exito 2', 30),
    ('Plantillas Social 2', 7),
    ('Remarketing 2', 11),
    ('Busqueda 2', 25),
    ('Carrito Abandonado 2', 22),
    ('Atribucion Multicanal 2', 18),
    ('Analisis de Competencia 2', 22),
    ('SEO On-page 2', 10),
    ('Anuncios en Feed 2', 12),
    ('Cupones 2', 21),
    ('Ficha de Google 2', 11),
    ('Segmentos por Interes 2', 20),
    ('Optimizacion CRO 2', 10),
    ('Auditoria 2', 8),
    ('A/B Testing 2', 23),
    ('Chatbots 2', 19),
    ('Benchmarking 2', 11),
    ('Stories 2', 25),
    ('Directorios 2', 29),
    ('Cupones Digitales 2', 29),
    ('Alertas de Rendimiento 2', 19),
    ('UTM Tracking 2', 24),
    ('Paletas Secundarias 2', 12),
    ('Editorial 2', 8),
    ('Backlinks 2', 24),
    ('Flujos de Bienvenida 2', 29),
    ('Pruebas Multivariantes 2', 19),
    ('Automatizacion de Bienvenida 2', 29),
    ('Reporte Mensual 2', 21),
    ('Mapas de Calor 2', 11),
    ('Transmisiones 2', 18),
    ('Analisis de Embudo 2', 17),
    ('Palabras Clave 2', 20),
    ('Video Largo 2', 23),
    ('Encuestas NPS 2', 25),
    ('Formularios 2', 21),
    ('Reporte Semanal 2', 14),
    ('Google Analytics 2', 31),
    ('Fidelizacion 2', 21),
    ('Calendario Editorial 2', 22),
    ('Motion Graphics 2', 20),
    ('Carrusel 2', 24),
    ('Pop-ups 2', 18),
    ('Branding Kit 2', 12),
    ('Reportes por Cliente 2', 17),
    ('Guiones de Venta 2', 20),
    ('Iconografia 2', 17),
    ('Guion 2', 14),
    ('Guias de Estilo 2', 12),
    ('Infografias 2', 31),
    ('Micro Influencers 2', 19),
    ('Macro Influencers 2', 27),
    ('Colaboraciones de Marca 2', 25),
    ('Paleta de Color 2', 19),
    ('Plantillas 2', 12);

-- ============================================
-- CONSULTA 1: Árbol completo con depth y path
-- Recorre todos los nodos desde la raíz
-- ============================================

WITH RECURSIVE arbol AS (
    -- Caso base: categorías raíz (áreas de servicio)
    SELECT
        id,
        name,
        parent_id,
        1        AS depth,
        name     AS path
    FROM service_categories
    WHERE parent_id IS NULL

    UNION ALL

    -- Caso recursivo: categorías hijas
    SELECT
        n.id,
        n.name,
        n.parent_id,
        a.depth + 1,
        a.path || ' > ' || n.name
    FROM service_categories n
    INNER JOIN arbol a ON n.parent_id = a.id
)
SELECT
    depth,
    REPEAT('  ', depth - 1) || name AS indented_name,
    path
FROM arbol
ORDER BY path;

-- ============================================
-- CONSULTA 2: Categorías de un nivel específico
-- Filtra solo las categorías de nivel 2 (servicios concretos)
-- ============================================

WITH RECURSIVE arbol AS (
    SELECT id, name, parent_id, 1 AS depth, name AS path
    FROM service_categories
    WHERE parent_id IS NULL
    UNION ALL
    SELECT n.id, n.name, n.parent_id, a.depth + 1, a.path || ' > ' || n.name
    FROM service_categories n
    INNER JOIN arbol a ON n.parent_id = a.id
)
SELECT name, depth, path
FROM arbol
WHERE depth = 2
ORDER BY path;

-- ============================================
-- CONSULTA 3: Hojas del árbol (entregables sin subcategorías)
-- ============================================

SELECT
    n.id,
    n.name
FROM service_categories n
WHERE NOT EXISTS (
    SELECT 1
    FROM service_categories child
    WHERE child.parent_id = n.id
)
ORDER BY n.name;

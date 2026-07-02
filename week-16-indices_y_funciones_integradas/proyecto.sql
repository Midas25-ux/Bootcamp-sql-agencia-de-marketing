-- ============================================
-- PROYECTO SEMANAL: Índices y Consultas Optimizadas
-- Semana 16 — Índices B-tree + Funciones integradas
-- PostgreSQL 16
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- categories -> services   (catálogo de servicios de la agencia)
-- records    -> invoices   (facturas emitidas a clientes)

DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS services CASCADE;

CREATE TABLE services (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE invoices (
    id          SERIAL         PRIMARY KEY,
    name        TEXT           NOT NULL,   -- nombre del cliente facturado
    description TEXT,
    service_id  INT            REFERENCES services (id),
    price       NUMERIC(10, 2),
    created_at  DATE           NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO services (name) VALUES
    ('Gestion de Google Ads'),
    ('Gestion de Meta Ads'),
    ('Gestion de TikTok Ads'),
    ('Gestion de LinkedIn Ads'),
    ('Email Marketing'),
    ('Posicionamiento SEO'),
    ('Diseno de Contenido'),
    ('Auditoria de Marketing Digital');

-- 200 facturas emitidas entre 2020 y 2025
INSERT INTO invoices (name, description, service_id, price, created_at) VALUES
    ('Corporacion Buenavista', 'Factura mensual por Posicionamiento SEO', 6, 1887.72, '2024-06-23'),
    ('Clinica Mirador', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3374.48, '2023-01-09'),
    ('Corporacion Rio Claro', 'Factura mensual por Gestion de Google Ads', 1, 1144.56, '2023-07-17'),
    ('Tienda Los Pinos', 'Factura mensual por Email Marketing', 5, 3773.26, '2022-12-22'),
    ('Distribuidora Andes', 'Factura mensual por Email Marketing', 5, 938.35, '2025-12-22'),
    ('Corporacion Sur', 'Factura mensual por Gestion de TikTok Ads', 3, 822.70, '2023-05-23'),
    ('Grupo Las Palmas', 'Factura mensual por Email Marketing', 5, 1759.34, '2025-09-23'),
    ('Grupo La Colina', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3370.62, '2024-08-18'),
    ('Estudio Norte', 'Factura mensual por Email Marketing', 5, 2751.71, '2020-11-20'),
    ('Corporacion Las Palmas', 'Factura mensual por Gestion de Google Ads', 1, 3392.89, '2024-05-10'),
    ('Comercial San Rafael', 'Factura mensual por Gestion de Google Ads', 1, 2353.22, '2021-04-22'),
    ('Boutique San Rafael', 'Factura mensual por Gestion de Google Ads', 1, 236.71, '2020-08-22'),
    ('Grupo Santa Elena', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2373.86, '2020-03-15'),
    ('Corporacion Norte', 'Factura mensual por Gestion de TikTok Ads', 3, 1480.33, '2024-07-13'),
    ('Estudio Rio Claro', 'Factura mensual por Email Marketing', 5, 779.35, '2022-12-16'),
    ('Grupo Bosque Verde', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2205.24, '2022-11-28'),
    ('Boutique Pacifico', 'Factura mensual por Gestion de Meta Ads', 2, 3706.35, '2025-05-06'),
    ('Clinica Sierra', 'Factura mensual por Gestion de LinkedIn Ads', 4, 1394.54, '2023-10-06'),
    ('Corporacion Central', 'Factura mensual por Gestion de Google Ads', 1, 3431.30, '2022-02-05'),
    ('Boutique El Roble', 'Factura mensual por Auditoria de Marketing Digital', 8, 2596.48, '2023-11-09'),
    ('Distribuidora Santa Elena', 'Factura mensual por Auditoria de Marketing Digital', 8, 3425.36, '2021-01-26'),
    ('Boutique Mirador', 'Factura mensual por Gestion de Google Ads', 1, 857.69, '2023-11-13'),
    ('Estudio Pacifico', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3463.41, '2022-07-17'),
    ('Comercial Central', 'Factura mensual por Gestion de Meta Ads', 2, 977.37, '2021-03-05'),
    ('Corporacion Central', 'Factura mensual por Diseno de Contenido', 7, 2518.28, '2021-05-22'),
    ('Boutique Del Valle', 'Factura mensual por Gestion de Google Ads', 1, 3534.30, '2025-11-27'),
    ('Boutique Sur', 'Factura mensual por Auditoria de Marketing Digital', 8, 326.50, '2023-03-21'),
    ('Clinica Mirador', 'Factura mensual por Gestion de Meta Ads', 2, 1171.54, '2021-10-13'),
    ('Servicios Sur', 'Factura mensual por Auditoria de Marketing Digital', 8, 3926.00, '2024-06-14'),
    ('Corporacion La Marina', 'Factura mensual por Email Marketing', 5, 2996.57, '2022-01-20'),
    ('Clinica La Colina', 'Factura mensual por Gestion de Meta Ads', 2, 3388.04, '2025-10-08'),
    ('Servicios San Rafael', 'Factura mensual por Posicionamiento SEO', 6, 837.76, '2023-05-23'),
    ('Boutique Cordillera', 'Factura mensual por Gestion de TikTok Ads', 3, 3290.80, '2024-10-11'),
    ('Clinica La Colina', 'Factura mensual por Gestion de TikTok Ads', 3, 961.27, '2021-01-11'),
    ('Corporacion Central', 'Factura mensual por Gestion de Meta Ads', 2, 3677.68, '2021-01-16'),
    ('Servicios El Roble', 'Factura mensual por Diseno de Contenido', 7, 3831.83, '2022-05-01'),
    ('Grupo Cordillera', 'Factura mensual por Gestion de LinkedIn Ads', 4, 456.49, '2025-04-25'),
    ('Restaurante Las Palmas', 'Factura mensual por Diseno de Contenido', 7, 1580.21, '2024-03-15'),
    ('Distribuidora Alameda', 'Factura mensual por Gestion de TikTok Ads', 3, 3142.53, '2020-06-23'),
    ('Servicios Bosque Verde', 'Factura mensual por Gestion de TikTok Ads', 3, 855.83, '2023-05-14'),
    ('Boutique Mirador', 'Factura mensual por Gestion de TikTok Ads', 3, 3649.71, '2023-12-07'),
    ('Distribuidora Cordillera', 'Factura mensual por Gestion de TikTok Ads', 3, 2986.91, '2023-08-23'),
    ('Tienda Los Pinos', 'Factura mensual por Diseno de Contenido', 7, 718.39, '2021-06-11'),
    ('Restaurante Buenavista', 'Factura mensual por Auditoria de Marketing Digital', 8, 3477.70, '2021-06-10'),
    ('Estudio Alameda', 'Factura mensual por Gestion de Meta Ads', 2, 1086.30, '2020-03-27'),
    ('Tienda Alameda', 'Factura mensual por Gestion de LinkedIn Ads', 4, 1207.40, '2022-12-05'),
    ('Distribuidora El Roble', 'Factura mensual por Auditoria de Marketing Digital', 8, 3809.35, '2024-10-09'),
    ('Restaurante Buenavista', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3729.71, '2020-12-28'),
    ('Comercial Andes', 'Factura mensual por Diseno de Contenido', 7, 262.56, '2023-03-07'),
    ('Distribuidora Sur', 'Factura mensual por Gestion de Google Ads', 1, 3592.73, '2023-11-04'),
    ('Estudio Los Pinos', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2622.20, '2023-04-24'),
    ('Tienda Bosque Verde', 'Factura mensual por Gestion de TikTok Ads', 3, 1769.85, '2023-03-03'),
    ('Boutique Pacifico', 'Factura mensual por Gestion de Google Ads', 1, 4332.14, '2020-11-25'),
    ('Boutique Rio Claro', 'Factura mensual por Gestion de Meta Ads', 2, 674.35, '2023-03-04'),
    ('Tienda Santa Elena', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3660.44, '2023-10-24'),
    ('Comercial Los Pinos', 'Factura mensual por Gestion de Google Ads', 1, 1883.89, '2021-01-07'),
    ('Servicios Santa Elena', 'Factura mensual por Gestion de Google Ads', 1, 3644.94, '2022-01-27'),
    ('Distribuidora La Colina', 'Factura mensual por Gestion de Meta Ads', 2, 3975.21, '2024-10-27'),
    ('Comercial Andes', 'Factura mensual por Gestion de TikTok Ads', 3, 4144.39, '2024-05-13'),
    ('Clinica La Colina', 'Factura mensual por Gestion de Google Ads', 1, 1549.81, '2024-10-23'),
    ('Servicios Mirador', 'Factura mensual por Gestion de TikTok Ads', 3, 702.73, '2025-11-09'),
    ('Tienda Pacifico', 'Factura mensual por Gestion de TikTok Ads', 3, 4125.68, '2024-03-21'),
    ('Grupo Norte', 'Factura mensual por Gestion de Google Ads', 1, 3932.23, '2024-04-06'),
    ('Tienda Rio Claro', 'Factura mensual por Gestion de TikTok Ads', 3, 2936.46, '2025-10-02'),
    ('Comercial Sur', 'Factura mensual por Auditoria de Marketing Digital', 8, 3399.83, '2024-11-27'),
    ('Tienda Las Palmas', 'Factura mensual por Diseno de Contenido', 7, 3895.99, '2023-03-25'),
    ('Grupo Pacifico', 'Factura mensual por Gestion de Google Ads', 1, 1316.53, '2021-07-04'),
    ('Tienda Central', 'Factura mensual por Diseno de Contenido', 7, 2499.29, '2023-05-20'),
    ('Corporacion Las Palmas', 'Factura mensual por Gestion de LinkedIn Ads', 4, 1598.16, '2021-02-13'),
    ('Servicios El Roble', 'Factura mensual por Posicionamiento SEO', 6, 1791.17, '2022-12-21'),
    ('Servicios Buenavista', 'Factura mensual por Diseno de Contenido', 7, 4497.68, '2025-12-22'),
    ('Comercial Las Palmas', 'Factura mensual por Gestion de TikTok Ads', 3, 3705.87, '2022-02-15'),
    ('Comercial Norte', 'Factura mensual por Email Marketing', 5, 2156.31, '2022-09-02'),
    ('Distribuidora Norte', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3888.83, '2020-09-09'),
    ('Corporacion Las Palmas', 'Factura mensual por Email Marketing', 5, 4178.96, '2021-10-16'),
    ('Distribuidora San Rafael', 'Factura mensual por Auditoria de Marketing Digital', 8, 3942.86, '2021-11-07'),
    ('Servicios La Colina', 'Factura mensual por Diseno de Contenido', 7, 2486.58, '2022-08-04'),
    ('Estudio Mirador', 'Factura mensual por Email Marketing', 5, 356.54, '2025-02-02'),
    ('Estudio Del Valle', 'Factura mensual por Email Marketing', 5, 3600.68, '2022-04-18'),
    ('Estudio Central', 'Factura mensual por Email Marketing', 5, 4411.72, '2020-02-15'),
    ('Boutique Cordillera', 'Factura mensual por Auditoria de Marketing Digital', 8, 861.79, '2025-10-24'),
    ('Clinica Cordillera', 'Factura mensual por Gestion de Google Ads', 1, 2979.13, '2024-12-01'),
    ('Distribuidora Santa Elena', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3985.49, '2021-11-28'),
    ('Distribuidora Rio Claro', 'Factura mensual por Posicionamiento SEO', 6, 731.80, '2023-05-04'),
    ('Comercial Santa Elena', 'Factura mensual por Email Marketing', 5, 832.84, '2020-12-27'),
    ('Servicios Del Valle', 'Factura mensual por Gestion de Google Ads', 1, 3468.58, '2025-09-07'),
    ('Distribuidora Rio Claro', 'Factura mensual por Email Marketing', 5, 1183.88, '2025-01-03'),
    ('Restaurante Los Pinos', 'Factura mensual por Auditoria de Marketing Digital', 8, 4180.82, '2025-06-04'),
    ('Restaurante Cordillera', 'Factura mensual por Posicionamiento SEO', 6, 2081.60, '2025-02-23'),
    ('Restaurante Cordillera', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2927.96, '2023-12-28'),
    ('Comercial La Marina', 'Factura mensual por Gestion de TikTok Ads', 3, 1306.00, '2021-04-04'),
    ('Boutique Del Valle', 'Factura mensual por Auditoria de Marketing Digital', 8, 2506.90, '2021-03-23'),
    ('Servicios El Roble', 'Factura mensual por Gestion de TikTok Ads', 3, 2653.96, '2024-10-10'),
    ('Corporacion Sierra', 'Factura mensual por Gestion de Meta Ads', 2, 2943.94, '2020-06-21'),
    ('Boutique Central', 'Factura mensual por Gestion de Meta Ads', 2, 331.10, '2022-06-09'),
    ('Comercial San Rafael', 'Factura mensual por Diseno de Contenido', 7, 2267.59, '2021-09-01'),
    ('Comercial Andes', 'Factura mensual por Diseno de Contenido', 7, 3784.99, '2025-12-04'),
    ('Corporacion Cordillera', 'Factura mensual por Gestion de TikTok Ads', 3, 494.89, '2022-03-22'),
    ('Restaurante La Colina', 'Factura mensual por Auditoria de Marketing Digital', 8, 209.21, '2024-03-25'),
    ('Restaurante Sierra', 'Factura mensual por Gestion de TikTok Ads', 3, 1611.33, '2021-05-04'),
    ('Corporacion Pacifico', 'Factura mensual por Gestion de TikTok Ads', 3, 1800.39, '2024-11-13'),
    ('Comercial Buenavista', 'Factura mensual por Gestion de TikTok Ads', 3, 3638.24, '2023-11-18'),
    ('Comercial San Rafael', 'Factura mensual por Email Marketing', 5, 2694.48, '2023-08-01'),
    ('Corporacion Central', 'Factura mensual por Gestion de Google Ads', 1, 322.63, '2020-09-10'),
    ('Distribuidora El Roble', 'Factura mensual por Posicionamiento SEO', 6, 489.85, '2021-06-08'),
    ('Comercial Central', 'Factura mensual por Gestion de Google Ads', 1, 1804.20, '2022-03-24'),
    ('Clinica Del Valle', 'Factura mensual por Email Marketing', 5, 4136.10, '2020-05-05'),
    ('Boutique Cordillera', 'Factura mensual por Posicionamiento SEO', 6, 4287.99, '2020-03-08'),
    ('Corporacion Buenavista', 'Factura mensual por Posicionamiento SEO', 6, 710.39, '2024-02-14'),
    ('Restaurante Sierra', 'Factura mensual por Diseno de Contenido', 7, 3290.42, '2022-03-08'),
    ('Boutique Del Valle', 'Factura mensual por Diseno de Contenido', 7, 3311.47, '2022-04-28'),
    ('Comercial Norte', 'Factura mensual por Gestion de TikTok Ads', 3, 3303.91, '2025-09-24'),
    ('Comercial Santa Elena', 'Factura mensual por Diseno de Contenido', 7, 2963.19, '2025-03-07'),
    ('Corporacion Santa Elena', 'Factura mensual por Gestion de LinkedIn Ads', 4, 435.51, '2021-07-06'),
    ('Boutique Andes', 'Factura mensual por Posicionamiento SEO', 6, 2761.25, '2025-06-11'),
    ('Estudio Pacifico', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3414.47, '2024-11-27'),
    ('Grupo Las Palmas', 'Factura mensual por Gestion de Meta Ads', 2, 2185.04, '2021-11-04'),
    ('Restaurante La Marina', 'Factura mensual por Posicionamiento SEO', 6, 2888.64, '2023-06-17'),
    ('Distribuidora El Roble', 'Factura mensual por Gestion de Google Ads', 1, 1050.21, '2023-07-23'),
    ('Restaurante Buenavista', 'Factura mensual por Posicionamiento SEO', 6, 4072.67, '2022-06-27'),
    ('Grupo Alameda', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3425.78, '2025-05-26'),
    ('Restaurante Las Palmas', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2988.14, '2020-07-20'),
    ('Comercial Las Palmas', 'Factura mensual por Gestion de Google Ads', 1, 408.38, '2021-05-23'),
    ('Comercial Cordillera', 'Factura mensual por Gestion de Google Ads', 1, 1342.25, '2022-08-01'),
    ('Estudio Pacifico', 'Factura mensual por Gestion de TikTok Ads', 3, 306.35, '2020-06-04'),
    ('Grupo Andes', 'Factura mensual por Gestion de Meta Ads', 2, 1782.03, '2022-06-27'),
    ('Corporacion Mirador', 'Factura mensual por Diseno de Contenido', 7, 4029.45, '2022-05-04'),
    ('Comercial Rio Claro', 'Factura mensual por Diseno de Contenido', 7, 439.11, '2023-12-19'),
    ('Grupo Norte', 'Factura mensual por Gestion de TikTok Ads', 3, 3491.32, '2023-09-04'),
    ('Boutique Santa Elena', 'Factura mensual por Gestion de TikTok Ads', 3, 433.20, '2022-07-12'),
    ('Grupo Las Palmas', 'Factura mensual por Gestion de Google Ads', 1, 2827.09, '2022-09-19'),
    ('Distribuidora Del Valle', 'Factura mensual por Email Marketing', 5, 2224.52, '2023-11-25'),
    ('Clinica Del Valle', 'Factura mensual por Posicionamiento SEO', 6, 705.76, '2025-08-13'),
    ('Servicios Cordillera', 'Factura mensual por Gestion de TikTok Ads', 3, 241.78, '2025-10-06'),
    ('Comercial Buenavista', 'Factura mensual por Gestion de LinkedIn Ads', 4, 215.99, '2020-01-25'),
    ('Distribuidora Central', 'Factura mensual por Auditoria de Marketing Digital', 8, 2645.44, '2024-05-27'),
    ('Corporacion La Marina', 'Factura mensual por Diseno de Contenido', 7, 2662.77, '2022-12-25'),
    ('Clinica Alameda', 'Factura mensual por Posicionamiento SEO', 6, 1696.58, '2020-09-18'),
    ('Boutique Santa Elena', 'Factura mensual por Auditoria de Marketing Digital', 8, 717.50, '2025-10-07'),
    ('Grupo Central', 'Factura mensual por Auditoria de Marketing Digital', 8, 2466.67, '2023-06-12'),
    ('Comercial Central', 'Factura mensual por Gestion de TikTok Ads', 3, 2239.10, '2023-01-21'),
    ('Boutique Central', 'Factura mensual por Auditoria de Marketing Digital', 8, 2805.34, '2025-06-12'),
    ('Corporacion Mirador', 'Factura mensual por Gestion de LinkedIn Ads', 4, 459.63, '2020-09-06'),
    ('Restaurante Las Palmas', 'Factura mensual por Gestion de TikTok Ads', 3, 2826.20, '2020-01-14'),
    ('Distribuidora Rio Claro', 'Factura mensual por Auditoria de Marketing Digital', 8, 485.10, '2021-04-18'),
    ('Distribuidora El Roble', 'Factura mensual por Diseno de Contenido', 7, 3790.43, '2025-08-01'),
    ('Estudio Cordillera', 'Factura mensual por Gestion de Google Ads', 1, 1897.74, '2025-04-14'),
    ('Tienda Mirador', 'Factura mensual por Email Marketing', 5, 1820.42, '2020-11-08'),
    ('Tienda Norte', 'Factura mensual por Posicionamiento SEO', 6, 1149.15, '2023-08-08'),
    ('Comercial Las Palmas', 'Factura mensual por Gestion de Google Ads', 1, 1850.59, '2023-10-14'),
    ('Servicios Norte', 'Factura mensual por Gestion de LinkedIn Ads', 4, 4288.85, '2023-02-01'),
    ('Corporacion Cordillera', 'Factura mensual por Diseno de Contenido', 7, 1300.61, '2022-07-16'),
    ('Comercial Pacifico', 'Factura mensual por Gestion de LinkedIn Ads', 4, 539.04, '2025-12-20'),
    ('Boutique Sur', 'Factura mensual por Gestion de TikTok Ads', 3, 323.61, '2022-03-21'),
    ('Distribuidora Rio Claro', 'Factura mensual por Gestion de Google Ads', 1, 2465.67, '2021-01-22'),
    ('Boutique Mirador', 'Factura mensual por Gestion de Google Ads', 1, 1155.19, '2022-11-25'),
    ('Boutique Bosque Verde', 'Factura mensual por Auditoria de Marketing Digital', 8, 2111.86, '2022-07-12'),
    ('Grupo Del Valle', 'Factura mensual por Gestion de Google Ads', 1, 4240.84, '2022-10-06'),
    ('Clinica Andes', 'Factura mensual por Diseno de Contenido', 7, 3862.00, '2021-03-27'),
    ('Servicios La Colina', 'Factura mensual por Auditoria de Marketing Digital', 8, 3811.98, '2021-12-05'),
    ('Clinica Buenavista', 'Factura mensual por Email Marketing', 5, 1642.75, '2021-08-18'),
    ('Comercial Andes', 'Factura mensual por Gestion de Google Ads', 1, 1897.73, '2022-05-05'),
    ('Servicios La Colina', 'Factura mensual por Email Marketing', 5, 3068.47, '2025-12-21'),
    ('Distribuidora Mirador', 'Factura mensual por Gestion de LinkedIn Ads', 4, 1320.21, '2021-09-08'),
    ('Comercial El Roble', 'Factura mensual por Diseno de Contenido', 7, 1603.05, '2020-01-19'),
    ('Tienda Central', 'Factura mensual por Gestion de Meta Ads', 2, 3620.27, '2020-09-26'),
    ('Grupo Andes', 'Factura mensual por Gestion de Meta Ads', 2, 1019.31, '2022-06-14'),
    ('Corporacion Andes', 'Factura mensual por Gestion de TikTok Ads', 3, 150.34, '2025-11-15'),
    ('Estudio Los Pinos', 'Factura mensual por Gestion de Google Ads', 1, 1007.59, '2024-12-11'),
    ('Tienda Alameda', 'Factura mensual por Gestion de Google Ads', 1, 3422.05, '2024-07-02'),
    ('Estudio Cordillera', 'Factura mensual por Posicionamiento SEO', 6, 2558.88, '2022-09-28'),
    ('Clinica Alameda', 'Factura mensual por Auditoria de Marketing Digital', 8, 1245.56, '2022-09-08'),
    ('Grupo Las Palmas', 'Factura mensual por Auditoria de Marketing Digital', 8, 3812.34, '2021-05-09'),
    ('Clinica Del Valle', 'Factura mensual por Gestion de Meta Ads', 2, 2491.71, '2023-08-21'),
    ('Clinica Mirador', 'Factura mensual por Gestion de Google Ads', 1, 3090.92, '2025-12-15'),
    ('Corporacion Andes', 'Factura mensual por Gestion de Meta Ads', 2, 3393.01, '2024-01-23'),
    ('Tienda Cordillera', 'Factura mensual por Gestion de TikTok Ads', 3, 1947.54, '2021-12-20'),
    ('Distribuidora Norte', 'Factura mensual por Gestion de Google Ads', 1, 722.32, '2023-03-18'),
    ('Servicios Rio Claro', 'Factura mensual por Gestion de Google Ads', 1, 2669.96, '2023-04-04'),
    ('Servicios Las Palmas', 'Factura mensual por Gestion de LinkedIn Ads', 4, 3965.42, '2020-08-13'),
    ('Boutique Bosque Verde', 'Factura mensual por Auditoria de Marketing Digital', 8, 227.21, '2021-05-24'),
    ('Corporacion Rio Claro', 'Factura mensual por Gestion de Google Ads', 1, 3365.46, '2022-04-09'),
    ('Servicios Pacifico', 'Factura mensual por Gestion de Meta Ads', 2, 1177.97, '2020-09-07'),
    ('Comercial El Roble', 'Factura mensual por Gestion de TikTok Ads', 3, 3108.88, '2020-09-23'),
    ('Servicios Las Palmas', 'Factura mensual por Gestion de Meta Ads', 2, 1151.42, '2023-10-13'),
    ('Clinica Central', 'Factura mensual por Diseno de Contenido', 7, 2098.04, '2020-12-06'),
    ('Tienda Norte', 'Factura mensual por Email Marketing', 5, 1891.27, '2021-10-01'),
    ('Comercial San Rafael', 'Factura mensual por Gestion de LinkedIn Ads', 4, 1333.24, '2020-07-13'),
    ('Servicios Mirador', 'Factura mensual por Email Marketing', 5, 3804.65, '2022-03-05'),
    ('Servicios San Rafael', 'Factura mensual por Gestion de Meta Ads', 2, 585.76, '2022-04-17'),
    ('Estudio Santa Elena', 'Factura mensual por Auditoria de Marketing Digital', 8, 2018.98, '2025-11-09'),
    ('Tienda Buenavista', 'Factura mensual por Gestion de TikTok Ads', 3, 2433.98, '2024-01-04'),
    ('Clinica Santa Elena', 'Factura mensual por Gestion de TikTok Ads', 3, 4346.17, '2025-12-26'),
    ('Restaurante Mirador', 'Factura mensual por Gestion de TikTok Ads', 3, 478.43, '2020-08-13'),
    ('Servicios Mirador', 'Factura mensual por Posicionamiento SEO', 6, 2017.03, '2022-12-05'),
    ('Corporacion Mirador', 'Factura mensual por Gestion de TikTok Ads', 3, 3972.53, '2020-12-05'),
    ('Servicios San Rafael', 'Factura mensual por Gestion de LinkedIn Ads', 4, 2848.71, '2022-09-20'),
    ('Tienda Central', 'Factura mensual por Posicionamiento SEO', 6, 2876.69, '2025-11-11'),
    ('Corporacion Los Pinos', 'Factura mensual por Auditoria de Marketing Digital', 8, 4484.94, '2024-09-28'),
    ('Servicios San Rafael', 'Factura mensual por Gestion de Meta Ads', 2, 3123.58, '2023-09-03');

-- ============================================
-- CONSULTA 1: Crear un índice y verificar con EXPLAIN
-- ============================================

-- Antes del índice: PostgreSQL recorre toda la tabla (Seq Scan)
EXPLAIN SELECT * FROM invoices WHERE service_id = 3;

CREATE INDEX idx_invoices_service_id ON invoices (service_id);

-- Después del índice: debería aparecer Index Scan / Bitmap Index Scan
EXPLAIN SELECT * FROM invoices WHERE service_id = 3;

-- ============================================
-- CONSULTA 2: Reporte con funciones de texto y fecha
-- ============================================

SELECT
    UPPER(name)                                    AS name_upper,
    TO_CHAR(created_at, 'DD/MM/YYYY')               AS created_fmt,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, created_at)) AS years_old
FROM invoices
ORDER BY created_at;

-- ============================================
-- CONSULTA 3: Reporte numérico con descuento
-- ============================================

SELECT
    name,
    price,
    ROUND(price * 0.85, 2)          AS discounted_price,
    ROUND(price - price * 0.85, 2)  AS savings
FROM invoices
ORDER BY price DESC;

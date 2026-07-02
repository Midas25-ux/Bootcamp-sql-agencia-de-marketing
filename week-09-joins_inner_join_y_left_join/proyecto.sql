-- ============================================
-- PROYECTO SEMANAL: JOINs aplicados a tu dominio
-- Semana 09 — INNER JOIN y LEFT JOIN
-- Dominio: Agencia de Marketing Digital
-- ============================================
-- reference_table -> employees   (empleados de la agencia)
-- main_items      -> campaigns   (campañas asignadas a un empleado)
-- child_records   -> leads       (leads generados por cada campaña)

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS employees;

-- Tabla de referencia: empleados de la agencia
CREATE TABLE employees (
    id         INTEGER PRIMARY KEY,
    name       TEXT    NOT NULL,
    role       TEXT    NOT NULL,
    hire_date  TEXT    NOT NULL,
    email      TEXT    NOT NULL UNIQUE,
    is_active  INTEGER NOT NULL DEFAULT 1
);

-- Tabla principal de tu dominio: campañas
CREATE TABLE campaigns (
    id           INTEGER PRIMARY KEY,
    name         TEXT    NOT NULL,
    channel      TEXT    NOT NULL,
    budget       REAL    NOT NULL CHECK (budget > 0),
    employee_id  INTEGER REFERENCES employees (id)
);

-- Tabla hija: leads capturados por cada campaña
CREATE TABLE leads (
    id           INTEGER PRIMARY KEY,
    full_name    TEXT    NOT NULL,
    email        TEXT    NOT NULL,
    captured_at  TEXT    NOT NULL,
    status       TEXT    NOT NULL DEFAULT 'nuevo',
    campaign_id  INTEGER REFERENCES campaigns (id)
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

INSERT INTO employees (id, name, role, hire_date, email, is_active) VALUES
    (1, 'Sofia Martinez', 'seo_specialist', '2023-10-10', 'sofia.martinez@agencia.com', 1),
    (2, 'Juan Pablo Morales', 'seo_specialist', '2021-05-16', 'juan.pablo.morales@agencia.com', 1),
    (3, 'Valentina Jimenez', 'designer', '2019-11-21', 'valentina.jimenez@agencia.com', 1),
    (4, 'Miguel Castro', 'ads_specialist', '2019-03-18', 'miguel.castro@agencia.com', 1),
    (5, 'Sebastian Rodriguez', 'designer', '2019-02-17', 'sebastian.rodriguez@agencia.com', 1),
    (6, 'Luisa Perez', 'account_manager', '2024-07-03', 'luisa.perez@agencia.com', 0),
    (7, 'Valentina Sanchez', 'designer', '2019-09-14', 'valentina.sanchez@agencia.com', 1),
    (8, 'Oscar Martinez', 'seo_specialist', '2024-06-19', 'oscar.martinez@agencia.com', 1),
    (9, 'Sebastian Mendoza', 'ads_specialist', '2022-06-22', 'sebastian.mendoza@agencia.com', 1),
    (10, 'David Reyes', 'ads_specialist', '2023-01-16', 'david.reyes@agencia.com', 1),
    (11, 'Manuela Ortiz', 'ads_specialist', '2023-12-06', 'manuela.ortiz@agencia.com', 1),
    (12, 'Diego Ramirez', 'account_manager', '2019-10-13', 'diego.ramirez@agencia.com', 1),
    (13, 'Mateo Jimenez', 'account_manager', '2023-09-23', 'mateo.jimenez@agencia.com', 1),
    (14, 'Luisa Sanchez', 'content_creator', '2021-11-22', 'luisa.sanchez@agencia.com', 1),
    (15, 'Sebastian Vargas', 'ads_specialist', '2022-02-12', 'sebastian.vargas@agencia.com', 0),
    (16, 'Alejandro Mendoza', 'account_manager', '2019-10-16', 'alejandro.mendoza@agencia.com', 1),
    (17, 'Maria Jose Lopez', 'designer', '2020-12-14', 'maria.jose.lopez@agencia.com', 1),
    (18, 'Tatiana Mendoza', 'designer', '2019-07-11', 'tatiana.mendoza@agencia.com', 1),
    (19, 'Andrea Gomez', 'account_manager', '2023-07-04', 'andrea.gomez@agencia.com', 1),
    (20, 'Sofia Rodriguez', 'account_manager', '2019-02-12', 'sofia.rodriguez@agencia.com', 1);

-- 80 campañas asignadas a los empleados anteriores
INSERT INTO campaigns (id, name, employee_id, channel, budget) VALUES
    (1, 'Cyber Monday - Cliente 038', 6, 'google_ads', 8300.60),
    (2, 'San Valentin - Cliente 030', 15, 'email_marketing', 8985.69),
    (3, 'Promocion 2x1 - Cliente 017', 12, 'google_ads', 7358.56),
    (4, 'Nueva Coleccion - Cliente 014', 3, 'seo', 2834.68),
    (5, 'Cyber Monday - Cliente 029', 13, 'tiktok_ads', 7831.68),
    (6, 'Expansion Regional - Cliente 023', 18, 'meta_ads', 11747.22),
    (7, 'Regreso a Clases - Cliente 012', 12, 'meta_ads', 4796.76),
    (8, 'Expansion Regional - Cliente 014', 17, 'email_marketing', 9454.72),
    (9, 'Black Friday - Cliente 026', 3, 'meta_ads', 6585.09),
    (10, 'Expansion Regional - Cliente 028', 10, 'meta_ads', 8749.33),
    (11, 'Fidelizacion Clientes - Cliente 023', 19, 'linkedin_ads', 7377.10),
    (12, 'Promocion 2x1 - Cliente 022', 7, 'meta_ads', 6919.38),
    (13, 'Descuento Fin de Mes - Cliente 029', 14, 'linkedin_ads', 994.63),
    (14, 'Temporada Navidad - Cliente 033', 19, 'email_marketing', 2855.21),
    (15, 'Expansion Regional - Cliente 010', 1, 'tiktok_ads', 5088.30),
    (16, 'Remarketing - Cliente 035', 20, 'google_ads', 10979.66),
    (17, 'Regreso a Clases - Cliente 001', 7, 'email_marketing', 6197.61),
    (18, 'Descuento Fin de Mes - Cliente 024', 8, 'google_ads', 10042.03),
    (19, 'Aniversario - Cliente 037', 7, 'meta_ads', 7094.41),
    (20, 'San Valentin - Cliente 019', 9, 'linkedin_ads', 10696.09),
    (21, 'Temporada Navidad - Cliente 004', 20, 'google_ads', 7524.63),
    (22, 'Regreso a Clases - Cliente 012', 11, 'linkedin_ads', 5603.05),
    (23, 'Promocion 2x1 - Cliente 022', 7, 'meta_ads', 6448.69),
    (24, 'Aniversario - Cliente 017', 2, 'tiktok_ads', 2452.28),
    (25, 'Prelanzamiento - Cliente 026', 7, 'google_ads', 2176.86),
    (26, 'Fidelizacion Clientes - Cliente 027', 16, 'email_marketing', 10064.31),
    (27, 'Expansion Regional - Cliente 008', 8, 'google_ads', 3905.02),
    (28, 'Reapertura - Cliente 007', 5, 'meta_ads', 2853.63),
    (29, 'Remarketing - Cliente 001', 20, 'google_ads', 9930.95),
    (30, 'Reapertura - Cliente 035', 17, 'meta_ads', 3573.90),
    (31, 'Remarketing - Cliente 018', 3, 'meta_ads', 7893.39),
    (32, 'Awareness de Marca - Cliente 023', 7, 'google_ads', 1947.55),
    (33, 'Black Friday - Cliente 036', 4, 'email_marketing', 2632.96),
    (34, 'Dia de la Madre - Cliente 011', 1, 'google_ads', 10553.70),
    (35, 'San Valentin - Cliente 014', 15, 'tiktok_ads', 1276.80),
    (36, 'Remarketing - Cliente 024', 11, 'email_marketing', 8285.15),
    (37, 'Regreso a Clases - Cliente 007', 19, 'meta_ads', 11953.19),
    (38, 'Dia de la Madre - Cliente 018', 7, 'seo', 3400.53),
    (39, 'Dia de la Madre - Cliente 034', 17, 'seo', 9517.19),
    (40, 'Temporada Navidad - Cliente 005', 20, 'tiktok_ads', 2005.97),
    (41, 'Promocion 2x1 - Cliente 029', 1, 'meta_ads', 5972.96),
    (42, 'Black Friday - Cliente 039', 3, 'meta_ads', 2785.31),
    (43, 'Temporada Verano - Cliente 039', 5, 'tiktok_ads', 10094.78),
    (44, 'Temporada Verano - Cliente 007', 13, 'meta_ads', 5871.26),
    (45, 'Cyber Monday - Cliente 005', 13, 'linkedin_ads', 3188.61),
    (46, 'Expansion Regional - Cliente 021', 4, 'meta_ads', 5839.30),
    (47, 'Reapertura - Cliente 005', 3, 'meta_ads', 10803.12),
    (48, 'Prelanzamiento - Cliente 005', 19, 'google_ads', 8243.76),
    (49, 'Expansion Regional - Cliente 038', 17, 'google_ads', 11373.51),
    (50, 'Remarketing - Cliente 020', 3, 'meta_ads', 9339.88),
    (51, 'Descuento Fin de Mes - Cliente 018', 11, 'google_ads', 6207.77),
    (52, 'Prelanzamiento - Cliente 019', 4, 'email_marketing', 10958.26),
    (53, 'Promocion 2x1 - Cliente 030', 6, 'meta_ads', 4454.07),
    (54, 'Regreso a Clases - Cliente 009', 20, 'email_marketing', 8787.92),
    (55, 'Promocion 2x1 - Cliente 030', 2, 'google_ads', 6792.67),
    (56, 'Expansion Regional - Cliente 035', 18, 'google_ads', 3221.66),
    (57, 'Prelanzamiento - Cliente 017', 13, 'google_ads', 820.02),
    (58, 'Fidelizacion Clientes - Cliente 025', 10, 'meta_ads', 10800.75),
    (59, 'Prelanzamiento - Cliente 033', 20, 'meta_ads', 11668.39),
    (60, 'Temporada Verano - Cliente 022', 9, 'linkedin_ads', 9754.69),
    (61, 'Awareness de Marca - Cliente 028', 4, 'google_ads', 2360.17),
    (62, 'San Valentin - Cliente 021', 6, 'email_marketing', 6432.09),
    (63, 'Reapertura - Cliente 021', 3, 'meta_ads', 11447.50),
    (64, 'Nueva Coleccion - Cliente 038', 20, 'linkedin_ads', 8376.14),
    (65, 'Dia de la Madre - Cliente 007', 13, 'seo', 9951.50),
    (66, 'Promocion 2x1 - Cliente 038', 15, 'meta_ads', 1463.25),
    (67, 'Aniversario - Cliente 026', 6, 'tiktok_ads', 2075.03),
    (68, 'Aniversario - Cliente 027', 7, 'seo', 5612.90),
    (69, 'Expansion Regional - Cliente 003', 3, 'linkedin_ads', 8089.36),
    (70, 'Expansion Regional - Cliente 023', 1, 'tiktok_ads', 9495.98),
    (71, 'Cyber Monday - Cliente 035', 4, 'email_marketing', 8818.70),
    (72, 'Fidelizacion Clientes - Cliente 038', 15, 'meta_ads', 8886.74),
    (73, 'San Valentin - Cliente 040', 7, 'seo', 9814.81),
    (74, 'Cyber Monday - Cliente 005', 13, 'meta_ads', 9046.04),
    (75, 'Descuento Fin de Mes - Cliente 027', 15, 'google_ads', 3534.75),
    (76, 'Promocion 2x1 - Cliente 031', 2, 'tiktok_ads', 1512.32),
    (77, 'Promocion 2x1 - Cliente 019', 17, 'google_ads', 1083.19),
    (78, 'Temporada Navidad - Cliente 029', 4, 'seo', 11531.78),
    (79, 'Fidelizacion Clientes - Cliente 039', 9, 'google_ads', 11463.92),
    (80, 'Ultimas Unidades - Cliente 037', 1, 'google_ads', 4896.91);

-- 191 leads repartidos entre 62 campañas; las 18 campañas restantes
-- quedan sin ningún lead (registros "huérfanos" para el LEFT JOIN)
INSERT INTO leads (id, campaign_id, full_name, email, captured_at, status) VALUES
    (1, 54, 'Isabella Mendoza', 'isabella.mendoza1@correo.com', '2025-06-23', 'nuevo'),
    (2, 54, 'Ricardo Ortiz', 'ricardo.ortiz2@correo.com', '2025-03-10', 'descartado'),
    (3, 54, 'Andrea Lopez', 'andrea.lopez3@correo.com', '2025-04-18', 'contactado'),
    (4, 54, 'Miguel Ortiz', 'miguel.ortiz4@correo.com', '2024-03-11', 'nuevo'),
    (5, 67, 'Isabella Jimenez', 'isabella.jimenez5@correo.com', '2025-08-22', 'nuevo'),
    (6, 73, 'Andrea Gonzalez', 'andrea.gonzalez6@correo.com', '2025-11-18', 'convertido'),
    (7, 71, 'Manuela Suarez', 'manuela.suarez7@correo.com', '2024-07-13', 'convertido'),
    (8, 72, 'Diego Sanchez', 'diego.sanchez8@correo.com', '2025-08-14', 'calificado'),
    (9, 72, 'Andres Gonzalez', 'andres.gonzalez9@correo.com', '2024-11-14', 'descartado'),
    (10, 35, 'Maria Jose Jimenez', 'maria.jose.jimenez10@correo.com', '2024-10-15', 'nuevo'),
    (11, 35, 'David Diaz', 'david.diaz11@correo.com', '2024-06-19', 'nuevo'),
    (12, 35, 'Paula Castro', 'paula.castro12@correo.com', '2024-02-21', 'contactado'),
    (13, 35, 'Camila Perez', 'camila.perez13@correo.com', '2024-12-18', 'nuevo'),
    (14, 35, 'Diego Morales', 'diego.morales14@correo.com', '2024-04-14', 'calificado'),
    (15, 13, 'Manuela Gonzalez', 'manuela.gonzalez15@correo.com', '2025-07-10', 'convertido'),
    (16, 13, 'Mateo Rodriguez', 'mateo.rodriguez16@correo.com', '2025-05-14', 'calificado'),
    (17, 13, 'David Gomez', 'david.gomez17@correo.com', '2025-09-21', 'convertido'),
    (18, 78, 'Daniela Torres', 'daniela.torres18@correo.com', '2025-10-23', 'nuevo'),
    (19, 78, 'Camila Diaz', 'camila.diaz19@correo.com', '2024-04-20', 'descartado'),
    (20, 78, 'Diego Rojas', 'diego.rojas20@correo.com', '2025-07-15', 'contactado'),
    (21, 79, 'Luisa Morales', 'luisa.morales21@correo.com', '2025-02-01', 'calificado'),
    (22, 79, 'Daniela Martinez', 'daniela.martinez22@correo.com', '2024-04-28', 'contactado'),
    (23, 79, 'Laura Morales', 'laura.morales23@correo.com', '2025-11-07', 'descartado'),
    (24, 79, 'Juan Pablo Rodriguez', 'juan.pablo.rodriguez24@correo.com', '2025-10-04', 'calificado'),
    (25, 61, 'Ricardo Ramirez', 'ricardo.ramirez25@correo.com', '2024-01-14', 'nuevo'),
    (26, 21, 'Camila Sanchez', 'camila.sanchez26@correo.com', '2024-01-28', 'convertido'),
    (27, 21, 'Tatiana Martinez', 'tatiana.martinez27@correo.com', '2024-06-12', 'convertido'),
    (28, 21, 'Sofia Morales', 'sofia.morales28@correo.com', '2024-03-27', 'nuevo'),
    (29, 21, 'Natalia Rodriguez', 'natalia.rodriguez29@correo.com', '2024-12-24', 'nuevo'),
    (30, 21, 'Andres Castro', 'andres.castro30@correo.com', '2024-02-03', 'contactado'),
    (31, 10, 'Paula Gonzalez', 'paula.gonzalez31@correo.com', '2025-04-07', 'calificado'),
    (32, 10, 'Carolina Gomez', 'carolina.gomez32@correo.com', '2024-06-20', 'convertido'),
    (33, 44, 'Alejandro Mendoza', 'alejandro.mendoza33@correo.com', '2024-11-13', 'contactado'),
    (34, 44, 'Natalia Lopez', 'natalia.lopez34@correo.com', '2024-11-06', 'convertido'),
    (35, 44, 'Tatiana Rojas', 'tatiana.rojas35@correo.com', '2025-01-19', 'calificado'),
    (36, 44, 'Daniela Jimenez', 'daniela.jimenez36@correo.com', '2024-01-23', 'contactado'),
    (37, 44, 'Miguel Sanchez', 'miguel.sanchez37@correo.com', '2024-07-11', 'contactado'),
    (38, 8, 'Andres Rojas', 'andres.rojas38@correo.com', '2024-07-13', 'convertido'),
    (39, 8, 'Maria Jose Gonzalez', 'maria.jose.gonzalez39@correo.com', '2025-04-08', 'contactado'),
    (40, 8, 'David Mendoza', 'david.mendoza40@correo.com', '2025-09-23', 'descartado'),
    (41, 8, 'Isabella Vargas', 'isabella.vargas41@correo.com', '2025-01-28', 'calificado'),
    (42, 6, 'Andres Ramirez', 'andres.ramirez42@correo.com', '2024-09-26', 'convertido'),
    (43, 6, 'Oscar Hernandez', 'oscar.hernandez43@correo.com', '2025-08-07', 'convertido'),
    (44, 4, 'Laura Vargas', 'laura.vargas44@correo.com', '2024-06-15', 'contactado'),
    (45, 4, 'Gabriela Suarez', 'gabriela.suarez45@correo.com', '2024-08-09', 'calificado'),
    (46, 4, 'Natalia Castro', 'natalia.castro46@correo.com', '2025-01-12', 'convertido'),
    (47, 4, 'Esteban Hernandez', 'esteban.hernandez47@correo.com', '2025-10-03', 'calificado'),
    (48, 4, 'Andrea Castro', 'andrea.castro48@correo.com', '2024-11-14', 'nuevo'),
    (49, 22, 'Sebastian Torres', 'sebastian.torres49@correo.com', '2025-11-10', 'nuevo'),
    (50, 22, 'Felipe Torres', 'felipe.torres50@correo.com', '2025-08-10', 'contactado'),
    (51, 22, 'Paula Morales', 'paula.morales51@correo.com', '2025-02-25', 'nuevo'),
    (52, 22, 'Alejandro Ramirez', 'alejandro.ramirez52@correo.com', '2024-06-26', 'contactado'),
    (53, 56, 'Nicolas Ortiz', 'nicolas.ortiz53@correo.com', '2024-05-13', 'convertido'),
    (54, 56, 'Santiago Diaz', 'santiago.diaz54@correo.com', '2025-06-09', 'nuevo'),
    (55, 56, 'Maria Jose Lopez', 'maria.jose.lopez55@correo.com', '2024-12-21', 'calificado'),
    (56, 56, 'Carolina Perez', 'carolina.perez56@correo.com', '2025-12-08', 'contactado'),
    (57, 56, 'Santiago Perez', 'santiago.perez57@correo.com', '2025-07-25', 'nuevo'),
    (58, 38, 'Sebastian Rojas', 'sebastian.rojas58@correo.com', '2025-08-08', 'contactado'),
    (59, 38, 'Andrea Vargas', 'andrea.vargas59@correo.com', '2025-08-07', 'nuevo'),
    (60, 38, 'Diego Perez', 'diego.perez60@correo.com', '2024-11-18', 'convertido'),
    (61, 38, 'Ricardo Jimenez', 'ricardo.jimenez61@correo.com', '2024-10-13', 'convertido'),
    (62, 38, 'Mateo Hernandez', 'mateo.hernandez62@correo.com', '2024-09-10', 'nuevo'),
    (63, 11, 'Laura Hernandez', 'laura.hernandez63@correo.com', '2024-05-16', 'nuevo'),
    (64, 11, 'Felipe Lopez', 'felipe.lopez64@correo.com', '2025-03-08', 'contactado'),
    (65, 11, 'Paula Sanchez', 'paula.sanchez65@correo.com', '2025-04-09', 'nuevo'),
    (66, 11, 'Oscar Vargas', 'oscar.vargas66@correo.com', '2024-11-28', 'convertido'),
    (67, 39, 'Alejandro Hernandez', 'alejandro.hernandez67@correo.com', '2025-09-25', 'contactado'),
    (68, 39, 'Manuela Sanchez', 'manuela.sanchez68@correo.com', '2025-10-08', 'calificado'),
    (69, 39, 'Sebastian Reyes', 'sebastian.reyes69@correo.com', '2024-01-15', 'calificado'),
    (70, 40, 'Julian Suarez', 'julian.suarez70@correo.com', '2024-05-18', 'contactado'),
    (71, 40, 'Andrea Reyes', 'andrea.reyes71@correo.com', '2025-10-23', 'descartado'),
    (72, 77, 'Alejandro Vargas', 'alejandro.vargas72@correo.com', '2024-09-02', 'descartado'),
    (73, 77, 'Esteban Rojas', 'esteban.rojas73@correo.com', '2024-01-28', 'convertido'),
    (74, 77, 'Isabella Suarez', 'isabella.suarez74@correo.com', '2024-03-14', 'contactado'),
    (75, 47, 'Manuela Ramirez', 'manuela.ramirez75@correo.com', '2025-11-06', 'contactado'),
    (76, 47, 'Sofia Rodriguez', 'sofia.rodriguez76@correo.com', '2025-08-10', 'contactado'),
    (77, 47, 'Diego Hernandez', 'diego.hernandez77@correo.com', '2025-04-19', 'contactado'),
    (78, 47, 'Alejandro Gonzalez', 'alejandro.gonzalez78@correo.com', '2024-05-16', 'contactado'),
    (79, 27, 'Andres Jimenez', 'andres.jimenez79@correo.com', '2024-04-01', 'calificado'),
    (80, 27, 'Sofia Ramirez', 'sofia.ramirez80@correo.com', '2024-11-26', 'calificado'),
    (81, 27, 'Felipe Vargas', 'felipe.vargas81@correo.com', '2024-07-19', 'nuevo'),
    (82, 31, 'Manuela Torres', 'manuela.torres82@correo.com', '2025-12-12', 'convertido'),
    (83, 31, 'Felipe Gonzalez', 'felipe.gonzalez83@correo.com', '2025-04-12', 'nuevo'),
    (84, 31, 'Andres Hernandez', 'andres.hernandez84@correo.com', '2024-01-03', 'convertido'),
    (85, 31, 'Daniela Perez', 'daniela.perez85@correo.com', '2024-11-24', 'calificado'),
    (86, 31, 'Esteban Vargas', 'esteban.vargas86@correo.com', '2024-09-13', 'calificado'),
    (87, 48, 'Carolina Torres', 'carolina.torres87@correo.com', '2025-11-18', 'calificado'),
    (88, 48, 'Juan Pablo Torres', 'juan.pablo.torres88@correo.com', '2024-11-17', 'calificado'),
    (89, 48, 'Maria Jose Rodriguez', 'maria.jose.rodriguez89@correo.com', '2025-04-11', 'contactado'),
    (90, 48, 'Camila Ortiz', 'camila.ortiz90@correo.com', '2024-10-23', 'contactado'),
    (91, 48, 'Sebastian Sanchez', 'sebastian.sanchez91@correo.com', '2024-04-07', 'nuevo'),
    (92, 68, 'Ricardo Vargas', 'ricardo.vargas92@correo.com', '2024-04-11', 'convertido'),
    (93, 68, 'Gabriela Martinez', 'gabriela.martinez93@correo.com', '2024-09-16', 'calificado'),
    (94, 50, 'Daniela Suarez', 'daniela.suarez94@correo.com', '2025-04-11', 'nuevo'),
    (95, 50, 'Diego Torres', 'diego.torres95@correo.com', '2024-02-01', 'nuevo'),
    (96, 50, 'Mateo Lopez', 'mateo.lopez96@correo.com', '2024-05-06', 'nuevo'),
    (97, 50, 'Felipe Suarez', 'felipe.suarez97@correo.com', '2024-03-15', 'calificado'),
    (98, 50, 'Camila Vargas', 'camila.vargas98@correo.com', '2024-09-08', 'nuevo'),
    (99, 58, 'Julian Reyes', 'julian.reyes99@correo.com', '2024-06-11', 'contactado'),
    (100, 58, 'Paula Jimenez', 'paula.jimenez100@correo.com', '2025-08-19', 'calificado'),
    (101, 58, 'Sebastian Castro', 'sebastian.castro101@correo.com', '2025-09-20', 'nuevo'),
    (102, 46, 'Sofia Diaz', 'sofia.diaz102@correo.com', '2025-10-19', 'convertido'),
    (103, 46, 'Miguel Jimenez', 'miguel.jimenez103@correo.com', '2024-10-11', 'contactado'),
    (104, 46, 'Juan Pablo Lopez', 'juan.pablo.lopez104@correo.com', '2024-03-24', 'nuevo'),
    (105, 46, 'Julian Sanchez', 'julian.sanchez105@correo.com', '2024-06-20', 'nuevo'),
    (106, 46, 'Gabriela Diaz', 'gabriela.diaz106@correo.com', '2024-04-28', 'contactado'),
    (107, 76, 'Esteban Reyes', 'esteban.reyes107@correo.com', '2025-08-21', 'contactado'),
    (108, 76, 'Maria Jose Martinez', 'maria.jose.martinez108@correo.com', '2025-06-25', 'nuevo'),
    (109, 53, 'Sofia Lopez', 'sofia.lopez109@correo.com', '2024-07-03', 'contactado'),
    (110, 53, 'Santiago Sanchez', 'santiago.sanchez110@correo.com', '2025-05-11', 'calificado'),
    (111, 69, 'Tatiana Gonzalez', 'tatiana.gonzalez111@correo.com', '2025-04-01', 'nuevo'),
    (112, 69, 'Andres Martinez', 'andres.martinez112@correo.com', '2025-03-08', 'nuevo'),
    (113, 30, 'Felipe Hernandez', 'felipe.hernandez113@correo.com', '2025-02-16', 'contactado'),
    (114, 30, 'Ricardo Rodriguez', 'ricardo.rodriguez114@correo.com', '2024-05-14', 'nuevo'),
    (115, 30, 'Luisa Rodriguez', 'luisa.rodriguez115@correo.com', '2024-09-07', 'nuevo'),
    (116, 5, 'Carolina Morales', 'carolina.morales116@correo.com', '2024-02-01', 'calificado'),
    (117, 28, 'Carolina Rojas', 'carolina.rojas117@correo.com', '2025-12-04', 'contactado'),
    (118, 24, 'Manuela Morales', 'manuela.morales118@correo.com', '2025-05-19', 'nuevo'),
    (119, 63, 'Felipe Rodriguez', 'felipe.rodriguez119@correo.com', '2025-06-06', 'contactado'),
    (120, 63, 'Juan Pablo Ortiz', 'juan.pablo.ortiz120@correo.com', '2025-12-03', 'calificado'),
    (121, 63, 'Mateo Reyes', 'mateo.reyes121@correo.com', '2024-03-02', 'nuevo'),
    (122, 63, 'Luisa Jimenez', 'luisa.jimenez122@correo.com', '2024-07-08', 'nuevo'),
    (123, 63, 'Felipe Diaz', 'felipe.diaz123@correo.com', '2024-09-07', 'nuevo'),
    (124, 3, 'Andrea Ortiz', 'andrea.ortiz124@correo.com', '2024-04-14', 'calificado'),
    (125, 18, 'Isabella Sanchez', 'isabella.sanchez125@correo.com', '2025-01-02', 'contactado'),
    (126, 18, 'David Castro', 'david.castro126@correo.com', '2024-10-14', 'contactado'),
    (127, 18, 'Manuela Gomez', 'manuela.gomez127@correo.com', '2025-04-03', 'calificado'),
    (128, 18, 'Miguel Martinez', 'miguel.martinez128@correo.com', '2024-05-28', 'contactado'),
    (129, 18, 'Paula Lopez', 'paula.lopez129@correo.com', '2025-10-05', 'nuevo'),
    (130, 51, 'Juan Pablo Mendoza', 'juan.pablo.mendoza130@correo.com', '2025-01-14', 'nuevo'),
    (131, 12, 'Sebastian Hernandez', 'sebastian.hernandez131@correo.com', '2025-06-08', 'nuevo'),
    (132, 12, 'Esteban Gomez', 'esteban.gomez132@correo.com', '2024-07-06', 'calificado'),
    (133, 12, 'Tatiana Perez', 'tatiana.perez133@correo.com', '2024-06-12', 'nuevo'),
    (134, 12, 'Esteban Perez', 'esteban.perez134@correo.com', '2024-01-03', 'contactado'),
    (135, 15, 'Natalia Gonzalez', 'natalia.gonzalez135@correo.com', '2025-11-22', 'contactado'),
    (136, 62, 'Sofia Hernandez', 'sofia.hernandez136@correo.com', '2025-02-27', 'contactado'),
    (137, 37, 'Andrea Jimenez', 'andrea.jimenez137@correo.com', '2025-11-03', 'nuevo'),
    (138, 37, 'Esteban Rodriguez', 'esteban.rodriguez138@correo.com', '2025-12-21', 'contactado'),
    (139, 37, 'Diego Gomez', 'diego.gomez139@correo.com', '2025-06-02', 'nuevo'),
    (140, 37, 'David Torres', 'david.torres140@correo.com', '2024-08-19', 'nuevo'),
    (141, 37, 'Alejandro Rojas', 'alejandro.rojas141@correo.com', '2024-09-24', 'contactado'),
    (142, 57, 'Daniela Rojas', 'daniela.rojas142@correo.com', '2024-10-15', 'nuevo'),
    (143, 57, 'Oscar Castro', 'oscar.castro143@correo.com', '2024-03-15', 'nuevo'),
    (144, 57, 'Daniela Mendoza', 'daniela.mendoza144@correo.com', '2025-03-20', 'calificado'),
    (145, 57, 'Sofia Reyes', 'sofia.reyes145@correo.com', '2025-06-23', 'descartado'),
    (146, 57, 'Esteban Castro', 'esteban.castro146@correo.com', '2024-06-15', 'nuevo'),
    (147, 55, 'Nicolas Vargas', 'nicolas.vargas147@correo.com', '2024-02-03', 'contactado'),
    (148, 55, 'Paula Martinez', 'paula.martinez148@correo.com', '2024-03-24', 'contactado'),
    (149, 1, 'Laura Ortiz', 'laura.ortiz149@correo.com', '2024-06-23', 'descartado'),
    (150, 1, 'Carolina Jimenez', 'carolina.jimenez150@correo.com', '2024-08-23', 'descartado'),
    (151, 74, 'Luisa Reyes', 'luisa.reyes151@correo.com', '2024-05-08', 'descartado'),
    (152, 74, 'Julian Rodriguez', 'julian.rodriguez152@correo.com', '2025-02-24', 'contactado'),
    (153, 74, 'Diego Lopez', 'diego.lopez153@correo.com', '2024-06-22', 'nuevo'),
    (154, 74, 'Andrea Diaz', 'andrea.diaz154@correo.com', '2024-06-11', 'calificado'),
    (155, 74, 'Alejandro Reyes', 'alejandro.reyes155@correo.com', '2025-07-13', 'nuevo'),
    (156, 70, 'Santiago Suarez', 'santiago.suarez156@correo.com', '2024-10-14', 'nuevo'),
    (157, 70, 'Ricardo Torres', 'ricardo.torres157@correo.com', '2024-03-12', 'calificado'),
    (158, 70, 'Gabriela Mendoza', 'gabriela.mendoza158@correo.com', '2024-09-15', 'convertido'),
    (159, 80, 'Santiago Rojas', 'santiago.rojas159@correo.com', '2024-07-12', 'nuevo'),
    (160, 80, 'Gabriela Ortiz', 'gabriela.ortiz160@correo.com', '2024-03-22', 'convertido'),
    (161, 80, 'Oscar Gomez', 'oscar.gomez161@correo.com', '2024-06-26', 'convertido'),
    (162, 80, 'Tatiana Ortiz', 'tatiana.ortiz162@correo.com', '2025-12-21', 'descartado'),
    (163, 80, 'Maria Jose Diaz', 'maria.jose.diaz163@correo.com', '2024-08-17', 'convertido'),
    (164, 34, 'Nicolas Hernandez', 'nicolas.hernandez164@correo.com', '2024-11-27', 'convertido'),
    (165, 29, 'David Sanchez', 'david.sanchez165@correo.com', '2025-05-13', 'contactado'),
    (166, 29, 'Andrea Suarez', 'andrea.suarez166@correo.com', '2025-12-28', 'contactado'),
    (167, 29, 'Juan Pablo Vargas', 'juan.pablo.vargas167@correo.com', '2025-10-23', 'contactado'),
    (168, 29, 'Gabriela Ramirez', 'gabriela.ramirez168@correo.com', '2025-07-01', 'contactado'),
    (169, 42, 'Miguel Hernandez', 'miguel.hernandez169@correo.com', '2025-12-25', 'contactado'),
    (170, 42, 'Paula Suarez', 'paula.suarez170@correo.com', '2024-09-03', 'nuevo'),
    (171, 42, 'Sebastian Mendoza', 'sebastian.mendoza171@correo.com', '2025-06-15', 'nuevo'),
    (172, 42, 'Santiago Martinez', 'santiago.martinez172@correo.com', '2024-06-10', 'contactado'),
    (173, 42, 'Natalia Vargas', 'natalia.vargas173@correo.com', '2025-06-11', 'convertido'),
    (174, 64, 'Nicolas Reyes', 'nicolas.reyes174@correo.com', '2025-03-18', 'descartado'),
    (175, 64, 'Esteban Jimenez', 'esteban.jimenez175@correo.com', '2025-12-11', 'descartado'),
    (176, 65, 'David Morales', 'david.morales176@correo.com', '2025-09-14', 'nuevo'),
    (177, 65, 'Isabella Lopez', 'isabella.lopez177@correo.com', '2024-02-17', 'nuevo'),
    (178, 65, 'Carolina Mendoza', 'carolina.mendoza178@correo.com', '2024-03-04', 'nuevo'),
    (179, 52, 'Natalia Morales', 'natalia.morales179@correo.com', '2025-12-10', 'contactado'),
    (180, 19, 'Paula Rodriguez', 'paula.rodriguez180@correo.com', '2024-04-13', 'contactado'),
    (181, 17, 'Nicolas Jimenez', 'nicolas.jimenez181@correo.com', '2025-10-10', 'contactado'),
    (182, 2, 'David Reyes', 'david.reyes182@correo.com', '2025-03-25', 'calificado'),
    (183, 2, 'Julian Ramirez', 'julian.ramirez183@correo.com', '2024-09-21', 'nuevo'),
    (184, 2, 'Gabriela Reyes', 'gabriela.reyes184@correo.com', '2025-04-11', 'convertido'),
    (185, 2, 'Tatiana Mendoza', 'tatiana.mendoza185@correo.com', '2025-11-22', 'contactado'),
    (186, 2, 'Andres Morales', 'andres.morales186@correo.com', '2024-10-04', 'nuevo'),
    (187, 36, 'Carolina Lopez', 'carolina.lopez187@correo.com', '2025-01-15', 'nuevo'),
    (188, 36, 'David Gonzalez', 'david.gonzalez188@correo.com', '2024-12-21', 'calificado'),
    (189, 36, 'Gabriela Torres', 'gabriela.torres189@correo.com', '2024-04-27', 'calificado'),
    (190, 36, 'Valentina Diaz', 'valentina.diaz190@correo.com', '2024-05-08', 'nuevo'),
    (191, 36, 'Juan Pablo Morales', 'juan.pablo.morales191@correo.com', '2024-07-25', 'nuevo');

-- ============================================
-- CONSULTA 1: INNER JOIN principal
-- Une campañas con los leads que sí tienen relación en ambas tablas
-- ============================================

SELECT
    c.name         AS campana,
    l.full_name    AS lead,
    l.captured_at  AS fecha_captura
FROM campaigns  c
INNER JOIN leads l ON l.campaign_id = c.id;

-- ============================================
-- CONSULTA 2: JOIN con tres tablas
-- Encadena campaigns + leads + employees
-- ============================================

SELECT
    c.name       AS campana,
    e.name       AS asesor_responsable,
    l.full_name  AS lead
FROM campaigns  c
INNER JOIN employees e ON c.employee_id = e.id
INNER JOIN leads     l ON l.campaign_id = c.id;

-- ============================================
-- CONSULTA 3: LEFT JOIN — todos los registros
-- Obtiene todas las campañas aunque no tengan leads
-- ============================================

SELECT
    c.name        AS campana,
    l.full_name   AS lead
FROM campaigns  c
LEFT JOIN leads l ON l.campaign_id = c.id;

-- ============================================
-- CONSULTA 4: Detectar huérfanos (campañas sin leads)
-- ============================================

SELECT
    c.name AS campana_sin_leads
FROM campaigns  c
LEFT JOIN leads l ON l.campaign_id = c.id
WHERE l.id IS NULL;

-- ============================================
-- CONSULTA 5: Reporte agregado con LEFT JOIN + COUNT
-- Cantidad de leads por campaña (incluye 0)
-- ============================================

SELECT
    c.name        AS campana,
    COUNT(l.id)   AS total_leads
FROM campaigns  c
LEFT JOIN leads l ON l.campaign_id = c.id
GROUP BY c.id, c.name
ORDER BY total_leads DESC;

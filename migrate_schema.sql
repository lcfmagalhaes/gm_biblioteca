-- =====================================================================
-- Script para migrar tabelas do schema gm_biblioteca para public
-- Execute este script no Supabase SQL Editor
-- =====================================================================

-- Mover todas as tabelas do schema gm_biblioteca para public
ALTER TABLE gm_biblioteca.codigo_postal SET SCHEMA public;
ALTER TABLE gm_biblioteca.editora SET SCHEMA public;
ALTER TABLE gm_biblioteca.autor SET SCHEMA public;
ALTER TABLE gm_biblioteca.genero SET SCHEMA public;
ALTER TABLE gm_biblioteca.livro SET SCHEMA public;
ALTER TABLE gm_biblioteca.livro_exemplar SET SCHEMA public;
ALTER TABLE gm_biblioteca.utente SET SCHEMA public;
ALTER TABLE gm_biblioteca.requisicao SET SCHEMA public;

-- Mover o tipo ENUM também
ALTER TYPE gm_biblioteca.livro_estado SET SCHEMA public;

-- Verificar se as tabelas foram movidas corretamente
SELECT table_name, table_schema 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('codigo_postal', 'editora', 'autor', 'genero', 'livro', 'livro_exemplar', 'utente', 'requisicao')
ORDER BY table_name;

-- Verificar se o tipo foi movido
SELECT typname, typnamespace::regnamespace as schema_name
FROM pg_type 
WHERE typname = 'livro_estado';

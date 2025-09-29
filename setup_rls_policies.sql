-- =====================================================================
-- Script para configurar RLS e políticas de acesso às tabelas
-- Execute este script no Supabase SQL Editor APÓS migrar as tabelas
-- =====================================================================

-- 1. Ativar RLS nas tabelas principais
ALTER TABLE public.livro ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.autor ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.livro_exemplar ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.genero ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.editora ENABLE ROW LEVEL SECURITY;

-- 2. Criar políticas para permitir leitura pública (para catálogo)
-- Política para tabela LIVRO
CREATE POLICY "Permitir leitura pública de livros" ON public.livro
    FOR SELECT USING (true);

-- Política para tabela AUTOR
CREATE POLICY "Permitir leitura pública de autores" ON public.autor
    FOR SELECT USING (true);

-- Política para tabela LIVRO_EXEMPLAR
CREATE POLICY "Permitir leitura pública de exemplares" ON public.livro_exemplar
    FOR SELECT USING (true);

-- Política para tabela GENERO
CREATE POLICY "Permitir leitura pública de géneros" ON public.genero
    FOR SELECT USING (true);

-- Política para tabela EDITORA
CREATE POLICY "Permitir leitura pública de editoras" ON public.editora
    FOR SELECT USING (true);

-- 3. Verificar se as políticas foram criadas
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
FROM pg_policies 
WHERE schemaname = 'public' 
AND tablename IN ('livro', 'autor', 'livro_exemplar', 'genero', 'editora')
ORDER BY tablename, policyname;

-- 4. Verificar se RLS está ativo
SELECT schemaname, tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('livro', 'autor', 'livro_exemplar', 'genero', 'editora')
ORDER BY tablename;

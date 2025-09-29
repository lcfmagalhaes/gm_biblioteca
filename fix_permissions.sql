-- =====================================================================
-- Script SIMPLES para resolver permissões - Execute no Supabase SQL Editor
-- =====================================================================

-- 1. Desativar RLS temporariamente para testar
ALTER TABLE public.livro DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.autor DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.livro_exemplar DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.genero DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.editora DISABLE ROW LEVEL SECURITY;

-- 2. Dar permissões diretas ao role anon
GRANT SELECT ON public.livro TO anon;
GRANT SELECT ON public.autor TO anon;
GRANT SELECT ON public.livro_exemplar TO anon;
GRANT SELECT ON public.genero TO anon;
GRANT SELECT ON public.editora TO anon;

-- 3. Dar permissões também ao role authenticated (caso precises)
GRANT SELECT ON public.livro TO authenticated;
GRANT SELECT ON public.autor TO authenticated;
GRANT SELECT ON public.livro_exemplar TO authenticated;
GRANT SELECT ON public.genero TO authenticated;
GRANT SELECT ON public.editora TO authenticated;

-- 4. Verificar permissões
SELECT 
    table_name,
    privilege_type,
    grantee
FROM information_schema.table_privileges 
WHERE table_schema = 'public' 
AND table_name IN ('livro', 'autor', 'livro_exemplar', 'genero', 'editora')
AND grantee IN ('anon', 'authenticated')
ORDER BY table_name, grantee;

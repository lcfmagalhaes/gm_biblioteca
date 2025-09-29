# 🔧 Guia de Configuração do Supabase - Authentication

## 📍 Onde Encontrar as Configurações

Com base na sua captura de tela, você está na seção **Authentication** do Supabase. Aqui está onde encontrar as configurações necessárias:

### 🎯 **Localização das Configurações:**

Na seção **CONFIGURATION** (que você pode ver na sua tela), procure por:

1. **📧 Sign In / Providers** ← **AQUI ESTÁ!**
   - Clique nesta opção
   - Aqui pode ativar/desativar a autenticação por email
   - Configurar provedores de login (Google, GitHub, etc.)

2. **📧 Emails** ← **IMPORTANTE!**
   - Configurações de templates de email
   - Confirmação de email
   - Reset de palavra-passe

3. **🔒 Policies** ← **CRÍTICO!**
   - Configurações de Row Level Security (RLS)
   - Políticas de acesso às tabelas

### 🚀 **Passos para Configurar:**

#### **Passo 1: Configurar Sign In / Providers**
1. Clique em **"Sign In / Providers"** na seção CONFIGURATION
2. Ative **"Enable email confirmations"** se quiser confirmação por email
3. Configure **"Email"** como provedor ativo
4. Salve as alterações

#### **Passo 2: Configurar Emails (Opcional)**
1. Clique em **"Emails"** na seção CONFIGURATION
2. Configure os templates de email se desejar
3. Ou deixe os templates padrão

#### **Passo 3: Configurar Policies (Importante)**
1. Clique em **"Policies"** na seção CONFIGURATION
2. Ou vá para **"Table Editor"** no menu lateral
3. Configure Row Level Security (RLS) nas suas tabelas

### 🎨 **Interface do Supabase:**

```
┌─────────────────────────────────────┐
│ 🔒 Authentication                   │
├─────────────────────────────────────┤
│ MANAGE:                             │
│ • Users                            │
│                                   │
│ CONFIGURATION:                     │
│ • Policies ← (RLS)                 │
│ • Sign In / Providers ← (EMAIL)    │
│ • Sessions                         │
│ • Rate Limits                      │
│ • Emails ← (TEMPLATES)             │
│ • Multi-Factor                     │
│ • URL Configuration                │
│ • Attack Protection                │
│ • Auth Hooks (BETA)                │
│ • Audit Logs (BETA)                │
│ • Advanced                         │
└─────────────────────────────────────┘
```

### ⚙️ **Configurações Mínimas Necessárias:**

#### **1. Sign In / Providers:**
- ✅ Ativar "Email" como provedor
- ✅ Configurar "Enable email confirmations" (opcional)
- ✅ Definir "Site URL" se necessário

#### **2. Policies (RLS):**
```sql
-- Exemplo de política para tabela 'livro'
CREATE POLICY "Allow public read access" ON livro
FOR SELECT USING (true);

-- Exemplo de política para tabela 'livro_exemplar'
CREATE POLICY "Allow public read access" ON livro_exemplar
FOR SELECT USING (true);
```

### 🔍 **Se Não Encontrar "Settings":**

O Supabase não tem uma seção chamada "Settings" na Authentication. As configurações estão distribuídas por:

- **Sign In / Providers** - Configurações de login
- **Emails** - Templates de email
- **Policies** - Segurança das tabelas
- **URL Configuration** - URLs de redirecionamento
- **Advanced** - Configurações avançadas

### 🚨 **Configuração Rápida (Mínima):**

1. **Clique em "Sign In / Providers"**
2. **Ative "Email"** como provedor
3. **Salve**
4. **Teste a aplicação**

### 📱 **Teste da Aplicação:**

Após configurar, execute:
```bash
flutter run -d chrome
```

E teste:
1. **Registo** de um novo utilizador
2. **Login** com as credenciais
3. **Navegação** na aplicação

### 🆘 **Se Ainda Não Funcionar:**

1. **Verifique se o projeto está ativo** no Supabase
2. **Confirme as credenciais** (URL e chave)
3. **Verifique os logs** no console do navegador
4. **Teste com um email simples** (ex: teste@teste.com)

### 📞 **Suporte:**

Se precisar de ajuda adicional:
- Consulte a [documentação oficial do Supabase](https://supabase.com/docs/guides/auth)
- Verifique os logs no console do navegador
- Teste com credenciais simples primeiro

**A configuração mais importante é ativar o "Email" em "Sign In / Providers"!** 🎯

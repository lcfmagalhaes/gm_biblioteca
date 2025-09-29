# 🚀 Guia de Início Rápido - GM Biblioteca

## ✅ **Sistema de Autenticação Implementado**

### **🔧 Funcionalidades Disponíveis:**
- ✅ **Login com email/senha**
- ✅ **Registo de utilizadores**
- ✅ **Login com Google** (opcional)
- ✅ **Recuperação de palavra-passe**
- ✅ **Logout seguro**
- ✅ **Gestão automática de sessão**

## 🚀 **Como Executar**

### **Opção 1: Pelo IDE (Mais Fácil)**
1. **Pressione F5** ou **Ctrl+F5**
2. **Selecione:** "🚀 GM Biblioteca - Chrome"
3. **Clique no botão play** ▶️

### **Opção 2: Pelo Terminal**
```bash
flutter run -d chrome
```

## 🔐 **Configuração do Supabase**

### **Para Login com Email/Senha:**
1. **Vá para:** Authentication > Sign In / Providers
2. **Ative:** "Email" como provedor
3. **Salve**

### **Para Login com Google (Opcional):**
1. **Vá para:** Authentication > Sign In / Providers
2. **Clique em:** "Google"
3. **Configure:**
   - **Client IDs:** `123456789-abcdefg.apps.googleusercontent.com`
   - **Client Secret:** `GOCSPX-abcdefghijklmnop`
4. **Salve**

## 🎯 **Teste da Aplicação**

### **1. Teste de Registo:**
1. **Execute a aplicação**
2. **Clique em "Criar conta"**
3. **Preencha os campos:**
   - Nome completo
   - Email
   - Palavra-passe
   - Confirmação de palavra-passe
4. **Clique em "Criar Conta"**

### **2. Teste de Login:**
1. **Use as credenciais criadas**
2. **Clique em "Entrar"**
3. **Deve redirecionar para a tela principal**

### **3. Teste de Login com Google:**
1. **Clique em "Entrar com Google"**
2. **Faça login com sua conta Google**
3. **Deve redirecionar para a aplicação**

## 🆘 **Resolução de Problemas**

### **Se a aplicação não compilar:**
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

### **Se o login não funcionar:**
1. **Verifique as configurações do Supabase**
2. **Confirme que ativou o "Email" em Sign In / Providers**
3. **Teste com credenciais simples**

### **Se o Google não funcionar:**
1. **Use as credenciais de teste** fornecidas
2. **Ou desative temporariamente** o Google
3. **Use apenas email/senha**

## 📱 **Funcionalidades da Aplicação**

### **Tela de Login:**
- Validação de email
- Campo de palavra-passe com toggle de visibilidade
- Link para registo
- Link para recuperação de palavra-passe
- Botão de login com Google (opcional)

### **Tela de Registo:**
- Campos: Nome, Email, Palavra-passe, Confirmação
- Validação completa dos campos
- Confirmação de palavra-passe
- Feedback visual de erros

### **Tela Principal:**
- Informações do utilizador logado
- Menu de funcionalidades
- Botão de logout com confirmação
- Interface moderna e responsiva

### **Tela de Livros:**
- Lista de livros disponíveis
- Informações de exemplares
- Navegação intuitiva

## 🎉 **Sistema Pronto!**

O sistema de autenticação está completamente implementado e pronto para uso:

- ✅ **Login e registo** funcionando
- ✅ **Interface moderna** e responsiva
- ✅ **Gestão de estado** automática
- ✅ **Navegação inteligente**
- ✅ **Tratamento de erros**
- ✅ **Feedback visual**

**Execute a aplicação e teste todas as funcionalidades!** 🚀

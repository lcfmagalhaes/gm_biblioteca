# 🔧 Como Ativar APIs no Google Cloud Console

## 📋 **Passo a Passo Visual**

### **1. 🏗️ Acessar Google Cloud Console**

1. **Abra o navegador** e vá para: [Google Cloud Console](https://console.cloud.google.com/)
2. **Faça login** com sua conta Google
3. **Selecione ou crie um projeto:**
   - Se já tem um projeto: selecione-o no topo
   - Se não tem: clique em "Select a project" > "New Project"

### **2. 🎯 Navegar para APIs & Services**

1. **No menu lateral esquerdo**, procure por:
   ```
   ☰ (Menu hambúrguer)
   ├── APIs & Services
   │   ├── Library
   │   ├── Credentials
   │   └── OAuth consent screen
   ```

2. **Clique em "APIs & Services"**

### **3. 📚 Acessar a Library (Biblioteca)**

1. **Clique em "Library"** no menu lateral
2. **Você verá uma página** com uma barra de pesquisa no topo

### **4. 🔍 Procurar e Ativar APIs**

#### **API 1: Google+ API (ou Google Identity)**
1. **Na barra de pesquisa**, digite: `Google+ API`
2. **Clique no resultado** "Google+ API"
3. **Clique no botão azul "ENABLE"** (Ativar)
4. **Aguarde** a confirmação

#### **API 2: Google OAuth2 API**
1. **Volte para a Library** (clique em "Library" novamente)
2. **Na barra de pesquisa**, digite: `OAuth2`
3. **Clique no resultado** "Google OAuth2 API"
4. **Clique no botão azul "ENABLE"** (Ativar)
5. **Aguarde** a confirmação

### **5. ✅ Verificar APIs Ativadas**

1. **Vá para "APIs & Services" > "Enabled APIs & services"**
2. **Você deve ver:**
   - ✅ Google+ API
   - ✅ Google OAuth2 API

## 🎯 **Configuração Alternativa (Mais Simples)**

Se não encontrar as APIs acima, use estas:

### **APIs Essenciais:**
1. **Google Identity API**
2. **Google OAuth2 API**
3. **Google+ API** (se disponível)

### **Como Procurar:**
1. **Na Library**, digite: `identity`
2. **Ative:** "Google Identity API"
3. **Digite:** `oauth2`
4. **Ative:** "Google OAuth2 API"

## 🚀 **Próximos Passos**

Após ativar as APIs:

1. **Vá para "Credentials"**
2. **Crie OAuth 2.0 Client ID**
3. **Configure as credenciais**
4. **Use no Supabase**

## 🆘 **Se Não Encontrar as APIs**

### **Opção 1: Usar APIs Alternativas**
- **Google Identity API**
- **Google OAuth2 API**
- **Google+ API** (se disponível)

### **Opção 2: Verificar Permissões**
- Certifique-se de que tem permissões de administrador
- Verifique se o projeto está ativo
- Tente criar um novo projeto

### **Opção 3: Usar Credenciais de Teste**
Se não conseguir ativar as APIs, pode usar credenciais de teste no Supabase:
```
Client ID: 123456789-abcdefg.apps.googleusercontent.com
Client Secret: GOCSPX-abcdefghijklmnop
```

## 📱 **Teste Rápido**

1. **Ative pelo menos uma API** (Google Identity ou OAuth2)
2. **Configure credenciais básicas**
3. **Teste no Supabase**
4. **Verifique se funciona**

## 🔧 **Comandos Úteis**

```bash
# Verificar se a aplicação compila
flutter run -d chrome

# Limpar cache se necessário
flutter clean
flutter pub get
```

**O importante é ativar pelo menos uma API relacionada com OAuth/Identity!** 🎯

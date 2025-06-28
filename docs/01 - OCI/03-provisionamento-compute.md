# 03 • Provisionamento das Máquinas Virtuais

## 1. Geração de Chaves SSH para Acesso às Instâncias

Para acessar as máquinas virtuais (VMs) do cluster na OCI de forma segura, é necessário gerar um par de chaves SSH (pública e privada). O procedimento abaixo cobre tanto usuários de **Windows** (via PowerShell) quanto de **Linux**.

---

### 1.1. Usuários Windows (PowerShell)

1. Abra o **PowerShell**:
   - Clique no menu Iniciar, digite "PowerShell", clique com o botão direito e escolha "Executar como administrador".

2. No PowerShell, digite o comando abaixo e pressione Enter:

```bash
ssh-keygen -b 4096
```

- Quando solicitado pelo "file in which to save the key", pressione **Enter** para aceitar o local padrão (`C:\Users\<SeuUsuario>\.ssh\id_rsa`).
- Se desejar, defina uma senha para a chave ou apenas pressione **Enter** para deixar em branco.

3. Ao final, serão criados dois arquivos na pasta `C:\Users\<SeuUsuario>\.ssh\`:
- `id_rsa` (chave privada, **NUNCA compartilhe**)
- `id_rsa.pub` (chave pública, que será usada nas VMs)

4. Para visualizar e copiar sua chave pública:

```bash
notepad C:\Users<SeuUsuario>.ssh\id_rsa.pub
```
### 1.2. Usuários Linux

1. Abra o terminal.
2. Execute o comando abaixo:

```bash
ssh-keygen -t rsa -b 4096 -C "seu_email@exemplo.com"
```
- Quando solicitado pelo "Enter file in which to save the key", pressione **Enter** para aceitar o local padrão (`/home/seuusuario/.ssh/id_rsa`).
- Se desejar, defina uma senha para a chave ou apenas pressione **Enter** para deixar em branco.

3. Serão criados dois arquivos em `~/.ssh/`:
- `id_rsa` (chave privada)
- `id_rsa.pub` (chave pública)

4. Para visualizar e copiar sua chave pública:

```bash
cat ~/.ssh/id_rsa.pub
```
















Serão criadas **4 instâncias**:

| Função  | Shape sugerido | Sistema Operacional |
|---------|----------------|---------------------|
| master  | VM.Standard.E4.Flex (4 OCPU, 16 GB) | Ubuntu 22.04 |
| node1  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |
| node2  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |
| node3  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |




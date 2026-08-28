import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "sistemavendas.db"
SCHEMA_PATH = BASE_DIR / "schema.sql"

def get_connection():
    """Estabelece uma conexão com o banco de dados SQLite"""
    conn = sqlite3.connect(DB_PATH)
    #Permite acessar os resultados com dicionários
    conn.row_factory = sqlite3.Row 
    #Ativa o suporte a chaves estrangeiras
    conn.execute("PRAGMA foreign keys = ON")
    return conn

def init_db():
    """ le o schema.sql e cria o arquivo sistema_vendas.db com as tabelas. """
    if not SCHEMA_PATH.exists():
        print(f"[ERRO] Arquivo schema.sql NÃO encontrado no caminho: {SCHEMA_PATH}")
        return
    with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
        schema_sql = f.read()
    conn = get_connection()
    try:
       cursor = conn.cursor()
       cursor.executescript(schema_sql) 
       conn.commit()
       print(f"[DATABASE] Sucesso! Banco de dados criado/verificado em: {DB_PATH}")
    except sqlite3.Error as e:
        print(f"[ERRO] Falha no SQLite: {e}")
        conn.rollback()
    finally:
        conn.close()

#Executa imediatamente quando o script for chamado via terminal
if __name__ == "__main__":
    init_db()
    

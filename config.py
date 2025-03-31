from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    azure_storage_connection_string: str
    container_name: str

    snowflake_user: str
    snowflake_password: str
    snowflake_account: str
    snowflake_warehouse: str
    snowflake_database: str
    snowflake_schema: str

    storage_integration: str
    file_format_name: str
    stage_name: str
    target_table: str

    class Config:
        env_file = ".env"

settings = Settings()

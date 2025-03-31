{% macro generate_surrogate_key(column_name) %}
    md5(lower(trim({{ column_name }})))
{% endmacro %}

{%- macro result_if_table_exists(table_ref, result_statement, if_empty=1) -%}

{{ adapter.dispatch('result_if_table_exists', 'pinterest_source') (table_ref, result_statement, if_empty=1) }}

{%- endmacro -%}

{%- macro default__result_if_table_exists(table_ref, result_statement, if_empty=1) -%}
    {%- set is_empty_result = pinterest_source.is_table_empty(table_ref) -%} 
    {%- if is_empty_result == "empty" %}
        {{ if_empty }}
    {%- else %}
        {{ result_statement }}
    {%- endif %}
{%- endmacro %}
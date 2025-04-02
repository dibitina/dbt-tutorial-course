{#

    throw errors when a value is
    less than or equal to the bound
    (by default - 0)

    value is an extra argument/variable with a default value :)

#}

{% test row_greater_thab(model, column_name, value=0) %}

SELECT
    {{ column_name }} AS row_that_failed

FROM {{ model }}
WHERE {{ column_name }} <= {{ value }}


{% endtest %}
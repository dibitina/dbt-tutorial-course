{#
It's a good idea to add the context to the test
in those Jinja comments at the top. Like this:

	This test is basically a "not_null" and "unique"
	rolled into one.

	It fails if a column is NULL or occurs more than once

This block is also not passed to the compiled SQL.
#}

{% test primary_key(model, column_name) %}
{#
primary_key: the test name to reference in yml
model and column_name
will be pulled from the yml file #}

WITH validation AS (
	SELECT
		{{ column_name }} AS primary_key,
		COUNT(1) AS occurrences

	FROM {{ model }}
	GROUP BY 1
)

SELECT *

FROM validation
WHERE primary_key IS NULL
	OR occurrences > 1

{% endtest %}

{# you can put another test right here -
or create another sql in the tests folder #}
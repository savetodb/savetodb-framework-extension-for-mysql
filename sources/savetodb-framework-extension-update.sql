-- =============================================
-- SaveToDB Framework Extension for MySQL
-- Version 10.8, January 9, 2023
--
-- This script updates SaveToDB Framework 9 to the latest version
--
-- Copyright 2022-2023 Gartle LLC
--
-- License: MIT
-- =============================================

SELECT CASE WHEN 1008 <= CAST(substr(HANDLER_CODE, 1, instr(HANDLER_CODE, '.') - 1) AS unsigned) * 100 + CAST(substr(HANDLER_CODE, instr(HANDLER_CODE, '.') + 1) AS decimal) THEN 'SaveToDB Framework is up-to-date. Update skipped' ELSE HANDLER_CODE END AS check_version FROM xls.handlers WHERE TABLE_SCHEMA = 'xls' AND TABLE_NAME = 'savetodb_framework_extension' AND COLUMN_NAME = 'version' AND EVENT_NAME = 'Information' LIMIT 1;

UPDATE xls.handlers t,
    (
    SELECT
        NULL AS TABLE_SCHEMA
        , NULL AS TABLE_NAME
        , NULL AS COLUMN_NAME
        , NULL AS EVENT_NAME
        , NULL AS HANDLER_SCHEMA
        , NULL AS HANDLER_NAME
        , NULL AS HANDLER_TYPE
        , NULL AS HANDLER_CODE
        , NULL AS TARGET_WORKSHEET
        , NULL AS MENU_ORDER
        , NULL AS EDIT_PARAMETERS

    UNION ALL SELECT 'xls', 'savetodb_framework_extension', 'version', 'Information', NULL, NULL, 'ATTRIBUTE', '10.8', NULL, NULL, NULL

    ) s
SET
    t.HANDLER_CODE = s.HANDLER_CODE
    , t.TARGET_WORKSHEET = s.TARGET_WORKSHEET
    , t.MENU_ORDER = s.MENU_ORDER
    , t.EDIT_PARAMETERS = s.EDIT_PARAMETERS
WHERE
    s.TABLE_NAME IS NOT NULL
    AND t.TABLE_SCHEMA = s.TABLE_SCHEMA
    AND t.TABLE_NAME = s.TABLE_NAME
    AND COALESCE(t.COLUMN_NAME, '') = COALESCE(s.COLUMN_NAME, '')
    AND t.EVENT_NAME = s.EVENT_NAME
    AND COALESCE(t.HANDLER_SCHEMA, '') = COALESCE(s.HANDLER_SCHEMA, '')
    AND COALESCE(t.HANDLER_NAME, '') = COALESCE(s.HANDLER_NAME, '')
    AND COALESCE(t.HANDLER_TYPE, '') = COALESCE(s.HANDLER_TYPE, '')
    AND (
    NOT COALESCE(t.HANDLER_CODE, '') = COALESCE(s.HANDLER_CODE, '')
    OR NOT COALESCE(t.TARGET_WORKSHEET, '') = COALESCE(s.TARGET_WORKSHEET, '')
    OR NOT COALESCE(t.MENU_ORDER, -1) = COALESCE(s.MENU_ORDER, -1)
    OR NOT COALESCE(t.EDIT_PARAMETERS, 0) = COALESCE(s.EDIT_PARAMETERS, 0)
    );

INSERT INTO xls.handlers
    ( TABLE_SCHEMA
    , TABLE_NAME
    , COLUMN_NAME
    , EVENT_NAME
    , HANDLER_SCHEMA
    , HANDLER_NAME
    , HANDLER_TYPE
    , HANDLER_CODE
    , TARGET_WORKSHEET
    , MENU_ORDER
    , EDIT_PARAMETERS
    )
SELECT
    s.TABLE_SCHEMA
    , s.TABLE_NAME
    , s.COLUMN_NAME
    , s.EVENT_NAME
    , s.HANDLER_SCHEMA
    , s.HANDLER_NAME
    , s.HANDLER_TYPE
    , s.HANDLER_CODE
    , s.TARGET_WORKSHEET
    , s.MENU_ORDER
    , s.EDIT_PARAMETERS
FROM
    (
    SELECT
        NULL AS TABLE_SCHEMA
        , NULL AS TABLE_NAME
        , NULL AS COLUMN_NAME
        , NULL AS EVENT_NAME
        , NULL AS HANDLER_SCHEMA
        , NULL AS HANDLER_NAME
        , NULL AS HANDLER_TYPE
        , NULL AS HANDLER_CODE
        , NULL AS TARGET_WORKSHEET
        , NULL AS MENU_ORDER
        , NULL AS EDIT_PARAMETERS

    UNION ALL SELECT 'xls', 'savetodb_framework_extension', 'version', 'Information', NULL, NULL, 'ATTRIBUTE', '10.8', NULL, NULL, NULL

    ) s
    LEFT OUTER JOIN xls.handlers t ON
        t.TABLE_SCHEMA = s.TABLE_SCHEMA
        AND t.TABLE_NAME = s.TABLE_NAME
        AND COALESCE(t.COLUMN_NAME, '') = COALESCE(s.COLUMN_NAME, '')
        AND t.EVENT_NAME = s.EVENT_NAME
        AND COALESCE(t.HANDLER_SCHEMA, '') = COALESCE(s.HANDLER_SCHEMA, '')
        AND COALESCE(t.HANDLER_NAME, '') = COALESCE(s.HANDLER_NAME, '')
        AND COALESCE(t.HANDLER_TYPE, '') = COALESCE(s.HANDLER_TYPE, '')
WHERE
    t.TABLE_NAME IS NULL
    AND s.TABLE_NAME IS NOT NULL;

-- print SaveToDB Framework Extension updated

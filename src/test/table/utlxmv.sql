Rem
Rem $Header: rdbms/admin/utlxmv.sql /main/9 2020/07/20 03:06:18 dgoddard Exp $
Rem $Header: rdbms/admin/utlxmv.sql /main/9 2020/07/20 03:06:18 dgoddard Exp $
Rem
Rem utlxmv.sql
Rem
Rem Copyright (c) 2000, 2017, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      utlxmv.sql - UTiLity for eXplain MV
Rem
Rem    DESCRIPTION
Rem      The utility script creates the MV_CAPABILITIES_TABLE that is
Rem      used by the DBMS_MVIEW.EXPLAIN_MVIEW() API.
Rem
Rem    NOTES
Rem
Rem    BEGIN SQL_FILE_METADATA
Rem    SQL_SOURCE_FILE: rdbms/admin/utlxmv.sql
Rem    SQL_SHIPPED_FILE: rdbms/admin/utlxmv.sql
Rem    SQL_PHASE: UTILITY
Rem    SQL_STARTUP_MODE: NORMAL
Rem    SQL_IGNORABLE_ERRORS: NONE
Rem    END SQL_FILE_METADATA
Rem    
Rem    MODIFIED   (MM/DD/YY)
Rem    sramakri    01/27/15 - bug-20301978
Rem    mthiyaga    01/22/15 - Bug 20393662
Rem    nshodhan    02/16/01 - Bug#1647071: replace mv with mview
Rem    raavudai    11/28/00 - Fix comment.
Rem    twtong      12/01/00 - fix for sql*plus
Rem    twtong      09/13/00 - modify mv_capabilities_tabe
Rem    twtong      08/18/00 - change create table to upper case
Rem    jraitto     06/12/00 - add RELATED_NUM and MSGNO columns
Rem    jraitto     05/09/00 - Explain_MV table
Rem    jraitto     05/09/00 - Created
Rem

create table mv_capabilities_table (
   statement_id         varchar(128),  -- Client-supplied unique statement identifier
   mvowner              varchar(128),  -- NULL for SELECT based EXPLAIN_MVIEW
   mvname               varchar(128),  -- NULL for SELECT based EXPLAIN_MVIEW
   capability_name      varchar(128),  -- A descriptive name of the particular 
                                       -- capability: 
                                       -- REWRITE
                                       --   Can do at least full text match
                                       --   rewrite
                                       -- REWRITE_PARTIAL_TEXT_MATCH
                                       --   Can do at leat full and partial 
                                       --   text match rewrite
                                       -- REWRITE_GENERAL
                                       --   Can do all forms of rewrite
                                       -- REFRESH
                                       --   Can do at least complete refresh 
                                       -- REFRESH_FROM_LOG_AFTER_INSERT
                                       --   Can do fast refresh from an mv log
                                       --   or change capture table at least 
                                       --   when update operations are 
                                       --   restricted to INSERT 
                                       -- REFRESH_FROM_LOG_AFTER_ANY
                                       --   can do fast refresh from an mv log
                                       --   or change capture table after any
                                       --   combination of updates
                                       -- PCT
                                       --   Can do Enhanced Update Tracking on
                                       --   the table named in the RELATED_NAME
                                       --   column.  EUT is needed for fast
                                       --   refresh after partitioned 
                                       --   maintenance operations on the table
                                       --   named in the RELATED_NAME column 
                                       --   and to do non-stale tolerated 
                                       --   rewrite when the mv is partially 
                                       --   stale with respect to the table
                                       --   named in the RELATED_NAME column.
                                       --   EUT can also sometimes enable fast
                                       --   refresh of updates to the table
                                       --   named in the RELATED_NAME column
                                       --   when fast refresh from an mv log 
                                       --   or change capture table is not 
                                       --   possilbe.
   possible             character(1),  -- T = capability is possible
                                       -- F = capability is not possible 
   related_text         varchar(2000), -- Owner.table.column, alias name, etc. 
                                       -- related to this message.  The
                                       -- specific meaning of this column 
                                       -- depends on the MSGNO column.  See
                                       -- the documentation for
                                       -- DBMS_MVIEW.EXPLAIN_MVIEW() for details
   related_num          number,        -- When there is a numeric value 
                                       -- associated with a row, it goes here.
                                       -- The specific meaning of this column 
                                       -- depends on the MSGNO column.  See
                                       -- the documentation for
                                       -- DBMS_MVIEW.EXPLAIN_MVIEW() for details
   msgno                integer,       -- When available, QSM message # 
                                       -- explaining why not possible or more 
                                       -- details when enabled.
   msgtxt               varchar(2000), -- Text associated with MSGNO.
   seq                  number         -- Useful in ORDER BY clause when 
                                       -- selecting from this table.
);

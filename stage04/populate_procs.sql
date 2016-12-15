/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Corpo Docente de BD225179
 */

DROP PROCEDURE IF EXISTS load_date_dim;
DROP PROCEDURE IF EXISTS load_time_dim;
DROP PROCEDURE IF EXISTS load_location_dim;
DROP PROCEDURE IF EXISTS load_user_dim;
DROP PROCEDURE IF EXISTS load_reservations;

DELIMITER $$
CREATE PROCEDURE load_date_dim()
BEGIN
  DECLARE v_full_date DATETIME;
  SET v_full_date = '2016-01-01 00:00:00';
  WHILE v_full_date < '2018-01-01 00:00:00' DO
    INSERT INTO olap_Date_dim (
     date_id,
     date_day,
     date_week,
     date_month,
     date_semester,
     date_year
    ) VALUES (
      YEAR(v_full_date) * 10000 + MONTH(v_full_date) * 100 + DAY(v_full_date),
      DAY(v_full_date),
      WEEK(v_full_date),
      MONTH(v_full_date),
      CEIL(MONTH(v_full_date) / 6),
      YEAR(v_full_date)
    );
    SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 DAY);
  END WHILE;
END;
$$

CREATE PROCEDURE load_time_dim()
BEGIN
  DECLARE v_full_time TIME;
  SET v_full_time = '00:00:00.0000';
  WHILE v_full_time <= '23:59:00.0000' DO
    INSERT INTO olap_Time_dim (
     time_id,
     time_minute,
     time_hour
    ) VALUES (
      HOUR(v_full_time) * 100 + MINUTE(v_full_time),
      HOUR(v_full_time),
      MINUTE(v_full_time)
    );
    SET v_full_time = ADDTIME(v_full_time, '00:01:0.0000');
  END WHILE;
END;
$$

CREATE PROCEDURE load_location_dim()
BEGIN
-- TODO
END;
$$

CREATE PROCEDURE load_user_dim()
BEGIN
-- TODO
END;
$$

CREATE PROCEDURE load_reservations()
BEGIN
-- TO *fucking* DO
END;
$$

DELIMITER ;

<!--
 - BD Instant Office
 - BD225179 16'17
 -
 - @author Rui Ventura (ist181045)
 - @author Diogo Freitas (ist181586)
 - @author Sara Azinhal (ist181700)
 -->

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Instant Office - Escolha uma Oferta</title>
  </head>
  <body>
    <h1>Escolha uma Oferta</h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        if (isset($_REQUEST['morada'])) {
          try {
            $db->beginTransaction();

            $stmt = $db->prepare("DELETE FROM Oferta
              WHERE morada = ? AND codigo = ? AND data_inicio = ? AND data_fim = ? AND tarifa = ?");
            $stmt->execute(array($_REQUEST['morada'], $_REQUEST['codigo'], $_REQUEST['data_inicio'], $_REQUEST['data_fim'], $_REQUEST['tarifa']));
            $stmt = null;

            echo "<p>Remoção feita com sucesso!</p>";

            $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo "<p>PDOException: {$e->getMessage()}</p>";
          }
        }

        $result = $db->query("SELECT * FROM Oferta");
        $objs = $result->fetchAll(PDO::FETCH_ASSOC);
        $result = null;

        echo "<table border=\"2\">";
        echo "<thead><tr>";
        foreach(array_keys($objs[0]) as $key)
          echo "<td>".ucfirst($key)."</td>";
        echo "</tr></thead><tbody>";

        foreach($objs as $obj) {
          $str = "morada={$obj['morada']}&codigo={$obj['codigo']}&data_inicio={$obj['data_inicio']}&data_fim={$obj['data_fim']}&tarifa={$obj['tarifa']}";
          echo "<tr>";
          echo "<td>{$obj['morada']}</td>";
          echo "<td>{$obj['codigo']}</td>";
          echo "<td>{$obj['data_inicio']}</td>";
          echo "<td>{$obj['data_fim']}</td>";
          echo "<td>{$obj['tarifa']}</td>";
          echo "<td><a href=\"remove_offer.php?$str\">Remover Oferta</a></td>";
          echo "</tr>";
        }

        echo "</tbody></table>";

        $db = null;

      } catch (PDOException $e) {
        echo "<p>PDOException: {$e->getMessage()}</p>";
      }

     ?>
    <br>
    <a href="index.php">Voltar ao Inicio</a>
    <br><br>
    <footer>Copyright &copy; 2016 <?php echo date("Y") > 2016 ? " - ".date("Y") : ""; ?></footer>
  </body>
</html>

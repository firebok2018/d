/*
create proc CONSULTA

as
select 

p.IdPedido as [ID PEDIDO],
p.FechaPedido as [FECHA PEDIDO],
e.NomEmpleado as [NOMBRE EMPLEADO],
e.ApeEmpleado AS [APELLIDO EMPLEADO],
p.DireccionDestinatario AS [DIRECCIÓN DESTINATARIO],
p.CiudadDestinatario AS [CIUDAD DESTINATARIO]
 from tb_empleados e inner join tb_pedidoscabe p
on e.IdEmpleado= p.IdEmpleado

 go

 exec CONSULTA
 
  con.Open();
            dgLista.DataSource = tabla();
 
 private DataTable tabla()
        {

            SqlDataAdapter da = new SqlDataAdapter("CONSULTA", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
   
        }
  SqlConnection cn = new SqlConnection("server =.;database=Negocios2018;uid=sa;pwd=sql");
  private void button1_Click(object sender, EventArgs e)
        {
            string nombre = txtProducto.Text;
            SqlDataAdapter da = new SqlDataAdapter("ListPro", cn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@nomPRO", nombre);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dgListarProducto.DataSource = null;
            dgListarProducto.DataSource = dt;

        }
     DESCryptoServiceProvider crip = new DESCryptoServiceProvider();
        byte[] key = new byte[] { 11,25,2,55,252,54,54,52};
        byte[] iv = new byte[] { 52,25,25,255,15,25 ,15,51};
      private void btnEncriptar_Click(object sender, EventArgs e)
        {

            SaveFileDialog sf = new SaveFileDialog();
            sf.Filter = "Archivo cifrado|*.EncryptW";
            if (sf.ShowDialog() == DialogResult.OK)
            {
                MemoryStream ms = new MemoryStream();
                StreamWriter encryp = new StreamWriter(ms);
                encryp.Write(txtDato.Text);
                encryp.Flush();

                FileStream file = new FileStream(sf.FileName, FileMode.Create);
                CryptoStream crypto = new CryptoStream(file, crip.CreateEncryptor(key, iv), CryptoStreamMode.Write);
                crypto.Write(ms.ToArray(), 0, ms.ToArray().Length);
                crypto.Close();
                file.Close();

                txtDato.Text = null;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog of = new OpenFileDialog();
            of.Filter = "Archivo cifrado|*.EncryptW";
            if (of.ShowDialog()== DialogResult.OK)
            {
                FileStream file = new FileStream(of.FileName, FileMode.Open);
                CryptoStream decryt = new CryptoStream(file, crip.CreateDecryptor(key, iv), CryptoStreamMode.Read);
                byte[] datos = new byte[4096];
                decryt.Read(datos, 0, datos.Length);

                MemoryStream ms = new MemoryStream();
                ms.Write(datos, 0, datos.Length);
                ms.Position = 0;
                txtDato.Text = new StreamReader(ms).ReadToEnd();

            }
        }
        //zip
        private void button2_Click(object sender, EventArgs e)
        {
            SaveFileDialog zip = new SaveFileDialog();
            zip.Filter = "Archivos comprimidos |*.zip";

            if (zip.ShowDialog() == DialogResult.OK) {
                MemoryStream ms = new MemoryStream();
                StreamWriter escritor = new StreamWriter(ms);
                escritor.Write(txtDatos.Text);
                escritor.Flush();

                FileStream f = new FileStream(zip.FileName, FileMode.Create);
                GZipStream zipz = new GZipStream(f, CompressionMode.Compress);

                zipz.Write(ms.ToArray(), 0,ms.ToArray().Length);
                zipz.Close();
                f.Close();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SaveFileDialog zip = new SaveFileDialog();
            zip.Filter = "Archivos comprimidos |*.zip";

            if (zip.ShowDialog() == DialogResult.OK)
            {
                MemoryStream ms = new MemoryStream();
                StreamWriter escritor = new StreamWriter(ms);
                escritor.Write(txtDatos.Text);
                escritor.Flush();

                FileStream f = new FileStream(zip.FileName, FileMode.Create);
                GZipStream zipz = new GZipStream(f, CompressionMode.Decompress);

                zipz.Write(ms.ToArray(), 0, ms.ToArray().Length);
                zipz.Close();
                f.Close();

            }
        }

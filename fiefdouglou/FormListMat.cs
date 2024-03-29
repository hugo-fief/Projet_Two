﻿// on définit toutes les librairies (assembly) dont on a besoins 
// dans le fichiers en les important
using System;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

// on encapsule toute notre form dans un bocal (package) propre au projet
namespace fiefdouglou
{
    /* Entité FormListMat qui étends la class Form afin de récupérer toute les class pour manipuler des formulaire windows form
   * et d'accésibilité public afin qu'elle soit accesible depuis n'importe quel form à la différence des méthodes private
   * et de type partial car quand vous utilisez une source générée automatiquement, vous pouvez ajouter du code à la classe sans avoir à 
   * recréer le fichier source. Visual Studio suit cette approche pour créer des formulaires Windows Forms
   */
    public partial class FormListMat : Form
    {
        public FormListMat()
        {
            // on charge notre form en initialisant tout ses composants
            InitializeComponent();
            // on récupère les identifiants de connection à la database
            Connection.GetConnectionString();
        }

        private void FormListMat_Load(object sender, EventArgs e)
        {
            // au chargement de la form on remplit nos comboBox de tout nos sites
            string strSQLsmc = "SELECT m.type AS filtre_par_type, c.nom AS filtre_par_client, s.nom AS filtre_par_site," +
                " m.picture AS picture FROM materiel m INNER JOIN client c ON c.id_client = m.id_client INNER JOIN site s " +
                " ON s.id_site = m.id_site; ";
            SqlDataReader drSQLsmc = Connection.OpenConnection(strSQLsmc);

            while (drSQLsmc.Read())
            {
                if (!comboBoxSite.Items.Contains("site fif"))
                    comboBoxSite.Items.Add(drSQLsmc["filtre_par_site"].ToString());
                if (!comboBoxClient.Items.Contains("test"))
                    comboBoxClient.Items.Add(drSQLsmc["filtre_par_client"].ToString());
                if (!comboBoxType.Items.Contains("informatique"))
                    comboBoxType.Items.Add(drSQLsmc["filtre_par_type"].ToString());
            }
            Connection.CloseConnection();

            Button7_Click(sender, e);

            string sqlNoQuery = "SELECT * FROM materiel";
            SqlDataReader drNoSQL = Connection.OpenConnection(sqlNoQuery);

            while (drNoSQL.Read())
            {
                listBoxMat.Items.Add(drNoSQL["nom"].ToString());
            }
            Connection.CloseConnection();
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            // on récupère ce qui à été définit dans nos comboBox
            string sitechoisi = comboBoxSite.SelectedItem.ToString();
            string param = "hasJointure";

            string strfilter = " WHERE (s.nom = '" + sitechoisi + "' )";
            string query = "SELECT m.nom as nom_matos, m.description as desc_matos, " +
                " m.date_intervention_faite as date_matos, m.mtbf as mtbf_matos, s.nom as nom_du_param " +
                " FROM materiel m inner join site s on m.id_site = s.id_site " + strfilter;
            RemplirListViewMat(query, param);
        }

        private void ButtonOK_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            // on récupère ce qui à été définit dans nos comboBox
            string clientchoisi = comboBoxClient.SelectedItem.ToString();
            string param = "hasJointure";

            string strfilter = " WHERE (c.nom = '" + clientchoisi + "' )";
            string query = "SELECT m.nom as nom_matos, m.description as desc_matos, m.date_intervention_faite " +
                    " as date_matos, m.mtbf as mtbf_matos, c.nom as nom_du_param FROM materiel m inner join client c " +
                    " on m.id_client = c.id_client " + strfilter;
            RemplirListViewMat(query, param);
        }

        private void Button6_Click(object sender, EventArgs e)
        {
            string param = "type";
            string clientchoisi = comboBoxType.SelectedItem.ToString();
            string query = "SELECT m.type as type_matos, m.nom as nom_matos, m.description as desc_matos," +
                " m.date_intervention_faite as date_matos, m.mtbf as mtbf_matos FROM materiel m " +
                " WHERE type = '" + clientchoisi + "'";
            RemplirListViewMat(query, param);
        }

        private void RemplirListViewMat(string sqlQuery, string param)
        {
            // on commence par vider notre listView juste au cas où
            listViewMat.Items.Clear();

            int i = 0;

            try
            {
                /* 
                * notre but là c'est de récupérer tout le matériel qui est propre au site et un client
                * qui a été précédemment définit dans nos comboBox en faisant une jointure interne entre la table
                * matériel, site et client 
                * m => table matériel
                * s => table site

                * en gros l'idée ce de récupérer pas mal d'infos de la table matériel ensuit de récupérer le contenu de la table
                * site et pour chaque matériel trouvé regarder si il appartient au site définit

                */
                string strSQL = sqlQuery;
                SqlDataReader drSQL = Connection.OpenConnection(strSQL);
                string site = "";
                int j = 1;

                // une fois notre éxécuté on va boucler dessus afin de remplir notre listViwe 
                // de tout ce que nous a retourné notre requete
                while (drSQL.Read())
                {
                    string nom = drSQL["nom_matos"].ToString();
                    string NoSerie = drSQL["desc_matos"].ToString();
                    string DateInstallation = drSQL["date_matos"].ToString();
                    string mtbf = drSQL["mtbf_matos"].ToString();
                    if (param == "hasJointure")
                        site = drSQL["nom_du_param"].ToString();
                    if (param == "type")
                        site = drSQL["type_matos"].ToString();
                    if (param == "date")
                        site = j.ToString();
                    if (param == "duree")
                        site = drSQL["duree"].ToString();
                    if (param == "recherche")
                        site = textBox1.Text;
                    if (param == "date_filtre")
                    {
                        site = dateDebut.Value.ToString("yyyy-dd-MM") + " / " + dateFin.Value.ToString("yyyy-dd-MM");
                    }

                    // on définit notre listView et on la remplit en lui ajoutant tout ce dont on a besoin d'afficher
                    var lvi = new ListViewItem()
                    {
                        Text = nom
                    };
                    lvi.SubItems.Add(NoSerie);
                    lvi.SubItems.Add(DateInstallation);
                    lvi.SubItems.Add(mtbf);
                    lvi.SubItems.Add(site);

                    listViewMat.Items.Add(lvi);
                    // on définit une variable i qu'on va incrémenter afin de cibler à chaque chaque élments de notre listView afin de 
                    // lui mettre pour chauqe éléments une couleur de fond ;)
                    listViewMat.Items[i].BackColor = Color.Gray;
                    i++;
                    j++;
                }
            }
            // si une requete sql qui n'a pas fonctionné dans le bout de code qu'on essaye d'éxécuté 
            // alors on attrape l'exception et on affiche l'erreur
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Erreur", MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }

            // si il y a une quelqonque erreur dans le bout de code qu'on essaye d'éxécuté alors attrape l'exception
            catch (Exception excep)
            {
                MessageBox.Show(excep.Message, "Érreur Générale", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            // une fois que le bout de code a fini son éxécution on ferme toute nos connections à la database
            finally
            {
                Connection.CloseConnection();
            }
        }

        private void Button5_Click(object sender, EventArgs e)
        {
            string param = "date";
            string query = "SELECT m.nom as nom_matos, m.description as desc_matos, m.date_intervention_faite " +
                    " as date_matos, m.mtbf as mtbf_matos FROM materiel m ORDER BY date_intervention_faite";
            RemplirListViewMat(query, param);
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            string param = "duree";
            string query = "SELECT m.nom as nom_matos, m.description as desc_matos, m.date_intervention_faite " +
                    " as date_matos, m.mtbf as mtbf_matos, " +
                    " -DATEDIFF(DAY, date_intervention_faite, GETDATE()) AS duree FROM materiel m " +
                " WHERE DATEADD(DAY, mtbf, date_intervention_faite) >= GETDATE() ORDER BY duree";
            RemplirListViewMat(query, param);
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            string param = "recherche";
            string query = string.Format("SELECT m.nom as nom_matos, m.description as desc_matos, m.date_intervention_faite " +
                " as date_matos, m.mtbf as mtbf_matos FROM materiel m WHERE m.nom LIKE '%{0}%'", textBox1.Text);
            RemplirListViewMat(query, param);

            // on va vérifier si lintervention existe comme ca on pourra gérer si l'utilisateur rentre n'importe quoi
            // dans la barre de recherche on pourra alors lui afficher une message d'erreur
            string queryCount = string.Format("SELECT COUNT(*) FROM intervention WHERE materiel_concerne LIKE '%{0}%' " +
                " AND id_intervention > 2", textBox1.Text);
            int res = Connection.ExecuteCountQuery(queryCount);

            // si aucune intervention n'a été trouvé dans le recherche qui à été saisie on affiche un message d'erreur
            if (res == 0)
            {
                MessageBox.Show("Aucun Résultat", "Érreur de Recherche", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Button8_Click(object sender, EventArgs e)
        {
            // on commence par vider notre listView juste au cas où
            listViewMat.Items.Clear();

            // on récupère notre procédure stockée qui permet de récupérer tout les matériel périmés dont la date de 
            // leur prochaines intervention - mtbf (exprimé en nombre de jour) est inférieur à la date actuelle
            SqlDataReader md = Connection.ExecuteProcedure("MatosPerimer");

            // on boucle sur les valeurs dans la database et on les remplit une par une dans la listview
            // en précisant uniquement les colonnes de la database que l'on souhaite afficher dans la listview
            // on remplit la listview et ensuite on définit une largueur pour chaque colonne de notre listview ainsi qu'une
            // couleur de fond pour chaque élément de notre listView
            while (md.Read())
            {
                string nom = md["nom"].ToString();
                string NoSerie = md["description"].ToString();
                string DateInstallation = md["date_intervention_faite"].ToString();
                string mtbf = md["mtbf"].ToString();
                string site = md["type"].ToString();

                // on définit notre listView et on la remplit en lui ajoutant tout ce dont on a besoin d'afficher
                var lvi = new ListViewItem()
                {
                    Text = nom
                };
                lvi.SubItems.Add(NoSerie);
                lvi.SubItems.Add(DateInstallation);
                lvi.SubItems.Add(mtbf);
                lvi.SubItems.Add(site);

                listViewMat.Items.Add(lvi);
            }
        }

        private void Button7_Click(object sender, EventArgs e)
        {
            // on commence par vider notre listView juste au cas où
            listViewMat.Items.Clear();

            // on récupère notre procédure stockée qui permet de récupérer tout les matériel périmés dont la date de 
            // leur prochaines intervention - mtbf (exprimé en nombre de jour) est inférieur à la date actuelle
            SqlDataReader md = Connection.ExecuteProcedure("MatosFonctionnel");

            // on boucle sur les valeurs dans la database et on les remplit une par une dans la listview
            // en précisant uniquement les colonnes de la database que l'on souhaite afficher dans la listview
            // on remplit la listview et ensuite on définit une largueur pour chaque colonne de notre listview ainsi qu'une
            // couleur de fond pour chaque élément de notre listView
            while (md.Read())
            {
                string nom = md["nom"].ToString();
                string NoSerie = md["description"].ToString();
                string DateInstallation = md["date_intervention_faite"].ToString();
                string mtbf = md["mtbf"].ToString();
                string site = md["type"].ToString();
                string toto = md["picture"].ToString();

                // on définit notre listView et on la remplit en lui ajoutant tout ce dont on a besoin d'afficher
                var lvi = new ListViewItem()
                {
                    Text = nom
                };
                lvi.SubItems.Add(NoSerie);
                lvi.SubItems.Add(DateInstallation);
                lvi.SubItems.Add(mtbf);
                lvi.SubItems.Add(site);
                lvi.SubItems.Add(toto);

                listViewMat.Items.Add(lvi);
            }
        }
        private void ListBoxMat_SelectedIndexChanged(object sender, EventArgs e)
        {
            string matos = listBoxMat.SelectedItems[0].ToString();
            string sqlQuery = "SELECT * FROM materiel WHERE nom = '" + matos + "'";

            SqlDataReader drSQL = Connection.OpenConnection(sqlQuery);

            while (drSQL.Read())
            {
                string destpath = Directory.GetCurrentDirectory() + @"\img\" + drSQL["picture"].ToString();
                pictureBoxMat.Image = Image.FromFile(destpath);
                pictureBoxMat.Size = new System.Drawing.Size(150, 150);
            }
            Connection.CloseConnection();
        }

        private void ButtonDate_Click(object sender, EventArgs e)
        {
            DateTime dtdeb = dateDebut.Value;
            DateTime dtfin = dateFin.Value;

            string param = "date_filtre";
            string strSQL = "SELECT m.nom as nom_matos, m.description as desc_matos, m.date_intervention_faite " +
                " as date_matos, m.mtbf as mtbf_matos FROM materiel m where " +
               " date_intervention_faite >= '" + dtdeb.ToString("yyyy-dd-MM") +
               "' and date_intervention_faite <= '" + dtfin.ToString("yyyy-dd-MM") + "'";

            RemplirListViewMat(strSQL, param);
        }
    }
}

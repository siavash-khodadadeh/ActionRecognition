import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class PrepareDataForWord2Vec {
	public static void main(String[] args) {
		String address = "/media/siavash/01D00557EB1240C0/"
				+ "Master Thesis/action_recognition_Vitra/"
				+ "Server_Codes/data/word2vec_data";
		ArrayList<File> files = new ArrayList<File>();
		listFiles(address, files);
		String allWordsFileAddress = "/media/siavash/01D00557EB1240C0/"
				+ "Master Thesis/action_recognition_Vitra/"
				+ "Server_Codes/data/word2vec_data/allwords.txt";
		try {
			PrintWriter out = new PrintWriter(new OutputStreamWriter(
					new FileOutputStream(new File(allWordsFileAddress))));
			for (File f : files) {
				System.out.println("Processing file: " + f.getName());
				BufferedReader in = new BufferedReader(new InputStreamReader(
						new FileInputStream(f)));
				String line = null;
				while ((line = in.readLine()) != null) {
					String word = line.split("\\s\\s\\s")[1];
					double d = Double.parseDouble(word);
					int wordNumber = (int) d;
					out.print(wordNumber + " ");
				}
				in.close();
			}
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void listFiles(String directoryName, ArrayList<File> files) {
		File directory = new File(directoryName);
		File[] fList = directory.listFiles();
		for (File f : fList) {
			if (f.isFile()) {
				files.add(f);
			} else if (f.isDirectory()) {
				listFiles(f.getAbsolutePath(), files);
			}
		}
	}
}

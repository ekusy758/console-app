using System;
using System.IO;
using System.Text;
using System.Speech.Synthesis;

namespace SpeakSynthVoice
{
    class Program
    {
        static void Main(string[] args)
        {
            string filePath = "";
            string baseDir = AppDomain.CurrentDomain.BaseDirectory;
            if (args.Length > 0)
            {
                filePath = args[0];
            }
            else
            {
                filePath = Path.Combine(baseDir, "speech.txt");
            }

            Speaker.PresetStart(filePath);
            Console.WriteLine("終了するには何かキーを押してください . . .");
            Console.ReadKey();
        }
    }

    public static class Speaker
    {
        public static void PresetStart(string filePath)
        {
            string content = "";
            try
            {
                content = File.ReadAllText(filePath, Encoding.GetEncoding("shift_jis")).Trim();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: ファイルの読み込みに失敗しました.\r\n" + ex.Message);
                return;
            }

            if (string.IsNullOrEmpty(content))
            {
                Console.WriteLine("Error: スピーチ内容が記録されていないようです.");
                return;
            }

            DisplayInstalledVoices();
            VoiceReading(content);
        }

        public static void VoiceReading(string text)
        {
            Console.WriteLine("システム音声による読み上げを開始します.");
            Console.WriteLine("\r\n*****************************************");
            Console.WriteLine("<音声>\r\n" + text);
            Console.WriteLine("*****************************************\r\n");

            // Default Voice: "Microsoft Haruka Desktop" (Japanese)
            using (var synth = new SpeechSynthesizer())
            {
                synth.Volume = 100;
                synth.Rate = 0;
                synth.Speak(text);
            }
            Console.WriteLine("システム音声による読み上げが完了しました.");
        }

        public static void DisplayInstalledVoices()
        {
            Console.WriteLine("---------------------------------------------");
            Console.WriteLine("InstalledVoices:");
            using (var synth = new SpeechSynthesizer())
            {
                foreach (var voice in synth.GetInstalledVoices())
                {
                    var info = voice.VoiceInfo;
                    string data = "Voice: " + info.Name + ", Culture: " + info.Culture.Name + ", Gender: " + info.Gender;
                    Console.WriteLine(data);
                }
            }
            Console.WriteLine("---------------------------------------------");
        }

    }
}

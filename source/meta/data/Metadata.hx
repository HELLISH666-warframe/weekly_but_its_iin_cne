import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

MetadataFile = {
    var card:MetadataCard;
    var credits:MetadataCredits;
}

MetadataCard = {
    var name:Null<String>;
    var expandBeat:Null<Int>;
    var duration:Null<Int>;
    var font:Null<String>;
    var fontSize:Null<Int>;
}

MetadataCredits = {
    var music:Null<Array<String>>;
    var chart:Null<Array<String>>;
    var art:Null<Array<String>>;
    var code:Null<Array<String>>;
    var va:Null<Array<String>>;
}

class Metadata 
{
    public static function get(song:String):MetadataFile
    {
            var rawJson = null;

            var formattedSong:String = Paths.formatToSongPath(song);
            var path:String = formattedSong + '/metadata';

            var moddyFile:String = Paths.modsJson(path);
            if(FileSystem.exists(moddyFile)) {
                rawJson = File.getContent(moddyFile).trim();
            }

            if(rawJson == null) {
                #if sys
                rawJson = File.getContent(Paths.json(path)).trim();
                #else
                rawJson = Assets.getText(Paths.json(path)).trim();
                #end	
            }

            while (!rawJson.endsWith("}")){
                
                rawJson = rawJson.substr(0, rawJson.length - 1);
            }

            return Json.parse(rawJson);
        }
    //    catch(e) {
      //      return null;
        //}
    }
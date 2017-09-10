
import 'dart:async';
import 'dart:io';


class ContentTypesProvider {

  static final CSS = new ContentType("text", "css" );
  static final JS = new ContentType("application", "javascript", charset: "utf-8");

  static final handledTypes = {

    "css":CSS,
    "html":ContentType.HTML,
    "js":JS
  };

  static ContentType lookup( String assetPath ){

    int lastDot = assetPath.lastIndexOf( '.' );

    // no dot ?
    if( -1 == lastDot ) {

      return null;
    }

    // last char is a dot ?
    if( lastDot + 1 == assetPath.length ) {

      return null;
    }

    var extension = assetPath.substring( lastDot + 1 );
    print( "extension: $extension");
    return handledTypes[extension];
  }


//  static final HTML = new ContentType("text", "html", charset: "utf-8");
//  [mimeTypes setObject:@"text/css" forKey:@".css"];


//  [mimeTypes setObject:@"application/vnd.ms-fontobject" forKey:@".eot"]; // http://symbolset.com/blog/properly-serve-webfonts/
//  [mimeTypes setObject:@"text/html" forKey:@".html"];
//  [mimeTypes setObject:@"image/gif" forKey:@".gif"];
//  [mimeTypes setObject:@"image/x-icon" forKey:@".ico"];
//  [mimeTypes setObject:@"image/jpeg" forKey:@".jpeg"];
//  [mimeTypes setObject:@"image/jpeg" forKey:@".jpg"];
//  [mimeTypes setObject:@"application/javascript" forKey:@".js"];
//  [mimeTypes setObject:MimeTypes_APPLICATION_JSON forKey:@".json"];
//  [mimeTypes setObject:MimeTypes_APPLICATION_JSON forKey:@".map"]; // http://stackoverflow.com/questions/19911929/what-mime-type-should-i-use-for-source-map-files
//  [mimeTypes setObject:@"image/png" forKey:@".png"];
//  [mimeTypes setObject:@"image/svg+xml" forKey:@".svg"]; // http://www.ietf.org/rfc/rfc3023.txt, section 8.19
//  [mimeTypes setObject:@"text/x.typescript" forKey:@".ts"]; // http://stackoverflow.com/questions/13213787/whats-the-mime-type-of-typescript
//  [mimeTypes setObject:@"application/x-font-ttf" forKey:@".ttf"]; // http://symbolset.com/blog/properly-serve-webfonts/
//  [mimeTypes setObject:@"application/x-font-woff" forKey:@".woff"]; // http://symbolset.com/blog/properly-serve-webfonts/
//  [mimeTypes setObject:@"application/font-woff2" forKey:@".woff2"]; // http://stackoverflow.com/questions/25796609/font-face-isnt-working-in-iis-8-0


}
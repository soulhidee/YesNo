import Foundation

struct GifHTMLBuilder {
    static func html(for urlString: String) -> String {
                """
                <html>
                    <head>
                        <style>
                            body, html {
                                margin: 0;
                                padding: 0;
                                height: 100%;
                                width: 100%;
                                overflow: hidden;
                            }
                            img {
                                width: 100%;
                                height: 100%;
                                object-fit: cover;
                            }
                        </style>
                    </head>
                    <body>
                        <img src="\(urlString)" />
                    </body>
                </html>
                """
    }
}

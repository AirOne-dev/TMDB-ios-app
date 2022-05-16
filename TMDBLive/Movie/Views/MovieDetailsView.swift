//
//  MovieDetailsView.swift
//  TMDBLive
//
//  Created by Erwan Martin on 29/03/2022.
//

import SwiftUI

var gd = Gradient(colors: [Color.primary, Color.primary, Color.black, Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255), Color.black, Color.black, Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.88), Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.75), Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.5), Color.clear.opacity(0.59)]);
var lg = LinearGradient(gradient: gd, startPoint: .bottom, endPoint: .top);
var lg_inv = LinearGradient(gradient: gd, startPoint: .top, endPoint: .bottom);


struct MovieDetailsView: View {
    let title: String;
    let length: String;
    let tags: [Int]
    let description: String;
    let notation: Float;
    let imageURL: String;
    let trailerURL: String;
    let moviesViewModel: MoviesViewModel;
    let genresViewModel: GenresViewModel;
    
    @State private var offset = 0.0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if trailerURL != "false" {
                    WebView(url: URL(string: trailerURL.replacingOccurrences(of: ".be", with: "be.com/embed") + "?controls=0&modestbranding=1&showinfo=0&rel=0")!)
                        .opacity(0.0)
                }
                ImageView(withURL: imageURL)
                    .opacity(1 - offset*1.25)
                    .frame(width: 0)
                GeometryReader { geo in
                    ScrollView(showsIndicators: false) {
                        Group {
                            VStack(spacing: 0) {
                                Spacer()
                                VStack(spacing: 16) {
                                    HStack {
                                        Button(action: {
                                            ApiViewModel.webView?.evaluateJavaScript("writeEmbed();");
                                        }) {
                                            HStack {
                                                Image(systemName: "play.fill")
                                                Text("Bande Annonce")
                                            }
                                            .font(Font.system(.title3, design: .default).weight(.semibold))
                                            .padding(.vertical, 15)
                                            .padding(.horizontal, 60)
                                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .foregroundColor(.white), alignment: .center)
                                            .foregroundColor(.black)
                                        }
                                    }
                                    HStack {
                                        Text(title).font(.title).bold()
                                        Spacer()
                                        Text(length)
                                        
                                    }
                                    HStack() {
                                        ForEach(tags, id: \.self) { tag in
                                            let g = genresViewModel.genres.first(where: {$0.id == tag})
                                            Text(g?.name ?? "").font(.callout).padding(.vertical, 4).padding(.horizontal, 8.0).overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.white, lineWidth: 1))
                                        }
                                        Spacer()
                                    }
                                    Text(description)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .clipped()
                                        .font(.callout)
                                        .lineSpacing(3)
                                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                                        Image(systemName: "star.fill")
                                        Text(String(notation))
                                    }
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .opacity(0.75)
                                }
                                .foregroundColor(Color.white)
                                .padding(.all)
                                .padding(.bottom, 20)
                                .background(VisualEffectView(style: .systemChromeMaterialDark)
                                    .mask(lg), alignment: .center)
                            }
                            .frame(height: geo.size.height)
                    }
                }
                VStack(spacing: 0) {
                    HStack() {
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss();
                        }) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.white)
                                .font(Font.title)
                        }
                        Spacer()
                    }
                    .padding(.all, 20)
                    .padding(.top, 10)
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .background(.black)
        .statusBar(hidden: true)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct VisualEffectView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieDetailsView(
            title: "Deadpool : the movie",
            length: "1h48",
            tags: [1223, 543],
            description: "Deadpool, est l'anti-héros le plus atypique de l'univers Marvel. A l'origine, il s'appelle Wade Wilson : un ancien militaire des Forces Spéciales devenu mercenaire. Après avoir subi une expérimentation hors...",
            notation: 4.6,
            imageURL: "https://www.journaldugeek.com/content/uploads/2020/11/deadpool.jpg",
            trailerURL: "",
            moviesViewModel: MoviesViewModel(),
            genresViewModel: GenresViewModel()
        )
    }
}
}

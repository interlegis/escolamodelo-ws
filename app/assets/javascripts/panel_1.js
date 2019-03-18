    ! function(e, t, n) {
        function a(e, t) {
            return typeof e === t
        }

        function o() {
            var e, t, n, o, r, s, i;
            for (var d in T)
                if (T.hasOwnProperty(d)) {
                    if (e = [], t = T[d], t.name && (e.push(t.name.toLowerCase()), t.options && t.options.aliases && t.options.aliases.length))
                        for (n = 0; n < t.options.aliases.length; n++) e.push(t.options.aliases[n].toLowerCase());
                    for (o = a(t.fn, "function") ? t.fn() : t.fn, r = 0; r < e.length; r++) s = e[r], i = s.split("."), 1 === i.length ? Modernizr[i[0]] = o : (!Modernizr[i[0]] || Modernizr[i[0]] instanceof Boolean || (Modernizr[i[0]] = new Boolean(Modernizr[i[0]])), Modernizr[i[0]][i[1]] = o), y.push((o ? "" : "no-") + i.join("-"))
                }
        }

        function r(e) {
            var t = P.className,
                n = Modernizr._config.classPrefix || "";
            if (E && (t = t.baseVal), Modernizr._config.enableJSClass) {
                var a = new RegExp("(^|\\s)" + n + "no-js(\\s|$)");
                t = t.replace(a, "$1" + n + "js$2")
            }
            Modernizr._config.enableClasses && (t += " " + n + e.join(" " + n), E ? P.className.baseVal = t : P.className = t)
        }

        function s() {
            return "function" != typeof t.createElement ? t.createElement(arguments[0]) : E ? t.createElementNS.call(t, "http://www.w3.org/2000/svg", arguments[0]) : t.createElement.apply(t, arguments)
        }

        function i(e, t) {
            return !!~("" + e).indexOf(t)
        }

        function d(e) {
            return e.replace(/([a-z])-([a-z])/g, function(e, t, n) {
                return t + n.toUpperCase()
            }).replace(/^-/, "")
        }

        function c() {
            var e = t.body;
            return e || (e = s(E ? "svg" : "body"), e.fake = !0), e
        }

        function l(e, n, a, o) {
            var r, i, d, l, u = "modernizr",
                p = s("div"),
                f = c();
            if (parseInt(a, 10))
                for (; a--;) d = s("div"), d.id = o ? o[a] : u + (a + 1), p.appendChild(d);
            return r = s("style"), r.type = "text/css", r.id = "s" + u, (f.fake ? f : p).appendChild(r), f.appendChild(p), r.styleSheet ? r.styleSheet.cssText = e : r.appendChild(t.createTextNode(e)), p.id = u, f.fake && (f.style.background = "", f.style.overflow = "hidden", l = P.style.overflow, P.style.overflow = "hidden", P.appendChild(f)), i = n(p, e), f.fake ? (f.parentNode.removeChild(f), P.style.overflow = l, P.offsetHeight) : p.parentNode.removeChild(p), !!i
        }

        function u(e, t) {
            return function() {
                return e.apply(t, arguments)
            }
        }

        function p(e, t, n) {
            var o;
            for (var r in e)
                if (e[r] in t) return n === !1 ? e[r] : (o = t[e[r]], a(o, "function") ? u(o, n || t) : o);
            return !1
        }

        function f(e) {
            return e.replace(/([A-Z])/g, function(e, t) {
                return "-" + t.toLowerCase()
            }).replace(/^ms-/, "-ms-")
        }

        function m(t, a) {
            var o = t.length;
            if ("CSS" in e && "supports" in e.CSS) {
                for (; o--;)
                    if (e.CSS.supports(f(t[o]), a)) return !0;
                return !1
            }
            if ("CSSSupportsRule" in e) {
                for (var r = []; o--;) r.push("(" + f(t[o]) + ":" + a + ")");
                return r = r.join(" or "), l("@supports (" + r + ") { #modernizr { position: absolute; } }", function(e) {
                    return "absolute" == getComputedStyle(e, null).position
                })
            }
            return n
        }

        function g(e, t, o, r) {
            function c() {
                u && (delete M.style, delete M.modElem)
            }
            if (r = a(r, "undefined") ? !1 : r, !a(o, "undefined")) {
                var l = m(e, o);
                if (!a(l, "undefined")) return l
            }
            for (var u, p, f, g, h, v = ["modernizr", "tspan", "samp"]; !M.style && v.length;) u = !0, M.modElem = s(v.shift()), M.style = M.modElem.style;
            for (f = e.length, p = 0; f > p; p++)
                if (g = e[p], h = M.style[g], i(g, "-") && (g = d(g)), M.style[g] !== n) {
                    if (r || a(o, "undefined")) return c(), "pfx" == t ? g : !0;
                    try {
                        M.style[g] = o
                    } catch (y) {}
                    if (M.style[g] != h) return c(), "pfx" == t ? g : !0
                }
            return c(), !1
        }

        function h(e, t, n, o, r) {
            var s = e.charAt(0).toUpperCase() + e.slice(1),
                i = (e + " " + B.join(s + " ") + s).split(" ");
            return a(t, "string") || a(t, "undefined") ? g(i, t, o, r) : (i = (e + " " + C.join(s + " ") + s).split(" "), p(i, t, n))
        }

        function v(e, t, a) {
            return h(e, n, n, t, a)
        }
        var y = [],
            b = "Moz O ms Webkit",
            T = [],
            w = {
                _version: "3.3.1",
                _config: {
                    classPrefix: "",
                    enableClasses: !0,
                    enableJSClass: !0,
                    usePrefixes: !0
                },
                _q: [],
                on: function(e, t) {
                    var n = this;
                    setTimeout(function() {
                        t(n[e])
                    }, 0)
                },
                addTest: function(e, t, n) {
                    T.push({
                        name: e,
                        fn: t,
                        options: n
                    })
                },
                addAsyncTest: function(e) {
                    T.push({
                        name: null,
                        fn: e
                    })
                }
            },
            Modernizr = function() {};
        Modernizr.prototype = w, Modernizr = new Modernizr, Modernizr.addTest("applicationcache", "applicationCache" in e), Modernizr.addTest("geolocation", "geolocation" in navigator), Modernizr.addTest("history", function() {
            var t = navigator.userAgent;
            return -1 === t.indexOf("Android 2.") && -1 === t.indexOf("Android 4.0") || -1 === t.indexOf("Mobile Safari") || -1 !== t.indexOf("Chrome") || -1 !== t.indexOf("Windows Phone") ? e.history && "pushState" in e.history : !1
        }), Modernizr.addTest("postmessage", "postMessage" in e), Modernizr.addTest("svg", !!t.createElementNS && !!t.createElementNS("http://www.w3.org/2000/svg", "svg").createSVGRect);
        var x = !1;
        try {
            x = "WebSocket" in e && 2 === e.WebSocket.CLOSING
        } catch (S) {}
        Modernizr.addTest("websockets", x), Modernizr.addTest("localstorage", function() {
            var e = "modernizr";
            try {
                return localStorage.setItem(e, e), localStorage.removeItem(e), !0
            } catch (t) {
                return !1
            }
        }), Modernizr.addTest("sessionstorage", function() {
            var e = "modernizr";
            try {
                return sessionStorage.setItem(e, e), sessionStorage.removeItem(e), !0
            } catch (t) {
                return !1
            }
        }), Modernizr.addTest("websqldatabase", "openDatabase" in e), Modernizr.addTest("webworkers", "Worker" in e);
        var C = w._config.usePrefixes ? b.toLowerCase().split(" ") : [];
        w._domPrefixes = C;
        var k = w._config.usePrefixes ? " -webkit- -moz- -o- -ms- ".split(" ") : ["", ""];
        w._prefixes = k;
        var P = t.documentElement,
            E = "svg" === P.nodeName.toLowerCase(),
            _ = function() {
                function e(e, t) {
                    var o;
                    return e ? (t && "string" != typeof t || (t = s(t || "div")), e = "on" + e, o = e in t, !o && a && (t.setAttribute || (t = s("div")), t.setAttribute(e, ""), o = "function" == typeof t[e], t[e] !== n && (t[e] = n), t.removeAttribute(e)), o) : !1
                }
                var a = !("onblur" in t.documentElement);
                return e
            }();
        w.hasEvent = _, Modernizr.addTest("hashchange", function() {
            return _("hashchange", e) === !1 ? !1 : t.documentMode === n || t.documentMode > 7
        }), Modernizr.addTest("audio", function() {
            var e = s("audio"),
                t = !1;
            try {
                (t = !!e.canPlayType) && (t = new Boolean(t), t.ogg = e.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/, ""), t.mp3 = e.canPlayType('audio/mpeg; codecs="mp3"').replace(/^no$/, ""), t.opus = e.canPlayType('audio/ogg; codecs="opus"') || e.canPlayType('audio/webm; codecs="opus"').replace(/^no$/, ""), t.wav = e.canPlayType('audio/wav; codecs="1"').replace(/^no$/, ""), t.m4a = (e.canPlayType("audio/x-m4a;") || e.canPlayType("audio/aac;")).replace(/^no$/, ""))
            } catch (n) {}
            return t
        }), Modernizr.addTest("canvas", function() {
            var e = s("canvas");
            return !(!e.getContext || !e.getContext("2d"))
        }), Modernizr.addTest("canvastext", function() {
            return Modernizr.canvas === !1 ? !1 : "function" == typeof s("canvas").getContext("2d").fillText
        }), Modernizr.addTest("video", function() {
            var e = s("video"),
                t = !1;
            try {
                (t = !!e.canPlayType) && (t = new Boolean(t), t.ogg = e.canPlayType('video/ogg; codecs="theora"').replace(/^no$/, ""), t.h264 = e.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/, ""), t.webm = e.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/, ""), t.vp9 = e.canPlayType('video/webm; codecs="vp9"').replace(/^no$/, ""), t.hls = e.canPlayType('application/x-mpegURL; codecs="avc1.42E01E"').replace(/^no$/, ""))
            } catch (n) {}
            return t
        }), Modernizr.addTest("webgl", function() {
            var t = s("canvas"),
                n = "probablySupportsContext" in t ? "probablySupportsContext" : "supportsContext";
            return n in t ? t[n]("webgl") || t[n]("experimental-webgl") : "WebGLRenderingContext" in e
        }), Modernizr.addTest("cssgradients", function() {
            for (var e, t = "background-image:", n = "gradient(linear,left top,right bottom,from(#9f9),to(white));", a = "", o = 0, r = k.length - 1; r > o; o++) e = 0 === o ? "to " : "", a += t + k[o] + "linear-gradient(" + e + "left top, #9f9, white);";
            Modernizr._config.usePrefixes && (a += t + "-webkit-" + n);
            var i = s("a"),
                d = i.style;
            return d.cssText = a, ("" + d.backgroundImage).indexOf("gradient") > -1
        }), Modernizr.addTest("multiplebgs", function() {
            var e = s("a").style;
            return e.cssText = "background:url(https://),url(https://),red url(https://)", /(url\s*\(.*?){3}/.test(e.background)
        }), Modernizr.addTest("opacity", function() {
            var e = s("a").style;
            return e.cssText = k.join("opacity:.55;"), /^0.55$/.test(e.opacity)
        }), Modernizr.addTest("rgba", function() {
            var e = s("a").style;
            return e.cssText = "background-color:rgba(150,255,150,.5)", ("" + e.backgroundColor).indexOf("rgba") > -1
        }), Modernizr.addTest("inlinesvg", function() {
            var e = s("div");
            return e.innerHTML = "<svg/>", "http://www.w3.org/2000/svg" == ("undefined" != typeof SVGRect && e.firstChild && e.firstChild.namespaceURI)
        });
        var z = s("input"),
            A = "autocomplete autofocus list placeholder max min multiple pattern required step".split(" "),
            R = {};
        Modernizr.input = function(t) {
            for (var n = 0, a = t.length; a > n; n++) R[t[n]] = !!(t[n] in z);
            return R.list && (R.list = !(!s("datalist") || !e.HTMLDataListElement)), R
        }(A);
        var $ = "search tel url email datetime date month week time datetime-local number range color".split(" "),
            N = {};
        Modernizr.inputtypes = function(e) {
            for (var a, o, r, s = e.length, i = "1)", d = 0; s > d; d++) z.setAttribute("type", a = e[d]), r = "text" !== z.type && "style" in z, r && (z.value = i, z.style.cssText = "position:absolute;visibility:hidden;", /^range$/.test(a) && z.style.WebkitAppearance !== n ? (P.appendChild(z), o = t.defaultView, r = o.getComputedStyle && "textfield" !== o.getComputedStyle(z, null).WebkitAppearance && 0 !== z.offsetHeight, P.removeChild(z)) : /^(search|tel)$/.test(a) || (r = /^(url|email)$/.test(a) ? z.checkValidity && z.checkValidity() === !1 : z.value != i)), N[e[d]] = !!r;
            return N
        }($), Modernizr.addTest("hsla", function() {
            var e = s("a").style;
            return e.cssText = "background-color:hsla(120,40%,100%,.5)", i(e.backgroundColor, "rgba") || i(e.backgroundColor, "hsla")
        });
        var O = "CSS" in e && "supports" in e.CSS,
            I = "supportsCSS" in e;
        Modernizr.addTest("supports", O || I);
        var L = {}.toString;
        Modernizr.addTest("svgclippaths", function() {
            return !!t.createElementNS && /SVGClipPath/.test(L.call(t.createElementNS("http://www.w3.org/2000/svg", "clipPath")))
        }), Modernizr.addTest("smil", function() {
            return !!t.createElementNS && /SVGAnimate/.test(L.call(t.createElementNS("http://www.w3.org/2000/svg", "animate")))
        });
        var B = w._config.usePrefixes ? b.split(" ") : [];
        w._cssomPrefixes = B;
        var W = w.testStyles = l;
        Modernizr.addTest("touch" /* was touchevents */ , function() {
            var n;
            if ("ontouchstart" in e || e.DocumentTouch && t instanceof DocumentTouch) n = !0;
            else {
                var a = ["@media (", k.join("touch-enabled),("), "heartz", ")", "{#modernizr{top:9px;position:absolute}}"].join("");
                W(a, function(e) {
                    n = 9 === e.offsetTop
                })
            }
            return n
        });
        var j = function() {
            var e = navigator.userAgent,
                t = e.match(/applewebkit\/([0-9]+)/gi) && parseFloat(RegExp.$1),
                n = e.match(/w(eb)?osbrowser/gi),
                a = e.match(/windows phone/gi) && e.match(/iemobile\/([0-9])+/gi) && parseFloat(RegExp.$1) >= 9,
                o = 533 > t && e.match(/android/gi);
            return n || o || a
        }();
        j ? Modernizr.addTest("fontface", !1) : W('@font-face {font-family:"font";src:url("https://")}', function(e, n) {
            var a = t.getElementById("smodernizr"),
                o = a.sheet || a.styleSheet,
                r = o ? o.cssRules && o.cssRules[0] ? o.cssRules[0].cssText : o.cssText || "" : "",
                s = /src/i.test(r) && 0 === r.indexOf(n.split(" ")[0]);
            Modernizr.addTest("fontface", s)
        }), W('#modernizr{font:0/0 a}#modernizr:after{content:":)";visibility:hidden;font:7px/1 a}', function(e) {
            Modernizr.addTest("generatedcontent", e.offsetHeight >= 7)
        });
        var V = {
            elem: s("modernizr")
        };
        Modernizr._q.push(function() {
            delete V.elem
        });
        var M = {
            style: V.elem.style
        };
        Modernizr._q.unshift(function() {
            delete M.style
        });
        var q = w.testProp = function(e, t, a) {
            return g([e], n, t, a)
        };
        Modernizr.addTest("textshadow", q("textShadow", "1px 1px")), w.testAllProps = h, w.testAllProps = v, Modernizr.addTest("cssanimations", v("animationName", "a", !0)), Modernizr.addTest("backgroundsize", v("backgroundSize", "100%", !0)), Modernizr.addTest("borderimage", v("borderImage", "url() 1", !0)), Modernizr.addTest("borderradius", v("borderRadius", "0px", !0)), Modernizr.addTest("boxshadow", v("boxShadow", "1px 1px", !0)),
            function() {
                Modernizr.addTest("csscolumns", function() {
                    var e = !1,
                        t = v("columnCount");
                    try {
                        (e = !!t) && (e = new Boolean(e))
                    } catch (n) {}
                    return e
                });
                for (var e, t, n = ["Width", "Span", "Fill", "Gap", "Rule", "RuleColor", "RuleStyle", "RuleWidth", "BreakBefore", "BreakAfter", "BreakInside"], a = 0; a < n.length; a++) e = n[a].toLowerCase(), t = v("column" + n[a]), ("breakbefore" === e || "breakafter" === e || "breakinside" == e) && (t = t || v(n[a])), Modernizr.addTest("csscolumns." + e, t)
            }(), Modernizr.addTest("flexbox", v("flexBasis", "1px", !0)), Modernizr.addTest("cssreflections", v("boxReflect", "above", !0)), Modernizr.addTest("csstransforms", function() {
            return -1 === navigator.userAgent.indexOf("Android 2.") && v("transform", "scale(1)", !0)
        }), Modernizr.addTest("csstransforms3d", function() {
            var e = !!v("perspective", "1px", !0),
                t = Modernizr._config.usePrefixes;
            if (e && (!t || "webkitPerspective" in P.style)) {
                var n, a = "#modernizr{width:0;height:0}";
                Modernizr.supports ? n = "@supports (perspective: 1px)" : (n = "@media (transform-3d)", t && (n += ",(-webkit-transform-3d)")), n += "{#modernizr{width:7px;height:18px;margin:0;padding:0;border:0}}", W(a + n, function(t) {
                    e = 7 === t.offsetWidth && 18 === t.offsetHeight
                })
            }
            return e
        }), Modernizr.addTest("csstransitions", v("transition", "all", !0)), o(), r(y), delete w.addTest, delete w.addAsyncTest;
        for (var G = 0; G < Modernizr._q.length; G++) Modernizr._q[G]();
        e.Modernizr = Modernizr
    }(window, document);
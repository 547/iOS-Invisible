var $pluginID = "com.mob.sharesdk.KaKao";eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([5-9a-fhk-mo-zA-Z]|[1-3]\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('a F={"1E":"app_key","1e":"rest_api_key","1f":"2h","1F":"auth_type","1G":"covert_url"};a 2i={"2K":0,"2L":1};d o(w){b.2M=w;b.t={"L":6,"M":6};b.1o=6;b.1g=6}o.p.w=d(){A b.2M};o.p.U=d(){A"o"};o.p.12=d(){7(b.t["M"]!=6&&b.t["M"][F.1E]!=6){A b.t["M"][F.1E]}k 7(b.t["L"]!=6&&b.t["L"][F.1E]!=6){A b.t["L"][F.1E]}A 6};o.p.1p=d(){7(b.t["M"]!=6&&b.t["M"][F.1e]!=6){A b.t["M"][F.1e]}k 7(b.t["L"]!=6&&b.t["L"][F.1e]!=6){A b.t["L"][F.1e]}A 6};o.p.1h=d(){7(b.t["M"]!=6&&b.t["M"][F.1f]!=6){A b.t["M"][F.1f]}k 7(b.t["L"]!=6&&b.t["L"][F.1f]!=6){A b.t["L"][F.1f]}A 6};o.p.W=d(){7(b.t["M"]!=6&&b.t["M"][F.1F]!=6){A b.t["M"][F.1F]}k 7(b.t["L"]!=6&&b.t["L"][F.1F]!=6){A b.t["L"][F.1F]}A $5.9.W()};o.p.2j=d(){A"2N-2O-"+b.w()+"-"+b.1p()};o.p.2k=d(){7(b.t["M"]!=6&&b.t["M"][F.1G]!=6){A b.t["M"][F.1G]}k 7(b.t["L"]!=6&&b.t["L"][F.1G]!=6){A b.t["L"][F.1G]}A $5.9.2k()};o.p.2P=d(1q){7(2Q.P==0){A b.t["L"]}k{b.t["L"]=b.2l(1q);b.2m()}};o.p.2R=d(1q){7(2Q.P==0){A b.t["M"]}k{b.t["M"]=b.2l(1q);b.2m()}};o.p.saveConfig=d(){a e=b;a 1i="2N-2O";$5.I.2S("2T",13,1i,d(8){7(8!=6){a 1H=8.1q;7(1H==6){1H={}}1H["plat_"+e.w()]=e.1p();$5.I.2U("2T",1H,13,1i,6)}})};o.p.isSupportAuth=d(){A 1X};o.p.2V=d(y,Q){a f=6;7(b.2W()){a e=b;a W=b.W();7(W=="2n"||W=="sso"){$5.I.isMultitaskingSupported(d(8){7(8.u){e.2X(d(1j,1r){7(1j){e.2Y(y,1r,Q)}k 7(W=="2n"){e.17(y,Q)}k{a f={"B":$5.9.G.UnsetURLScheme,"K":"分享平台［"+e.U()+"］尚未配置2Z 30:"+e.1o+"，无法进行授权!"};$5.R.X(y,$5.9.q.E,f)}})}k 7(W=="2n"){e.17(y,Q)}k{a f={"B":$5.9.G.1I,"K":"分享平台［"+e.U()+"］不支持["+W+"]授权方式!"};$5.R.X(y,$5.9.q.E,f)}})}k 7(W=="web"){e.17(y,Q)}k{f={"B":$5.9.G.1I,"K":"分享平台［"+b.U()+"］不支持["+W+"]授权方式!"};$5.R.X(y,$5.9.q.E,f)}}k{f={"B":$5.9.G.InvaildPlatform,"K":"分享平台［"+b.U()+"］应用信息无效!"};$5.R.X(y,$5.9.q.E,f)}};o.p.cancelAuthorize=d(){b.1J(6,6)};o.p.31=d(1Y,c){a e=b;a l={};7(1Y!=6){a f={"B":$5.9.G.1I,"K":"分享平台［"+e.U()+"］不支持获取其他用户资料!"};7(c!=6){c($5.9.q.E,f)}A}b.18(d(v){l["propertyKeys"]=$5.J.1s(["2o","thumbnail_image","32"]);e.1k("19://1t.Y.14/v1/v/me","33",l,6,d(C,8){a h=8;7(C==$5.9.q.S){h={"34":e.w()};e.35(h,8);7(h["1K"]==v["1K"]){h["Z"]=v["Z"]}}7(c!=6){c(C,h)}})})};o.p.addFriend=d(y,v,c){a f={"B":$5.9.G.1I,"K":"平台["+b.U()+"]不支持添加好友方法!"};7(c!=6){c($5.9.q.E,f)}};o.p.getFriends=d(cursor,size,c){a f={"B":$5.9.G.1I,"K":"平台["+b.U()+"]不支持添加好友方法!"};7(c!=6){c($5.9.q.E,f)}};o.p.share=d(y,r,c){a e=b;a l={};a f=6;a s=6;a 1Z=r["kakao_scene"];7(1Z==6){1Z=2i.2K}20(1Z){10 2i.2L:s=$5.9.s.36;b.37(s,r,c);O;2p:s=$5.9.s.KaKaoStory;b.38(s,r,c);O}};o.p.handleAuthCallback=d(y,1a){a f=6;a e=b;a 21=$5.J.parseUrl(1a);7(21!=6&&21.1Y!=6){a l=$5.J.parseUrlParameters(21.1Y);7(l!=6&&l.1v!=6){l["39"]=b.1p();l["grant_type"]="authorization_code";l["2h"]=b.1h();$5.I.3a(b.w(),6,"19://3b.Y.14/3c/2q","1L",l,6,d(8){7(8!=6){7(8["B"]!=6){7(c){c($5.9.q.E,8)}}k{a 1w=$5.J.3d($5.J.3e(8["3f"]));7(8["3g"]==3h){e.2r(y,1w)}k{a 1v=$5.9.G.V;f={"B":1v,"22":1w};7(c){c($5.9.q.E,f)}}}}k{f={"B":$5.9.G.V};$5.R.X(y,$5.9.q.E,f)}})}k{f={"B":$5.9.G.3i,"K":"无效的授权回调:["+1a+"]"};$5.R.X(y,$5.9.q.E,f)}}k{f={"B":$5.9.G.3i,"K":"无效的授权回调:["+1a+"]"};$5.R.X(y,$5.9.q.E,f)}};o.p.handleSSOCallback=d(y,1a,3j,3k){7(1a.indexOf(b.1o+"://")==0){a e=b;$5.I.ssdk_kakaoHandleSSOCallback(b.12(),1a,d(8){20(8.C){10 $5.9.q.S:{e.2r(y,8.u);O}10 $5.9.q.E:{a f={"B":$5.9.G.V,"22":{"B":8.B,"K":8.K}};$5.R.X(y,$5.9.q.E,f);O}2p:$5.R.X(y,$5.9.q.Cancel,6);O}});A 1X}A 13};o.p.handleShareCallback=d(y,1a,3j,3k){A 13};o.p.1k=d(x,3l,l,1M,c){a f=6;a e=b;b.18(d(v){7(v!=6){7(l==6){l={}}7(1M==6){1M={}}7(v.Z!=6){1M["Authorization"]="Bearer "+v.Z.2q}$5.I.3a(e.w(),6,x,3l,l,1M,d(8){7(8!=6){a 1w=$5.J.3d($5.J.3e(8["3f"]));7(8["3g"]==3h){7(c){c($5.9.q.S,1w)}}k{a 1v=$5.9.G.V;f={"B":1v,"22":1w};7(c){c($5.9.q.E,f)}}}k{f={"B":$5.9.G.V};7(c){c($5.9.q.E,f)}}})}k{f={"B":$5.9.G.UserUnauth,"K":"尚未授权["+e.U()+"]用户"};7(c){c($5.9.q.E,f)}}})};o.p.2l=d(1x){1x[F.1e]=$5.J.3m(1x[F.1e]);1x[F.1f]=$5.J.3m(1x[F.1f]);A 1x};o.p.2W=d(){7(b.1p()!=6&&b.1h()!=6){A 1X}$5.R.3n("#3o:["+b.U()+"]应用信息有误，不能进行相关操作。请检查本地代码中和服务端的["+b.U()+"]平台应用配置是否有误! \\n本地配置:"+$5.J.1s(b.2P())+"\\n服务器配置:"+$5.J.1s(b.2R()));A 13};o.p.17=d(y,Q){a 3p="19://3b.Y.14/3c/2V?39="+$5.J.1y(b.1p())+"&response_type=1v&2h="+$5.J.1y(b.1h())+"&C="+(3q 3r().3s());$5.R.ssdk_openAuthUrl(y,3p,b.1h())};o.p.2r=d(y,23){a e=b;a Z={"2q":23["access_token"],"expired":(3q 3r().3s()+23["expires_in"]*1000),"1l":23,"w":$5.9.credentialType.OAuth2};a v={"34":b.w(),"Z":Z};b.1J(v,d(){e.31(6,d(C,8){7(C==$5.9.q.S){v["Z"]["1K"]=8["1K"].1z();8["Z"]=v["Z"];v=8;e.1J(v,6);$5.R.X(y,$5.9.q.S,v)}k{a f={"B":$5.9.G.V,"22":8};e.1J(6,6);$5.R.X(y,$5.9.q.E,f)}})})};o.p.1J=d(v,c){b.1g=v;a 1i=b.2j();$5.I.2U("3t",b.1g,13,1i,d(8){7(c!=6){c()}})};o.p.18=d(c){7(b.1g!=6){7(c){c(b.1g)}}k{a e=b;a 1i=b.2j();$5.I.2S("3t",13,1i,d(8){e.1g=8!=6?8.1q:6;7(c){c(e.1g)}})}};o.p.35=d(v,1A){7(v!=6&&1A!=6){v["1l"]=1A;v["1K"]=1A["id"].1z();v["2o"]=1A["2o"];v["icon"]=1A["32"]}};o.p.2s=d(s,r){a w=$5.9.T.2t;a z=$5.9.D(b.w(),r,"z");a x=$5.9.D(b.w(),r,"x");a 15=$5.9.D(s,r,"25");a 1N=$5.9.D(s,r,"2u");a 1B=$5.9.D(s,r,"3u");7(s==$5.9.s.36&&(15!=6||1N!=6||1B!=6)){w=$5.9.T.3v}k 7(x!=6){w=$5.9.T.2v}k 7(26.p.1z.27(z)===\'[28 29]\'){w=$5.9.T.2w}A w};o.p.1b=d(11,c){7(b.2k()){a e=b;b.18(d(v){$5.9.convertUrl(e.w(),v,11,c)})}k{7(c){c({"u":11})}}};o.p.3w=d(x,c){7(!/^(1m\\:\\/)?\\//.1O(x)){$5.I.downloadFile(x,d(8){7(8.u!=6){7(c!=6){c(8.u)}}k{7(c!=6){c(6)}}})}k{7(c!=6){c(x)}}};o.p.2x=d(z,1n,c){7(z.P>1n){a e=b;b.3w(z[1n],d(x){7(x!=6){z[1n]=x;1n++}k{z.splice(1n,1)}e.2x(z,1n,c)})}k{7(c!=6){c(z)}}};o.p.2m=d(){b.1o="Y"+b.12()};o.p.2X=d(c){a e=b;$5.I.3x(d(8){a 1r=6;a 1j=13;7(8!=6&&8.2y!=6){2a(a i=0;i<8.2y.P;i++){a 1P=8.2y[i];7(1P!=6&&1P.2z!=6){2a(a j=0;j<1P.2z.P;j++){a 2A=1P.2z[j];7(2A==e.1o){1j=1X;1r=2A;O}}}7(1j){O}}}7(!1j){$5.R.3n("#3o:尚未配置["+e.U()+"]2Z 30:"+e.1o+", 无法使用进行授权。")}7(c!=6){c(1j,1r)}})};o.p.2Y=d(y,1r,Q){a e=b;$5.I.isPluginRegisted("14.5.sharesdk.connector.Y",d(8){7(8.u){a 2b=6;7(Q!=6&&Q["2B"]!=6&&26.p.1z.27(Q["2B"])===\'[28 29]\'){2b=Q["2B"].join(",")}$5.I.2C("kakaokompassauth://",d(8){7(8.u){$5.I.3y(e.12(),e.1h(),2b,2,d(8){7(8["B"]!=6){e.17(y,Q)}})}k{$5.I.2C("storykompassauth://",d(8){7(8.u){$5.I.3y(e.12(),e.1h(),2b,4,d(8){7(8["B"]!=6){e.17(y,Q)}})}k{e.17(y,Q)}})}})}k{e.17(y,Q)}})};o.p.37=d(s,r,c){a e=b;a 1c=r!=6?r["@1c"]:6;a H={"@1c":1c};a w=$5.9.D(s,r,"w");7(w==6){w=$5.9.T.2c}7(w==$5.9.T.2c){w=b.2s(s,r)}a f=6;a N=6;a 1Q=6;a 1R=6;a 16=6;a x=6;a 2D=6;a 15=6;a 2d=6;a 1B=6;a m=$5.9.D(s,r,"m");a z=$5.9.D(s,r,"z");7(26.p.1z.27(z)===\'[28 29]\'&&z.P>0){2a(a i=0;i<z.P;i++){7(!/^(1m\\:\\/)?\\//.1O(z[i])){N=z[i];O}}}1Q=$5.9.D(s,r,"image_width");1R=$5.9.D(s,r,"image_height");16=$5.9.D(s,r,"16");x=$5.9.D(s,r,"x");2D=$5.9.D(s,r,"app_button_title");15=$5.9.D(s,r,"25");2d=$5.9.D(s,r,"2u");1B=$5.9.D(s,r,"3u");20(w){10 $5.9.T.2t:7(m!=6){b.1b([m],d(8){m=8.u[0];$5.I.ssdk_kakaoShareText(e.12(),1,m,d(8){a h=8.u;7(8.C==$5.9.q.S){h={};h["m"]=m}7(c!=6){c(8.C,h,6,H)}})})}k{f={"B":$5.9.G.V,"K":"分享参数m不能为空!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;10 $5.9.T.2w:7(N!=6){b.1b([m],d(8){m=8.u[0];$5.I.ssdk_kakaoShareImage(e.12(),1,m,N,1Q,1R,d(8){a h=8.u;7(8.C==$5.9.q.S){h={};h["m"]=m;h["z"]=[N]}7(c!=6){c(8.C,h,6,H)}})})}k{f={"B":$5.9.G.V,"K":"分享参数N不能为空或者不是网络图片!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;10 $5.9.T.2v:7(x!=6){b.1b([m,x],d(8){m=8.u[0];x=8.u[1];$5.I.ssdk_kakaoShareWebpage(e.12(),1,m,N,1Q,1R,16,x,d(8){a h=8.u;7(8.C==$5.9.q.S){h={};h["1l"]={"16":16};h["m"]=m;h["z"]=[N];h["2E"]=[x]}7(c!=6){c(8.C,h,6,H)}})})}k{f={"B":$5.9.G.V,"K":"分享参数x不能为空!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;10 $5.9.T.3v:b.1b([m,x],d(8){m=8.u[0];x=8.u[1];$5.I.ssdk_kakaoShareApp(e.12(),1,m,N,1Q,1R,16,x,2D,15,2d,1B,d(8){a h=8.u;7(8.C==$5.9.q.S){h={};h["1l"]={"16":16,"android_exec_params":15,"iphone_exec_params":2d,"ipad_exec_params":1B};h["m"]=m;h["z"]=[N];h["2E"]=[x]}7(c!=6){c(8.C,h,6,H)}})});O}};o.p.38=d(s,r,c){a e=b;a l={};a f=6;a 3z=r!=6?r["@client_share"]:13;a m=6;a z=6;a x=6;a 11=6;a 1S=$5.9.D(s,r,"1S");a 2F=$5.9.D(s,r,"3A");a 15=$5.9.D(s,r,"25");a 1N=$5.9.D(s,r,"2u");a 1C=$5.9.D(s,r,"1T");a 1D=$5.9.D(s,r,"iphone_market_param");7(1S!=6){l["1S"]=1S}7(2F!=6){l["3A"]=2F}7(15!=6){l["25"]=15}7(1N!=6){l["ios_exec_param"]=1N}7(1C!=6){l["1T"]=1C}7(1D!=6){l["2e"]=1D}a 1c=r!=6?r["@1c"]:6;a H={"@1c":1c};a w=$5.9.D(s,r,"w");7(w==6){w=$5.9.T.2c}7(w==$5.9.T.2c){w=b.2s(s,r)}20(w){10 $5.9.T.2t:m=$5.9.D(s,r,"m");l["1d"]=m;7(m!=6){11=[m,1C,1D];e.1b(11,d(8){l["1d"]=8.u[0];7(8.u.P>1){l["1T"]=8.u[1]}7(8.u.P>2){l["2e"]=8.u[2]}7(3z){$5.I.3x(d(8){7(8!=6){a 2G="storylink://posting";a 3B=8.CFBundleIdentifier;a 3C=8.CFBundleName;a 3D=8.CFBundleShortVersionString;$5.I.2C(2G,d(8){7(8.u){a 3E=2G+"?2f="+$5.J.1y(l["1d"])+"&apiver=1.0&appid="+$5.J.1y(3B)+"&appver="+$5.J.1y(3D)+"&appname="+$5.J.1y(3C);$5.R.openURL(3E);e.18(d(v){a h={"m":l["1d"]};7(c!=6){c($5.9.q.S,h,v,H)}})}k{e.2g(l,H,c)}})}k{e.2g(l,H,c)}})}k{e.2g(l,H,c)}})}k{f={"B":$5.9.G.V,"K":"分享参数m不能为空!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;10 $5.9.T.2w:m=$5.9.D(s,r,"m");z=$5.9.D(s,r,"z");7(26.p.1z.27(z)===\'[28 29]\'&&z.P>0){b.2x(z,0,d(z){a 2H={"1m":[]};2a(a i=0;i<z.P;i++){a N=z[i];a 1U="application/octet-stream";7(/\\.jpe?g$/.1O(N)){1U="N/jpeg"}k 7(/\\.3F$/.1O(N)){1U="N/3F"}k 7(/\\.3G$/.1O(N)){1U="N/3G"}a 1m={"path":N,"mime_type":1U};2H["1m"].push("@1m("+$5.J.1s(1m)+")");e.1k("19://1t.Y.14/v1/1V/1W/upload/multi","1L",2H,6,d(C,8){7(C==$5.9.q.S){a 2I=8;l["1d"]=m;l["image_url_list"]=$5.J.1s(2I);11=[m,1C,1D];e.1b(11,d(8){l["1d"]=8.u[0];7(8.u.P>1){l["1T"]=8.u[1]}7(8.u.P>2){l["2e"]=8.u[2]}e.18(d(v){e.1k("19://1t.Y.14/v1/1V/1W/2f/photo","1L",l,6,d(C,8){a h=8;7(C==$5.9.q.S){h={};h["1l"]=8;h["2J"]=8["id"];h["m"]=m;h["z"]=2I}7(c!=6){c(C,h,v,H)}})})})}k{7(c!=6){c($5.9.q.E,8,6,H)}}})}})}k{f={"B":$5.9.G.V,"K":"分享参数z不能为空!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;10 $5.9.T.2v:m=$5.9.D(s,r,"m");x=$5.9.D(s,r,"x");7(x!=6){11=[m,x,1C,1D];e.1b(11,d(8){l["1d"]=8.u[0];7(8.u.P>2){l["1T"]=8.u[2]}7(8.u.P>3){l["2e"]=8.u[3]}a 3H={"x":8.u[1]};e.1k("19://1t.Y.14/v1/1V/1W/linkinfo","33",3H,6,d(C,8){7(C==$5.9.q.S){l["link_info"]=$5.J.1s(8);e.18(d(v){e.1k("19://1t.Y.14/v1/1V/1W/2f/link","1L",l,6,d(C,8){a h=8;7(C==$5.9.q.S){h={};h["1l"]=8;h["2J"]=8["id"];h["m"]=m;h["2E"]=[x]}7(c!=6){c(C,h,v,H)}})})}k{7(c!=6){c($5.9.q.E,8,6,H)}}})})}k{f={"B":$5.9.G.V,"K":"分享参数x不能为空!"};7(c!=6){c($5.9.q.E,f,6,H)}}O;2p:f={"B":$5.9.G.UnsupportContentType,"K":"不支持的分享类型["+w+"]"};7(c!=6){c($5.9.q.E,f,6,H)}O}};o.p.2g=d(l,H,c){a e=b;e.18(d(v){e.1k("19://1t.Y.14/v1/1V/1W/2f/note","1L",l,6,d(C,8){a h=8;7(C==$5.9.q.S){h={};h["1l"]=8;h["2J"]=8["id"];h["m"]=l["1d"]}7(c!=6){c(C,h,v,H)}})})};$5.9.registerPlatformClass($5.9.s.o,o);',[],230,'|||||mob|null|if|data|shareSDK|var|this|callback|function|self|error||resultData|||else|params|text||KaKao|prototype|responseState|parameters|platformType|_appInfo|result|user|type|url|sessionId|images|return|error_code|state|getShareParam|Fail|KaKaoInfoKeys|errorCode|userData|ext|utils|error_message|local|server|image|break|length|settings|native|Success|contentType|name|APIRequestFail|authType|ssdk_authStateChanged|kakao|credential|case|contents|appKey|false|com|androidExecParams|title|_webAuthorize|_getCurrentUser|https|callbackUrl|_convertUrl|flags|content|RestApiKey|RedirectUri|_currentUser|redirectUri|domain|hasReady|callApi|raw_data|file|index|_urlScheme|restApiKey|value|urlScheme|objectToJsonString|kapi||code|response|appInfo|urlEncode|toString|rawData|ipadExecParams|andoridMarkParam|iosMarkParam|AppKey|AuthType|ConvertUrl|curApps|UnsupportFeature|_setCurrentUser|uid|POST|headers|iosExecParams|test|typeObj|imageWidth|imageHeight|permission|android_market_param|mimeType|api|story|true|query|scene|switch|urlInfo|user_data|credentialRawData||android_exec_param|Object|apply|object|Array|for|scope|Auto|iphoneExecParams|ios_market_param|post|_storyShareText|redirect_uri|KaKaoScene|cacheDomain|convertUrlEnabled|_checkAppInfoAvailable|_updateUrlScheme|both|nickname|default|token|_succeedAuthorize|_getShareType|Text|iphone_exec_param|WebPage|Image|_getImagesPath|CFBundleURLTypes|CFBundleURLSchemes|schema|scopes|canOpenURL|appButtonTitle|urls|enableShare|baseUrl|uploadParams|imageList|cid|Story|Talk|_type|SSDK|Platform|localAppInfo|arguments|serverAppInfo|getCacheData|currentApp|setCacheData|authorize|_isAvailable|_checkUrlScheme|_ssoAuthorize|URL|Scheme|getUserInfo|profile_image|GET|platform_type|_updateUserInfo|KaKaoTalk|_talkShare|_storyShare|client_id|ssdk_callHTTPApi|kauth|oauth|jsonStringToObject|base64Decode|response_data|status_code|200|InvalidAuthCallback|sourceApplication|annotation|method|trim|log|warning|authUrl|new|Date|getTime|currentUser|ipad_exec_param|App|_getImagePath|getAppConfig|ssdk_kakaoAuth|enableUseClientShare|enable_share|bundleId|appName|appVer|reqUrl|png|gif|linkParams'.split('|'),0,{}))
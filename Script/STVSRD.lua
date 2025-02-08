--// Services
local UserInputService = game:GetService("UserInputService")

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
    Title = "Slendytubbies VS Redux",
    Theme = "Void",
    Size = UDim2.fromOffset(500, 270),
    Transparency = 0.2,
    Blurring = false,
    MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

local Themes = {
    Light = {
        Primary = Color3.fromRGB(232, 232, 232),
        Secondary = Color3.fromRGB(255, 255, 255),
        Component = Color3.fromRGB(245, 245, 245),
        Interactables = Color3.fromRGB(235, 235, 235),
        Tab = Color3.fromRGB(50, 50, 50),
        Title = Color3.fromRGB(0, 0, 0),
        Description = Color3.fromRGB(100, 100, 100),
        Shadow = Color3.fromRGB(255, 255, 255),
        Outline = Color3.fromRGB(210, 210, 210),
        Icon = Color3.fromRGB(100, 100, 100),
    },
    Dark = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(35, 35, 35),
        Component = Color3.fromRGB(40, 40, 40),
        Interactables = Color3.fromRGB(45, 45, 45),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
    Void = {
        Primary = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(20, 20, 20),
        Component = Color3.fromRGB(25, 25, 25),
        Interactables = Color3.fromRGB(30, 30, 30),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
}

--// Set the default theme
Window:SetTheme(Themes.Void)

--// Sections
Window:AddTabSection({ Name = "STVSRD", Order = 1 })

--// Tab [MAIN]
local Main = Window:AddTab({
    Title = "Main",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

local Farm = Window:AddTab({
    Title = "Farm",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

local Misc = Window:AddTab({
    Title = "Misc",
    Section = "STVSRD",
    Icon = "rbxassetid://11963373994"
})

Window:AddSection({ Name = "Notification", Tab = Main }) 

([[This file was protected with MoonSec V3]]):gsub('.+', (function(a) _wBEQoZVVyeiT = a; end)); return(function(o,...)local h;local u;local f;local l;local r;local d;local e=24915;local n=0;local t={};while n<568 do n=n+1;while n<0x3df and e%0xeaa<0x755 do n=n+1 e=(e-186)%42303 local a=n+e if(e%0x1844)>=0xc22 then e=(e-0xda)%0x83f2 while n<0x29b and e%0xc8c<0x646 do n=n+1 e=(e-394)%22393 local d=n+e if(e%0x2660)<=0x1330 then e=(e-0xf5)%0x2290 local e=26904 if not t[e]then t[e]=0x1 l=(not l)and _ENV or l;end elseif e%2~=0 then e=(e*0x179)%0x3d95 local e=17849 if not t[e]then t[e]=0x1 end else e=(e+0x347)%0xbad8 n=n+1 local e=20318 if not t[e]then t[e]=0x1 end end end elseif e%2~=0 then e=(e-0x111)%0x589b while n<0xd4 and e%0xc58<0x62c do n=n+1 e=(e+241)%9586 local a=n+e if(e%0x175c)>=0xbae then e=(e*0x21)%0x46da local e=90980 if not t[e]then t[e]=0x1 u=tonumber;end elseif e%2~=0 then e=(e*0x34)%0xa561 local e=2971 if not t[e]then t[e]=0x1 d=function(d)local e=0x01 local function t(n)e=e+n return d:sub(e-n,e-0x01)end while true do local n=t(0x01)if(n=="\5")then break end local e=f.byte(t(0x01))local e=t(e)if n=="\2"then e=r.da_sFohX(e)elseif n=="\3"then e=e~="\0"elseif n=="\6"then l[e]=function(e,n)return o(8,nil,o,n,e)end elseif n=="\4"then e=l[e]elseif n=="\0"then e=l[e][t(f.byte(t(0x01)))];end local n=t(0x08)r[n]=e end end end else e=(e-0x26a)%0x9334 n=n+1 local e=6801 if not t[e]then t[e]=0x1 h="\4\8\116\111\110\117\109\98\101\114\100\97\95\115\70\111\104\88\0\6\115\116\114\105\110\103\4\99\104\97\114\122\95\114\97\87\75\110\80\0\6\115\116\114\105\110\103\3\115\117\98\120\109\83\108\120\113\110\100\0\6\115\116\114\105\110\103\4\98\121\116\101\86\117\102\121\113\110\116\100\0\5\116\97\98\108\101\6\99\111\110\99\97\116\115\118\81\108\122\65\79\82\0\5\116\97\98\108\101\6\105\110\115\101\114\116\105\74\118\68\85\97\85\99\5";end end end else e=(e-0x18c)%0x6e0f n=n+1 while n<0x32d and e%0x45f8<0x22fc do n=n+1 e=(e+972)%30058 local d=n+e if(e%0x3c88)>=0x1e44 then e=(e*0x3af)%0x6259 local e=45020 if not t[e]then t[e]=0x1 l=getfenv and getfenv();end elseif e%2~=0 then e=(e+0xe6)%0x8ccc local e=80329 if not t[e]then t[e]=0x1 f=string;end else e=(e+0x287)%0x1bde n=n+1 local e=71428 if not t[e]then t[e]=0x1 r={};end end end end end e=(e+965)%4127 end d(h);local n={};for e=0x0,0xff do local t=r.z_raWKnP(e);n[e]=t;n[t]=e;end local function a(e)return n[e];end local h=(function(f,o)local h,t=0x01,0x10 local n={{},{},{}}local l=-0x01 local e=0x01 local d=f while true do n[0x03][r.xmSlxqnd(o,e,(function()e=h+e return e-0x01 end)())]=(function()l=l+0x01 return l end)()if l==(0x0f)then l=""t=0x000 break end end local l=#o while e<l+0x01 do n[0x02][t]=r.xmSlxqnd(o,e,(function()e=h+e return e-0x01 end)())t=t+0x01 if t%0x02==0x00 then t=0x00 r.iJvDUaUc(n[0x01],(a((((n[0x03][n[0x02][0x00]]or 0x00)*0x10)+(n[0x03][n[0x02][0x01]]or 0x00)+d)%0x100)));d=f+d;end end return r.svQlzAOR(n[0x01])end);d(h(28,"k(/Vz50eco6AyEs#so"));d(h(30,"a7L(B>1gOA*pur.M.Lu*7AMurup>AuggM1(OLpc>.*pBAOgO11B*7MM(t(gI>(*xg>>>BLLBr.r1*pAMgL1A(*WA*pA7r.uLApOL1*(g?.U#.r*7pO1pgg.Or#7MFL.Lpp*LgrMrBg7r7L.(u*O1A*1*>B7LLtD(pp>B(*O>>p>WL1*>..uO*p*lg*(g(.LAMO.Yu(Ag>MIJ.*((fgMOr(*rA.1r1L(77BlkrprLguO*gLLB(pM*uM1u>7OLg(>(B1L(ZO*ppLA>1AgLBA7BMrr71.>_*>g7>pBO7jr.rpurAO1pBA((uO*Au(*r*(g>1p(uL7n.MLO+11pBA7gg>*(*7(M*r>*OA*gA>.LAL._(uB1DBgAO1gB*(177AB.>u,*Bgg>pB>(HSBMOur*rgL>/(3r:pB%>. uBAggp1>>L7(7*.A*upg1.>BM?r(Lm^BrruB*ug:>r>>LLq7M1*rppL.7L17(>7.MArAuupLg1BALuL7.u.OupB*(tgp>7B17uApr.u1*pOrgL>(7gMrupu(p.gL1>Mg"));local e=(-27241+(function()local l,e=0,1;(function(n,e)e(e(e,e),e(n,n))end)(function(n,t)if l>468 then return t end l=l+1 e=(e-872)%16525 if(e%1482)<=741 then e=(e*593)%28183 return t else return t(t(n,n),t(n,n))end return n(n(t,n),t(n,n))end,function(t,n)if l>199 then return n end l=l+1 e=(e*889)%38338 if(e%482)<241 then e=(e+463)%19966 return t else return n(n(n,n),t(n and t,n))end return t(n(n,n),t(t,n))end)return e;end)())local c=r.vUzgHqFJ or r.tfxkiLHF;local ne=(getfenv)or(function()return _ENV end);local f=4;local d=3;local te=1;local l=2;local function p(s,...)local g=h(e,"V g3JFZ}th-Pzmj*P}FZ4 -zFt J-mFtc3W zjZZggPm}} hPmZPm zg}ZgJ}m}Fggm!ZjPFZFd-PFZ+Zg *z*}EgZmh%jm*Z3/jPhPt}}g3mt3,g z*}mg t}th jmP33gjmPt333z*}t3Jms}-j j3t/3ZmF3t dmmtt3gzg}*gth4} *h}gghz}}g mg}j-Zd>jzFtjgJzP}ZJJmPt-g/}tgZzm}tg3 Pm-tm3m}Pgtm>}PgZgFmmthm3tggtm3}j}m3m*3hZ3-t 33mZt gz -j3hhJJjFt*3zj*3Kj3tF3smPz}hFJYzh-}F *z-gJzt-3*m*t-3FgJ*n-hJJ*j-!FgB - Fg*z3-*Zt*3-jFj3PBJtP h_FZPgtFZ *}PlFt*3-ZJ*)3Z +zh}F-jzh}Jg3-w}PgFzjz-hFg*hhtZJQm-*F*a3P-3-IZ-zF}<3P}3F 3PjZ}-yJz*Z- Jz*h-gJm*t-JF-*h-JJ*Zmq-zJFj gP-Zz+hz Fj -P}**mzFJ**--Pm}J *zZ}JjZtZ3 gZz}}tggzjZZ JttZt *zt3F* zJtT Zz*}} gzFZjggzmJhgtzhJtg3z*}z &hhZ3gjm3Z  jP3Zj*gzJFP!tZZ  PzZ} gz Zt 3Pj}P JP*Z- Fz ZP Zz }jgPzgZj tzFZj hzJZ*g}zF}p Pzt}  mz}}ggmzt}3 jz-}J *z-t}gMzP}Zg jZ}}ggzm}hg3zj}h3Zj9}-gFm8t}gZm }z3hmt}mgtm3tgghmJ}*FLmZt_gPmZt}gzmttg3rmtt}3hmhtJg*jCtF3 mPt-3zmzt}3gjJtt3JmjthJJm*t-3Fj tP3Zj hj3}jgtm3tjFtj3hjJ-*J*jFhc3PjZh JFj}hgF3jthF3jjhhJJ3j-zFJgjPhtJ *3h}JmjmztJ}jjhPJJ*hh-JZ*1-mJ}* h*J}*}hmJt*3-jFt*J- J-*P-:Jj*Z-3Ft*}-FJm*t-3Jj*hPJFg*--}FY83-ZFJ*z-}Z3*m-tF3{(-hFF**--Z-XS-PFZ!g-zF}5g");local n=0;r.DZM_PeTA(function()r.ZFaqZKGO()n=n+1 end)local function e(e,t)if t then return n end;n=e+n;end local t,n,a=o(0,o,e,g,r.Vufyqntd);local function h()local n,t=r.Vufyqntd(g,e(1,3),e(5,6)+2);e(2);return(t*256)+n;end;local m=true;local m=0 local function z()local e=n();local n=n();local d=1;local l=(t(n,1,20)*(2^32))+e;local e=t(n,21,31);local n=((-1)^t(n,32));if(e==0)then if(l==m)then return n*0;else e=1;d=0;end;elseif(e==2047)then return(l==0)and(n*(1/0))or(n*(0/0));end;return r.Kpyflm_E(n,e-1023)*(d+(l/(2^52)));end;local p=n;local function j(n)local t;if(not n)then n=p();if(n==0)then return'';end;end;t=r.xmSlxqnd(g,e(1,3),e(5,6)+n-1);e(n)local e=""for n=(1+m),#t do e=e..r.xmSlxqnd(t,n,n)end return e;end;local m=#r.XhehQtgF(u('\49.\48'))~=1 local e=n;local function k(...)return{...},r.xZKL_Hbc('#',...)end local function _()local g={};local c={};local e={};local u={g,c,nil,e};local e=n()local o={}for l=1,e do local t=a();local e;if(t==0)then e=(a()~=#{});elseif(t==2)then local n=z();if m and r.BtbjFrsI(r.XhehQtgF(n),'.(\48+)$')then n=r.qSWCYrDU(n);end e=n;elseif(t==1)then e=j();end;o[l]=e;end;u[3]=a();for e=1,n()do c[e-(#{1})]=_();end;for c=1,n()do local e=a();if(t(e,1,1)==0)then local r=t(e,2,3);local a=t(e,4,6);local e={h(),h(),nil,nil};if(r==0)then e[d]=h();e[f]=h();elseif(r==#{1})then e[d]=n();elseif(r==s[2])then e[d]=n()-(2^16)elseif(r==s[3])then e[d]=n()-(2^16)e[f]=h();end;if(t(a,1,1)==1)then e[l]=o[e[l]]end if(t(a,2,2)==1)then e[d]=o[e[d]]end if(t(a,3,3)==1)then e[f]=o[e[f]]end g[c]=e;end end;return u;end;local function y(t,e,n)local l=e;local l=n;return u(r.BtbjFrsI(r.BtbjFrsI(({r.DZM_PeTA(t)})[2],e),n))end local function s(g,e,a)local function ee(...)local h,m,u,y,_,t,ee,b,j,z,p,n;local e=0;while-1<e do if e<=2 then if e<=0 then h=o(6,77,1,71,g);m=o(6,61,2,65,g);else if e~=-3 then repeat if e<2 then u=o(6,58,3,87,g);_=k y=0;break;end;t=-41;ee=-1;until true;else u=o(6,58,3,87,g);_=k y=0;end end else if e<=4 then if 0~=e then repeat if e>3 then z=r.xZKL_Hbc('#',...)-1;p={};break;end;b={};j={...};until true;else z=r.xZKL_Hbc('#',...)-1;p={};end else if 1<e then repeat if 5<e then e=-2;break;end;n=o(7);until true;else n=o(7);end end end e=e+1;end;for e=0,z do if(e>=u)then b[e-u]=j[e+1];else n[e]=j[e+1];end;end;local e=z-u+1 local e;local o;local function r(...)while true do end end while true do if t<-40 then t=t+42 end e=h[t];o=e[te];if o>=15 then if o<=22 then if o<19 then if o>=17 then if 14<=o then for t=26,56 do if o~=17 then n[e[l]]={};break;end;local h,a,o,f,r;local t=0;while t>-1 do if t>2 then if t>=5 then if t>=2 then for e=42,75 do if 5<t then t=-2;break;end;n(r,f);break;end;else n(r,f);end else if t==4 then r=h[a];else f=h[o];end end else if t<=0 then h=e;else if 0<t then repeat if 1~=t then o=d;break;end;a=l;until true;else o=d;end end end t=t+1 end break;end;else n[e[l]]={};end else if 11~=o then for t=22,79 do if 16~=o then n[e[l]]=s(m[e[d]],nil,a);break;end;do return end;break;end;else n[e[l]]=s(m[e[d]],nil,a);end end else if 21<=o then if 18<o then repeat if 21<o then n[e[l]][e[d]]=n[e[f]];break;end;local c,r;for o=0,5 do if o>2 then if o>3 then if 2<=o then for r=41,76 do if 5>o then n[e[l]]=a[e[d]];t=t+1;e=h[t];break;end;n[e[l]][e[d]]=n[e[f]];break;end;else n[e[l]]=a[e[d]];t=t+1;e=h[t];end else n[e[l]][e[d]]=e[f];t=t+1;e=h[t];end else if o>0 then if-1<o then for r=24,90 do if o<2 then n[e[l]]={};t=t+1;e=h[t];break;end;n[e[l]][e[d]]=e[f];t=t+1;e=h[t];break;end;else n[e[l]][e[d]]=e[f];t=t+1;e=h[t];end else c=e[l];r=n[e[d]];n[c+1]=r;n[c]=r[e[f]];t=t+1;e=h[t];end end end until true;else n[e[l]][e[d]]=n[e[f]];end else if 18~=o then for t=40,74 do if 20~=o then local e=e[l]n[e](n[e+1])break;end;n(e[l],e[d]);break;end;else local e=e[l]n[e](n[e+1])end end end else if o>=27 then if 29>o then if o>27 then a[e[d]]=n[e[l]];else t=e[d];end else if 25~=o then repeat if o<30 then do return end;break;end;if(n[e[l]]==e[f])then t=t+1;else t=e[d];end;until true;else if(n[e[l]]==e[f])then t=t+1;else t=e[d];end;end end else if 24>=o then if 24==o then if(n[e[l]]==e[f])then t=t+1;else t=e[d];end;else local t=e[l]n[t](c(n,t+1,e[d]))end else if 21~=o then repeat if 25~=o then for o=0,3 do if o>1 then if o==3 then if(n[e[l]]==e[f])then t=t+1;else t=e[d];end;else n[e[l]]=a[e[d]];t=t+1;e=h[t];end else if o==0 then n[e[l]]=(e[d]~=0);t=t+1;e=h[t];else a[e[d]]=n[e[l]];t=t+1;e=h[t];end end end break;end;n[e[l]]=(e[d]~=0);until true;else n[e[l]]=(e[d]~=0);end end end end else if o<=6 then if 2>=o then if 0<o then if o>1 then n[e[l]][e[d]]=n[e[f]];else local l=e[l];local t=n[e[d]];n[l+1]=t;n[l]=t[e[f]];end else n[e[l]]=a[e[d]];end else if o<5 then if o>3 then n[e[l]][e[d]]=e[f];else local o;n[e[l]][e[d]]=n[e[f]];t=t+1;e=h[t];o=e[l]n[o](c(n,o+1,e[d]))t=t+1;e=h[t];do return end;end else if o==6 then local t=e[l]n[t](c(n,t+1,e[d]))else n[e[l]]=(e[d]~=0);end end end else if 11<=o then if 13>o then if 12>o then t=e[d];else n[e[l]]=s(m[e[d]],nil,a);end else if o>10 then repeat if 14>o then local e=e[l]n[e](n[e+1])break;end;n[e[l]]={};until true;else n[e[l]]={};end end else if 8<o then if o>6 then repeat if 10~=o then n[e[l]][e[d]]=e[f];break;end;n[e[l]]=a[e[d]];until true;else n[e[l]]=a[e[d]];end else if o~=5 then repeat if 8~=o then local l=e[l];local t=n[e[d]];n[l+1]=t;n[l]=t[e[f]];break;end;a[e[d]]=n[e[l]];until true;else a[e[d]]=n[e[l]];end end end end end t=1+t;end;end;return ee end;local l=0xff;local a={};local f=(1);local d='';(function(n)local t=n local o=0x00 local e=0x00 t={(function(d)if o>0x1f then return d end o=o+1 e=(e+0x66c-d)%0x38 return(e%0x03==0x2 and(function(t)if not n[t]then e=e+0x01 n[t]=(0xe6);end return true end)'ABnwo'and t[0x1](0x1fd+d))or(e%0x03==0x0 and(function(t)if not n[t]then e=e+0x01 n[t]=(0xd);end return true end)'gQTGJ'and t[0x3](d+0x36b))or(e%0x03==0x1 and(function(t)if not n[t]then e=e+0x01 n[t]=(0xf7);a[f]=ne();f=f+l;end return true end)'cuf_G'and t[0x2](d+0x199))or d end),(function(r)if o>0x22 then return r end o=o+1 e=(e+0x92c-r)%0x41 return(e%0x03==0x2 and(function(t)if not n[t]then e=e+0x01 n[t]=(0xc9);end return true end)'BTukX'and t[0x2](0x2b4+r))or(e%0x03==0x0 and(function(t)if not n[t]then e=e+0x01 n[t]=(0xd6);d='\37';l={function()l()end};d=d..'\100\43';end return true end)'Reybl'and t[0x3](r+0x118))or(e%0x03==0x1 and(function(t)if not n[t]then e=e+0x01 n[t]=(0x0);end return true end)'oBwXK'and t[0x1](r+0x257))or r end),(function(h)if o>0x2d then return h end o=o+1 e=(e+0x94c-h)%0x23 return(e%0x03==0x1 and(function(t)if not n[t]then e=e+0x01 n[t]=(0x75);l[2]=(l[2]*(y(function()a()end,c(d))-y(l[1],c(d))))+1;a[f]={};l=l[2];f=f+l;end return true end)'gidBh'and t[0x1](0x96+h))or(e%0x03==0x2 and(function(t)if not n[t]then e=e+0x01 n[t]=(0x89);end return true end)'dGevq'and t[0x2](h+0x228))or(e%0x03==0x0 and(function(t)if not n[t]then e=e+0x01 n[t]=(0x77);d={d..'\58 a',d};a[f]=_();f=f+((not r.XZXdfYKy)and 1 or 0);d[1]='\58'..d[1];l[2]=0xff;end return true end)'YXE_A'and t[0x3](h+0x232))or h end)}t[0x2](0x964)end){};local e=s(c(a));return e(...);end return p((function()local n={}local e=0x01;local t;if r.XZXdfYKy then t=r.XZXdfYKy(p)else t=''end if r.BtbjFrsI(t,r._TdoAvGq)then e=e+0;else e=e+1;end n[e]=0x02;n[n[e]+0x01]=0x03;return n;end)(),...)end)((function(t,e,n,d,l,o)local o;if t>=4 then if 5>=t then if t>4 then local t=d;do return function()local e=e(n,t(t,t),t(t,t));t(1);return e;end;end;else local t=d;local l,o,d=l(2);do return function()local e,n,f,r=e(n,t(t,t),t(t,t)+3);t(4);return(r*l)+(f*o)+(n*d)+e;end;end;end else if t>=7 then if 7~=t then do return n(t,nil,n);end else do return setmetatable({},{['__\99\97\108\108']=function(e,l,t,d,n)if n then return e[n]elseif d then return e else e[l]=t end end})end end else do return l[n]end;end end else if 1>=t then if-1<=t then for o=16,91 do if 1~=t then do return e(1),e(4,l,d,n,e),e(5,l,d,n)end;break;end;do return function(t,e,n)if n then local e=(t/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(t%(e+e)>=e)and 1 or 0;end;end;end;break;end;else do return e(1),e(4,l,d,n,e),e(5,l,d,n)end;end else if t>=-1 then for o=23,71 do if t<3 then do return 16777216,65536,256 end;break;end;do return e(1),e(4,l,d,n,e),e(5,l,d,n)end;break;end;else do return 16777216,65536,256 end;end end end end),...)

Window:AddParagraph({
	Title = "Update date: Friday, January 31, 2025",
	Description = "-a stressful time-",
	Tab = Main
})

-- Tab [FARM]

local args = {
    [1] = "Player",
    [2] = "TrainingMaze"
}

local a = false
local b = false

Window:AddToggle({
    Title = "Autofarm",
    Description = "[Beta]",
    Tab = Farm,
    Callback = function(c)
        a = c
    end,
})

Window:AddToggle({
    Title = "ESP Custards",
    Description = "",
    Tab = Farm,
    Callback = function(c)
        b = c
        updateHighlights()
    end,
})

--// Tab [MISC]

Window:AddToggle({
    Title = "NightVision",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        local Lighting = game:GetService("Lighting")
        Lighting.NightVision.Enabled = Boolean
    end,
})

Window:AddToggle({
    Title = "More light",
    Description = "",
    Tab = Misc,
    Callback = function(Boolean)
        local Lighting = game:GetService("Lighting")
        Lighting.LightningEffect.Enabled = Boolean
    end,
})

--// Tab [SETTINGS]
local Settings = Window:AddTab({
    Title = "Settings",
    Section = "STVSRD",
    Icon = "rbxassetid://11293977610",
})

Window:AddDropdown({
    Title = "Set Theme",
    Description = "Set the theme of the library!",
    Tab = Settings,
    Options = {
        ["Light Mode"] = "Light",
        ["Dark Mode"] = "Dark",
        ["Extra Dark"] = "Void",
    },
    Callback = function(Theme) 
        Window:SetTheme(Themes[Theme])
    end,
}) 

Window:AddSlider({
    Title = "UI Transparency",
    Description = "Set the transparency of the UI",
    Tab = Settings,
    AllowDecimals = true,
    MaxValue = 1,
    Callback = function(d) 
        Window:SetSetting("Transparency", d)
    end,
})

--// Highlight
local e = game.Players.LocalPlayer

local function updateHighlights()
    local f = workspace.game.gameCustard:GetDescendants()
    
    for _, g in pairs(f) do
        if g:IsA("Part") then
            if b then
                if not g:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight")
                    h.Name = "Highlight"
                    h.Parent = g
                    h.FillColor = Color3.fromRGB(235, 52, 219)
                    h.OutlineColor = Color3.fromRGB(255, 255, 255)
                    h.FillTransparency = 0.5
                    h.OutlineTransparency = 0.5

                    local k = Instance.new("PointLight")
                    k.Parent = g
                    k.Color = Color3.fromRGB(232, 85, 242)
                    k.Range = 10
                    k.Brightness = 2
                end

                local i = g:FindFirstChild("BillboardGui")
                local j
                if not i then
                    i = Instance.new("BillboardGui")
                    i.Name = "BillboardGui"
                    i.Adornee = g
                    i.Size = UDim2.new(0, 200, 0, 50)
                    i.StudsOffset = Vector3.new(0, 2, 0)
                    i.AlwaysOnTop = true

                    j = Instance.new("TextLabel") -- Billboard TextLabel 
                    j.Size = UDim2.new(1, 0, 1, 0)
                    j.TextColor3 = Color3.new(1, 1, 1)
                    j.BackgroundTransparency = 1
                    j.TextScaled = false
                    j.TextSize = 10
                    j.TextTransparency = 0.5
                    j.TextStrokeTransparency = 0.5
                    j.TextStrokeColor3 = Color3.new(0, 0, 0)
                    i.Parent = g
                    j.Parent = i
                else
                    j = i:FindFirstChild("TextLabel")
                end

                local distance = (e.Character.PrimaryPart.Position - g.Position).magnitude
                j.Text = "Custard | Distance: " .. math.floor(distance) .. "m"
            else
                local h = g:FindFirstChild("Highlight")
                if h then
                    h:Destroy()
                end

                local k = g:FindFirstChild("PointLight")
                if k then
                    k:Destroy()
                end

                local i = g:FindFirstChild("BillboardGui")
                if i then
                    i:Destroy()
                end
            end
        end
    end
end

spawn(function()
    while true do
        wait(0.01)
        if b then
            updateHighlights()
        else
            for _, part in pairs(workspace.game.gameCustard:GetDescendants()) do
                if part:IsA("Part") then
                    local h = part:FindFirstChild("Highlight")
                    if h then
                        h:Destroy()
                    end

                    local k = part:FindFirstChild("PointLight")
                    if k then
                        k:Destroy()
                    end

                    local i = part:FindFirstChild("BillboardGui")
                    if i then
                        i:Destroy()
                    end
                end
            end
        end
    end
end)


--// Autofarm
local function teleportParts()
    local k = e.Character or e.CharacterAdded:Wait()
    local l = game.Workspace:WaitForChild("game"):WaitForChild("gameCustard"):GetChildren()

    for _, m in ipairs(l) do
        if e.PlayerGui:FindFirstChild("Title") and e.PlayerGui.Title:FindFirstChild("mainframe") and e.PlayerGui.Title.mainframe.Visible then
            return true
        end

        if m:IsA("Part") then
            m.Position = k.PrimaryPart.Position + Vector3.new(0, 0, 0)
            wait(0.5)
        end
    end

    return false
end

spawn(function()
    while true do
        wait(1)

        if a then
            game:GetService("ReplicatedStorage").sendCharacterSpawnRequest:FireServer(unpack(args))
            wait(1.5)

            local n = e.PlayerGui
            if n:FindFirstChild("PlayerDefaultGui") and n.PlayerDefaultGui:FindFirstChild("Mobile") then
                teleportParts()
            end

            e.CharacterAdded:Wait()
        end
        
        wait(1)
    end
end)

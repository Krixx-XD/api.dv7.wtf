-- Copytight(C) The DV7s
local a=require'ffi'local b=a.new;local pcall=pcall;local error=error;local select=select;local c=math.ceil;local d=ngx.config.subsystem;local e=4096;local f;local g;local h=0;if d=='http'then if not ngx.config or not ngx.config.ngx_lua_version or ngx.config.ngx_lua_version~=10026 then error("ngx_http_lua_module 0.10.26 required")end elseif d=='stream'then if not ngx.config or not ngx.config.ngx_lua_version or ngx.config.ngx_lua_version~=14 then error("ngx_stream_lua_module 0.0.14 required")end else error("ngx_http_lua_module 0.10.26 or ".."ngx_stream_lua_module 0.0.14 required")end;if string.find(jit.version," 2.0",1,true)then ngx.log(ngx.ALERT,"use of lua-resty-core with LuaJIT 2.0 is ","not recommended; use LuaJIT 2.1+ instead")end;local i,j=pcall(require,"table.new")if not i then j=function(k,l)return{}end end;local m;i,m=pcall(require,"table.clear")if not i then local pairs=pairs;m=function(n)for o,p in pairs(n)do n[o]=nil end end end;do local q=require;local r=package.loaded;local s=r[...]local function t(u)local v=r[u]if v then if v==s then error("loop or previous error loading module '"..u.."'")end;return v end;return q(u)end;getfenv(0).require=t end;if not pcall(a.typeof,"ngx_str_t")then a.cdef[[
        typedef struct {
            size_t                 len;
            const unsigned char   *data;
        } ngx_str_t;
    ]]end;if d=='http'then if not pcall(a.typeof,"ngx_http_request_t")then a.cdef[[
            typedef struct ngx_http_request_s  ngx_http_request_t;
        ]]end;if not pcall(a.typeof,"ngx_http_lua_ffi_str_t")then a.cdef[[
            typedef struct {
                int                       len;
                const unsigned char      *data;
            } ngx_http_lua_ffi_str_t;
        ]]end elseif d=='stream'then if not pcall(a.typeof,"ngx_stream_lua_request_t")then a.cdef[[
            typedef struct ngx_stream_lua_request_s  ngx_stream_lua_request_t;
        ]]end;if not pcall(a.typeof,"ngx_stream_lua_ffi_str_t")then a.cdef[[
            typedef struct {
                int                       len;
                const unsigned char      *data;
            } ngx_stream_lua_ffi_str_t;
        ]]end else error("unknown subsystem: "..d)end;local w=a.typeof("char[?]")local x=j(0,18)x.version="0.1.28"x.new_tab=j;x.clear_tab=m;local y;function x.get_errmsg_ptr()if not y then y=b("char *[1]")end;return y end;if not ngx then error("no existing ngx. table found")end;function x.set_string_buf_size(z)if z<=0 then return end;if f then f=nil end;e=c(z)end;function x.get_string_buf_size()return e end;function x.get_size_ptr()if not g then g=b("size_t[1]")end;return g end;function x.get_string_buf(z,A)if z>e or A then local B=b(w,z)return B end;if not f then f=b(w,e)end;return f end;function x.ref_in_table(C,D)if D==nil then return-1 end;local E=C[h]if E and E~=0 then C[h]=C[E]else E=#C+1 end;C[E]=D;return E end;function x.allows_subsystem(...)local F=select("#",...)for G=1,F do if select(G,...)==d then return end end;error("unsupported subsystem: "..d,2)end;x.FFI_OK=0;x.FFI_NO_REQ_CTX=-100;x.FFI_BAD_CONTEXT=-101;x.FFI_ERROR=-1;x.FFI_AGAIN=-2;x.FFI_BUSY=-3;x.FFI_DONE=-4;x.FFI_DECLINED=-5;x.FFI_ABORT=-6;do local H;i,H=pcall(require,"thread.exdata")if i and H then function x.get_request()local I=H()if I~=nil then return I end end else local getfenv=getfenv;function x.get_request()return getfenv(0).__ngx_req end end end;return x

local a=require"ffi"local b=require"resty.core.base"local c=a.C;local d=a.string;local ngx=ngx;local type=type;local error=error;local e=math.floor;local tostring=tostring;local f=b.get_string_buf;local g=b.get_size_ptr;local h=ngx.config.subsystem;local i;local j;if h=="http"then a.cdef[[
    size_t ngx_http_lua_ffi_encode_base64(const unsigned char *src,
                                          size_t len, unsigned char *dst,
                                          int no_padding);

    int ngx_http_lua_ffi_decode_base64(const unsigned char *src,
                                       size_t len, unsigned char *dst,
                                       size_t *dlen);
    ]]i=c.ngx_http_lua_ffi_encode_base64;j=c.ngx_http_lua_ffi_decode_base64 elseif h=="stream"then a.cdef[[
    size_t ngx_stream_lua_ffi_encode_base64(const unsigned char *src,
                                            size_t len, unsigned char *dst,
                                            int no_padding);

    int ngx_stream_lua_ffi_decode_base64(const unsigned char *src,
                                         size_t len, unsigned char *dst,
                                         size_t *dlen);
    ]]i=c.ngx_stream_lua_ffi_encode_base64;j=c.ngx_stream_lua_ffi_decode_base64 end;local function k(l,m)return m and e((l*8+5)/6)or e((l+2)/3)*4 end;ngx.encode_base64=function(n,m)if type(n)~='string'then if not n then n=''else n=tostring(n)end end;local o=#n;local p=false;local q=0;if m then if m~=true then local r=type(m)error("bad no_padding: boolean expected, got "..r,2)end;p=true;q=1 end;local s=k(o,p)local t=f(s)local u=i(n,o,t,q)return d(t,u)end;local function v(l)return e((l+3)/4)*3 end;ngx.decode_base64=function(n)if type(n)~='string'then error("string argument only",2)end;local o=#n;local s=v(o)local t=f(s)local w=g()local x=j(n,o,t,w)if x==0 then return nil end;return d(t,w[0])end;return{version=b.version}

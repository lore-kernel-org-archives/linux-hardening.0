Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082FAD2D;
	Sat, 22 Mar 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742626993; cv=none; b=IapxWE40oEM7+24yHu/Eyjv/rMxjvfxs7NW2UwcpSMH3KGtNqcWAJbfAoeBQytDVJDXS9rK99a3/VaQH/SVWDJJgo5Iw8Q/iTd9P1LftzOUIzHovYDkHb16OXcK8yhLwnYr7sr0zUWmZxg90pqJmcAXFPsK/euU23lSGZR0m8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742626993; c=relaxed/simple;
	bh=HtzlmGFKNc96G3c31xfHA2/WSc+840Arh4hTDS/Blu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idcQDn/wKBzNrPCNc+aM7JrtppPrJ3PqX71Aw/Jyj7vGrRZ8+fcKuf4F44FpHGC6iRLS5iI5qvh4ErOXgyv1rUojqbMRv7fWfcQy6hSnMT7T7sH9sK0fwGZ1yg0zWCa6xEy/NSIgGK+xs8GPx5T/19A3q4DuOOFIp4Jyaa6I3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh8bkayS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh8bkayS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8CC4CEDD;
	Sat, 22 Mar 2025 07:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742626993;
	bh=HtzlmGFKNc96G3c31xfHA2/WSc+840Arh4hTDS/Blu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uh8bkaySVZxDeFbmWF40056K7l8MVIb+9kF4CPx6jnwyybECJMrvd1REqb6+ZGb/7
	 U1M5Zwze0ONfLVHeZABlmUHipLqjLu0fd0Ibaf/a8/dI/4dcMUjq0xIm74Ox02xp5t
	 7WMD1NaJ6nuv24ylk6fz4ZSXJ+HF8jQBfEe2F2ahX3sBX/vgAT8SZ/0CGzmQTA/et7
	 epxym2eHwY69WirMTSZHNyvsMbhYU5XJ/Dvy4qaTqU4nonav25pjjM0Vt4MfXM3sd0
	 jTzv9+YZqKA8tcvByuN4WGOc+/V1HIX6UD47YGXBnnEC2Hat5xdrTMF9NRqIQJ1PN+
	 FVCchGpV2CxWQ==
Date: Sat, 22 Mar 2025 00:03:09 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [PATCH 3/5] compiler_types: Introduce __is_lvalue()
Message-ID: <202503212348.C21AACA6@keescook>
References: <20250321202620.work.175-kees@kernel.org>
 <20250321204105.1898507-3-kees@kernel.org>
 <CAG48ez17ZtF4YESkGeegJYMTuQMsRcU3njVkNqbSbgv75jpc5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez17ZtF4YESkGeegJYMTuQMsRcU3njVkNqbSbgv75jpc5g@mail.gmail.com>

On Sat, Mar 22, 2025 at 04:38:21AM +0100, Jann Horn wrote:
> On Fri, Mar 21, 2025 at 9:41 PM Kees Cook <kees@kernel.org> wrote:
> > If __builtin_is_lvalue() is available, use it with __is_lvalue(). There
> > is patch to Clang to provide this builtin now[1].
> >
> > Link: https://github.com/kees/llvm-project/commits/builtin_is_lvalue/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Before you land that LLVM patch, it might be a good idea to figure out
> how this interacts with the fun C quirk where you can have temporary
> rvalues which can contain array members to which you can technically
> create lvalues but must not write. As far as I understand, calling
> "kfree(getS().ptrs[0])" as in the following example would cause UB
> with your patch:

Yay UB! I can confirm that currently isModifiableLvalue() does not catch
this.

> 
> ```
> $ cat kees-kfree-test.c
> #include <stdlib.h>
> 
> #define __is_lvalue(expr)      __builtin_is_lvalue(expr)
> 
> void __kfree(void *ptr);
> void BEFORE_SET_TO_NULL();
> void AFTER_SET_TO_NULL();
> static inline void kfree_and_null(void **ptr)
> {
>        __kfree(*ptr);
>        BEFORE_SET_TO_NULL();
>        *ptr = NULL;
>        AFTER_SET_TO_NULL();
> }
> #define __force_lvalue_expr(x) \
>        __builtin_choose_expr(__is_lvalue(x), x, (void *){ NULL })
> #define __free_and_null(__how, x)      \
> ({                                     \
>        typeof(x) *__ptr = &(x);        \
>        __how ## _and_null((void **)__ptr);     \
> })
> #define __free_and_maybe_null(__how, x)        \
>        __builtin_choose_expr(__is_lvalue(x), \
>                __free_and_null(__how, __force_lvalue_expr(x)), \
>                __kfree(x))
> #define kfree(x)          __free_and_maybe_null(kfree, x)
> 
> struct S {
>     void *ptrs[1];
> };
> struct S getS(void);
> 
> int is_lvalue_test(void) {
>   return __is_lvalue(getS().ptrs[0]);
> }
> void testfn2(void) {
>   kfree(getS().ptrs[0]);
> }
> $ [...]/bin/clang-14 -c -o kees-kfree-test.o kees-kfree-test.c -O3 -Wall
> $ objdump -d -Mintel -r kees-kfree-test.o
> 
> kees-kfree-test.o:     file format elf64-x86-64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <is_lvalue_test>:
>    0:   b8 01 00 00 00          mov    eax,0x1
>    5:   c3                      ret
>    6:   66 2e 0f 1f 84 00 00    cs nop WORD PTR [rax+rax*1+0x0]
>    d:   00 00 00
> 
> 0000000000000010 <testfn2>:
>   10:   50                      push   rax
>   11:   e8 00 00 00 00          call   16 <testfn2+0x6>
>                         12: R_X86_64_PLT32      getS-0x4
>   16:   48 89 c7                mov    rdi,rax
>   19:   e8 00 00 00 00          call   1e <testfn2+0xe>
>                         1a: R_X86_64_PLT32      __kfree-0x4
>   1e:   31 c0                   xor    eax,eax
>   20:   e8 00 00 00 00          call   25 <testfn2+0x15>
>                         21: R_X86_64_PLT32      BEFORE_SET_TO_NULL-0x4
>   25:   31 c0                   xor    eax,eax
>   27:   59                      pop    rcx
>   28:   e9 00 00 00 00          jmp    2d <testfn2+0x1d>
>                         29: R_X86_64_PLT32      AFTER_SET_TO_NULL-0x4

I don't see UB manifested here, though? It looks more like a dead store
was eliminated (i.e. it was an automatic variable that wasn't going to
be referenced outside of the expression statement).

If I add a global and assign the global from *ptr, it all seems to work
fine:

--- kees-kfree-test.c.orig    2025-03-22 00:00:53.550633347 -0700
+++ kees-kfree-test.c       2025-03-21 23:58:57.124268268 -0700
@@ -2,6 +2,8 @@
 
 #define __is_lvalue(expr)      __builtin_is_modifiable_lvalue(expr)
 
+void *g;
+
 void __kfree(void *ptr);
 void BEFORE_SET_TO_NULL();
 void AFTER_SET_TO_NULL();
@@ -11,6 +13,7 @@
        BEFORE_SET_TO_NULL();
        *ptr = NULL;
        AFTER_SET_TO_NULL();
+       g = *ptr;
 }
 #define __force_lvalue_expr(x) \
        __builtin_choose_expr(__is_lvalue(x), x, (void *){ NULL })

...

  27:   e8 00 00 00 00          call   2c <testfn2+0x1c>
                        28: R_X86_64_PLT32      AFTER_SET_TO_NULL-0x4
  2c:   48 c7 05 00 00 00 00    mov    QWORD PTR [rip+0x0],0x0        # 37 <testfn2+0x27>
  33:   00 00 00 00 

> jannh@horn:~/test/kees-kfree$
> ```
> 
> As far as I understand, this causes UB in C99 ("If an attempt is made
> to modify the result of a function call or to access it after the next
> sequence point, the behavior is undefined.") and in C11 ("A non-lvalue
> expression with structure or union type, where the structure or union
> contains a member with array type (including, recursively, members of
> all contained structures and unions) refers to an object with
> automatic storage duration and temporary lifetime. 36) Its lifetime
> begins when the expression is evaluated and its initial value is the
> value of the expression. Its lifetime ends when the evaluation of the
> containing full expression or full declarator ends. Any attempt to
> modify an object with temporary lifetime results in undefined
> behavior.").
> 
> Basically, something like getS().ptrs[0] gives you something that is
> technically an lvalue but must not actually be written to, and
> ->isModifiableLvalue() does not catch that.

But I agree, any mention of UB does give me pause! :)

-- 
Kees Cook

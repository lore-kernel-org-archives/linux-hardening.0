Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D0C6FD18
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Apr 2023 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjDRR6X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDRR6W (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Apr 2023 13:58:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B846F9766
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 10:58:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o2so28033164plg.4
        for <linux-hardening@vger.kernel.org>; Tue, 18 Apr 2023 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681840700; x=1684432700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTGJ+i+oQsymPHHwJcFJ9iLltFfpbe7LBlqn1W6eNDc=;
        b=NswMtF0hj3QTqC65QMJKUTLLGxMayF+chHlfBPCxYR315Q06DNjAhT6SyhGyArQHrj
         wJPiliYCo4grhuLcTesMlcFayFwH3W8baV+RGcDjAu5CZbMZLnUN6xtSbkcSA1JlFqHP
         rDlg0/yK51mBJ3Q8aflsn7BqcRYoODVmjritpvxXOZu0N7HW3O+WppKwp+/03X3cB8AV
         I7xGxk2hRF0PHOVG9YDKIEodA1HEoY2g4WQCbMMD9n76Iwz5f2ISilTDoLAfq0qj+rqB
         I4EoCVpri+lDQN6K23N0M+ucGgx17bEhERcmo40vPjLW2FaDl+RXoDOcu2YHLuJpwiRi
         DyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840700; x=1684432700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTGJ+i+oQsymPHHwJcFJ9iLltFfpbe7LBlqn1W6eNDc=;
        b=h6n+A2Nj8IePs3qRYJUOs6GgBUGom3hpkIw6gISNuHsJ5LVr2ImfvzV4srJ8vN66Bt
         Yor5Htd76V+sjw1PW2JEaLDvNLMwlxqS4vFK4Or5snwL9UduYXD9qWkPlAS+mqwosAo6
         9WyOF4Dt/SSaVULo4ek1P5sSX6CkEs2YEHGHwHs2h6trLln8WFCaQ8JsQdvvIZla2WIh
         2SwE4YlVj2JHzW+QVSrQjbVDIOutwfc6HfPBtZEWLmA0Vgt3oEzPrUWolNlJwpt5cMyC
         tW8X+pXJRrVkoHbtBmT584Zx0YCo0wF6JXrhOBKIXd8J/ELBXLi1XQlJ/tGBR0Z7FZOF
         5wzQ==
X-Gm-Message-State: AAQBX9eL2474qNisSbGwn7aNwftqfBE3mj1gu6uFhQhFX+ujxV4eT4T1
        wGG5zQiwN7SPRs4bJQzC1NGNywtfLWEaqZOABax56w==
X-Google-Smtp-Source: AKy350YRRZ/3GoBhAIzVSM8X9gJZzcR+6rhrShxCz3VnYV6nJUBhuROlHXwNOzO+w8O/VHLk8O8xGCp9vcfm19wZVLU=
X-Received: by 2002:a05:6a20:3c93:b0:f0:9e73:c77b with SMTP id
 b19-20020a056a203c9300b000f09e73c77bmr575996pzj.20.1681840699906; Tue, 18 Apr
 2023 10:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-4-keescook@chromium.org>
In-Reply-To: <20230407192717.636137-4-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 10:58:08 -0700
Message-ID: <CAKwvOd=iztc+27ytBSmYNFHCERm+L--GP9b1c_xPd5BQwo7d+A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] fortify: Use const variables for __member_size tracking
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The sizes reported by __member_size should never change in a given
> function. Mark them as such.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 42 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index c9de1f59ee80..fae1bf4bd543 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -20,7 +20,7 @@ void __write_overflow_field(size_t avail, size_t wanted=
) __compiletime_warning("
>  ({                                                             \
>         char *__p =3D (char *)(p);                                \
>         size_t __ret =3D SIZE_MAX;                                \
> -       size_t __p_size =3D __member_size(p);                     \
> +       const size_t __p_size =3D __member_size(p);               \
>         if (__p_size !=3D SIZE_MAX &&                             \
>             __builtin_constant_p(*__p)) {                       \
>                 size_t __p_len =3D __p_size - 1;                  \
> @@ -142,7 +142,7 @@ extern char *__underlying_strncpy(char *p, const char=
 *q, __kernel_size_t size)
>  __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
>  char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
>  {
> -       size_t p_size =3D __member_size(p);
> +       const size_t p_size =3D __member_size(p);
>
>         if (__compiletime_lessthan(p_size, size))
>                 __write_overflow();
> @@ -169,7 +169,7 @@ char *strncpy(char * const POS p, const char *q, __ke=
rnel_size_t size)
>  __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
>  char *strcat(char * const POS p, const char *q)
>  {
> -       size_t p_size =3D __member_size(p);
> +       const size_t p_size =3D __member_size(p);
>
>         if (p_size =3D=3D SIZE_MAX)
>                 return __underlying_strcat(p, q);
> @@ -191,8 +191,8 @@ extern __kernel_size_t __real_strnlen(const char *, _=
_kernel_size_t) __RENAME(st
>   */
>  __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __ker=
nel_size_t maxlen)
>  {
> -       size_t p_size =3D __member_size(p);
> -       size_t p_len =3D __compiletime_strlen(p);
> +       const size_t p_size =3D __member_size(p);
> +       const size_t p_len =3D __compiletime_strlen(p);
>         size_t ret;
>
>         /* We can take compile-time actions when maxlen is const. */
> @@ -233,8 +233,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *=
 const POS p, __kernel_size
>  __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
>  __kernel_size_t __fortify_strlen(const char * const POS p)
>  {
> +       const size_t p_size =3D __member_size(p);
>         __kernel_size_t ret;
> -       size_t p_size =3D __member_size(p);
>
>         /* Give up if we don't know how large p is. */
>         if (p_size =3D=3D SIZE_MAX)
> @@ -267,8 +267,8 @@ extern size_t __real_strlcpy(char *, const char *, si=
ze_t) __RENAME(strlcpy);
>   */
>  __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const P=
OS q, size_t size)
>  {
> -       size_t p_size =3D __member_size(p);
> -       size_t q_size =3D __member_size(q);
> +       const size_t p_size =3D __member_size(p);
> +       const size_t q_size =3D __member_size(q);
>         size_t q_len;   /* Full count of source string length. */
>         size_t len;     /* Count of characters going into destination. */
>
> @@ -318,10 +318,10 @@ extern ssize_t __real_strscpy(char *, const char *,=
 size_t) __RENAME(strscpy);
>   */
>  __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const =
POS q, size_t size)
>  {
> -       size_t len;
>         /* Use string size rather than possible enclosing struct size. */
> -       size_t p_size =3D __member_size(p);
> -       size_t q_size =3D __member_size(q);
> +       const size_t p_size =3D __member_size(p);
> +       const size_t q_size =3D __member_size(q);
> +       size_t len;
>
>         /* If we cannot get size of p and q default to call strscpy. */
>         if (p_size =3D=3D SIZE_MAX && q_size =3D=3D SIZE_MAX)
> @@ -394,9 +394,9 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, =
const char * const POS q, s
>  __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
>  char *strncat(char * const POS p, const char * const POS q, __kernel_siz=
e_t count)
>  {
> +       const size_t p_size =3D __member_size(p);
> +       const size_t q_size =3D __member_size(q);
>         size_t p_len, copy_len;
> -       size_t p_size =3D __member_size(p);
> -       size_t q_size =3D __member_size(q);
>
>         if (p_size =3D=3D SIZE_MAX && q_size =3D=3D SIZE_MAX)
>                 return __underlying_strncat(p, q, count);
> @@ -639,7 +639,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memsc=
an);
>  __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size=
_t size)
>  {
> -       size_t p_size =3D __struct_size(p);
> +       const size_t p_size =3D __struct_size(p);
>
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
> @@ -651,8 +651,8 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, i=
nt c, __kernel_size_t size)
>  __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
>  int memcmp(const void * const POS0 p, const void * const POS0 q, __kerne=
l_size_t size)
>  {
> -       size_t p_size =3D __struct_size(p);
> -       size_t q_size =3D __struct_size(q);
> +       const size_t p_size =3D __struct_size(p);
> +       const size_t q_size =3D __struct_size(q);
>
>         if (__builtin_constant_p(size)) {
>                 if (__compiletime_lessthan(p_size, size))
> @@ -668,7 +668,7 @@ int memcmp(const void * const POS0 p, const void * co=
nst POS0 q, __kernel_size_t
>  __FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
>  void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
>  {
> -       size_t p_size =3D __struct_size(p);
> +       const size_t p_size =3D __struct_size(p);
>
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
> @@ -680,7 +680,7 @@ void *memchr(const void * const POS0 p, int c, __kern=
el_size_t size)
>  void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_=
inv);
>  __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size=
_t size)
>  {
> -       size_t p_size =3D __struct_size(p);
> +       const size_t p_size =3D __struct_size(p);
>
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
> @@ -693,7 +693,7 @@ extern void *__real_kmemdup(const void *src, size_t l=
en, gfp_t gfp) __RENAME(kme
>                                                                     __rea=
lloc_size(2);
>  __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, g=
fp_t gfp)
>  {
> -       size_t p_size =3D __struct_size(p);
> +       const size_t p_size =3D __struct_size(p);
>
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
> @@ -720,8 +720,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS=
0 p, size_t size, gfp_t gfp
>  __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
>  char *strcpy(char * const POS p, const char * const POS q)
>  {
> -       size_t p_size =3D __member_size(p);
> -       size_t q_size =3D __member_size(q);
> +       const size_t p_size =3D __member_size(p);
> +       const size_t q_size =3D __member_size(q);
>         size_t size;
>
>         /* If neither buffer size is known, immediately give up. */
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers

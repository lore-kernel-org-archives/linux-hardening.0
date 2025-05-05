Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183D15199A
	for <linux-hardening@vger.kernel.org>; Mon,  5 May 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469034; cv=none; b=X48E80p6gY7ljQbtljqJtgd4ATv7H8Ry0zUS4DHFeZAclX5qVW4F1sOfKvarzip3Vg7nznCbvLvfvg1ckUJLmhS01srUUHAYt7IwezmRnkT9S77npWwb4kUdV0a5rjJAu0kHIEomYiSWpKpPA59s7gyfWa0PQ1Bc/JExotLSsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469034; c=relaxed/simple;
	bh=ebM4dpi9tTj1/J6Zu4pVcvgIwpnGYs8XJ6sG1Hbq8m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hs2nEegXsFXIdXc9kshnox5M+wwf+y8fjc53gy1r4JvWy9mkJJJDaTxkwZ0trwdg2RV19ULP71mBUbhyMTvUNktAORCIF4J1+PYyxCnatBBS3RvjUVrDp/rayg7/EfapfzdUWEO4abdRZzgKnIO5xvbacnlXljwvhnvIP7M+HiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0efNXa1K; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0efNXa1K"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso1109647241.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 May 2025 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746469031; x=1747073831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RdDSV3C1kkoxQpJwSli9pdvJprdzRDcGLg/gY+ewYo=;
        b=0efNXa1KGH5gWOf3cgeob43GRgbpvGT8H/TvwCrd55v9Vm+TtRaS/cxbOlmd77bcAV
         +0zMagvuoA+aPcGEq3tfeYjvj5ant7HAg8hl5VybkgafYJnqUw+fCM5gHUBwFYK6CE6W
         6RXvnaPfkPv4pYiwLj4BYQ3MsQNG+oETE0aVd5anrWlGo6+VxjGGlMIFUV7OAcHcYjpg
         AoQuCf0c+oSz3pDB1vApH76szfOaNLtwr+/GRxxLjnfATA7an46on+1qQ+Mjk0vfUbGL
         ev+2/O97nO7oggcgD33lUbzpi+8LMgE9EMc2/gc0bcunAV57RKI7FjZLBUMzjt+yH7oH
         2YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469031; x=1747073831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RdDSV3C1kkoxQpJwSli9pdvJprdzRDcGLg/gY+ewYo=;
        b=TEReSyn3Pyb1fkqBKVS+oKuvKSN7f1dAaB5geolSZFbzQxdxPfIWxTdLnXhHKEwhGB
         OqIdNCjEOuWnFRF1ViH8IaE/1lKm7lQZ73hg1QdI2XCRns5PeVkPxTtQCU8ZusK6ryN8
         /rLBIu7mOdCeIO9wxPNvmCoipY+h58CJHHDpVonzoh4STV59lbkPEi2KOe7ejCkWPVm1
         8JY1PAWo2jee+Jg4xcym9OoUaq5I4YYnymI/Q52i4bKylaRyRObFmz2T7Ohe4v9nAWG7
         QWbFyzDPxCLG0zB8WR1xutoMZ3Bi+u9lb3TmVDR/laHwrtEtGLApy6S/fpujzc8GpRMy
         FgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXesNLOqh6wIh38e3YCTSvxx5Gq6N9U+g455P0I8RZg9QVblUlWcera3xzkQfJKkbMSDZcIcRsdw8V36vd/a4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXtz6MX797JhhtnRlI0qfg02cV2If3aaW9uQ56Amp1NQeYlmq
	Exyy/XddIb/23LUL79EPBRzBXDce62LvDJ6ujF9tChJFupZpmpytOmevXFfCgDXNiCGbGDJu2Xf
	K3wGRLoIwciscQN6z7vaY706CSK7UAP+ravhZ
X-Gm-Gg: ASbGncsh0wmbOh+frAlH0zRmILu/gkhcoaaWYmYe1s+oVZFCTGDwJQotxf3ojcQQ0+4
	3OijYjoOerKwaIU09BJlcKQaVA5+ku4sQpff6YztfUc4uNlD7Xvv93+B7c3A9lqvBXeOQPWsvBp
	yWlIYhZ9lSn9PQEl6KTVvr
X-Google-Smtp-Source: AGHT+IF/v/NhUlwDl+Ul0geebRYwa8/EIVndjMjgtVnXrErs28xqOVyt7NYHnyhn7xzOG/mZcLIcvccqpB89VJSlcqA=
X-Received: by 2002:a05:6102:158d:b0:4c4:dead:59ab with SMTP id
 ada2fe7eead31-4db14781447mr4073359137.5.1746469031346; Mon, 05 May 2025
 11:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503184001.make.594-kees@kernel.org> <20250503184623.2572355-3-kees@kernel.org>
In-Reply-To: <20250503184623.2572355-3-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 5 May 2025 11:16:58 -0700
X-Gm-Features: ATxdqUG-8XZR84SCa_hy8LufhE4gnWyYrv86WHg4i3ik94ojF9GAbNyF1NZH5uE
Message-ID: <CAFhGd8rGJcveDn4g1nS=tURe-uT1+PFm2EQeWpUrH_oy763yFg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] integer-wrap: Force full rebuild when .scl file changes
To: Kees Cook <kees@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 11:46=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Since the integer wrapping sanitizer's behavior depends on its associated
> .scl file, we must force a full rebuild if the file changes. If not,
> instrumentation may differ between targets based on when they were built.
>
> Generate a new header file, integer-wrap.h, any time the Clang .scl
> file changes. Include the header file in compiler-version.h when its
> associated feature name, INTEGER_WRAP, is defined. This will be picked
> up by fixdep and force rebuilds where needed.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: <linux-kbuild@vger.kernel.org>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  include/linux/compiler-version.h | 3 +++
>  scripts/Makefile.ubsan           | 1 +
>  scripts/basic/Makefile           | 5 +++++
>  3 files changed, 9 insertions(+)
>
> diff --git a/include/linux/compiler-version.h b/include/linux/compiler-ve=
rsion.h
> index 69b29b400ce2..187e749f9e79 100644
> --- a/include/linux/compiler-version.h
> +++ b/include/linux/compiler-version.h
> @@ -19,3 +19,6 @@
>  #ifdef RANDSTRUCT
>  #include <generated/randstruct_hash.h>
>  #endif
> +#ifdef INTEGER_WRAP
> +#include <generated/integer-wrap.h>
> +#endif
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 9e35198edbf0..653f7117819c 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -15,6 +15,7 @@ ubsan-cflags-$(CONFIG_UBSAN_TRAP)             +=3D $(ca=
ll cc-option,-fsanitize-trap=3Dundefined
>  export CFLAGS_UBSAN :=3D $(ubsan-cflags-y)
>
>  ubsan-integer-wrap-cflags-$(CONFIG_UBSAN_INTEGER_WRAP)     +=3D  \
> +       -DINTEGER_WRAP                                          \
>         -fsanitize-undefined-ignore-overflow-pattern=3Dall        \
>         -fsanitize=3Dsigned-integer-overflow                      \
>         -fsanitize=3Dunsigned-integer-overflow                    \
> diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
> index dd289a6725ac..fb8e2c38fbc7 100644
> --- a/scripts/basic/Makefile
> +++ b/scripts/basic/Makefile
> @@ -14,3 +14,8 @@ cmd_create_randstruct_seed =3D \
>  $(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
>         $(call if_changed,create_randstruct_seed)
>  always-$(CONFIG_RANDSTRUCT) +=3D randstruct.seed
> +
> +# integer-wrap: if the .scl file changes, we need to do a full rebuild.
> +$(obj)/../../include/generated/integer-wrap.h: $(srctree)/scripts/intege=
r-wrap-ignore.scl FORCE
> +       $(call if_changed,touch)
> +always-$(CONFIG_UBSAN_INTEGER_WRAP) +=3D ../../include/generated/integer=
-wrap.h

I'm not sure how this fake header stuff works to ensure builds deps
are tracked properly but we do need scl files to be considered as part
of complete builds, so:

Acked-by: Justin Stitt <justinstitt@google.com>

> --
> 2.34.1
>

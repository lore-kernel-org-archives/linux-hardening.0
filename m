Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC926983A
	for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879810; cv=none; b=dgi5FAWJV5+N2mBAVH9YZChhCYfo+i0XC/cjTBkG/y4/UqvEYuK/Z74kPGQtH8T3z8H12zICStGpmrcsif33uzZ4H9qpJSBECTxGLjlOFdjAn/Wc1a2simFhYZzELe4v7ysQVI3eEk0IohCogXB9Sp/wm90XnMKm5vebMWvF7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879810; c=relaxed/simple;
	bh=tqYcp36kSOOENz/soiYs13MgeYzT3g5zF8GJrqqqqOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA15J+LS2nk3jRIHsUMhCQuLaixvY0SrekRTyc+YC3n5quwl5Go6TcMqT0Dz2mHG8hiU3RdvKU+2x+WHCGrMgvQlCMIsy3yQ59vTpOKdhwjMUnQoEgTbQ3xIspUyI77UBIDa7aRU0uKnpmijV9QYIp+fJzpefBK1fZg/tDK/7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7jbwVXT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7jbwVXT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so1975950a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741879806; x=1742484606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=00u7ecFNyPAZ4Z5cOSw/OvdLmibjnRE9ersVFXwW+QE=;
        b=m7jbwVXTgMrT8qlo5jU2Byj+XHo/ECuMa00iXoxL02g4F93KzNoaZifcVOva4osT+C
         JCAA87InMV1Wqx4txC5XtAC3LzPFo4eYgsmActaBQ5H2MvhVToBecEVFmkvXkWgVWw5p
         +zO3UpjCqU34v88Cg3HAKh9zP4iWE1OIbQ+5/QTsnpfzF4ff+jl7LA1HYo9x+MQLP84t
         Kb3Dgk1VxUDcswj6sN6yR6Sj2f4rqnvcusDbhXApJl0SjzyKPkIuuVT/IgMVCrfKeyIg
         HL8N0RZQ/9MnU4oz4Ph9gbNCM6d5UAPBvTcHamTc9kKBl2cHUdkDR3VbMe8Enwf3fBSz
         weUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879806; x=1742484606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00u7ecFNyPAZ4Z5cOSw/OvdLmibjnRE9ersVFXwW+QE=;
        b=fWXvmldPf1BV1t6zP6uTFOb75FCiGwBFWRa36RskT7tY4U1mkHPtmzFg32MDYZbIHO
         6oWrkR+S44K8dbMLXOev8fSRqCNJmaxM35Lv9v4TSnXZuVDSIdQk88Tpmko0ZVg4fFaI
         cO4mSgPtepKEr4vPllJnuGx64nbqC1StnrGsJr4IgKt3LYwssQfhhGIHhajTPGXcDgE3
         vtK+HC59zITkGSpCcM5x38Yu1S5SJCUKEZnmaPX1T/23V4uBH/0hYoNvVa3KQeFp+RoS
         M+av3gcGTGuHJxWCXPjrHlcJMWjJvRMsvlnidc8uX1Xpmnk+z7aWhhZsr13q1p8x1Zce
         PQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXth9xHtHi6UkKTsPyDtA9PXNjPCQhsMlzwe3ohXdQyEBhvDvTiUI96juX0E+ToLLkUtKWvm76xMqi3eGUjvLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRZYIHES1U1+Kppi1qtQEcw3CG+4ZCpnN54RY+qqPEtsw1XkY
	RRsLXnghjMW/wiKswPXmakU2xw9yGB2CmFBae8FYBE9VkYYJFBO5TtJvsawsgKBV8SBGuezhsNN
	dAbyAyFYLdbg1Ao2Brzd5kPgGgCW+ayF2LfsK
X-Gm-Gg: ASbGnctF+wcFKBBd7rsXWP3atIwa7WsZ3h2Kin3fCdQxidFxwUpQAkvRaAqc2MS30S8
	LJNo4l3nAxrmgDjdXibzxVIRuCB41vOziHlFtQLhe+fWswV1MulSx/oI642iKyVfKm+f8VvW2FC
	Y8VXAJ16HgwXrWKl4xCnpXBz9BW1zkVMbAOeuuFA==
X-Google-Smtp-Source: AGHT+IEv0rtOsQstIMulfJeTHgWikPpW7fu1mPHnescJ1GSms7d/WLQhnr03CyeNMSYLnDPxmDhcIz/mp/0Hr9kM0jc=
X-Received: by 2002:a17:90b:2741:b0:2ff:7b28:a519 with SMTP id
 98e67ed59e1d1-300ff370231mr15211554a91.30.1741879806198; Thu, 13 Mar 2025
 08:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307040948.work.791-kees@kernel.org> <20250307041914.937329-1-kees@kernel.org>
In-Reply-To: <20250307041914.937329-1-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 13 Mar 2025 11:29:29 -0400
X-Gm-Features: AQ5f1Jo2s3dBQmL6L50YXOekPGf_8rCDFxDD6svVuHOtyM0nHf71JobMTMo6fo0
Message-ID: <CANpmjNOHSanxX7EyXhia4AuVd+6q5v1mXQMTM_k0Rj20P_ASAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ubsan/overflow: Rework integer overflow sanitizer
 option to turn on everything
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kbuild@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 23:19, Kees Cook <kees@kernel.org> wrote:
>
> Since we're going to approach integer overflow mitigation a type at a
> time, we need to enable all of the associated sanitizers, and then opt
> into types one at a time.
>
> Rename the existing "signed wrap" sanitizer to just the entire topic area:
> "integer wrap". Enable the implicit integer truncation sanitizers, with
> required callbacks and tests.
>
> Notably, this requires features (currently) only available in Clang,
> so we can depend on the cc-option tests to determine availability
> instead of doing version tests.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kbuild@vger.kernel.org
> ---
>  include/linux/compiler_types.h  |  2 +-
>  kernel/configs/hardening.config |  2 +-
>  lib/Kconfig.ubsan               | 23 +++++++++++------------
>  lib/test_ubsan.c                | 18 ++++++++++++++----
>  lib/ubsan.c                     | 28 ++++++++++++++++++++++++++--
>  lib/ubsan.h                     |  8 ++++++++
>  scripts/Makefile.lib            |  4 ++--
>  scripts/Makefile.ubsan          |  8 ++++++--
>  8 files changed, 69 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index f59393464ea7..4ad3e900bc3d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -360,7 +360,7 @@ struct ftrace_likely_data {
>  #endif
>
>  /* Do not trap wrapping arithmetic within an annotated function. */
> -#ifdef CONFIG_UBSAN_SIGNED_WRAP
> +#ifdef CONFIG_UBSAN_INTEGER_WRAP
>  # define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
>  #else
>  # define __signed_wrap
> diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
> index 3fabb8f55ef6..dd7c32fb5ac1 100644
> --- a/kernel/configs/hardening.config
> +++ b/kernel/configs/hardening.config
> @@ -46,7 +46,7 @@ CONFIG_UBSAN_BOUNDS=y
>  # CONFIG_UBSAN_SHIFT is not set
>  # CONFIG_UBSAN_DIV_ZERO is not set
>  # CONFIG_UBSAN_UNREACHABLE is not set
> -# CONFIG_UBSAN_SIGNED_WRAP is not set
> +# CONFIG_UBSAN_INTEGER_WRAP is not set
>  # CONFIG_UBSAN_BOOL is not set
>  # CONFIG_UBSAN_ENUM is not set
>  # CONFIG_UBSAN_ALIGNMENT is not set
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 1d4aa7a83b3a..63e5622010e0 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -116,21 +116,20 @@ config UBSAN_UNREACHABLE
>           This option enables -fsanitize=unreachable which checks for control
>           flow reaching an expected-to-be-unreachable position.
>
> -config UBSAN_SIGNED_WRAP
> -       bool "Perform checking for signed arithmetic wrap-around"
> +config UBSAN_INTEGER_WRAP
> +       bool "Perform checking for integer arithmetic wrap-around"
>         default UBSAN
>         depends on !COMPILE_TEST
> -       # The no_sanitize attribute was introduced in GCC with version 8.
> -       depends on !CC_IS_GCC || GCC_VERSION >= 80000
>         depends on $(cc-option,-fsanitize=signed-integer-overflow)
> -       help
> -         This option enables -fsanitize=signed-integer-overflow which checks
> -         for wrap-around of any arithmetic operations with signed integers.
> -         This currently performs nearly no instrumentation due to the
> -         kernel's use of -fno-strict-overflow which converts all would-be
> -         arithmetic undefined behavior into wrap-around arithmetic. Future
> -         sanitizer versions will allow for wrap-around checking (rather than
> -         exclusively undefined behavior).
> +       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> +       depends on $(cc-option,-fsanitize=implicit-signed-integer-truncation)
> +       depends on $(cc-option,-fsanitize=implicit-unsigned-integer-truncation)

Can these be in 1 cc-option? I know it might look slightly more ugly,
but having 3 different ones will shell out to the compiler 3 times,
which is a little less efficient. At some point it might noticeably
increase the build initialization latency.

Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55D22756A
	for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832827; cv=none; b=sJTo2ilfOvH0h2hsmCafkVJyQoCOA1AWY/RKSryzX+6PhuNi4DN/jkckj9pHzSgiSUi1TEjVIQFJ/umnGlawPlgim4pP7nlfxHzUqsV2pKNLESZhfz7XL64if6HeCjSeesDQ8wuAwxa6Esid2DDpyOMSwEHijfbkiIPq7WTkJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832827; c=relaxed/simple;
	bh=J0UexsktNSqCM9oZLpEk47OgaAxXlbfBFz7je7XQr2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qie9rtZ+q/h6TRoi2HXiMLKikuVHrN/kI5Me7EKEPhaNveT/ccOhoObz6uQONsvFt+sn7itdrHrnV+OL1dC6ASWQWrlnnQhz1Rle3aCK8yPg2DcDvAWQx5AJxfzFIVpUV2OYOIIhEWSLV9OuFOzLuLJ7p4pR0kbIGOK0fhnxPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDZ3izHG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDZ3izHG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31e41cfa631so6426179a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753832825; x=1754437625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5t7MDT/jSpU+9EuuhzwQmjAC64RK3pa7YGAopoG6Q0=;
        b=rDZ3izHGJhanoZWkCYnDrJiVjLTspRQ/6/4wO+1xtJCNf2mnTemoHGiVTfuu3MK1Sp
         /M53g7c2ly5PVb8CGMKbN55TjqwVWXeG+rmzbsDZZKutG4YzauOPeIKvxkWP4A8xGDXm
         +CMENdXrpknycydz6n33xe7LsghhruVnvTBhhKfX8P88LVrqLGMyNcCgiVOYzbC+typa
         0pKEhIPQM1I3SDbALw8idBKNow1mGze4Hxy1ua24Q5eSDEatcR37IDcRSjd+IaDoB9hu
         1cywh5P5559q9IL8bJaI/STyBa/ZmqhB/fmOK4O0FOXH3uZUsSfQ/m9jny1gHOo5tYPG
         RUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753832825; x=1754437625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5t7MDT/jSpU+9EuuhzwQmjAC64RK3pa7YGAopoG6Q0=;
        b=uwSOQ+WjinWvbv4kCm85RTqvaQFQJbznw5jqjLIRb/w2tI55pefbQtY5RaDuzH4PRw
         Y3MbWBy0IUxmM48CKF5CekXt+U4J1qPD1l1ytFae4l+XXcoYh25tlSvET+WWCztWvbxf
         RbMj+pGFcTfshWB6tJQTg7xBq604dwbkUJvhgStUgcVckWL0/J58ar71qXZw6aqPeOkV
         IjyqvkQHAyLe09GCyiVyJPHP/u9dAPQlHYrxPSvyUPcZdyjmeKKcYuaAen66Aou82MEu
         94eiJX58Ny/luGLq/rE/sc3nme/CzKTbrug6V7I8fc6ScD7c46VbEfU1gZP9BycoXScR
         m7fw==
X-Forwarded-Encrypted: i=1; AJvYcCW+VIknZ8a/4oAJjwO6ZYHC97uID0omBQYAlRAIXcVp3MxWAf1L7jKBTzWELt26/ySy0OICEiCEggn2DYmkvws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuItJUMNGGq4t5k5Qyl5+CVRTS81AW6qI20q6vdFqZ48jpALq
	TJc7WTIJ3jPRCkYSblBuzSRzY74oi8CR97o76N+ijNGlQ6sSdKfSgsjGRaT8MYvcuILevxVlsU8
	bv8bQRvPJx0bj3/apbklftGExLTiWaoj00H6oSHT9
X-Gm-Gg: ASbGncufbLhvwfiMpSOQiPwn1fqdJrbTlMwilGUUksbjAVLjwzQeGuqJgrwh/Bjs/6N
	lFaGkA9B+DZBo2sBFlxs4NVH3efEdoCgKnbEdFSBuOs6xDLKBDKYwVH6qfhmBt8K7hogn5G+VJk
	z573jtCkEl8GPe/O4kyEze4E4U/b8gjXbR8VxayKddErb7JbSJwVr2ccsWBpD5PvbTaIidqmFQC
	5A5H7if+TjPQ/0zpJQvqdBSXU772AtrsD33IJs=
X-Google-Smtp-Source: AGHT+IFatYHgbdkljf2uPOkFYPjGqRSd5VZTTw5Hl+NajdqJb3Z+1Xk7PfcV2apzyvJWSR0lq7DZY2BZw1y0sfbpKyg=
X-Received: by 2002:a17:90b:540d:b0:311:df4b:4b81 with SMTP id
 98e67ed59e1d1-31f5de555ecmr1560173a91.25.1753832824572; Tue, 29 Jul 2025
 16:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729234055.it.233-kees@kernel.org>
In-Reply-To: <20250729234055.it.233-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 30 Jul 2025 01:46:28 +0200
X-Gm-Features: Ac12FXx5J_uI5wvGiwYtgZvEifeHFoZvdN3qjvmiKrjmEOPX9wOpmjCSn_Ig6-A
Message-ID: <CANpmjNOrerXn9DyLyazQPhg4JDEBm+NfNhR_zua04TcwQO76yA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, "Kirill A . Shutemov" <kas@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Uros Bizjak <ubizjak@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 01:41, Kees Cook <kees@kernel.org> wrote:
>
> In order to support Clang's stack depth tracking (for Linux's kstack_erase
> feature), the coverage sanitizer needed to be disabled for __init (and
> __head) section code. Doing this universally (i.e. for GCC too) created
> a number of unexpected problems, ranging from changes to inlining logic
> to failures to DCE code on earlier GCC versions.
>
> Since this change is only needed for Clang, specialize it so that GCC
> doesn't see the change as it isn't needed there (the GCC implementation
> of kstack_erase uses a GCC plugin that removes stack depth tracking
> instrumentation from __init sections during a late pass in the IR).
>
> Successfully build and boot tested with GCC 12 and Clang 22.
>
> Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good:

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  v2: correctly split compiler-specific stuff out of compiler_types.h (Miguel)
>  v1: https://lore.kernel.org/all/20250729224325.work.019-kees@kernel.org/
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Kirill A. Shutemov <kas@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/x86/include/asm/init.h    | 2 +-
>  include/linux/compiler-clang.h | 3 +++
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 2 +-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 6bfdaeddbae8..5a68e9db6518 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -5,7 +5,7 @@
>  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
>  #define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
>  #else
> -#define __head __section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> +#define __head __section(".head.text") __no_sanitize_undefined __no_kstack_erase
>  #endif
>
>  struct x86_mapping_info {
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 4fc8e26914ad..fa4ffe037bc7 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -89,6 +89,9 @@
>  #define __no_sanitize_coverage
>  #endif
>
> +/* Only Clang needs to disable the coverage sanitizer for kstack_erase. */
> +#define __no_kstack_erase      __no_sanitize_coverage
> +
>  #if __has_feature(shadow_call_stack)
>  # define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2b77d12e07b2..16755431fc11 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -424,6 +424,10 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>
> +#ifndef __no_kstack_erase
> +# define __no_kstack_erase
> +#endif
> +
>  #ifndef __noscs
>  # define __noscs
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index c65a050d52a7..a60d32d227ee 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -51,7 +51,7 @@
>     discard it in modules) */
>  #define __init         __section(".init.text") __cold __latent_entropy \
>                                                 __noinitretpoline       \
> -                                               __no_sanitize_coverage
> +                                               __no_kstack_erase
>  #define __initdata     __section(".init.data")
>  #define __initconst    __section(".init.rodata")
>  #define __exitdata     __section(".exit.data")
> --
> 2.34.1
>

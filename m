Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369678F4C
	for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830078; cv=none; b=f3riDYH9aILwuo4lfRUkbgv70ccLoeeQxmQn/2fTt/vwakEWtqYfWuHOXqpkWT7xJyKts85ExY3anM0w/IOZgPu2ei9bjIiTkzSdaQc9+kh+5jsOIZg1r1KI7JkjmXr+qmeE6SAuZHgwgonbnNXyrobDzYDWnBrePnG0JRCT3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830078; c=relaxed/simple;
	bh=6jCng/YTFDTeRQn8f5lOGqcgmpk9+VAP8yf8TUEi2dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z46sR2ZeLUF7vKCcN3TeSwxwM14n9RwZxpyz2yueuOyXIjp4HY4VjRxHzUV+H8pqRdSwp2o0KaoWZob2Cnnw7HWrFXbK5u5zrmaCXvhO2zUXuQbfpSWH7iez1bvXwFHzq/oyBnlIKkvfiI2F9WAi0Rw+arHWBfbloPAMVR6GoDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJU0jswm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJU0jswm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so2436113a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Jul 2025 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753830076; x=1754434876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+3hpEC/XWKCoJPxAX/7UW8fvRo82H1QQsUoMkegBlc=;
        b=UJU0jswma8orqsuW0f2z7ERYVhJSe5n37pBFXfFiOG3JYdOGnwoP5CfAV3NnG/7rdx
         7dwBCUFED02gF1opxvLfsK3lpdMqnsyj7eexoUVknaI8le7KteOb8aIFQkc9wnhjEgBU
         VW5EEsP4rHZMb1NanoUFjlQuUDrcgR6zjczLs3NsRkse9C14vZeEJ2wfQUZFdVg72J1N
         rSQnz7u5o8dsadumPf5ZZxAiXdwT8LybWonX5rlnI53JfzWlAKJdwdD48XpdMhR3x2Gw
         r6PDp9bH3Sf5zjjJ34+a7HJsX3v89Qpf6LtfiS0OHeZujoUtjGSY99kJy7aIWT+mED4G
         xQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753830076; x=1754434876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+3hpEC/XWKCoJPxAX/7UW8fvRo82H1QQsUoMkegBlc=;
        b=AByGH8iMuSxARn1lsNZiDTlScSig6xtu9KuLMfrKC1r38z6nlaK9dbGjo+1wtL+9t4
         apxS/zOpNg+KKaPh5y9cMTpyF0jP+QOb79+eeB50Umr4DAurAH+zZfqrUibQIuqiJg2t
         dQB23QRfnTZmlZv/2m9+D4vENRN1NVEKOhvJ67RcOVsyxMEOHZThI0K194FqAIb733o/
         XORPm4CgU8kdLQ4KnUXaXcY9U7YXPx11/m6xDAcrFM8wPJNr1bOU5g+zXfcF4fZmDaTP
         l9aP6dgofWzeNthd8qsu/890F56LSxSbIfSiN1NOrTsAUOR7X54E2Kd6dvgzL2RVsJ7R
         NoBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqClAabnV6EG2AmOUGgl676ikmr8T+p2v3x3s5viIKG5/wSEuUIDeC5x7aWeZ1nHPGvIwXKB3j0bLhAqgi/is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRjaA0xVB+uCInz2DXaM0JAAsBTY5hPslHdXDkUAa+bEWWJ/p
	QV4rZfu6P0UxCzporOIt4/4rbArsENvLQ5pYDSzR9Qe8RZMXkzavQvrg4UwkFb2NQW1MEZbd29J
	mqq/c9OqXtdMb2KLhOZkf1NqJlN8NFza1YcnauZf1
X-Gm-Gg: ASbGncuNyLEbIIG3fY5reLraZDWZduVRoFgwu8p3mRIGu8WD2gPVpyJnzp7IrMZL2+H
	5V8YK3RKvb8MhJKsMiEUD6yRLuIWz6m3jTj8T8hprKvIc5roGylHij3A5PIdy8EL5PahevUVGDu
	wGwQ0KIcZ80yELbKnb6k4ZQ+hXxzcZQstvECCepcPDExEsmcPpe0EVTIy39ijaz0loGE3oq1rJA
	z1oqykKUhdlBb3yNwFf/KJPj8dZgEJZa6ECi80=
X-Google-Smtp-Source: AGHT+IEN+u/12HjQVSX1/UUPQZ6DEc6cODR2xLZMwTUPE7uUQpZPyiemKu7LkzWBOqN0Bu8mzVperrPAwON/FhFOFr4=
X-Received: by 2002:a17:90b:1fcf:b0:312:f0d0:bc4 with SMTP id
 98e67ed59e1d1-31f5dd9ccc8mr1419937a91.5.1753830075828; Tue, 29 Jul 2025
 16:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729224325.work.019-kees@kernel.org>
In-Reply-To: <20250729224325.work.019-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 30 Jul 2025 01:00:39 +0200
X-Gm-Features: Ac12FXyfCCLmSEsE8JlzE9w-_XpBxlAkYo0upai9b0-ZK8VVBgqqOiOpyuUYP2g
Message-ID: <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, "Kirill A . Shutemov" <kas@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 00:43, Kees Cook <kees@kernel.org> wrote:
>
> In order to support Clang's stack depth tracking (for Linux's kstack_erase
> feature), the coverage sanitizer needed to be disabled for __init (and
> __head) section code. Doing this universally (i.e. for GCC too), created
> a number of unexpected problems, ranging from changes to inlining logic
> to failures to DCE code on earlier GCC versions.
>
> Since this change is only needed for Clang, specialize it so that GCC
> doesn't see the change as it isn't needed there (the GCC implementation
> of kstack_erase uses a GCC plugin that removes stack depth tracking
> instrumentation from __init sections during a late pass in the IR).
>
> Successful build and boot tested with GCC 12 and Clang 22.
>
> Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
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
> Cc: Miguel Ojeda <ojeda@kernel.org>
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
>  include/linux/compiler_types.h | 7 +++++++
>  include/linux/init.h           | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
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
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2b77d12e07b2..89e2c01fc8b1 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -378,6 +378,13 @@ struct ftrace_likely_data {
>  # define __signed_wrap
>  #endif
>
> +/* GCC does not like splitting sanitizer coverage across section inlines */
> +#ifdef CC_IS_CLANG
> +#define __no_kstack_erase      __no_sanitize_coverage
> +#else
> +#define __no_kstack_erase
> +#endif

I think this belongs into compiler-clang.h, we've typically refrained
from ifdef CC_IS_CLANG/GCC in the generic headers.
See __nocfi for an example, where compiler_types.h provides a default
empty definition, and compiler-clang.h provides a non-empty
definition.

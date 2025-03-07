Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0320D4FE
	for <linux-hardening@vger.kernel.org>; Fri,  7 Mar 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390803; cv=none; b=fBKZi1e60nQef7q8+poV388zH7/uzGO+OUMWxxLcqI9RmISVogNJOe1iF4gvF4qqla2CrxjXqsEy1X+PD/ptGcqCqC113xde5jUf4e+p6filyAnMiGRWV2ZNI/4nzlSKEARzcXdf7b49slm9j7o7ZnxywrFmJUEBNMFMlfbaBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390803; c=relaxed/simple;
	bh=w436wgjGcjzJ3dyS3A6//n+WNelqPnxFh6A/g8MJI18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap8FXnTWTuTPHHV18xtivMEoGNjSjNMK5Jxdd1h+cjBdxmGNUijTraJHs4/bXh6/z0L5VpJIVn/C5qwAjnbN5FVo2jua5XbHsSWFTDhk7qs15897q7Fvg/KzIGJsh/i4XgCLu/rXSyayy9sQNf2W2bZkKwzgB0FtU6q4K9qIiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vwXPcN9; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vwXPcN9"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8553e7d9459so66213239f.2
        for <linux-hardening@vger.kernel.org>; Fri, 07 Mar 2025 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741390800; x=1741995600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDc72lD8Mhnu3NfUsPcD1oy818yB1nERuThSEkGUHkw=;
        b=4vwXPcN9EGBJ8ArVBWRV4hhuiBxfqvIWxYMwiZbdrqCsMPfdc5jLTlnroiaktJRLbm
         LTglMy81pePPJdHIi6qUoTDil3fjiSrhxYyDzkhnXFI8V0m8Zc7Br5HQJo2ASz0+8ZIM
         yaD3t/44crfxvTVhTdlycs1+v1A0W2VIkIvEXoFyHWbejQ37hsCOVtSNQ6TqScOa+C0s
         LK7ztbCcQnFMyTifJQdOFzoyjrwdOq1iIvZiVSv/tiTE4vMhUwC2blVrh14fiQyIVsfy
         aRwx8/pM4W3SGR/L1T9smglthFDByAXMQSf+jELc49CjcWOljOlS+uQzHEkKery5Edih
         ioWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390800; x=1741995600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDc72lD8Mhnu3NfUsPcD1oy818yB1nERuThSEkGUHkw=;
        b=GiuywiEKvshEZSFVr/dIg9eI+NMiSsDzTG8HIQOTBa1ARerLa8JWrnvHLddda5yVG4
         ZY9LHws7Pq/TYN5qqjwfywaCCychRMd7JbOk2qPuwphH2Xoq/wA1UHvA2cpjyh9ZgqLM
         Tj2/ihJhjGnfsT30U8vgDnM66rmMsb24u0eJ9cKHz2mQvzOoIYY10HPbozd1RnAib6cQ
         A+bMioZ8h6g82nXt42u29JpVuzrt/Ce7AqlHoPt9yIN6sSFpQ7u9VcpAMt82iux97Me4
         /2dxchZhXwLe0BtzCquJPE3Rr0+4gHGk1civxzyHozR9a60WoDyPU8U0/e20ZJnEDfF9
         WI2A==
X-Forwarded-Encrypted: i=1; AJvYcCWBBKfIAlUkCN0oWJjH9bcb4Rv0zjarpyqKiv3+VPElG0NrkncpeKX4XkczFwmj4D1hvajyYeP23QOHLb/BpOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKGY9HXPnZmGcAd0ewSy1BJppD6EJp8A+s43yAjgnyaROzjyN
	bG18rhE1wWXihL/VTt8tnVZFfHFHT+aH9CgRBKmHfzEomdAM8YnxJIAT7IPiMQ==
X-Gm-Gg: ASbGnctySCS41rBYrid7ykJPPy/KBHK9iHcLezkvQIw8cR/hPwd6kKgbR2BaBlNmaS5
	qkbsDDq+Y3rgfW6KNUgoEygGxLqyJVDLE49/qx1BRodrSHkROwmevHcfPxqBrMgpXbJWgOuoS3Y
	Xy5106FytGy7tQ9sMJi01ETcEEwYOcQaLsDjaanUuARRNzZhE/x2yh0ThmPd4STbgjDABUEuNtv
	mj3aQdi5xRiVj0Mh3QHK0udAE1QmndHgwb6x9eAnH/GdaoI+17TIZnfJ55/+4YBPkNwEVM/cL2+
	S6eoR9kODqNUpx+4IAdl+46oIjzpuaxc/5Zs2ISAhgv15EF9Ai3/cTy8ZY8XingvGZXOss1PFnI
	b4NKXpmcC
X-Google-Smtp-Source: AGHT+IE5GWqkBP7F2KuCtSZMj3O7YCqwL1LClyQ1d+IKR/y1v4SzZvWajbv9qbfRqrrAzp37TIieCQ==
X-Received: by 2002:a05:6602:474b:b0:855:9c88:7894 with SMTP id ca18e2360f4ac-85b1d03fb51mr700353139f.11.1741390800315;
        Fri, 07 Mar 2025 15:40:00 -0800 (PST)
Received: from google.com (26.80.59.108.bc.googleusercontent.com. [108.59.80.26])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06b059sm1193908173.136.2025.03.07.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:39:59 -0800 (PST)
Date: Fri, 7 Mar 2025 15:39:57 -0800
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Bill Wendling <morbo@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3] ubsan/overflow: Enable ignorelist parsing and add
 type filter
Message-ID: <52samxs253u3t2cmm5xwbmrwzyof36w7xczpuvbkarqwonwl32@2jbmkagpk7za>
References: <20250307040948.work.791-kees@kernel.org>
 <20250307041914.937329-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307041914.937329-3-kees@kernel.org>

On Thu, Mar 06, 2025 at 08:19:11PM -0800, Kees Cook wrote:
> Limit integer wrap-around mitigation to only the "size_t" type (for
> now). Notably this covers all special functions/builtins that return
> "size_t", like sizeof(). This remains an experimental feature and is
> likely to be replaced with type annotations.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> ---
>  lib/Kconfig.ubsan               | 1 +
>  scripts/Makefile.ubsan          | 3 ++-
>  scripts/integer-wrap-ignore.scl | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/integer-wrap-ignore.scl
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 888c2e72c586..4216b3a4ff21 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -125,6 +125,7 @@ config UBSAN_INTEGER_WRAP
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>  	depends on $(cc-option,-fsanitize=implicit-signed-integer-truncation)
>  	depends on $(cc-option,-fsanitize=implicit-unsigned-integer-truncation)
> +	depends on $(cc-option,-fsanitize-ignorelist=/dev/null)
>  	help
>  	  This option enables all of the sanitizers involved in integer overflow
>  	  (wrap-around) mitigation: signed-integer-overflow, unsigned-integer-overflow,
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 233379c193a7..9e35198edbf0 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -19,5 +19,6 @@ ubsan-integer-wrap-cflags-$(CONFIG_UBSAN_INTEGER_WRAP)     +=	\
>  	-fsanitize=signed-integer-overflow			\
>  	-fsanitize=unsigned-integer-overflow			\
>  	-fsanitize=implicit-signed-integer-truncation		\
> -	-fsanitize=implicit-unsigned-integer-truncation
> +	-fsanitize=implicit-unsigned-integer-truncation		\
> +	-fsanitize-ignorelist=$(srctree)/scripts/integer-wrap-ignore.scl
>  export CFLAGS_UBSAN_INTEGER_WRAP := $(ubsan-integer-wrap-cflags-y)
> diff --git a/scripts/integer-wrap-ignore.scl b/scripts/integer-wrap-ignore.scl
> new file mode 100644
> index 000000000000..431c3053a4a2
> --- /dev/null
> +++ b/scripts/integer-wrap-ignore.scl
> @@ -0,0 +1,3 @@
> +[{unsigned-integer-overflow,signed-integer-overflow,implicit-signed-integer-truncation,implicit-unsigned-integer-truncation}]
> +type:*
> +type:size_t=sanitize

Forgot to mention this in my intial reply but we have to be careful
with what types are added here. Kees, I know we're on the same page from
offline chats but for others: using sanitizer case lists to discriminate
against types for the purposes of sanitizer instrumentation may not work
properly through various arithmetic conversions. Mainly, implicit
promotions which tend to break this particular approach.

Now, for size_t we got kind of "lucky" because there are no implicit
promotions with size_t, it doesn't get promoted. This is not the case
for other types. This further necessitates the need for canonical
wrapping types backed by in-source annotations/qualification -- coming
soon in Clang.

> -- 
> 2.34.1
> 

Justin

Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4431B4240
	for <linux-hardening@vger.kernel.org>; Fri,  7 Mar 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390387; cv=none; b=a37lsSkzx6TcfUEgYiL7y3dsBXK13vQTlEGesJ95MjkzAv0BViRpA8YiMU6tkG/wxEDzn+q8Zj/kh1pDlBFrV8k4dyi2/WXSzgpbE2XWH+p5/TCAF/s8WSnbvjuGAJ+4rbQgiIofAJcOK9/WzfKzCklHzFchStUuNbu7qPYENpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390387; c=relaxed/simple;
	bh=L4aJtPrE2GfnROL3oS1K4BKrQk2bSyTkmLWv+1Ga//g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrg4zoXII7aWNAeH4o5JoDtNkmP6yQHvbX5qQmeYnkiljEbTBUxBidHCr2Ng7As4cwEvaBzOuJyEaEQTwp1UndUTxmj1kyKS2Uw+j2Jo9a5mtx1C/R3PvFVtATXKt2DtdKpf4/NkHshFvKY2cc2h8TlnlBFGtL3eX94u+ir7DH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2kUD9xc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2kUD9xc"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85ae9566c52so73201139f.1
        for <linux-hardening@vger.kernel.org>; Fri, 07 Mar 2025 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741390385; x=1741995185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFXO9D6YwhROjoFlwWSesjCYFiKET0NT2Feon19Q6U=;
        b=k2kUD9xckJ57FamQavIRngz9SRxwGmFBVrm5lTB90cHRqkkg83eegNh0ge0KBCmfIe
         /QRw4bppDOf14fwz+RBsTHMrCwZiM3OtI9PXu/PH0zun5gk/GVI52Bci+3jX3nTorKb1
         9ACZb+alUl/YTdI6a9on1h35z8ZvxDEh6isuzEeIPw3vg18G+XkC1plEcmgfaqqGldjM
         0OHAnnRwtYXUb1o/MncUoYp7RN3ZKyDEjpZ8eXJ6V4BNBfJDQP00hJaFNUyH0gmwz5r0
         FddyrObyjEBI0OSKCGCmcbIGQxpP46NMk+D+0ZlZRoXKD/qtDRP5BrfCTN+haGvzTGyg
         Igiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390385; x=1741995185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHFXO9D6YwhROjoFlwWSesjCYFiKET0NT2Feon19Q6U=;
        b=tW8g14T5qAPNJ4SRUUU6X9ZFoo3UUxVuvj0IbycKpwBluxTOhfGsAUg4QLFh8Mg7nM
         d0FseRFoS6pGcvyKN/FllThUCR0vNIRErYUufsn+fwlJqZZF1z7zoBlk+bGmixfKFRMQ
         rmeQqGYy4uA6CvN4LlCRRNww2mYM8pfOakjLgD7EnbI5H+cgVmWr7KEdvUv0E2j+E93+
         8ixntQRRkDbNvn3Ik7vqlqCFd14/2Bc45aw1UTQ7nZAKlgFc4NfHy/fPU8MsgxSDJYVS
         6RNskGR5FcV026Ox8HgGTYlQ3QueBPCHQLAAgNlVyfmtGAKvXdtyOPvbQjzDRQ4FT4FP
         g5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM90iUuCZSdXZ4k83Sz4mgb3kTy6SjRCSZ8lL9I5S1KcpUdoM6Vfb361njMNtVkmgqYRcy9kRJrAuU6qglSOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtES2pluPhHPhf5z6UmxcbcgRkrKSZPVNJFctBCXQ1wVCdbBX
	Z3yMolURXZY367r8rfTuNANJf6RwT0RUDt3V8Bg4H2n9/GRJu5wGSquo9dca5A==
X-Gm-Gg: ASbGnctp+GQua5GR7mHyGOem38OgWVw2yX3LCrvItkaBdgZ+mJFOhy9PtYdqMeaip+8
	VWh/eprEKGnub/8h5D44M9QkT6qE29QSbNrfpxRGj84Yq5zVyc7x61mo/T6jCtymdtCGttIJ1Hc
	AiBZFBfaKVOsTUPVr/TNwIYPmn9zghlsdF6nB+TjBN66ZQ+9qy1GnLrxKNl39/NsqbVYlQQCnKg
	uY7jpBpxHRAx9rha4MLd0GuXjAW/bsmr3Jvn2iff2k4RIK8vyLLdFp/0OoClk4sUsBn6arpe9H2
	mBiYlsvymIaIwo8JizHdThlK9Qe6h/npibViJeFjfbsHqeRWh+XzQCtNSAI0wGjSLEkNYN1ufe+
	AChRCVZxo
X-Google-Smtp-Source: AGHT+IFyRzzf7mMzUIJI4y0Th6wZ9sjI35nBIcnhd9RXwZh9GmhLYqRpDr7OO9MYwGSF0/lxYav2hg==
X-Received: by 2002:a05:6602:4006:b0:855:ac69:32a4 with SMTP id ca18e2360f4ac-85b1d053032mr663250139f.1.1741390384993;
        Fri, 07 Mar 2025 15:33:04 -0800 (PST)
Received: from google.com (26.80.59.108.bc.googleusercontent.com. [108.59.80.26])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22079b1dfsm382085173.118.2025.03.07.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:33:04 -0800 (PST)
Date: Fri, 7 Mar 2025 15:33:01 -0800
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
Message-ID: <upvdnfozcexlpb2x4auimec347adozkl2al4hu2yp3kfagdeyp@dqs2ft6wdmog>
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

Hi,

On Thu, Mar 06, 2025 at 08:19:11PM -0800, Kees Cook wrote:
> Limit integer wrap-around mitigation to only the "size_t" type (for
> now). Notably this covers all special functions/builtins that return
> "size_t", like sizeof(). This remains an experimental feature and is
> likely to be replaced with type annotations.

For future travelers, track the progress of type annotations over at
[1]. There's still discussion on how these will be implemented in Clang.

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

Hi again future travelers, sanitizer special case list support for
overflow/truncation sanitizers as well as the "=sanitize" comes from a
new Clang 20 feature allowing SCL's to specify sanitize categories, see [2].

> -- 
> 2.34.1
> 
>

The plumbing looks correct,

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://discourse.llvm.org/t/rfc-clang-canonical-wrapping-and-non-wrapping-types/84356
[2]: https://github.com/llvm/llvm-project/pull/107332

Thanks
Justin

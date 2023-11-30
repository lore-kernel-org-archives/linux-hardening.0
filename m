Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQ/Te5zA"
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857693
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:07:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-285a64dcf3eso1272816a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701378434; x=1701983234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbIZvkmLDHjuqC1Cwkdf1lYVKO4lsiVt6+GTqmsC6fc=;
        b=kQ/Te5zAg9tH0VOfkVIPix7dtbWBpPaJb4OxFopu3MfRwYpikD3CxatKPPlkODP5k6
         /dBER9ypWI8ZhurDdtAci2UxsOHz0WADU2f+0XEwy8647nqnzn44V+2hWz0PyXb4HQd9
         rLrBK7QFYISCEkO04a7DIR+E1QOmA2nTTWtPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378434; x=1701983234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbIZvkmLDHjuqC1Cwkdf1lYVKO4lsiVt6+GTqmsC6fc=;
        b=UUHTkKknWTfA+BWUYwx9iob5oJnojZjZaRp72idhvxcnhC13mpXfvjVhR4311CaWN5
         thsMJK+nE15XDEZm/bN4nd4JskGMq0HN1NnMfz04gbJXnN61trsN0S2jb/8o676ERq10
         oW6rzh/VJVeuy/5E2Tabm5QMejYHmHQadAcJaKNOAZl3KU4+GovdwYMkfRMUu4LhCGEW
         v1P/BO3EiisX6NM/UzYzUtbuqPUnd3StJpapgNN/v7rGtgysR44IWrlZ39Ml/ZvWu48K
         bzrnWR4K2Qd+pd+F0TD4ZIRlx6y7Le5Tn5N0E5/FxeGA4+ZQaaFsoZlk4IXzsTG63yb0
         be9A==
X-Gm-Message-State: AOJu0YyJ0q18+81T2daHrv489DmdNDPmZGDo6PLZWzHdh8ijMDFCCk/J
	ipyrRv/JBjS37DogzuC89Z/xQg==
X-Google-Smtp-Source: AGHT+IEJgJAEtudsVkOaUX/5ItBV95aXss2DqhWCaxPJGVs0Ullk1uwZ0w8Y4goJlNpEFPj2g4aaIw==
X-Received: by 2002:a17:90b:1e02:b0:285:b08a:780d with SMTP id pg2-20020a17090b1e0200b00285b08a780dmr16762443pjb.23.1701378434172;
        Thu, 30 Nov 2023 13:07:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bk8-20020a17090b080800b00285a17f9da1sm3705287pjb.43.2023.11.30.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:07:13 -0800 (PST)
Date: Thu, 30 Nov 2023 13:07:13 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] init: Kconfig: Disable -Wstringop-overflow for
 GCC-11
Message-ID: <202311301304.28F0C52BA@keescook>
References: <ZWj1+jkweEDWbmAR@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWj1+jkweEDWbmAR@work>

On Thu, Nov 30, 2023 at 02:52:10PM -0600, Gustavo A. R. Silva wrote:
> -Wstringop-overflow is buggy in GCC-11. Therefore, we should disable

Can you add some links for this? For example, maybe this?
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97490

Or discussions from -next builds?

> this option specifically for that compiler version. To achieve this,
> we introduce a new configuration option: GCC11_NO_STRINGOP_OVERFLOW.
> 
> The compiler option related to string operation overflow is now managed
> under configuration CC_STRINGOP_OVERFLOW. This option is enabled by
> default for all other versions of GCC that support it.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

But yeah, let's get this landed to keep new warnings from appearing...

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  Makefile     |  4 +++-
>  init/Kconfig | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 2cfd71ae3a86..8adc611fb611 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -982,7 +982,9 @@ NOSTDINC_FLAGS += -nostdinc
>  # perform bounds checking.
>  KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
>  
> -KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
> +#Currently, disable -Wstringop-overflow for GCC 11, globally.
> +KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) += $(call cc-option, -Wno-stringop-overflow)
> +KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) += $(call cc-option, -Wstringop-overflow)
>  
>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS	+= -fno-strict-overflow
> diff --git a/init/Kconfig b/init/Kconfig
> index 9ffb103fc927..aaaa99a5d2a9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -876,6 +876,18 @@ config CC_NO_ARRAY_BOUNDS
>  	bool
>  	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
>  
> +# Currently, disable -Wstringop-overflow for GCC 11, globally.
> +config GCC11_NO_STRINGOP_OVERFLOW
> +	def_bool y
> +
> +config CC_NO_STRINGOP_OVERFLOW
> +	bool
> +	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC_VERSION < 120000 && GCC11_NO_STRINGOP_OVERFLOW
> +
> +config CC_STRINGOP_OVERFLOW
> +	bool
> +	default y if CC_IS_GCC && !CC_NO_STRINGOP_OVERFLOW
> +
>  #
>  # For architectures that know their GCC __int128 support is sound
>  #
> -- 
> 2.34.1
> 

-- 
Kees Cook

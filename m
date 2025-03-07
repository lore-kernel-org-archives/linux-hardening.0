Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E93208989
	for <linux-hardening@vger.kernel.org>; Fri,  7 Mar 2025 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389164; cv=none; b=PJrSkCeJgXdhxI98fWWCzeU9mtRTFIH/kWa3Go01dGyU8sNrjap3pBJEo04E9ywQqK5ESDIG4bas6DJ5k4DCXr8bVuDzac94a1spxHoVA4VAgno/a7bSHMLb+KYio33y3vLf39lD6W0KWdGp2yIUKrMw5z89l73Vi+3tzos9ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389164; c=relaxed/simple;
	bh=iAr5WyJszTlsFuuCiqSrDjfdnmsHP/Pi4YVF/CoLA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ZNu1xyxDHyMz+kHdeSeIcXzdMbDiS3o5gJFjLkVs5hrHJL8ooy6cHlUm1yA5ZliKNhZI4CUpuTWnUfW2R7t6JdyVsr72Bj2otflhh7QrsNCIGVwoMb24B7QghH5KEzazzEkYMxP0JI4qLZ71HGbXHdqoktIwcSm/9GttHL/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqC2HE2G; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqC2HE2G"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855184b6473so164018839f.2
        for <linux-hardening@vger.kernel.org>; Fri, 07 Mar 2025 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741389161; x=1741993961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWk7dXPmdm5yCaIaVrSCJTIdKCaoNn8ysMEwHD+DXFk=;
        b=jqC2HE2GAR5fjnLq7k9HHXB9YU8wqgTJ+srKfDYA1zjBjjOFFvlCIa4oZJwpoHLnig
         FgTPTgiGKEf9Hi4kRTaw83z0sG4Y+u36LAoZ4KTZ5R4F3rZ4dr/ULb+7E8GLS4C6oCAI
         0ATDZTck0tSBPKRRai9l08E9dDydqIUlNkQQYwvxb9OiH1tl2yHrpVUtDs9c2XohMAfJ
         KrrjCTU+N6jxxYQE8Lk65/BKvK+FvR5SyWB2FcA/Zj9FWPqrlUNTaNxTce1ZsCLxWxCP
         Ly0qO3gAzeJH77UrTUwaznHZh+Mgax3HKEeyTgrqb7EiumnaFxPQro8En0k45BrWnJWy
         uiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741389161; x=1741993961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWk7dXPmdm5yCaIaVrSCJTIdKCaoNn8ysMEwHD+DXFk=;
        b=c2Tu9l1XvEUdjtNbjruJtNLAJOCzYBwz3TCghcWEto0ARaszVYuwT1LLEtwCStUDKu
         l91rQMrtixRdRaixeGdjkGLaYfWcdeGk2oc08k62Xne/Nsx59hvBlq7zF8lVmJeprlTW
         S+G4lJFX9MH0hprgscbk+/Ve8mM0ZwdQfWJ/+3kdrHPTYsv++snRUZQkMjGGjQ/2CTFW
         sZxm3kPviaOh+dBbpvW5rYlPqanLgWvsz1jy5Olvd/73WvAn92KYfm41k9lA4TmC6sPL
         d1yTttiDwXuSbYbwczU1h7lYB8UJY/ITTqB+dpoUZ+l54JC4gAYbLqAtQA9cx3sux9ho
         bWLg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWPv6iJdf7ecpe8DVIB2rLGNAAvqNVeIHoA9mQAbOvpgVez1k8GJ9B25vxzPys9dLDEjr+pEgQEgOqVYryX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYHaBoTwAjJdEUaUyw2Nkkr08KUcsUVnb1bVIyJBaOVAhKeyv
	L/LA7dWNgeqZ3c2sb20feHsqGwhS7TTXutpwYNGnhSCEOF5kFnwl0xZ9lRkf6Q==
X-Gm-Gg: ASbGncsP8ao2F0bmehVsuZ1ZcVSRccBlkB8SYFPVCj/OjaS8gK0ZWS4guwEi4wPq7Gq
	fEzCH2m7snjek/zOz/G71PqAzzjjNlZGmKjVjyXCQWs3U5EJ6Zc+TkXCLsYV+QamQWLOUoDVlpl
	jXbzYqK7guAIdnnq7+S9XC2c1zTdAaWcV80wFqE5etwBIvKDsUT2flyEv4oWNaRASRc9wf5IsEs
	bMdqzpXmFKcJ056RXHmgM+o03x9Qv1GOrwAdcPGo5muxEzC99hogXwS5YPcmijlKZJZPSFOeody
	zpjssDKx6JNvfsjilbPrUQ8kSxWzY3BhzMRTg4hZORbb2IyqHqt5ujKQgohMG75XMW88CnjFf66
	dc1yXcE0j
X-Google-Smtp-Source: AGHT+IHiiJqDXqIfUK/CVTI1rCS7/zKGfwuR4j+jwP7Uw2SRUCzehVJJV8FDhIdmPV4bfql6Mc8Hcw==
X-Received: by 2002:a05:6602:c8a:b0:85a:eff8:4ce0 with SMTP id ca18e2360f4ac-85b1cf7fbb6mr661020739f.1.1741389161258;
        Fri, 07 Mar 2025 15:12:41 -0800 (PST)
Received: from google.com (26.80.59.108.bc.googleusercontent.com. [108.59.80.26])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f216f55378sm681019173.109.2025.03.07.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:12:40 -0800 (PST)
Date: Fri, 7 Mar 2025 15:12:35 -0800
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Bill Wendling <morbo@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] ubsan/overflow: Enable pattern exclusions
Message-ID: <yduqbthmtpc5e2n4u73ofbp326chk3qdkgdiyrgmwcbhgeqceq@yybbkifwt4zk>
References: <20250307040948.work.791-kees@kernel.org>
 <20250307041914.937329-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307041914.937329-2-kees@kernel.org>

Hi,

On Thu, Mar 06, 2025 at 08:19:10PM -0800, Kees Cook wrote:
> To make integer wrap-around mitigation actually useful, the associated
> sanitizers must not instrument cases where the wrap-around is explicitly
> defined (e.g. "-2UL"), being tested for (e.g. "if (a + b < a)"), or
> where it has no impact on code flow (e.g. "while (var--)"). Enable
> pattern exclusions for the integer wrap sanitizers.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/Kconfig.ubsan      | 1 +
>  scripts/Makefile.ubsan | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 63e5622010e0..888c2e72c586 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -120,6 +120,7 @@ config UBSAN_INTEGER_WRAP
>  	bool "Perform checking for integer arithmetic wrap-around"
>  	default UBSAN
>  	depends on !COMPILE_TEST
> +	depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)

This option group "all" may be expanded in the future, e.g., negations
of unsigned integers (not just unsigned integer literals). As these are
deliberately designed for the kernel, I think we will want them anyways.
So, all is good.

>  	depends on $(cc-option,-fsanitize=signed-integer-overflow)
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>  	depends on $(cc-option,-fsanitize=implicit-signed-integer-truncation)
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 4fad9afed24c..233379c193a7 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -15,6 +15,7 @@ ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined
>  export CFLAGS_UBSAN := $(ubsan-cflags-y)
>  
>  ubsan-integer-wrap-cflags-$(CONFIG_UBSAN_INTEGER_WRAP)     +=	\
> +	-fsanitize-undefined-ignore-overflow-pattern=all	\
>  	-fsanitize=signed-integer-overflow			\
>  	-fsanitize=unsigned-integer-overflow			\
>  	-fsanitize=implicit-signed-integer-truncation		\
> -- 
> 2.34.1
> 

Reviewed-by: Justin Stitt <justinstitt@google.com>

Justin

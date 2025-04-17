Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B1156CA
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893425; cv=none; b=sxzdKZbkVBkqVFMtYO1RMfe7rEBtk04qvNauM7p+B5e6+wVy8iwXkF/1/yu9bzBBkGLpgJBWE2EwpYpyDv+428RC1lRjUSenVW6LrjpHqZ6Fnas3qiCj49LacZUWZtAv+XxPcvTsPr9t/sBL9CtFxctBRHlEia4tCCZIwkM+Hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893425; c=relaxed/simple;
	bh=z8BywmB7U7TmFZECdgY4Am3vkqHwYELaHUoKH8WUIW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eckOX8aXm8KNRMTOqQzMVjFff3JTrxxSOIVXlkJbmysi6xK+5BqQ8uxrAGMIeLUtY7n9KhJrwnqX3ot7nkgN44CRmvK3W0AFb6gmpf4vussvztvEdN02PlMaY8HPOYM2rwAq2ohNLeEuhyyXbgUB+LIF9HnIA/TVH65zkLj+HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITdwt1Ov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITdwt1Ov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744893422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJBhTbOABggX16wvpv2vgV0fRUNwe643nUmUBYY404=;
	b=ITdwt1OvWFzYkl7KFnhzKhAD/CsEot+H/yAMbkw3gtKFlwSMBVr8x4nkoY3MeTm5xjUqiB
	wzxK2QFVZATIzTiqNrakQZSnnaj5Z9SmPbES18JaFvwtTvejjfxkqzCFOZPylBNG1U1h/l
	IhoWUODPeHJ9uM9v3c1wOfIyK7J6Io0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-mcg13sHsPPa4YO5HmmyYSg-1; Thu, 17 Apr 2025 08:37:01 -0400
X-MC-Unique: mcg13sHsPPa4YO5HmmyYSg-1
X-Mimecast-MFC-AGG-ID: mcg13sHsPPa4YO5HmmyYSg_1744893420
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54a6b0c70so56244585a.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 05:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893420; x=1745498220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAJBhTbOABggX16wvpv2vgV0fRUNwe643nUmUBYY404=;
        b=p5DZV5XRrtyGrYfad8cL5i3gZ/kAMOyA9c2P0LHn1g1c6aeNPYRn+M7vtoVGRfoBUr
         OhOp8hTpArgas7lZw6lokW4H0MqJ8BX0X5By26g5uzBktRSjSV8Jnrx3E7AbI+3vA454
         0VYyVpXCGlDPC6Kby271NLJcRkvQkO/4I3RDZE3gv4gtkhBGy2ZnCoKs2amqFCnEXVFW
         cUlfIaEu4+Qp2CoWItCFWoSNEtW477GKxMLcB2A51DYQrj6M2JfV3iuQzTgvEsi6mHCG
         NMFBzlikzQhY1NlOFWSRW7V1VauuZxUFJr1JjoPZzjMbDJA0dZJJ+w0d0a6uUNQwJ0TQ
         x+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpzT2zxLrVpsh6SMO68xEJON0kVYeeyKqWjXRnRktU/jLAXQhxuezfZHEC7Z6BfQxeixlMF091mkVRqIlXN4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbejfQbaPBF9w9y7tSJvzSytA0lgfq2a3DeJBIGoOzk4u0Vx1
	DjAGu7McdxAQjqofTiK0biwRdIalXCVCTuCrC3wDJD9J7Br7AVw+vAaIuZ46OHmPHxbdN2ews4d
	QNnWiDORjBgWTGSYdt4l1Bs7Fmn5+a0Cq72G8I+v7yooj8rj0HR94y8kR/SpI6yyKrA==
X-Gm-Gg: ASbGncsVEemv/05irQGUfEfEi5nFwK7XkY+D62SxWBllZKwIPj/lTXTV9CYlSg36vFh
	wHiu3wZYz6qMftYFV0k3v2vHZnwfMCKCRyC12CHWYlss5FS+VxO2i7WgVQowDtQmFRLiwDwzp+6
	G6D2NGtE16Rjllv6ZFftzuVJ3zFpiqqRLPuXXuanN08LFNPeDpSq4ayk08y30oNyxTBNLxc8B1e
	NdXiSKNrWDHdWAfJMnJAUj84l3K27AFZnZAOqmc5TDX0nIlJobhyKhEFkdP+RBG3iTFgJlwAvf1
	JGIBUt71grp3aPXhHnF6wVSk7oLRvvsBckBum1UeB4zR23ANDJ5lYA==
X-Received: by 2002:a05:620a:2629:b0:7c7:ad79:a087 with SMTP id af79cd13be357-7c9190875f7mr865552685a.57.1744893419781;
        Thu, 17 Apr 2025 05:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuHxFULT3nNni+vu8M3Vjd+F9IkWUkQuz6UZU9DS4yGU16eKaT0xWtw67tyWocpLYiA1XROw==
X-Received: by 2002:a05:620a:2629:b0:7c7:ad79:a087 with SMTP id af79cd13be357-7c9190875f7mr865548585a.57.1744893419359;
        Thu, 17 Apr 2025 05:36:59 -0700 (PDT)
Received: from athena.aquini.home (c-76-23-219-111.hsd1.me.comcast.net. [76.23.219.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89f98eesm1173067885a.83.2025.04.17.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:36:58 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:36:55 -0400
From: Rafael Aquini <raquini@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <aAD153YR9ahpDBcW@athena.aquini.home>
References: <20250415170232.it.467-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250415170232.it.467-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZXnFG2K2ZfjrLBRuim-5Z1GX6v752YCUffzqJEN7OZo_1744893420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 10:02:33AM -0700, Kees Cook wrote:
> Some system owners use slab_debug=FPZ (or similar) as a hardening option,
> but do not want to be forced into having kernel addresses exposed due
> to the implicit "no_hash_pointers" boot param setting.[1]
> 
> Introduce the "hash_pointers" boot param, which defaults to "auto"
> (the current behavior), but also includes "always" (forcing on hashing
> even when "slab_debug=..." is defined), and "never". The existing
> "no_hash_pointers" boot param becomes an alias for "hash_pointers=never".
> 
> This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".
> 
> Link: https://github.com/KSPP/linux/issues/368 [1]
> Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
> Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: use switch state to avoid missing states (pmladek)
>  v1: https://lore.kernel.org/lkml/20250410174428.work.488-kees@kernel.org/
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tamir Duberstein <tamird@gmail.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  .../admin-guide/kernel-parameters.txt         | 34 +++++++----
>  include/linux/sprintf.h                       |  2 +-
>  lib/vsprintf.c                                | 61 +++++++++++++++++--
>  mm/slub.c                                     |  5 +-
>  4 files changed, 82 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 76e538c77e31..d0fd9c745db9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1798,6 +1798,27 @@
>  			backtraces on all cpus.
>  			Format: 0 | 1
>  
> +	hash_pointers=
> +			[KNL,EARLY]
> +			By default, when pointers are printed to the console
> +			or buffers via the %p format string, that pointer is
> +			"hashed", i.e. obscured by hashing the pointer value.
> +			This is a security feature that hides actual kernel
> +			addresses from unprivileged users, but it also makes
> +			debugging the kernel more difficult since unequal
> +			pointers can no longer be compared. The choices are:
> +			Format: { auto | always | never }
> +			Default: auto
> +
> +			auto   - Hash pointers unless slab_debug is enabled.
> +			always - Always hash pointers (even if slab_debug is
> +				 enabled).
> +			never  - Never hash pointers. This option should only
> +				 be specified when debugging the kernel. Do
> +				 not use on production kernels. The boot
> +				 param "no_hash_pointers" is an alias for
> +				 this mode.
> +
>  	hashdist=	[KNL,NUMA] Large hashes allocated during boot
>  			are distributed across NUMA nodes.  Defaults on
>  			for 64-bit NUMA, off otherwise.
> @@ -4120,18 +4141,7 @@
>  
>  	no_hash_pointers
>  			[KNL,EARLY]
> -			Force pointers printed to the console or buffers to be
> -			unhashed.  By default, when a pointer is printed via %p
> -			format string, that pointer is "hashed", i.e. obscured
> -			by hashing the pointer value.  This is a security feature
> -			that hides actual kernel addresses from unprivileged
> -			users, but it also makes debugging the kernel more
> -			difficult since unequal pointers can no longer be
> -			compared.  However, if this command-line option is
> -			specified, then all normal pointers will have their true
> -			value printed. This option should only be specified when
> -			debugging the kernel.  Please do not use on production
> -			kernels.
> +			Alias for "hash_pointers=never".
>  
>  	nohibernate	[HIBERNATION] Disable hibernation and resume.
>  
> diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
> index 51cab2def9ec..521bb2cd2648 100644
> --- a/include/linux/sprintf.h
> +++ b/include/linux/sprintf.h
> @@ -22,7 +22,7 @@ __scanf(2, 0) int vsscanf(const char *, const char *, va_list);
>  
>  /* These are for specific cases, do not use without real need */
>  extern bool no_hash_pointers;
> -int no_hash_pointers_enable(char *str);
> +void hash_pointers_finalize(bool slub_debug);
>  
>  /* Used for Rust formatting ('%pA') */
>  char *rust_fmt_argument(char *buf, char *end, const void *ptr);
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 01699852f30c..22cbd75266ef 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -60,6 +60,20 @@
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
>  
> +/*
> + * Hashed pointers policy selected by "hash_pointers=..." boot param
> + *
> + * `auto`   - Hashed pointers enabled unless disabled by slub_debug_enabled=true
> + * `always` - Hashed pointers enabled unconditionally
> + * `never`  - Hashed pointers disabled unconditionally
> + */
> +enum hash_pointers_policy {
> +	HASH_PTR_AUTO = 0,
> +	HASH_PTR_ALWAYS,
> +	HASH_PTR_NEVER
> +};
> +static enum hash_pointers_policy hash_pointers_mode __initdata;
> +
>  noinline
>  static unsigned long long simple_strntoull(const char *startp, char **endp, unsigned int base, size_t max_chars)
>  {
> @@ -2271,12 +2285,23 @@ char *resource_or_range(const char *fmt, char *buf, char *end, void *ptr,
>  	return resource_string(buf, end, ptr, spec, fmt);
>  }
>  
> -int __init no_hash_pointers_enable(char *str)
> +void __init hash_pointers_finalize(bool slub_debug)
>  {
> -	if (no_hash_pointers)
> -		return 0;
> +	switch (hash_pointers_mode) {
> +	case HASH_PTR_ALWAYS:
> +		no_hash_pointers = false;
> +		break;
> +	case HASH_PTR_NEVER:
> +		no_hash_pointers = true;
> +		break;
> +	case HASH_PTR_AUTO:
> +	default:
> +		no_hash_pointers = slub_debug;
> +		break;
> +	}
>  
> -	no_hash_pointers = true;
> +	if (!no_hash_pointers)
> +		return;
>  
>  	pr_warn("**********************************************************\n");
>  	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> @@ -2289,11 +2314,39 @@ int __init no_hash_pointers_enable(char *str)
>  	pr_warn("** the kernel, report this immediately to your system   **\n");
>  	pr_warn("** administrator!                                       **\n");
>  	pr_warn("**                                                      **\n");
> +	pr_warn("** Use hash_pointers=always to force this mode off      **\n");
> +	pr_warn("**                                                      **\n");
>  	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
>  	pr_warn("**********************************************************\n");
> +}
> +
> +static int __init hash_pointers_mode_parse(char *str)
> +{
> +	if (!str) {
> +		pr_warn("Hash pointers mode empty; falling back to auto.\n");
> +		hash_pointers_mode = HASH_PTR_AUTO;
> +	} else if (strncmp(str, "auto", 4) == 0)   {
> +		pr_info("Hash pointers mode set to auto.\n");
> +		hash_pointers_mode = HASH_PTR_AUTO;
> +	} else if (strncmp(str, "never", 5) == 0) {
> +		pr_info("Hash pointers mode set to never.\n");
> +		hash_pointers_mode = HASH_PTR_NEVER;
> +	} else if (strncmp(str, "always", 6) == 0) {
> +		pr_info("Hash pointers mode set to always.\n");
> +		hash_pointers_mode = HASH_PTR_ALWAYS;
> +	} else {
> +		pr_warn("Unknown hash_pointers mode '%s' specified; assuming auto.\n", str);
> +		hash_pointers_mode = HASH_PTR_AUTO;
> +	}
>  
>  	return 0;
>  }
> +early_param("hash_pointers", hash_pointers_mode_parse);
> +
> +static int __init no_hash_pointers_enable(char *str)
> +{
> +	return hash_pointers_mode_parse("never");
> +}
>  early_param("no_hash_pointers", no_hash_pointers_enable);
>  
>  /*
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71..f3d61b330a76 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6314,9 +6314,8 @@ void __init kmem_cache_init(void)
>  	if (debug_guardpage_minorder())
>  		slub_max_order = 0;
>  
> -	/* Print slub debugging pointers without hashing */
> -	if (__slub_debug_enabled())
> -		no_hash_pointers_enable(NULL);
> +	/* Inform pointer hashing choice about slub debugging state. */
> +	hash_pointers_finalize(__slub_debug_enabled());
>  
>  	kmem_cache_node = &boot_kmem_cache_node;
>  	kmem_cache = &boot_kmem_cache;
> -- 
> 2.34.1
> 
>

Thank you, Kees.

Acked-by: Rafael Aquini <raquini@redhat.com>


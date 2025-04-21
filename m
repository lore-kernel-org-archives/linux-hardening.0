Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595A1D8DEE
	for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745258720; cv=none; b=c6kTg6IK2lKRgeqD1lOk0SpIeJ4uOX6sBxJsFC95tbF/JYlL2/TEEXxA5WzG41K245DWT18acd/ewfc7YnrrZvSa+Hxg36qZrjY8LfoWw+1pvaZ/4XStBijLsy4HLGMk5LZ054wWBnuLnoBqi0oLwX7gRoKFVaT+bilvrjYsVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745258720; c=relaxed/simple;
	bh=qGgJymgZyzfYkWI9uvVgSpOlA7nuXmcfvo3qhmYbHOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b4cXQh8fUCQG7dCIcdzYVDrZcFI0ted2o2qftyMQ66x7z3OFijvx3+CJZ+461WCmYKQr56aJg8t7FfajuWsvKpEzhU4BjH3hKqx++u8zaZETfSHZxGDFOp5fBm0OdRDudjuLWqltwS27QhGnfLkYaFffldWCbIEH/BNJmDx3RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGWvZEXb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGWvZEXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745258716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eVvKIhcDUigy61iYir4MfxXVC274WCrw45kaD6hp0uk=;
	b=jGWvZEXbad2iULzI22+yZmmxQH2PjAeNfP4fjaDQp3GORjyc6EqU+Ei//kPFs2ggLxNqFl
	p0UNdtIgdcLMuFgkbzyOIYivmVX1+antMv+gxF8RTqa06ppNFKZLjIrx26N36Ov5cBRjOI
	eq6IXq52VlzoqiOBjmoVpWBpFsRNUZM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-ecgbeBEbPeWHJHDfspscjQ-1; Mon, 21 Apr 2025 14:05:14 -0400
X-MC-Unique: ecgbeBEbPeWHJHDfspscjQ-1
X-Mimecast-MFC-AGG-ID: ecgbeBEbPeWHJHDfspscjQ_1745258714
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4767816a48cso115751741cf.3
        for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 11:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745258714; x=1745863514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVvKIhcDUigy61iYir4MfxXVC274WCrw45kaD6hp0uk=;
        b=rITH7s23h/3bqY2vxitc024wVUcjed+ArDGPeIXtysx/jCHwNweDt6HEhfH3F2L50u
         2jnJqqtZIUZ37KM+LECy6EKQHC1DLjXAnUccPXaLyIKUoedbWpbWBqqtwo/6HRdbMm5Z
         zAoDeicpDZSP2zw0aSh131/1SYNMHG4TvN9t2ZW3zwGAzOZYO6J7qxZZsZxaNz3OLB1d
         KdKI0FgbBkhIlynHaXkEj4SvRYHVWpYw1JaHzY6jvzX/bPV021IRYZbgCIgTCgVqUjUp
         XO4cPe6grNKXmWv70rDncefPOEeeBCSJUv/O+OAiUIpsHIwVMz+UWFjM+qGX09YEQqAv
         pE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHeIvaoQ2Cm7zCrAhHbfl6qXQxTJdyTtLPh0t0vobSljbeppjtfBA1Gg1rzHUWrcUvJQ1QU+soekdMyYBC/d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezcHnmXdgmv0hqKVx/k1LTGJPaqxpiP0X7neElid3wJXACzBI
	6Ncu6NLHB81MQMTppeoD+eitW58mdGKrNPoiphtXM9bifYbpHdf5pV6Y7d1olErVKaaTRGNw1jI
	GUcwTDo9/I2Ew+JLuJAcVZcaj9D1CVDkiI0VneJWAm3iHYun+OZCMmrTXLUy0KfeGKg==
X-Gm-Gg: ASbGncv+LI3rc6pPTjvvjdR0o08//aFHbmdGlT9Sq25e9upb3OMuDnhnquOaCnxgakJ
	CILCMyvCyemlXD58wGKP0KYoNunKXcgYw+2OdDiRBA65e3Qg9E9ZFF4uFTSJDC9rdRkMoKYbjb+
	FiJi837YrfIX+D4i/PeEcxktdNwFANgEfAl6vPa5RgdGKkhB5LsiBtl/1vqq+fm88ztUJtaeTEm
	+/+shZCKvMMX5k+MUE4bVoHT2xBgWQZlZjac4tQZReID92J309jkvx10450gtYWoVPxWSGlEaUc
	3L15G8TEvVPzx0rAfcWv74U4sJc4okS6EBuFK7CldXjTN6M4+8q1hw==
X-Received: by 2002:a05:622a:130a:b0:476:7e72:3538 with SMTP id d75a77b69052e-47aec4c5b9bmr257980531cf.50.1745258714105;
        Mon, 21 Apr 2025 11:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzSdW6NS+1cQtXXq3zs8Ag1p4QSDq3hHqyATaMXHMXhtpgSTpQ221iJSeiQeHxMsRVOyUsJw==
X-Received: by 2002:a05:622a:130a:b0:476:7e72:3538 with SMTP id d75a77b69052e-47aec4c5b9bmr257979471cf.50.1745258713436;
        Mon, 21 Apr 2025 11:05:13 -0700 (PDT)
Received: from athena.aquini.home (c-76-23-219-111.hsd1.me.comcast.net. [76.23.219.111])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa2ccsm45046821cf.67.2025.04.21.11.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 11:05:12 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:05:10 -0400
From: Rafael Aquini <raquini@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <aAaI1sJdna67WCaf@athena.aquini.home>
References: <20250421165508.make.689-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421165508.make.689-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ewc8-XMxfHF55TSfipmqXsTuMNOIsaBB14myeGf07-E_1745258714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 21, 2025 at 09:55:12AM -0700, Kees Cook wrote:
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
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v3: add docs about implicit "no_hash_pointers" when using "slab_debug" (harry.yoo)
>  v2: https://lore.kernel.org/all/20250415170232.it.467-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20250410174428.work.488-kees@kernel.org/
> ---
>  .../admin-guide/kernel-parameters.txt         | 38 ++++++++----
>  include/linux/sprintf.h                       |  2 +-
>  lib/vsprintf.c                                | 61 +++++++++++++++++--
>  mm/slub.c                                     |  5 +-
>  4 files changed, 86 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9fd26b95b34..cb12531b2100 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1795,6 +1795,27 @@
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
> @@ -4117,18 +4138,7 @@
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
> @@ -6478,6 +6488,10 @@
>  			Documentation/mm/slub.rst.
>  			(slub_debug legacy name also accepted for now)
>  
> +			Using this option implies the "no_hash_pointers"
> +			option which can be undone by adding the
> +			"hash_pointers=always" option.
> +
>  	slab_max_order= [MM]
>  			Determines the maximum allowed order for slabs.
>  			A high setting may cause OOMs due to memory
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
Acked-by: Rafael Aquini <raquini@redhat.com>


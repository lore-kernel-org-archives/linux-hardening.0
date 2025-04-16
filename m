Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B424EA86
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805194; cv=none; b=LR4rk0d66Fg5fwVbK8M9wdqLBuXDCKAyUXCZicNDLs+IZaCbrVBgsej8PupGfX8RtD/ew/UiMOAhVWwfy9NLg8aFTl+NWgp429M643+Zk1h/Z+TdU7MtXGMNaethKpWjF7OT+djVZRh+W/Fx2MhkuZ3dX61Oeu9zXYUpKeWN32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805194; c=relaxed/simple;
	bh=7z5UuWt1Xp12b2i2yn8J6VdnsKROGuzIKJmaC/18ry0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShwTzXVykSr1xjlpMZcvq+gbWIHFVhMQ26qMRA2quDdoOeO93Aq0F0V6nXrjkiOK7jmW1jad0/WLXAN0rbZ2bn0EfLbtBH9oUqicqloCxQpjVHc3M03bD5NkKC6Sw5NWGcIrkVMez6YA/Df9KooZ09P7imPQM8u9Gdax5U5phqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rzmu6wgg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rzmu6wgg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so56458145e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744805190; x=1745409990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjyHsmaGnXgLnOkHlMa/FoIoQg9ZMkPhTyPYzZ36NRw=;
        b=Rzmu6wggtSkjVw4lb+3MLn97dAulkiGa3tpJTATpR+cEBHaWdfghAc3vKjIDWiPLza
         qgLv4HENYqEmOUXBX7tPjJ5I0sU5p7Jb/kBoGdq9BA8DNzwALNp0if8fjaOJM+ajzJgQ
         pq4W/SOKKjqUS8m7wubgizr0XgiHGh7EL3MRH/rpLxPIvde2Ta3bw0u4hdrxv2LREO6D
         l4PskYbAM4OuRvKTf/ksg1QEEeJ8nSlmhgutRXr9CbExJeQmzZ8gVpVJ/yftJnq7qmuk
         iyqYfgi/vmsaFx2SV3TLKuehnVp1jcyoPuc8A6k7IBHPTRqOzd6JXG5uNf3lts6F24RO
         mfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744805190; x=1745409990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjyHsmaGnXgLnOkHlMa/FoIoQg9ZMkPhTyPYzZ36NRw=;
        b=nyjgqpvSf/Rd6satSlDq6pBmr/vmFDOK29t7TBW3+esIayGfvgZrSWgLi+CdLR/HdI
         45alNDcYDBiAHflA+M28epyqmKfokYEKI9AHhXgVWhcMFBMeeWpHKBv6+s6SW+6ctltm
         50c0gIvs7k4E0mf/A4Ae8zP0f0Q72skAupRBXktniBWq5rSLMql8eVNO4iuNXD3Y8nWG
         S5I9rErePdxen8WrmAOQrQtu+5PNju12YBII/YqtlXaJ4xgzBsZk1DG/xWMPdL7SPD/J
         CNUXJoi2y3kE9D4OICrXbVay99XolMimxXLJnfujyynj8Y9P6v4/uXtWO8vP5Yk2RAWA
         g5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUXxGaWeZ8zK7kmOhYuN92GcT5IeImtE3n+Ua5E9Rtp4SNNICzeM8X5SgSu/tG4TRTibyyGaKl6IouMG3KZ/7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywatmwQFugbBJM5fRBB0bInSARsBtkANCUTv1Kfi1CBP8+o6KE
	MRqj8+FDW/+gsDILCNACCp1Z07hFPIxOaS6vKbannmtfOQNJltccTTFInnMiVSU=
X-Gm-Gg: ASbGncuP2HXLuOMhHD/guv815TsU7a72xv+07/tFX8P/fSO3exk/YTqcDThnArxAYdv
	lECimIUurJGUP4KwtULMU3/tUuLk4vQnqj2S0SDjd+le9Wma8v/lJLBtb8UH7Yl6z9jFW0Fau/q
	m7gZt+AoHePI1lSnijDywY6cbuG5fMcTZUSWxhfSTDrrBd1YsuJf/U6D4Bw1k0REMDWE/GaAtp0
	btZXDl6LolnAQ4ZBg+VZMV48LAA3xr9xYs6oXB+VsLBY6EFQ47Q0nqLP8i68vwwrPNSE+CWKZBJ
	MpRQI45LG6HxO8Osw1pO4uXoBPnou0jphVo8yGoX7Ec=
X-Google-Smtp-Source: AGHT+IFGKnieYQcUUWn9WtxkWhVslqMn2qgJvWXBfUXQ9Q1PyuLY6YM0BeRt1acfCAoIy7S9Be2mKQ==
X-Received: by 2002:a5d:64ae:0:b0:39c:11c0:eb98 with SMTP id ffacd0b85a97d-39ee5b9f651mr1610490f8f.39.1744805184017;
        Wed, 16 Apr 2025 05:06:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae963f62sm16683914f8f.5.2025.04.16.05.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:06:23 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:06:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
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
Message-ID: <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>
References: <20250415170232.it.467-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415170232.it.467-kees@kernel.org>

On Tue 2025-04-15 10:02:33, Kees Cook wrote:
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

Tested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to wait few more days for a potential feedback.
I'll queue it for 6.16 unless anyone complains.

See a rant below ;-)

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
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

I personally do not like that these two parameters do not have the
real effect until hash_pointers_finalize() is called at some
"random" "unrelated" location, namely kmem_cache_init().
But I could live with it.

But the alternative solution proposed at
https://lore.kernel.org/r/Z_0AFjai6Bvg-YLD@pathway.suse.cz
was hairy another way.

We could always improve it when it causes troubles.

Best Regards,
Petr

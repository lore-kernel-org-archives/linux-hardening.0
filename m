Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D93314B2
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541626; cv=none; b=ugRa1ukOqoKHRG8QIo0HXzoi+T9brhmgWcQBtfneampnQBmxoFvu2OStUIEHX9cS4HIM0a8nzmXzKxuc7fRo+pxqSAT4mBVFuFX/GS4QobJ3C6WDI6ioWp1J0uv83NHwHI9zhS5iUVVkllFWZeApW0M4MPPfIDUsPwhSlC4kQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541626; c=relaxed/simple;
	bh=Rwi7Cu8wK8PRPeBmHirEY0WEDhwHCHjnE925WnBAEsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMJszhMnUejpB4Cqo8XBMms0z3WVKtWe11OAMISR9Z8cF1dhaUPO/N3F4+nmyvXAJWKBE+jom+FuAKRutuy3lCf452EcLJWwRE18jK2sxEbl2CdKtVVs/6DsLIsZ5FDo9S+xq77NLK4o113NTH3m1aXKiAmBPywsDCcmt5lo5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQ8XGPe2; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQ8XGPe2"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8843c431d11so97912839f.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541624; x=1756146424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xthx9ompS/Nj5CKJ3I4BXZ4xhbM39aiwRjdnUlZCUzI=;
        b=yQ8XGPe2gFoEnEemhwYLrmVWX6+5chnNIbLWOVh66V2X547loRxI0d8t40ZuCFBnGA
         vGRZ09hqJYv7bH2RX7GOg/K9eC6uw8qntF0emVL1Pj5G1hF20lub9/7lHBQIJLc5pDDt
         YeZgoPLN7Sb2plK5u9Mj+9kxwhDnxLGDOqeD5BpUh9dDlgOnCRheWDnC3eACtz4Bxlkd
         sPVJ0xkiWFT+4AnaP7HgusymjDftPJAjKs4fTDBn7SPOuoJ+LvoZ3wT8Cy2AlclbBpg2
         r2yu732fCi5wYnOOF1wgPVt+B4RHZSb4wmFX9FaybLbKL6WXTtltnYT/ZGj6FkasUJsC
         sOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541624; x=1756146424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xthx9ompS/Nj5CKJ3I4BXZ4xhbM39aiwRjdnUlZCUzI=;
        b=bmG8+EZIfXJGZxgGpNMYs6G2wrWNLQTso0CQa7+3CGBDKiIVgYyL4PjYU1z1hGVQZ3
         g4YKC2IaGmN+AUABCXMOr9yqDTt4JWvDgdo1QXwxScGUZcCh/ODI0hxa7F0gfF3oCGaT
         cLwK5lIqn9iHiPBwRxFCarsrPsba7BnZApeNqhYaS44LQnYkRr2kSNyDZxCsr26C2u/3
         neEJakg72QVLGrWNJmZabS89u7bGEjyBZgsy7yqzu/P4AN/yTqH6mxZEvv5Hp85FQZ4b
         nFQkXSsNOT+shoGx4KiBnnTAocb2FFnf2eglLdY7ZbyIkt0ewB6FYzVsbD7aR5gfYzio
         X8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1AhHxPmjjS2QYvVQwk18dVIfv1UL5hQCH97ptKo7pAlZeMXIA90T8pRGS4B/AGSgbCNDpSS2G7k/kcU9HoFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgNQS4PPILAp6czqu6YPK4h67hraRhRxLZXuHM7akcQ7aePVj
	9Xz5YM2AU2+UBu2+2iPwko05z2BxNrHqDrZAXcdW/How2NuRLtMvLkedoweBWWLiKxdBJmTBB7N
	9SrIEJg==
X-Gm-Gg: ASbGncv829J5AjR0CaW+czI0GEXB8M4ZdANOzcsOkee8+zliole8pDaZ36W2kVHkxOz
	7qzs5MjykuJyNYNWWTsk7atVTlPnF5J0UM+OhMqGW7ytgDUERIqey1gSGrMdPV5xqRshKrjcz+g
	UqVMiVd0yMnQWRjsZQ862wrXHBZ8cobfMOCIllmcLAtA1nSpm5apfV/xsBn/FneyGFP+vYpEU2P
	e2anT4I8w/xjAanvl+vGpO1reea2aePLi4NXn0W5FbTVKchYyor+bnGRNsssg1FCac2jt9OCHaB
	68MuRjllj1/QdzIc90gcA7cuhN93xtv7ltZrFLIBc9X1ANE4z7VccGO/HSwDFY8YCcXGU9qA4di
	v0IV2LurSVXT/2lrksJRoYeoy5cCGmnPXuPafkISqlLtSOaMj2CUaCCjs7/JUSiHGMr4UT6XL7A
	==
X-Google-Smtp-Source: AGHT+IF2dotuoGSCZvg+ZyHAacP4HbK0Z2LLDMxgQqs043KhXAhyYpRU6mXhUnrZ2USLYc+dScshIw==
X-Received: by 2002:a05:6602:6d06:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-884471192d0mr2123993939f.4.1755541623533;
        Mon, 18 Aug 2025 11:27:03 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c2cc7sm323121039f.18.2025.08.18.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:27:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:26:57 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
Message-ID: <hqvjfoaw5ooucqp3mwswrjxletq6vdzztwvlaxvxf5a6bivdzf@7fcytrsqhz4y>
References: <20250815213742.321911-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815213742.321911-3-thorsten.blum@linux.dev>

Hi,

On Fri, Aug 15, 2025 at 11:37:44PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/kcsan/kcsan_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 49ab81faaed9..ea1cb4c8a894 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -125,7 +125,7 @@ static void probe_console(void *ignore, const char *buf, size_t len)
>  				goto out;
>  
>  			/* No second line of interest. */
> -			strcpy(observed.lines[nlines++], "<none>");
> +			strscpy(observed.lines[nlines++], "<none>");

Looks good.

Here's my checklist:
1) strcpy() and strscpy() have differing return values, but we aren't using
it.
2) strscpy() can fail with -E2BIG if source is too big, but it isn't in
this case.
3) two-arg version of strscpy() is OK to use here as the source has a known
size at compile time.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  		}
>  	}
>  
> @@ -231,7 +231,7 @@ static bool __report_matches(const struct expect_report *r)
>  
>  			if (!r->access[1].fn) {
>  				/* Dummy string if no second access is available. */
> -				strcpy(cur, "<none>");
> +				strscpy(expect[2], "<none>");
>  				break;
>  			}
>  		}
> -- 
> 2.50.1
> 
>

Thanks
Justin

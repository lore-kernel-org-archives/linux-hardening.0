Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F8158219
	for <linux-hardening@vger.kernel.org>; Fri,  3 May 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764667; cv=none; b=cAr4rDSjj7gvRCFU72efqDcAhTZO44WCjr9rhKz8rmvXdj0W3v1YZVrTNom2Q1HYSSzz3neP647Pp0LNO+c3KmeROgXjraTukHujM6Hdz2GjyJWhAAlX+m+7v4sN4UTPC0fGzXA9r+jIUZAXoCyNIfSPXI6iecpz1teW3Cezd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764667; c=relaxed/simple;
	bh=x28zhPQYDxN9o4XVDCDp8X1jPK2/Y8lfsDGM/Wyqw1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWoD8lZCxWebi95RT04c9CTiiu0mqWStDuv834bdln48wGtXz8SamwfUw9YmMiJWJJqI66YmD1wptYCWBA2FAkdNlDFX3N0QWx/VbWOWBymGn78y6OL/D3qVUlP7lPu7qkyIkXypwvDMOp+h3Lcq1tSCA+FTmBiNnHzOjQkFO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMmYTq8F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMmYTq8F"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso81462b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 May 2024 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764665; x=1715369465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=EMmYTq8FcnWNpEfEnDuUuEn35bSpggBuRRS9ej+n4B4UDZYnU/bXDuGJpfgiU+9js0
         2rHL0PBoe5CRRli68Rhx4oAxQUmmd/KdhslbhXK8wscdoY5pLDi7XBIW6F5koifZzc2Z
         j8pL5pE/Kz4XlUiE2VqzRK2Z26ujvbhHOmU2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764665; x=1715369465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=fVvy4uR6bqNAhBXLdw4Jn0lFr5bgo923tSafNTQffO+yvdyEO+8eQzInQP+MC+zGia
         gw9u0FrWHwcGDje1TAkxd96vo1MPyhJvFCm7YJvRm4tgl7TwRXK3bJuzl481PWvPGuR5
         SFQ/sxzOiaInuNrCN91R0iDM51spRvU3pKOEUXGa+5w6zwy+/5NUVGOp18UZinfy3B7j
         8K9sIuYqsfVPRcrw46FcYJ+zU9wVpPhj9nOaujHfcGzk6SswGgigbyGZKcU9HAxNUnmw
         sU3CGvjDFPjVh28DoaiPPQq5Qc3oioRWDvJyqFv/Bmp1XrN+I/7SV59ASBOGjUgpe6HE
         pgIA==
X-Forwarded-Encrypted: i=1; AJvYcCV1QaLmDTSVln8ax7suSFNVSfRXlJ/HfCEYnhQ675Htrbh1yjz2NdHw/gn08CsMvHYruLo1GHsHhJGo/ec11DSYLThQgNBHMIY5XWKbFn+F
X-Gm-Message-State: AOJu0Yx+NN1Tu6t3Ixg1/+vuoZ3jjZwifVo1z+kc2KvDyJqkPFCoiFNd
	oi2P+smiMTk4OhTKygFE+JVc9UyUSQU/Fxd8cATuEkwBQ+0/fFD7cWQgrjJS8g==
X-Google-Smtp-Source: AGHT+IEbb/3D0nXc0Je0N+ipwjcG+uekqZpepX1LOoATHx5do+IW7TcvLbcHgkaK0O1cKziTuDQRyw==
X-Received: by 2002:a05:6a21:31c7:b0:1af:55e7:633d with SMTP id zb7-20020a056a2131c700b001af55e7633dmr4672289pzb.0.1714764665382;
        Fri, 03 May 2024 12:31:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp9-20020a056a003b8900b006ea8cc9250bsm3420413pfb.44.2024.05.03.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:31:04 -0700 (PDT)
Date: Fri, 3 May 2024 12:31:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <202405031229.9856D89B7A@keescook>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>

On Fri, May 03, 2024 at 03:44:09PM +0200, Thomas Weiﬂschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
                        ^^^^^^^

Was this supposed to be "prototype"? I couldn't quite figure out what
was meant there; the sentence reads fine to me without the word there at
all. :)

> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Cc: stable@vger.kernel.org
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> This was split out of my sysctl-const-handler series [0].
> 
> As that series will take some more time, submit the patch on its own,
> as it is a generic bugfix that is valuable on its own.
> And I can get it out of my books.
> 
> Changelog in contrast to the patch in the series:
> * Reword commit message to remove strong relation to the constification
> * Cc stable
> 
> [0] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/
> 
> Cc: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/stackleak.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 34c9d81eea94..b292e5ca0b7d 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *table, int write,
>  	int ret = 0;
>  	int state = !static_branch_unlikely(&stack_erasing_bypass);
>  	int prev_state = state;
> +	struct ctl_table tmp = *table;
>  
> -	table->data = &state;
> -	table->maxlen = sizeof(int);
> -	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	tmp.data = &state;
> +	tmp.maxlen = sizeof(int);
> +	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);

In looking at this yet again, I can't figure out why maxlen is being
set. It starts its life as sizeof(int):

static struct ctl_table stackleak_sysctls[] = {
        {
                .procname       = "stack_erasing",
                .data           = NULL,
                .maxlen         = sizeof(int),

-Kees

>  	state = !!state;
>  	if (ret || !write || state == prev_state)
>  		return ret;
> 
> ---
> base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
> change-id: 20240503-sysctl-const-stackleak-af3e67bc65b0
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 
Kees Cook

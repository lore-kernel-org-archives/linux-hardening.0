Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF11581F3
	for <linux-hardening@vger.kernel.org>; Fri,  3 May 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758937; cv=none; b=GNhO9tJTjN5yNkas0bgusM7XKNhcIaHWucnIT82sBFMhkjqTa+fMllBt6oHrE60mclb16H55IVI+oSDS8g6Vh9AFNgNAUrBgsTugL6hgxSKO/2aEPoD6fCi54C/wXKwR6M7Zu0k142Ubqnr+VJlsd40oYL73VBqOlBHrRPJyAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758937; c=relaxed/simple;
	bh=y3FTe/yZF4coOVNZnP08rsN6uKtTbcXmWT1Sw/5yX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4hAg8TAgxCkERtpHt+pTTR2X5cEYkdSuRtgtw6s5Oew9pLtKW40cl0NWSv3y+XkvzYrfrl3YL1v+EcxQ5zRtHcrklGK67lZjZk/vlW34k4m24h4yzxSSlGseAr5k+0NzQ1md3gneg2oWAavXLXRvdo9J8KFA5xQEQ+7Dpg+0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I7Bpelm0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7Bpelm0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e65a1370b7so87126835ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 03 May 2024 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714758935; x=1715363735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3szH4sxaPwAp0vnc9Q5nq9mDwhSGAgkyGp9dC8w3aY=;
        b=I7Bpelm0zmKoC7Il/cXvk491ccGh2erQBEUqfCrAaKsj7rD/V1Wri2IPC7V+ZZPGtZ
         SfUV2Sl/25OfdQjW7AXVYlm/MZViHGfzrtGBcgk3I26rPOW4uWpKw70FiBEbSfVXqaIx
         erQri9AeiWXq33z4IQEpZc3NDR06D1jd+n/8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758935; x=1715363735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3szH4sxaPwAp0vnc9Q5nq9mDwhSGAgkyGp9dC8w3aY=;
        b=sWyxEKAULSIPmPTwEd2iRYYx7QDq2E/LtZScfiBaauzqpEqm614Rw4o94Kspqx6YiQ
         zAxV6Eg68Y+tmcE8VqSJXgWe8KSajRnBoqm5+qo56Ld+ZcHBfvzxZAiCAONoNCo2Tkbz
         SIjvVF/dnEf5xRgAUBRK670coK/tkrUl7odH6+gND94bdYCtrxL+vvElAzPw63uA66+Z
         hrAjvK65ZlAppRi9nhNuyUCfDXHEEKpi6g/W7epu3/VXyPSVLEWlwp7zeDUfScPtpZhJ
         iHYXHO9kfdZE1kFmxdKJPP2luZJUqIjxyf6YFFariOnvqBFce3zODobZihvtypwgoAHE
         JgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYk+tJoeOi9m79UaW9JjK9uulzFYEgmrhGLwGh4659eldJ0RnqQFGLuK9XpetIAgpt58eyVSIfkUh5OZznRsVxIEBodzTF9QVNu9i480ik
X-Gm-Message-State: AOJu0YwpMxg9J0E9m0cUUzalphNXjFRKtb39c63GB+XGcf8nrYJHOJ28
	9Tv0v7JByAheDBy8gynBlfewSo96d8jXXhXc4yYO0oAV/gfu8wtW8lnXnoCUWw==
X-Google-Smtp-Source: AGHT+IHkJw5A8PcSewyYDCRkDgMfU3P1H8c5aehvN8EioZ0XkEs3+oWSN6CDc45ewDHdxINqVBBJeA==
X-Received: by 2002:a17:902:7615:b0:1e4:b4f5:5cfa with SMTP id k21-20020a170902761500b001e4b4f55cfamr3282835pll.27.1714758935489;
        Fri, 03 May 2024 10:55:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001e97772524asm3526577plh.234.2024.05.03.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:55:34 -0700 (PDT)
Date: Fri, 3 May 2024 10:55:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <202405031054.9FFA75B@keescook>
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
> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Cc: stable@vger.kernel.org

I realize I've already Acked, but does this actually need to be CCed
to stable?

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
>  	state = !!state;
>  	if (ret || !write || state == prev_state)
>  		return ret;

I can pick this up; thanks!

-Kees

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

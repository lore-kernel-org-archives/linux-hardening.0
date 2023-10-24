Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618B749D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsLhEsi3"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813410D1
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 16:39:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5010281b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698190777; x=1698795577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0C3WrdgCxuejz0NFaILHBvkacIaw3n5f5P0gOFfM1Hs=;
        b=OsLhEsi3M96gvK2oeB/w7CRBJSy8o7bEcp0LqIZqEw6CC4UDzCgcqJXSUxLrFi9JMp
         dSZ8uyaZST+L4DwJ4ahuk2L6t4gDNbm5Mt5TXKS272zU2as4rbCH2BSGZyIXINtRZMQ8
         lL08T/rG++olCpz418yEJO1AFWutk+QB1n5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190777; x=1698795577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C3WrdgCxuejz0NFaILHBvkacIaw3n5f5P0gOFfM1Hs=;
        b=WwQoP2vgHhfdRHABDHLchs0qb7Wf7YCc+CrbIurbJV1fEebB+qPMc+Db0GrbW4D6fh
         1L0wJidL8UJiDyrAZFHkDnA2xTVz5OoGJ3KU2HXFuBGoieaLjhDnoXi3vW4k/WwY6YOy
         57g4FOlHcpjvAw+g9YteqlqrZ4NeDB3jU8cT7y1E7frw3Z6G486hojNI49chKLVkMlSj
         88fNK7ZrHYjqCpwF5GuV5ppkxuIb2o6wmxCUL0fM6kQcTCimUhRrNji3nbILqcL4g56o
         6ujBg5Cqly3kZHyHruQaQ01XZrMWZ2RE9IuPh8GOWj0zhRMl8tq1ZhesEYaEcql8RezN
         fBrg==
X-Gm-Message-State: AOJu0YwmStImOm5YsKePlUhxRUSH6yby+Cc2V36l/vflIHcCUIeh4YJE
	3/GhDBQJzHZBegJKxy9GV2Nflw==
X-Google-Smtp-Source: AGHT+IF5E0QJLpebVs4RdVAuB/USU/z4C1vdW4R6JPpH6owAFSc8vHSAZtHlk4IzGnWoQz4qd/1kcA==
X-Received: by 2002:aa7:8893:0:b0:6b5:a01f:f7fd with SMTP id z19-20020aa78893000000b006b5a01ff7fdmr16530335pfe.0.1698190777691;
        Tue, 24 Oct 2023 16:39:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b0068842ebfd10sm8110229pfl.160.2023.10.24.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:39:37 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:39:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <202310241629.0A4206316F@keescook>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
> the space that is remaining.
> The space for the ending NULL is also not taken into account.
> 
> in order to fix it:
>    - call decode_register() before the snprintf() calls
>    - use scnprintf() instead of snprintf() and compute, in the 'remaining'
>      variable, the space that is still available in the 'msg' buffer
>    - add a %s at the end of the format strings and append directly the
>      result of decode_register() stored in 'other'
>    - write directly at the right position in the 'msg' buffer when
>      appending some data in the for loop.
> 
> Doing so, all usages of strncat() are removed.
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is cross-compile tested only.
> Review with care.
> 
> v2: remove some other erroneous usage of strncat()
> ---
>  drivers/edac/thunderx_edac.c | 44 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index b9c5772da959..62e1e120178b 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1111,6 +1111,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>  
>  	unsigned long tail;
>  	struct ocx_com_err_ctx *ctx;
> +	size_t remaining;
>  	int lane;
>  	char *msg;
>  	char *other;
> @@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>  				ARRAY_SIZE(ocx->com_err_ctx));
>  		ctx = &ocx->com_err_ctx[tail];
>  
> -		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
> -			ocx->edac_dev->ctl_name, ctx->reg_com_int);
> -
>  		decode_register(other, OCX_OTHER_SIZE,
>  				ocx_com_errors, ctx->reg_com_int);
>  
> -		strncat(msg, other, OCX_MESSAGE_SIZE);
> +		remaining = OCX_MESSAGE_SIZE;
> +		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
> +				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
> +				       other);

As the replacements get longer, I would encourage you to use seq_buf
instead -- it does all the length math internally. For example:

	seq_buf s;

        msg = kmalloc(OCX_MESSAGE_SIZE, GFP_KERNEL);
	seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);


	seq_buf_printf(&s, "%s: OCX_COM_INT: %016llx%s",
		       ocx->edac_dev->ctl_name,
		       ctx->reg_com_int, other);

	...
  		for (lane = 0; lane < OCX_RX_LANES; lane++)
  			if (ctx->reg_com_int & BIT(lane)) {
				...

				seq_buf_printf(&s, "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx%s",
	                                       lane, ctx->reg_lane_int[lane],
	                                       lane, ctx->reg_lane_stat11[lane],
	                                       other);
		}

	...
	seq_buf_terminate(&s);


etc...

Though I think the seq_buf API could use some improvement: it should
always maintainer a %NUL-terminated string so the final
seq_buf_terminate() isn't needed...

-- 
Kees Cook

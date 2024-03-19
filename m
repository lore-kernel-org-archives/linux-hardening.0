Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3363FE2A
	for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884689; cv=none; b=uwZrf4coRNsMqIsF7uLxuJNCcSejgwphr30yNQyKnmUV6rfcfwtMq87YKq65TahWFEU8th6GDTwKxDTEFvbBqs5gltb6sIBw4yM1wDJ0mqNhym4LB/tfWifsfziiMcxxO+eflhIUnjmzUmRs1V5nXknyUlDN82JkOl1fN2A3wwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884689; c=relaxed/simple;
	bh=eBhcJkjdIZMXWCWXz9E2KeEXBdZhRhMUhqzS5PYUx28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzrTy3rjnnDwdYC4k1divh7zXN2LpXdMyJfImVCLGMQx9rt42NA3g1M0wmsRCikuv2dA14yL4CJ50yL+OecgNTyr9b1Xe1okN1quQhjFr4K2BbjEP9Brj9xEo9dfDt8+Ew4k5fLrS/QEhrCYY15+sEPJBBfno5mbMufld0z+Gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YzKnAYJy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzKnAYJy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0411c0a52so12698365ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710884687; x=1711489487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4jDMTaEh9Tmc/RAOO1DLFWKOQOj35T+6qA1lIMjBb0=;
        b=YzKnAYJyPyVU1ZCnmtblJF0iSVjoOegMvXZv5uJdE5tGlCUpSq9fSosZODrT0BrFtA
         BNJyDJ3ZRFeM7tOEc8yYO9Ri3BmzEOG24FlyszeEf52QJnOnY0yV9p+ufjFkeyCLckHT
         R5mETtg1wGOQD2d1RoqrZRjoabeT5gxDbM5wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884687; x=1711489487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4jDMTaEh9Tmc/RAOO1DLFWKOQOj35T+6qA1lIMjBb0=;
        b=nR4AhGLz0qc3E7NwjApuIFG5CNb1U6gDkhushDvKuQUii8pWPVaLfs+rTuzpnPDRQ6
         hPRNR+vScDY6ceOGOOOyfOCZH7O/v4VewPkD0MDgbeipEpEw6qMOo2UugmLjNmiu4oxG
         LPLOP+fp6DhN6bZfm414s3nFqlyMyjTZmOheMI2xAYrGS8EDw9XNhOT0/NFe+wIs2tll
         bNv9c6PwcPYfyzIKQmCUIT8N31YsXtQQoiRAIrmAmLHutoERw0jCekbTTbvMhfHuez0x
         MnB5hVsoCisdsTGtKG9Uj6IAvHMtMqoRpX6T/bHvu20UHLmqYy37Dy9Ojhz6lCa74TdV
         Gu5w==
X-Forwarded-Encrypted: i=1; AJvYcCWjMFf0bUqufyVzulcLJeDhvwk//yL1W1mm55GEJrl0MLLzYAQBi4RfimmKGbGOnVajtdTkrkZt8bZqVMKgcH6BnDOTmIxa8bcHHwYYH5RI
X-Gm-Message-State: AOJu0YzJnMuyljZNyoTqWfSuSPXqW9nuM/lLua2j/YjK+SGyXKlkOjKC
	xWcRY386t8V9CVqf6TVkhEWZ/69Ffq7xZi00YU6BdEYtaIIsXwjE0aXS1VIkog==
X-Google-Smtp-Source: AGHT+IE5OC8LzVRzLn5nTU5QYo7UeQmmxs9m35kXMJwGMfexxRccoDwLT4tRF8BNtoPmHD0tgyYoGg==
X-Received: by 2002:a17:902:d549:b0:1e0:4aac:e543 with SMTP id z9-20020a170902d54900b001e04aace543mr2800312plf.38.1710884686935;
        Tue, 19 Mar 2024 14:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm11873034plo.67.2024.03.19.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:44:46 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:44:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
Message-ID: <202403191443.0E396FCA@keescook>
References: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>

On Mon, Mar 18, 2024 at 11:02:12PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect nc->if_name to be NUL-terminated based on existing manual
> NUL-byte assignments and checks:
> |	nc.if_name[IFNAMSIZ-1] = '\0';
> ...
> | 	if (nc->if_name[0] != '\0')
> 
> Let's use the new 2-argument strscpy() since it guarantees
> NUL-termination on the destination buffer while correctly using the
> destination buffers size to bound the operation.

We may need for -rc1 (or -rc2), depending on when subsystem tree re-open
for landing patches to use the 2-arg versio, but, regardless, it looks
right:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 4036566febcb..f5b0d91d32a7 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -4010,7 +4010,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
>  	mux_net = netdev_priv(net);
>  	mux_net->dlci = dlci;
>  	kref_init(&mux_net->ref);
> -	strncpy(nc->if_name, net->name, IFNAMSIZ); /* return net name */
> +	strscpy(nc->if_name, net->name); /* return net name */
>  
>  	/* reconfigure dlci for network */
>  	dlci->prev_adaption = dlci->adaption;
> 
> ---
> base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
> change-id: 20240318-strncpy-drivers-tty-n_gsm-c-ab1336e0e196
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

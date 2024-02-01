Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0567429F
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811233; cv=none; b=q18b9VJJzupdTcHa9xP/oR0BqpAtWSmJNPv8nRUmCT1Kjg0wTE06DlPtFUP6rxM5A4eWEDq4hdYg/qdzztyo3O9Oxlkq3QkhyXzTymMF+nUyio1eAAf6hIpV+rn9Y8kyr8wgjibVPHOYVhSLwmh0vWlrHPQE6Yl1exVUKhr0Egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811233; c=relaxed/simple;
	bh=Ox3x6CM4QaMOogPqQbDoJ0aLd5BdtewXWzn+0/j21mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im/HS1iOwTazRr4HfUOD91wDwAbzAOKNBymfoHU6afZgdqdulFapTl9BLFsDBngTRgH7nc3tq9TWrt35UKkB0/JBqhL3fm2n73ig9nYlQRDaFhxxjOnfXouv/UP74f1AimnErqBZV7kftW3wJ6y+NfgS2CDVXWNGiostvq2jY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHz6aR/S; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHz6aR/S"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d918008b99so9918535ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706811231; x=1707416031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whpiy4k9kzDyAtD9CAv6xmw0z4bIwWOa1seDBlUYFpU=;
        b=lHz6aR/S36nsOSo0GV2LXZFCjo7citnng2cwMqvKs73lmJDmxE0vhW/aKLp87d/bfY
         48O1/AlKSv+IBG3Wu/go6HfNOJh+m0MWTYKOFntpmi+1YAdLxTn9+dOwm3WGEyYlzz27
         TwYPWPpROLpXcxNWGbygk3ExFkD8NBrJd0SGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811231; x=1707416031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whpiy4k9kzDyAtD9CAv6xmw0z4bIwWOa1seDBlUYFpU=;
        b=E4fRr8IBIrlehvNO8meC5GByxUTWNwCVbF5VSjKHLmnsSHMVl773C/g7jrry4+0ehf
         RDWj0ufQ9CZJ9kzFaSARLWJpSM9rQJQV5OzGAFF+xDY93MVQSHsw44Rb7B7EdDQVSI80
         lupIQe0pQeRb9hLF/f4/Nnh95iZnOnONM1xOdnYWoe3cwac1up7uyJGsqwgb3uQIsSoM
         f2WHNAtP0jGdxX1oyQcta6cPAaNigheY2+rLMhVnXy8O0mL42wubpyvPqdBoImogLcqt
         QMPX8fuqpOAtTan7hI9uul9VhPs0Ne6jml9V4OfaD9Gtqm32DN9uAjtvEKeKie9n0Xgd
         Xo+Q==
X-Gm-Message-State: AOJu0YzxCSlLUQ+MdbzeahDpZeLJtUoX/jx+V6kIKnU0UYD5NSMI/C0s
	fNzJDExitZqJkQeL0OdmTLf0bgOk0d9J2g67MjGUPPRYb9xDh8GRF/Ku1IW/BA==
X-Google-Smtp-Source: AGHT+IGcFHfFmeD2zA/IkjGFZMNil+oXI/XIFBFGtew37zOyMGshizeQoH1iCfi05UKspVXNhNb87Q==
X-Received: by 2002:a17:902:c405:b0:1d7:553d:4e8 with SMTP id k5-20020a170902c40500b001d7553d04e8mr6645733plk.21.1706811231292;
        Thu, 01 Feb 2024 10:13:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUihJdpBhCpDmy0nLeFewQGjPbYt8pvfq0hXgJBnFdeMVxIUYlIJrEXSXrdJp8qLmEPyIgKGAL4cndmLOk/+TrWBc3uS65qSHWpvp5NLQHzPysCPiKnUZ1ArlC3adxWfNt2fwuPTWHOcit1PrwyJU6G2Md4cK85XffR43sNwsm4p7yHKZwIQSkD290LIRQZt1Fv/ot9QBqJr0YkHe2aKpv3Y6UdBOG+1pPWZOY=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id li7-20020a170903294700b001d71729ec9csm102007plb.188.2024.02.01.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:13:50 -0800 (PST)
Date: Thu, 1 Feb 2024 10:13:50 -0800
From: Kees Cook <keescook@chromium.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] pstore/ram_core: Improve exception handling in
 persistent_ram_new()
Message-ID: <202402011013.025B9EDDC@keescook>
References: <14171fc4-8157-4919-86b8-bdec0493197d@web.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14171fc4-8157-4919-86b8-bdec0493197d@web.de>

On Thu, Jan 18, 2024 at 03:06:53PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 18 Jan 2024 14:57:21 +0100
> 
> * Omit an initialisation (for the variable “ret”)
>   which became unnecessary with this refactoring
>   because a memory allocation failure will be directly indicated
>   by a corresponding return statement in an if branch.
> 
> * Move a call of the function “kstrdup” before two other statements.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for you patch!

I've decided not to apply it because I prefer having a single exit path
for error handling, and it works as-is already.

-Kees

> ---
>  fs/pstore/ram_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index f1848cdd6d34..5047a8502e17 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -586,21 +586,23 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
>  			unsigned int memtype, u32 flags, char *label)
>  {
>  	struct persistent_ram_zone *prz;
> -	int ret = -ENOMEM;
> +	int ret;
> 
>  	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
>  	if (!prz) {
>  		pr_err("failed to allocate persistent ram zone\n");
> -		goto err;
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	prz->label = kstrdup(label, GFP_KERNEL);
> +	if (!prz->label) {
> +		kfree(prz);
> +		return ERR_PTR(-ENOMEM);
>  	}
> 
>  	/* Initialize general buffer state. */
>  	raw_spin_lock_init(&prz->buffer_lock);
>  	prz->flags = flags;
> -	prz->label = kstrdup(label, GFP_KERNEL);
> -	if (!prz->label)
> -		goto err;
> -
>  	ret = persistent_ram_buffer_map(start, size, prz, memtype);
>  	if (ret)
>  		goto err;
> --
> 2.43.0
> 

-- 
Kees Cook

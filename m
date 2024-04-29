Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC8839FD
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412286; cv=none; b=qem2WB3F+oy2P5NcBbgilC2rrjqUpuhcvVNBllHgxfwvYGRz3hkelPoZtbdzCxPMyap1c15YBkHuHMO3V6zNBTo2aRzvdP58jQjy5kymDVKVCZD9Vdc3z3h+U1+tlYUc2E3op2QPyd0SWGqNJ8CkN/BX1e/VCA3XHevxwJzdoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412286; c=relaxed/simple;
	bh=jZICQhTLjVbGoXbLAw7fdChRrXlYrhHBQwoN7fp00Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7UWbmuqF0ATVPCseEadLvfcviiRflAyHgZey+WJCTfj3okT8sb9vS44o93uxpLTg003+QeGMZo+7/Bt71FsabzUxt4DKQt36EejblBtE7LMbWICARZBziFFbxz1b2epOffa6CEHif5V/iLSrNIm8dVHnW+eFT/4OrfFz3iXAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZJjv8nB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZJjv8nB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso4081384b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412284; x=1715017084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZdX1Cezd33gwlmLv7IZxW/osMfveXEryHL7Jm8dSrs=;
        b=LZJjv8nB5yK2CbMViEHtZlILSokwuxq5OdVsDEK8ye/foQuZHZ5xotoB14MNNuXQKM
         umCJ1skdtCJntlrWnIwTdfb4nX3rgP4xYAE/sWi6Vdh452Oe4B83qKKnL+gQlgCqP7dY
         N+lh+2mMEkBwUHJVbkKRD5zVshbS9L/1DViIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412284; x=1715017084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZdX1Cezd33gwlmLv7IZxW/osMfveXEryHL7Jm8dSrs=;
        b=gGsreK2+4aa5J2IWBOvfx0ENrrloAJ6+vc0qBy6l3V3dCkOHkUteN4vhv94JEi0855
         qhOXe0gPlLgXEXzTC52mQrEB52Ww+iw0Ey/zYs9kmxov6TubiKC1EbkgtGq0unURSOd3
         qCR2pkCk8WQWPVynvCGeNgSnr3NIRWQgc++0mnBsRalJqU9Ikr3Dhz0grdoVwGGa8w1U
         fulL1vCFjNfCz21OBRTkwu8tUOxTHtKvpl3Eqy3vSqhNGqkQCbuTRzrnbUCR1uSPaete
         tbJ1Xq/4sPHFFtGNCoTdRf3MOsI3P+Q+qn8OrFM+dTLHS7Jf0B+gHFLNM1H2smH5+Cxn
         V+9w==
X-Forwarded-Encrypted: i=1; AJvYcCWXrWchhXJa3bqgjhS7bNZhI1DA5pqXybzRVszCSVeMj8LrY7QQ8UdKtnBh/If8/gAg/cryOJ1lVH+R6BEEYEzRQy2Rcem7WWmZtck56lmc
X-Gm-Message-State: AOJu0YwMQsW5Lnor0xZfra6O3v+m27mVYLSFZKCP6hFjUOD94BgeNpOL
	OAMRJlwSvo6B3H06666Hq7tEaNqwyLg/0BDhMvW9Dr2n7GGrIIcIjYCkLJiyzA==
X-Google-Smtp-Source: AGHT+IG0Ug+Y9/YgxIBXiIws/D83aLQ8EE2Y9SjkanMbBtQN9P+XFAK2SptutXGuaucRfTEMzA8PzA==
X-Received: by 2002:a05:6a00:850:b0:6f3:8479:290a with SMTP id q16-20020a056a00085000b006f38479290amr246404pfk.17.1714412284263;
        Mon, 29 Apr 2024 10:38:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le7-20020a056a004fc700b006e567c81d14sm19497081pfb.43.2024.04.29.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:38:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:38:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: ff-core - prefer struct_size over open coded
 arithmetic
Message-ID: <202404291037.1A42B7C6B@keescook>
References: <AS8PR02MB72371E646714BAE2E51A6A378B152@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72371E646714BAE2E51A6A378B152@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Apr 27, 2024 at 05:05:56PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "ff" variable is a pointer to "struct ff_device" and this
> structure ends in a flexible array:
> 
> struct ff_device {
> 	[...]
> 	struct file *effect_owners[] __counted_by(max_effects);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() function.
> 
> The struct_size() helper returns SIZE_MAX on overflow. So, refactor
> the comparison to take advantage of this.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  drivers/input/ff-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 16231fe080b0..609a5f01761b 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -9,8 +9,10 @@
>  /* #define DEBUG */
>  
>  #include <linux/input.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/overflow.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  
> @@ -315,9 +317,8 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
>  		return -EINVAL;
>  	}
>  
> -	ff_dev_size = sizeof(struct ff_device) +
> -				max_effects * sizeof(struct file *);
> -	if (ff_dev_size < max_effects) /* overflow */
> +	ff_dev_size = struct_size(ff, effect_owners, max_effects);
> +	if (ff_dev_size == SIZE_MAX) /* overflow */
>  		return -EINVAL;
>  
>  	ff = kzalloc(ff_dev_size, GFP_KERNEL);
> -- 
> 2.25.1
> 

Yup, thanks. This looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

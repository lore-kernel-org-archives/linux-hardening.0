Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508792;
	b=K/hdKb/Q1f95styyflwnq3tplXLvtU57VHHQF0Otw6BedNVfA0u38YSo5vwcotZdLdlI
	 GE+Pn2YWJKTuTE+G2bs9L2Ds5d/X6dsLHhf1lCTVYhUDv0JBkYDHhsNaUoiUZBwJDVcJJ
	 YKuN02agXvTEV/20DwR5Is8qVn/xvIiF1TVP9tnx22gTzRJ2qnHjMU14Tc4fXEVrbWibC
	 fhd6/YHI8OWciMLG/LWL7psjOSJG8Ut+KF6uN65kSKdNnuEROUXNSMHHU5v4AF8B/9Eq6
	 QzsqYiEL8gBYsl5yej5CsT4/QYBTjfGe4atIGguGaLDcZ3QtlmE3bXCV2uuUdjwfp1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508792;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7IpB5wJW74xYwGanhmC7DHQajEzsrcbC4df9jW6z3C8=;
	b=sjoiBgLQMTxAJcZGflTaoc3KDcsxl/TVocVm/ulR1HB9y+IFXAKnAJwpqB+/Gs/cBfKF
	 H7dbO/KLJugdFYOrcs3k+bUFTjt2azqpd4BC4KAmYJ34ygyOh+E8dunEt2Xrk4bY5PZuH
	 aCP6LGLnXtbVSHthtPoQhhNqeNlspbriqF92UT0Yp45Vq1KgYa4BzWZj0d2dtLFs8d7Gk
	 gvSVJiEU6I4Fh5ilK2wlcrpTFw6KIOavl+BymMkkwNGKP4gyRFiAxL3C+xJrUs9KX+JhR
	 cxQE//1bK3nyXogM6ohqw5tQuguvdzlKgBzhAAWTjx63d4RPV3N+OmTUG4HtK/x/8fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZME8eefb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA122606A889;
	Thu, 12 Nov 2026 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZME8eefb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B51F000CA;
	Thu, 12 Nov 2026 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508792;
	bh=7IpB5wJW74xYwGanhmC7DHQajEzsrcbC4df9jW6z3C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZME8eefbYjJSAdhqvvEOGHQCDYSepUI/4At4ClK7DqOdbWzlskQ+Zaflf22UNPbMV
	 UzXLHAXZgUW4PSSmk90d+x3d0rMQ5Jn12oQbg/i8X7HYh9r6m4efZVDn0VwTvk4uu8
	 eGt7n4Y/p7N/64m7FHt//t1vug0UF4/qobL/vNiw9oqPCM166k3rlF81vV2k7m0Gou
	 Szkfh+A/Or/flwLqATZaephn7a9zfUUbrM1vXgKWZhcm3rFdd3WQ32aUkSdRFWTR5h
	 WOglvIAPLpfhQULwD8wknoT4+j9kEwB1Vj02WfracMFr42W2Ohg9IqzXwz3tAJNK8U
	 F2xZrXNWt6Hzg==
Date: Thu, 12 Nov 2026 10:39:52 -0800
From: Kees Cook <kees@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	morbo@google.com, justinstitt@google.com,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] comedi: comedi_bond: Refactor strlcat() to seq_buf in
 do_dev_config()
Message-ID: <202611121039.836B308B1@keescook>
References: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>

On Sat, Sep 26, 2026 at 11:00:00PM -0700, Mariia Nikitash wrote:
> From: Bill Wendling <morbo@google.com>
> 
> do_dev_config() builds a space-separated list of bonded devices in
> devpriv->name by formatting each "minor:subdev " pair into a temporary
> stack buffer with snprintf() and appending it with strlcat() in a loop.
> 
> In preparation for removing the deprecated strlcat() API[1], use struct
> seq_buf and seq_buf_printf() to format each entry directly into
> devpriv->name. This avoids repeated rescanning of devpriv->name and
> eliminates the temporary buffer.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>  drivers/comedi/drivers/comedi_bond.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
> index 8e10ecab4f0d..a10cfbd04c72 100644
> --- a/drivers/comedi/drivers/comedi_bond.c
> +++ b/drivers/comedi/drivers/comedi_bond.c
> @@ -39,6 +39,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/string.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <linux/comedi.h>
>  #include <linux/comedi/comedilib.h>
> @@ -170,10 +171,11 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>  {
>  	struct comedi_bond_private *devpriv = dev->private;
>  	DECLARE_BITMAP(devs_opened, COMEDI_NUM_BOARD_MINORS);
> +	struct seq_buf s;
>  	int i;
>  
>  	memset(&devs_opened, 0, sizeof(devs_opened));
> -	devpriv->name[0] = 0;
> +	seq_buf_init(&s, devpriv->name, sizeof(devpriv->name));
>  	/*
>  	 * Loop through all comedi devices specified on the command-line,
>  	 * building our device list.
> @@ -250,15 +252,9 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>  			}
>  			devpriv->devs = devs;
>  			devpriv->devs[devpriv->ndevs++] = bdev;
> -			{
> -				/* Append dev:subdev to devpriv->name */
> -				char buf[20];
> -
> -				snprintf(buf, sizeof(buf), "%u:%u ",
> -					 bdev->minor, bdev->subdev);
> -				strlcat(devpriv->name, buf,
> -					sizeof(devpriv->name));
> -			}
> +
> +			/* Append dev:subdev to devpriv->name */
> +			seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->subdev);
>  		}
>  	}
>  
> @@ -267,6 +263,8 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>  		return -EINVAL;
>  	}
>  
> +	seq_buf_str(&s);

If this hasn't been applied yet, a v2 with the above changed to the
now-available seq_buf_terminate() would be nice to have. Either way:

Reviewed-by: Kees Cook <kees@kernel.org>


> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Kees Cook

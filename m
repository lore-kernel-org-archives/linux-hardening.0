Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF3224B15
	for <linux-hardening@vger.kernel.org>; Thu,  1 May 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746127037; cv=none; b=skMMHzdC3lK1MtWyf1G8pjb+YJCtJhq57vViQnoiNM/4NIql+msOWgchmezqMFkOpTg3PgB5+EcSmf4+/4aHWJTqcb0DzCSqtEHk1Wkft6/gnDh+YoxQ7k5YBePOjiq8AFf0X7i9t03fwqDb6aayiBxR7AiZvWNXMZOzjpNoixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746127037; c=relaxed/simple;
	bh=ypae/SV9VD918sATjJkk7w77bRm2u1pK6oZfpp1bsHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTL84bY788ZN7RkenWmSP5iqbgXSWR/EqSXgXr8Ab+0AzaRtbPaPjlnwh7AZFVMLF9MqskTcDoqAREeZ/wQymHpXXV+IoqidI1yI71ZxLw527ELPTCMMLNRHLYCYXmOgKoFX4cU1i509NxBFmf70H6wjMtu9KEPaJO4uywHh3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZXAqDCfq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZXAqDCfq"
Date: Thu, 1 May 2025 15:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746127019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIoAstH486gFOTvCeAwrB7etwoImokcAgUtVm6ICfHE=;
	b=ZXAqDCfqAbIF6vb4CYrbOwl8D9NQ3JBruRAMzdUK9smKm2gLXI3ROQfQwRP4fswbu4eOXx
	3c3XAi8R7NXgC1LJWFVNITuNbwf+Kk0/eYIHyrCyfZX5KZYyeCwoIU0rCAgmNAqSxLJots
	F7X8XYLpoO7CwcRGmajv8LkEs2idI84=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Alan Huang <mmpgouride@gmail.com>
Cc: kees@kernel.org, gustavoars@kernel.org, thorsten.blum@toblux.com, 
	linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Revert "bcachefs: Annotate struct bch_xattr with
 __counted_by()"
Message-ID: <wsymhks7o6zbsjvac7bmi6vhjkk56ovp2vclrla64sqcquda2x@ikfk7tt76gec>
References: <20250501184150.200319-1-mmpgouride@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501184150.200319-1-mmpgouride@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 02:41:50AM +0800, Alan Huang wrote:
> This reverts commit 86e92eeeb23741a072fe7532db663250ff2e726a.
> 
> After the x_name, there is a value. According to the disscussion[1],
> __counted_by assumes that the flexible array member contains exactly
> the amount of elements that are specified. Now there are users came across
> buffer overflow caused by the __counted_by here[2], so revert that.
> 
> [1] https://lore.kernel.org/lkml/Zv8VDKWN1GzLRT-_@archlinux/T/#m0ce9541c5070146320efd4f928cc1ff8de69e9b2
> [2] https://privatebin.net/?a0d4e97d590d71e1#9bLmp2Kb5NU6X6cZEucchDcu88HzUQwHUah8okKPReEt
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  fs/bcachefs/xattr_format.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/xattr_format.h b/fs/bcachefs/xattr_format.h
> index c7916011ef34..e9f810539552 100644
> --- a/fs/bcachefs/xattr_format.h
> +++ b/fs/bcachefs/xattr_format.h
> @@ -13,7 +13,7 @@ struct bch_xattr {
>  	__u8			x_type;
>  	__u8			x_name_len;
>  	__le16			x_val_len;
> -	__u8			x_name[] __counted_by(x_name_len);
> +	__u8			x_name[];

this needs a comment, so we don't make the same mistake again

>  } __packed __aligned(8);
>  
>  #endif /* _BCACHEFS_XATTR_FORMAT_H */
> -- 
> 2.48.1
> 

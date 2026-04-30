Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3642EEA6
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560220; cv=none; b=hFGsEM1LEHMG9wRJ8RvELY87+Imo9qZNmVpW0O2ediZVFGa9gdc/POfBEh1v9+CK6N4HALUIxFvvrMfaTGtu4+lmA59im/fgcCW1wXAPwDf+ZLEjV5gtu0qQn1fS+uwcmv5Pww6Mle20LagzCr42hePNtGjdfomrPxO6iGb/sj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560220; c=relaxed/simple;
	bh=2hEdTqpc7hM//a6t/1E/VIS6o43CeUZQ8Xb2xsiZ5dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBT533q+eh1M8SUPdwWE6kwKbupknd5gYMRvkPtcZDbOGP056PsfG6o04/zHHlG+LuMJb/pZgdqHTJJw4tKF9RGoF0E4HIuuFKqhSfEvo4b1FQbf7OXqOZgNhUpLAZs8wAjnb6geDFO40aj36ryIiXxDdAiGrDPU9Sh3F40Owvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bmZXv834; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bmZXv834"
Date: Thu, 30 Apr 2026 16:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777560206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1xjE5n+aceb0Om87z1eG3qTDVMwrgIjpvQe0/EKiT0=;
	b=bmZXv834K0+3WUI6of7K+SfXlVYMAC5hi96Qyr0mfSlPQRpK/3Xj3VR32hgXLaPE3uzR6B
	u7Ljsgn10mlLDFsP+INr68A5NDhJHvctYTRPRWXuPtxGF6bpQxMWKAqZCBE0fj+pXTIWxc
	gXYGc4dpLswk3HScfKi0jcfMZ6amaCw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add kernel hardening keyword
 __counted_by_ptr
Message-ID: <afNqiA087kjdT5zE@linux.dev>
References: <20260414130926.312094-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414130926.312094-3-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 14, 2026 at 03:09:28PM +0200, Thorsten Blum wrote:
> In addition to __counted_by, __counted_by_le, and __counted_by_be, also
> match the keyword __counted_by_ptr.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1126fdd639ad..969460c85ad6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13889,7 +13889,7 @@ F:	scripts/Makefile.randstruct
>  F:	security/Kconfig.hardening
>  K:	\b(add|choose)_random_kstack_offset\b
>  K:	\b__check_(object_size|heap_object)\b
> -K:	\b__counted_by(_le|_be)?\b
> +K:	\b__counted_by(_le|_be|_ptr)?\b
>  
>  KERNEL JANITORS
>  L:	kernel-janitors@vger.kernel.org

Could you give this another look so that __counted_by_ptr() patches are
also sent to linux-hardening@vger.kernel.org?

Thanks,
Thorsten

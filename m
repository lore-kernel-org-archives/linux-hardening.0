Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB91BD9C9;
	Wed, 25 Feb 2026 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771991961; cv=none; b=kcr6iT3lOqGb4Ozq+dFhkAkt2H3YqdJ2zrFlaWK1/xOVG8E/CTCHfbxPk/LMzfEfYrmfmmiYOd2t446WweBE/479k27cHqj2kNFTh0LxdroAy/VW88hjlOgBHSn+4J7avvnlmHo/7DjNCdJ9i8dysvNwOOZT8lHMqLrNG5Gk0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771991961; c=relaxed/simple;
	bh=ctn1ALFjXCD3NoEeOc3CyvrNoJqY0deHLtCqf5aAKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aejip0XHlGGAOsEeHFU81r+oWcdOzGQX+kLzT6EdsJQfNejK/6aoGxA1Mnia8yefzZTVYdpGTQO22PWULLg27CD7903k1iCSz107b+Fx2MSbE1kARTX3MN7Bg2qZqYx4zyko82RlcJO+5/wjYf35VVJu1cGOzdUq7yuBeewLluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SK/eImto; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SK/eImto"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u91RniVAY4w/S1lsK0JgZKyctLf5bLCFqmMYO9i/oc4=; b=SK/eImtoTmraU1RBu0e5YrZH5k
	Ma/Bo/nGJwG1rFxceN99IbmTc52Uia0MKxFRpVAAOTeC1HSWZLlMyn0vV/IfuKaOwPU11zw0Q647R
	5OWrjaB5WKdTumkyMeJdCxQdKCIufSePHgi3fcEVXR7wSzMpnOUzbWCuIChAKGLaawfwTBhKuquUZ
	GTfaO1FkwTMYVOKJZcgBY74IKibc+xO58VuUAoK0R2EIysoZS1ZPIzQYd27mOV8uJ2bKCdk6eEj0D
	HxseRazeb6LWtfEUFLBaOMdXFyOrdtyxkj3uumh+ZJ7O4SjF9FWynkAddoxnicZLVIgS04hhkPZqu
	agytE2gw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv63I-00000000OwB-1kXC;
	Wed, 25 Feb 2026 03:59:08 +0000
Date: Wed, 25 Feb 2026 03:59:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Saturate to SIZE_MAX for allocation size overflows
Message-ID: <aZ5zjIpYZYoc-LSX@casper.infradead.org>
References: <20260225013954.work.319-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225013954.work.319-kees@kernel.org>

On Tue, Feb 24, 2026 at 05:40:02PM -0800, Kees Cook wrote:
> +++ b/include/linux/slab.h
> @@ -1105,7 +1105,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
>  	size_t bytes;
>  
>  	if (unlikely(check_mul_overflow(n, size, &bytes)))
> -		return NULL;
> +		bytes = SIZE_MAX;
>  	return kmalloc_noprof(bytes, flags);

Wouldn't this be better written as:

	return kmalloc_noprof(size_mul(n, size), flags);

(etc)


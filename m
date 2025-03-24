Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA625D1E1;
	Mon, 24 Mar 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834932; cv=none; b=KZ1MA7gz9u8B5a+XUzSKZTEBFPS3Go7ld7jff7uyq82I+0+d1C8S+juLWw7KA5kJ+KHiCatyJKiNorKQBPnYqcgeWrt5i+1lBWUc6BHTki+lsS43Iy0f9GIFtr0H7oQCssMocZ1Cf6ayVBCBbGcf0w9dktXDIsVUsci+27QARHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834932; c=relaxed/simple;
	bh=sayeoWKFFq1gCersPRDqm3tR8WeC5c4VRp8l8D2eJ7Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nuoFwJhiG6SbZKLP+Zu60dsfUfuS2CB9U9MDLszYVsYXt2UyX7c5wX5h7nqAq4u5YcVQvOkTCKg7ZGmKQ31HDmYzCfI0g58PDGX4+yFW3VmA9ytRU/cR+Am19pJ6LnzB2j4HQJQHfzFlj1B9qtAN2UMymo9VYVdTDz1YCZVQ+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=PuNW8IJM; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="PuNW8IJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1742833007;
	bh=sayeoWKFFq1gCersPRDqm3tR8WeC5c4VRp8l8D2eJ7Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PuNW8IJMRMPqmJoHY28KOKknba33zkvjaGV+/sa/zYLs7an3WLSXSqyZYOc+PbYaq
	 bMg+fwipm3EQ7e7HD453pzc4EAU1x96demCTo+8BnZewB/GkMqnxGfxFwIr96MI+8M
	 PPQq2Ypi0ufeYnFdWPm+TG7hE+HMqv2KVTvIDvNE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 61C6A4027F; Mon, 24 Mar 2025 09:16:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 5F45E401C4;
	Mon, 24 Mar 2025 09:16:47 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:16:47 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Kees Cook <kees@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] [DEBUG] slab: Report number of NULLings
In-Reply-To: <20250321204105.1898507-5-kees@kernel.org>
Message-ID: <e3437446-798d-f4f3-11d7-675f8886575b@gentwo.org>
References: <20250321202620.work.175-kees@kernel.org> <20250321204105.1898507-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Mar 2025, Kees Cook wrote:

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 2717ad238fa2..a4740c8b6ccb 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -469,6 +469,8 @@ void __kfree(const void *objp);
>  void __kfree_sensitive(const void *objp);
>  size_t __ksize(const void *objp);
>
> +extern atomic_t count_nulled;

That is a scalability issue. Use a vmstat counter instead?


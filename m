Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234405579D
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783516; cv=none; b=iLrtgUDJxTbobNbKc2qzdSUOXgQ7AJKu3smEqaSk5ziw2iLs1qimaJ6Z0FilNdMpF2jYZZAxdLUWh+6Wfb4/ZL4f60d65DAiUkkalJvHvBR2G2UahsOL9jia3ri9TF/pV0TjZMStKo9+1PNXZ6yyMo3MFXMH4n6jBwiHd1W3+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783516; c=relaxed/simple;
	bh=R76I21nWlclOcet2e0P90I1PHkxwCPo5keHk8owejo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLRyzdvIMuUO0yVQOL8I1hX9vnicNA7LqEeYdHUzfDQ9zi2jUlZEjD1MPJO0xCt7fSyzgOxQ6IeIdV7hpUtneqitYKYxndEJtqEXF/D2l7RuyM0Yz/++eIP2WGkw9I69PYGBOi++jt12OKbuBG2Ov2o1Sn+2NGWZa9GIwmJ3hjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UuKaQd/k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuKaQd/k"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e036b76725so5658615ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710783514; x=1711388314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=UuKaQd/kdUfqjFpdzStNEI14LWD6cUu+mlPELBj0uTovOm248wSiuF8z29fsIttms0
         3jK7x5fmUURJ7wCOknt21/mkCZ3wHtLtpde78PS6cjxFx9yKGXU42LOE2stFLBTd5i40
         iOetnjbZ81AcABVxnKR1StvGJXG2rQv3ZZRVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783514; x=1711388314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=texmG0Gw1zeNIT3HK3A5521t3H/aX3K5C6j7gLeepPE=;
        b=ZCb3gaBQJTrd4kabtxjVN2v8TTgcr1uSricIGyifsD4vMdel+NO1zkngErIQfA8T4B
         TKxp7Q0HFw0u8wzq2FKC0j63IJeJ+lnflheBNQfbFc5DIeBESD0JaMX5V+IgPgx72o+C
         9OYggHV8tCuirqHKuHFvfKXpnxDXWgttWvDyWyJB0Tal6NpHgWuKVXTqbfxW33/b5bmT
         fTzz2mB3bTM38yw5v3eiWoI3ZCj9rGMmqeYNKsIhdNMaigi3hLu6gWLgQxDJ8E7YK9c0
         rY99pjxsXhD0seWImJ1679I9xtwYn5LEGi+ugX2Dp8Q9R4xIU/YjdsxsShb3EoN2ysX4
         egRA==
X-Gm-Message-State: AOJu0YwoVuqcYa9oeZsf7InLYHu/0D/w7wKkCT9wG/vVHB9qPIVgyiPt
	TUekSKS9D2jrHZh71lxxESJdg1RsU1yz6xgC9K2KZdXDdsCU8QYGY4AdFdCGsg==
X-Google-Smtp-Source: AGHT+IFwifvFDojSxhKBkKKqy3uuDnQSOhhO6SnmFZueyTL3hVRvKoeX4hiPXzD3uMyruoUadtwycA==
X-Received: by 2002:a17:902:e841:b0:1de:e9b5:bb54 with SMTP id t1-20020a170902e84100b001dee9b5bb54mr478461plg.34.1710783514163;
        Mon, 18 Mar 2024 10:38:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm9500656plo.67.2024.03.18.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:38:33 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:38:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Message-ID: <202403181037.C66CB5ABE@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
> Some structures contain flexible arrays at the end and the counter for
> them, but the counter has explicit Endianness and thus __counted_by()
> can't be used directly.
> 
> To increase test coverage for potential problems without breaking
> anything, introduce __counted_by_{le,be} defined depending on platform's
> Endianness to either __counted_by() when applicable or noop otherwise.
> The first user will be virtchnl2.h from idpf just as example with 9 flex
> structures having Little Endian counters.

Yeah, okay, that makes good sense. It'll give us as much coverage as we
can get until the compilers gain "expression" support for the
'counted_by' attribute.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

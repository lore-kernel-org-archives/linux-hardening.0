Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592442;
	b=04YG7zGf7PPsb3GujrR237tGBdGr4TVfoJLRlttOCQZ1aeJ8IYzgiT3P19jBbDN1qddL
	 FrhGUcnEAvyQTgwuUzwFd+6fbUbNiDowkblmsrIWKFoafbxgpH1qVZmgola5xmUFyd5+j
	 6d/xO81Rbmfa1ekZZqh430TkF/Lh14G9QmOzcmgdQYBpErD4UPsVbVMvuONPlusQe/IGD
	 viq2ffItj3Af34En/3uyKePMABmVyaOaZ5sOzcyIVYRxmwaOE6ZjJtqW9WnSRRrr8KaXE
	 9ZrwEzOahBz6OtMWA0F2S6PCG1PVmXXbyl+jCKaLMtI5HuSdbSalVilF+iqCM0Ayl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YOhDE1A1NoWSc3HJwwDv7rAFd3isHMa6WzPG0AjLim4=;
	b=VioUoMU3fxSY+rwEvK/ruj+Q6ZBy+/rwOBw8Qpl71LHIt1VNj+Fom3BXIrWoFsbcxSmY
	 RxqwvSTPphrDe9+eCyPWOC7pfo9/KnIyaQpTwzocGKUE8mWLUw380bDKPfbYr3Xu/9TyR
	 w4EIsiFfZQpW9U6qB/vympqYErMqGle5u7nE5xmHJNuPMSSj8OW3tfoFCwGqfsljIn/Wg
	 1gw7PzKph91wVBUeGy0yIpyGMsGuQHN5JpmYcWsEFo7tIh0cLbrI//yagkfitE7itXnDb
	 vr7DLlJQLm9QEepmUmfKhYojwcigmnLT0LICGiD8XCa4eQrFrQYrI28QUXSmdNdoSHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNTbB+EJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376A606A883;
	Fri, 13 Nov 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNTbB+EJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FB1F000C4;
	Fri, 13 Nov 2026 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592442;
	bh=YOhDE1A1NoWSc3HJwwDv7rAFd3isHMa6WzPG0AjLim4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aNTbB+EJz4n3/fVzL99OxKi/yQ7LVSH5J6kc6Jo9gU+zr3YPO5nCdRI7Zzcd6gYZv
	 Yo/mOVlnPijDK3bwYnF7YKw8z3B7jAT31Fh5qGtC3xYdcqh1G1W+lEi8yQ0ap15uLg
	 G50OnTuSIoXaO5drPd4o28nKQThc+FTZJqTQDYhwCYz3Ug1NZvDrAgiXRUaDRWHkId
	 tYBF1spAr4DG+g6tzrfafOd7CnXkOHDj7qgA7jGuWmZMjVe6m3u8pRSHGmSMCd3jDn
	 w+V2ReHymkGyG3RRc9V7uWs7OdQbfNuP0xshxE6mhTjhNrno1Jvi+P38MozjWubqgx
	 K1ZAbQgfIDxqA==
Date: Fri, 13 Nov 2026 09:54:01 -0800
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 5/6] mm/slab: Support disabling
 KMALLOC_PARTITION_CACHES at boot
Message-ID: <202611130951.3B6741770@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <617bbfdce4fb2689c2510f0cd7f9adbb3ab8edfa.1793253633.git.chris@chrisdown.name>
 <202610302123.687A961@keescook>
 <20261113005212.556c6f234712bdfe@chrisdown.name>
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
In-Reply-To: <20261113005212.556c6f234712bdfe@chrisdown.name>

On Fri, Nov 13, 2026 at 12:52:12AM -0800, Chris Down wrote:
> Kees Cook writes:
> > Swap the ifdef for a CONFIG-controlled static branch that defaults off
> > without CONFIG_KMALLOC_PARTITION_CACHES.
> 
> I've dropped the #ifdef in v3. kmalloc_partition_enabled now defaults to
> IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES), and kmalloc_partition= is
> ignored without that option, so new_kmalloc_cache() doesn't need any
> #ifdef.
> 
> I've kept it as a bool rather than a static key, for the same reason as
> on 3/6: the only reader is new_kmalloc_cache(), at boot. When
> partitioning is off, kmalloc_type() still picks a partition index, but
> every one of them resolves to the normal cache. So the flag is never
> read on the allocation path.
> 
> The one place a static key would actually help is kmalloc_type(), where
> it could skip picking a partition and go straight to KMALLOC_NORMAL.
> Since kmalloc_type() is inline, that means exporting the key to modules.
> That seemed like more than this series needs, but if you think it's
> worth it I'm happy to add it.

I'll go look at v3. The goal was both immutability after init and
avoiding a branch in an allocation path.

-- 
Kees Cook

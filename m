Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AC12BF24;
	Wed, 15 Jan 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985148; cv=none; b=fmh/RVA8E/g9Uvn9jtc/ruNYa2SiR/wg8OXh/7JlnHbpqSYdxwU450QxmR3R7VxWYqTeBSIPdDHvTUlbDDLEoCyNTJ7FGvwF+QGkCRDOEujMWVwpLVDHA0XX01Ijm0RwiNnY+R8Qwes4TsW/9stwNbo1Ut/AHHDhlojvC1y9CnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985148; c=relaxed/simple;
	bh=usyC6r7teDvo9uThZarga5X1zNn6I8cqW+sSlamTdk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2yeA8ytqAcs+ACdUF+OvDRPPC5F0qg4LoAa+Ua7RUQt6+hDSLkTTkUndMBLqXxOPmSBfXJCWQ+lAqpX6vU2bqoOdl/jAPuMp2F7lOAP18t10BXdhkTPR2VTqgnAz2MJGgx+oI11FO/x6W1yVw4E0Goz0tk/S+MoGya5XdQpnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1OTwamC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1OTwamC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C305C4CED1;
	Wed, 15 Jan 2025 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736985147;
	bh=usyC6r7teDvo9uThZarga5X1zNn6I8cqW+sSlamTdk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1OTwamCXon4A5RcfRuFwlqgq1cPbI5o7I3HtMqztdEmzVYIPiZsmPpR/wgcyIF9G
	 Fj2r8dLncZAXJsme5nX7tPHqpQlW2F9wVPArcJ4UnSi6yZ+HFv5zgw6pI2UwV/UM4c
	 hKVeAz/HWs0lspszPBMFU3FkpEFH5GFTRr2tlMSAZjY02SzTS87ym8ISCBDAe/D+EV
	 E1q+D+MyRFsPKOeIgges9iJcXpR+pHRDtsksMBX1vIXoAUPNFyR2QzeLtp2l6bhzK6
	 wMcRzXppi2005WW86oygKs8o60lAS/8jpF851zskk3YibQXIcY6ebhVFbmHwHwgJ/R
	 lztR2t/kkX8tg==
Date: Wed, 15 Jan 2025 15:52:23 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, Liam.Howlett@oracle.com,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	Vlastimil Babka <vbabka@suse.cz>, Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <202501151538.3E757401@keescook>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>

On Wed, Jan 15, 2025 at 07:46:00PM +0000, Lorenzo Stoakes wrote:
> You are now suggesting disabling the !CRIU requirement. Which violates my
> _requirements_ (not optional features).

Why not make this simply incremental? The feature isn't intended to work
with CRIU. Why don't we get the feature in first, with a !CRUI depends?
This lets the users of this feature actually use it.

> You seem to be saying you're pushing an internal feature on upstream and
> only care about internal use cases, this is not how upstream works, as
> Matthew alludes to.

Internal? No. Chrome OS and Android. Linux runs more Android devices
than everything else in the world combined -- this is not some random
experiment.

I really don't like the feature creep nature of the system mapping
sealing reviews. There's nothing special here -- we have plenty of
features that conflict with other features. And we have a long history
in the kernel of landing the core changes with lots of conflict depends
that we then resolve as we move forward.

Why not just make system map sealing conflict with CRIU? Who is asking
to use both at the same time?

> I have told you that my requirements are:
> 
> 1. You cannot allow a user to set config or boot options to have a
>    broken kernel configuration.

What do you define as a "broken kernel configuration"?

> 2. You must provide evidence that the arches you claim work with this,
>    actually do.

What evidence would you find sufficient? I'm concerned this is turning
into a rock fetching quest.

-Kees

-- 
Kees Cook

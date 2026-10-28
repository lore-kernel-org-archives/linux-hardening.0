Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201854;
	b=AdzpMF/8tDJjoLjzM21fDALqQ1z+aa1JocmP+7R0kuDtd2tk37JKsl/mJhH8dav2/lKA
	 e1hqB39RHOUi+MErgmiPU9bpvWQs4bWntlsotI+ZrXIqyhCoPd7w6RLWo1lpS/4rjYwT3
	 u5MqQ1UzOVK7dK32BgJdI7I7cTXdDIPiMpKy7ez4ZLk15NN0k7V1DpNh89yGE3wAhdDkO
	 ElhUqsx1FxB1AwRo9fkYZFahG0KhK0F9rq88s0N4XKRhzagAvixl8U5I2uF8ukFkh7OUR
	 jPyvbYFda01UvPn3Yk+Ek5NwB6A0In6RDaxtRjjM7W4wDHvVyI40i9ncwE7MNHmgpOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iEstB2Yqj/OV4/iylOODgI3e0ZEYrocagDRh/bGqrzU=;
	b=p5eh0pF7e5u2CB/8b99RJf81Ev1H5IUCqMEwRG8hkb/PU2VmGE9/REZadRCsOHSBOYgJ
	 MzA0v8oy/+nZ/Mv27irmlx0mzWqTYrEwLTg6RPFEl1Q2UY9saTiTaQNE81g+wArfMZI8H
	 E9lUBV0VvOrNiUDd6Sj9qzJL7dVy6tlTHGQkUQW39MwSRQj8xzrkYDXQD0PTNrIZTSQ8z
	 BbLPJ+Pm4FUqIbpLBe97Sd5iQk8neCV2/xNrK4BocOkWd2SIh8A7pEKKdwwcrIcykblXG
	 jqafWlU3mWOP1s3xjgg2WbV1nx8+7puuN1yKKoS3tkrTQKDcLEZV9A+cwACP8i6I5Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geYSyUoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64D606A32A;
	Wed, 28 Oct 2026 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geYSyUoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7081F031E2;
	Wed, 28 Oct 2026 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201853;
	bh=iEstB2Yqj/OV4/iylOODgI3e0ZEYrocagDRh/bGqrzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=geYSyUoQgrGtwDbkkBwlXHTFNbhkeqzSW52AV3xgPmMnYLfnuh7bWTDf/yXqU3F0/
	 Uwp1PErTxxkS8aF8yIsAFIQ1nhA00DgrpkkCC7FiIsrXMH53H1wB36EDCWCPl02axG
	 28tMyiaQfMjN4uVROLQPgjZg0X5RcvRFC6U0tFe9mplLI5iAzo3pSuq09urihZoG+s
	 NJw+Uih0fQ4fiBUQjBo9hNO6n41sCFUDB0nkmyrg9XfpgJxgSuXj5uT4keq74WaL8W
	 xjG6EiPDB4+X8HzbnjU3aigdSmQzXkr3BZpA2vajjR8JZDNm0nzmY1+LNovKF3Zw4F
	 DGM3/VWtbmnHg==
Date: Wed, 28 Oct 2026 15:37:31 +0000
From: Harry Yoo <harry@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features
 at boot
Message-ID: <auIVIKxjrdXIaUIY@thinkstation>
References: <cover.1793086056.git.chris@chrisdown.name>
 <auIN44CnAyzvR_Ll@thinkstation>
 <auIUaT6LyEI2cXpj@chrisdown.name>
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
In-Reply-To: <auIUaT6LyEI2cXpj@chrisdown.name>

On Wed, Oct 28, 2026 at 11:27:37PM +0800, Chris Down wrote:
> Hi Harry,
> 
> Harry Yoo writes:
> > If we end up supporting boot-time parameters for hardening,
> > I think it should be all enabled (or disabled) by:
> > 
> >  slab_hardening=none|light|full
> >  # please feel free to suggest bertter names
> > 
> > none: "Turn of all of them to maximize performance"
> > 
> > light: "I'm willying to sacrifice _some_ memory and CPU for security"
> > 
> > full: "I'm willying to sacrifice more overhead for security
> > 
> > IMHO more fine-grained knob for each feature doesn't make much sense.
> 
> I think if we did the 4 knobs that is a good idea. Given now it's two, I
> think it seems reasonable to keep it as two separate knobs unless you
> object? Otherwise I think given it will only cover the latter two, it
> should be something like kmalloc_isolation= instead. Let me know what you
> think.

There has been constant, steady efforts to add more and more hardening
features over the last decade. So I'd say slab_hardening= is more
future proof :-)

Kees or Marco might have more insights on this.

-- 
Cheers,
Harry / Hyeonggon

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504427;
	b=pdnYlF1PTSb07ZI94E7KCMdzabn6wVUS5BshTngGTwUp91r86WirVT46D1QDUjc0N4vE
	 Xzo4t0iM/x3IB1IjEYHvjCXe+baPdHi68CjXYdtejlCtU4IcllmTWHYv0BFG2/WRxd586
	 13ewVJPHtkhMifUCk5bVIz5rr9Y3OiXhfv2AQSopwKe3INgeg/GQLiigAi+eciR4tTDwQ
	 ICjef+ZCwjnnzhFdVP7WV+CYkuKtahNiznt0QUXVOo2vsvTHhvpZJwN6x6N0SRV68xcrv
	 LFol2f3qmPm8hzKvSshnvNXcObRQKYtoqVx/3NlNsIIU5uK3dUSWtS6VrMPqB32XQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504427;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Glvz53zLbLbW8bLhJ7jWkgAZpG3+a8zrKk+EYR0fOlo=;
	b=yQIgA2vF1BTXflOGKgO5SrCFhgSXk15wTIjQcOPnbQcioZJymuZO9PlhfUZQSiMlbAfw
	 B7oyvd8tJKV4GZDGyOU377tJarUAn0j9RQe0tWHkkqW5HwjbWXPSc+F+LSFW6RFCRVOS4
	 1LHlBbb5iBpTDRG2mAYc0TcRJIdsEsihS1hyYIGLLKjcuVPqxXK0KH/JL/tBG3+Oka6nM
	 9fy37de1KDrJg/yh9Lqv2e4HLFADcYCR/pq8oD1rGf4Qq3ixTZNDmFVR9NpmTaH7O/kaq
	 fW6g1LlHrGQ7uQKdXCE5JNBWQ/zm0k5h938JHB88DtqC+HYpZpjH2eT5kC7bEZ8ccvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGVxhXwB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C96606A32D;
	Thu, 12 Nov 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGVxhXwB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741471F000C6;
	Thu, 12 Nov 2026 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504426;
	bh=Glvz53zLbLbW8bLhJ7jWkgAZpG3+a8zrKk+EYR0fOlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGVxhXwB/EN0+UEepRhMiIUwZF3NTeqJdbcF2aWDAYIUv/z44L/8ZpvnuXDYd+RFc
	 4GwHY1ml311TymQ3n5RLQfQYpU7LnGUQcm9HOjkwUNjzSHP+jSlZ0aDvxUDUj6IwgO
	 LaNnjasMf8r60oqCditXg23z+ImYJqCpf871ryVTghPUjgaKW6favdiUStEeWgnB5c
	 AAu6YMgq/oYnWOoZHEdAXDUQQPxREuRM+LMMhnFXtDLE4+UPox/aRkD22cJsTIRSgz
	 XdsVcZBy/qDo17bX2NxgCxqcW/ovpPmDUo6SIdDDfapLI7DuTKQAthNx1FWK1jZe9Y
	 AZXuDSWZPcvOA==
Date: Thu, 12 Nov 2026 09:27:06 -0800
From: Kees Cook <kees@kernel.org>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, wenst@chromium.org,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Message-ID: <202611120924.2058DD59@keescook>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
 <87bj7yw9e2.wl-tiwai@suse.de>
 <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
 <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
 <a64e2fa1-6670-4018-80b8-b6856709ad5f@gmail.com>
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
In-Reply-To: <a64e2fa1-6670-4018-80b8-b6856709ad5f@gmail.com>

On Wed, Nov 11, 2026 at 11:28:52AM +0100, Emanuele Ghidoli wrote:
> 
> 
> On 11/11/26 06:59, Kees Cook wrote:
> > 
> > 
> > On November 10, 2026 9:50:08 PM PST, Kees Cook <kees@kernel.org> wrote:
> > 
> > For example, what keeps snd_soc_rtd_add_component() from overflowing
> > that array? If you want to protect the array, add another member,
> > say max_component, and use that for the counter, which gets set at
> > allocation time and protects the array from indexing beyond the actual
> > allocation size.
> 
> Hello Kees,
> 
> Mark has already applied the fix to for-7.4 (d00ba321499c). I agree that
> your proposal is far better, but the applied patch was meant as the
> minimal change to fix the regression.

Yes, totally correct. :) I was just looking at it from a root-cause
perspective. Each time we hit issues with counted_by I try to understand
what the problem was, since the goal is to make it "easy to use". :P

> On your question about what keeps snd_soc_rtd_add_component() from
> overflowing the array: nothing, and it already seems possible today.
> 
> From an LLM-assisted review of the code: the platform loop in
> snd_soc_add_pcm_runtime() adds every component that matches the platform
> dai_link_component, while components[] has one entry per
> platform. On mt8173, for example, the AFE registers three components on the
> same device and the front-end links use it as platform, so four components go
> into three entries. The extra store has gone unnoticed in the slab slack, but
> with max_components as the counter UBSAN_BOUNDS would report it.
> 
> I can't work on a follow-up. If someone picks it up, components[] probably
> needs to be sized by the matching components before the counter is switched to
> max_components.

Yeah, I think we need some better documentation about best practices for
counted_by, as there is clearly 2 very distinct cases it's getting
applied to, and the "usage count" case is the most fragile.

-- 
Kees Cook

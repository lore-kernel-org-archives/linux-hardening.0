Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D633FE4;
	Tue, 30 Jul 2024 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722300094; cv=none; b=AS9q2a/q+r7Gk+1WxKesVfSeaV6/AXDinZglfDNXFWfKNem9tOwIRzZn665jCe4KgqcHKtDeOwZKWFO5If7P52xQWM1d9ibwmT+ctGuqaug0v+t493uB+FaR6rA4PHBcClgrM472cuz3gvZ7lJDGG9CTm/OcEEsMaIE429I1UqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722300094; c=relaxed/simple;
	bh=lekOe1+MxIlBhZ79to1c7J8l/84yUjXxzwj1ShXt120=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7uZ9MKEPjA4Qc4g5lZYfZDR1jXlRC/sIZSA+ATNzHLvTzYGVxRF930q3UwiD0GskXabMrIazsEfbczr9vo/43vwBU61VtJpDaDQJn3MCKL5DJV9vKRilyKD0v7kkRN0AgpJCp8+LRabJNMJgQLN2EruI5Je0zCSpJQNse9K1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFFZDywE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFFZDywE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CFEC32786;
	Tue, 30 Jul 2024 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722300094;
	bh=lekOe1+MxIlBhZ79to1c7J8l/84yUjXxzwj1ShXt120=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFFZDywEF0SbkA1T6NxPBDtE8DY9WpMHcsFArPqMBlGfl7FvduTsdJOT7vlQUT5Fg
	 5LBJDufE7cJlcNEGezDo7apcOGC3Zz4Fswj5K876wOTWkeH+FhDfT0gIie/QY1Hgor
	 u7AfQA9Wz2Y83u1J3nHTC304yXdAGRRbt0VheTg01RCdqwm6njkSgNTXtewQFxiGk1
	 J5uGSULYCrkfZcLQljxoEmo+ikNoy24W1VKYD88IvMPfPHfTgCGTYM+oMNofQsFJwL
	 4gvF7idkNbbVEnezp1MQWre3PFwj6omZPV6v8tvEmyn9UXAMJm+hZhNkosV7Vkrued
	 DtkRKPqtTxF4Q==
Date: Mon, 29 Jul 2024 17:41:34 -0700
From: Kees Cook <kees@kernel.org>
To: jvoisin <julien.voisin@dustri.org>
Cc: ast@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, jgross@suse.com, jpoimboe@kernel.org,
	leitao@debian.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, nathan@kernel.org,
	peterz@infradead.org, samitolvanen@google.com, tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Message-ID: <202407291720.1E1B193A@keescook>
References: <20240501000218.work.998-kees@kernel.org>
 <c875722b-0434-41fe-b375-cc685498c444@dustri.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c875722b-0434-41fe-b375-cc685498c444@dustri.org>

On Mon, Jul 29, 2024 at 02:35:02PM +0200, jvoisin wrote:
> > Since FineIBT performs checking at the destination, it is weaker against
> > attacks that can construct arbitrary executable memory contents. As such,
> > some system builders want to run with FineIBT disabled by default. Allow
> > the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
> > newly introduced CONFIG_CFI_AUTO_DEFAULT.
> 
> I'm confused as why you think that KCFI is stronger/better than FineIBT.

Sure, can I try to explain this more.

> The latter is compatible with execute-only memory,

Yes, and since Linux doesn't have kernel execute-only memory (and likely
won't for some time), it doesn't make sense to use FineIBT over KCFI for
that reason.

> makes use of hardware support,

Hm? KCFI does too. IBT is still enabled with KCFI (when the hardware
supports it).

> doesn't need LTO,

KCFI doesn't need LTO either.

> is faster,

What? Measured how? I feel like you're thinking about the old Clang CFI,
not the modern KCFI implementation.

> … moreover, I don't see why an
> attacker able to "construct arbitrary executable memory contents"
> wouldn't be able to bypass KCFI as well,

To bypass KCFI, the attacker additionally needs a targeted memory
exposure to get the correct function hash that they must include before
the malicious function they construct. With FineIBT, no such exposure is
needed.

> since its threat model
> (https://github.com/kcfi/docs/blob/master/kCFI_whitepaper.pdf)
> explicitly says "We assume an OS that fully implements the W^X policy
> [56,58,106] preventing direct code injection in kernel space."

I mean, a whitepaper's threat model is nice and all, but this just isn't
the reality. Linux certainly tries to maintain W^X, but there are bugs
and things like BPF, which can be manipulated to gain attacker-controlled
executable code injected into the kernel address space. (e.g. BPF will
flip a writable region from RW to RX, so W^X is maintained spatially but
not temporally.)

So without execute-only memory, some deployments prefer to not weaken
the CFI implementation to allow for hash checking bypasses. Once X-O
exists, FineIBT is a slam-dunk over KCFI. :)

-Kees

-- 
Kees Cook

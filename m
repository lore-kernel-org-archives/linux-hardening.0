Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220060;
	b=RPlD3d/P5w/FetID6qxntAFRnT2VZ88HNTxn87Wa/BDypFT5YsBsUK2i5LHosKiNZxvT
	 uHHB2pLWPRkOW0Et6xmdeMC1oKmc2MHwKwJ29CDdXVdnzvLCNlB6uPFCG3N3D/DawJ/K+
	 2s4R9CJu/jhfUKVvrakmog2Fz1QVvzhHe5jLzhhV0Rx7ia4r+UTOmnQ8yKXG2QlFqV28t
	 nw3cPV65DUZ/2czHMMxDF9b0ZB26SmKiv42r8kFvju5EK2QDsvJ1uM5v0Arw3U0JfFPpK
	 CzjdOKXpfy1IFsHbP9ItIsL7kTDNncHZZsw24mMA8g56UYN6nthEiz6kcwNXbG+kgTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220060;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=yoRbYSaEgyXzc6e4eII2kRWFOGhXHWDdsx8aEjPIx8k=;
	b=sH1Qt0/laI9Ue5HsurEmHfwzuYZqVaTALVC23TOQ+fmPAFHDipxMIsdDeMtaHopOoFj1
	 6EKPniU4PRWs0ge/HrxaG2x53CXZW06uxfSeSxzb0SmYisW73fTIOHkpsBhdNtexXNkgk
	 cwNsNKAwdQKhwndrVhCdXTFD2Rc11m/+72rDk+VNSbzAwpDIA3JqsGROMkGxPV/b+iWru
	 +ncsIFtZJCk3kmzEV4p0BizV49wsZE57m58ycqTFRKSh5Ruchu9px0legETmTRHInAjpK
	 y2WRVIvh8RBR7DR6cjs72R2+MaUcognIGlh6bpHD7WenCjYwiuvDdv5atcPKz/eEcuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZAKjsqk0;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34F606A31A;
	Wed, 28 Oct 2026 20:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B34F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZAKjsqk0
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BAD6440E04D1;
	Wed, 28 Oct 2026 20:40:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oFQJ2xt0nLro; Wed, 28 Oct 2026 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793220053; bh=yoRbYSaEgyXzc6e4eII2kRWFOGhXHWDdsx8aEjPIx8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAKjsqk0cTygPtU/kDghBcuIGhFMCS84Awt0EwTtmQEhZF5MrJ7xcB1LO4CqxRwW6
	 72wG9CvVgWAfABYQqRzzrnN2rbcyAV6mEYdWM6sjuqOqKc0CyDBS1La+FaLbOmZNIh
	 svy2CJPksG7MKu9+6vPRLY0Lba59Qqxm3KKM04VwqAL5dDj3w+4JIByQKkRNdDQGX6
	 TB1MfxRc+ENserpSVcw4M7CVJtpnZpjWyhKV4soWtzYVMG0aLwZiNblrgONB3TWvLi
	 Di0ciOrNJbXkujeJTKYbfHj72KUaEtNZcBGgy/vfVkN8Y3ssN1ueFPpQ/sCQR6frgw
	 aOpVH9wrEoFpP9jxpM9tZ/gQw3iaZjKFxPAMPQY2SFBAadnTDsdiePUfy/0dVjO+TV
	 qUVp0uEX6a4TCETBbUEsuOzaTAdTfFqnevp9drgWGzWY1kEQ6BeOm0C+56/M/nglt2
	 07WYg3/SF9T/7L7e0ye6JTTBRLvWPSt6q5tZRKaspHa8GMlmrArPtRiJfoFRzWrhgD
	 H+84+xAUO3lpdvVsPix8lbCG3sp9GBgFaapca9c6WQqfRIUOftQyioiP3rKDxNEohA
	 olp7mbAE9aPi/YYnHWRmekEo5P1K9PaMb3NBSIWx9F1+YHBFWTU2ePXfL5zd7OJfXq
	 fGU5pj8pQHhMNCa0wpEib0X8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E78A740E021A;
	Wed, 28 Oct 2026 20:40:38 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:40:34 -0700
From: Borislav Petkov <bp@alien8.de>
To: s1nkhole <dedemorow@gmail.com>
Cc: dave.hansen@intel.com, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry/32: Harden return-to-user
Message-ID: <20261028204034.GEauJdwqPRlPoAoaYe@fat_crate.local>
References: <ac147f25-a2d3-46b9-89c5-44a1c0e4f038@intel.com>
 <20261028192139.32606-1-dedemorow@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028192139.32606-1-dedemorow@gmail.com>

On Wed, Oct 28, 2026 at 10:21:39PM +0300, s1nkhole wrote:
> If you have a moment: this is my first work on arch/x86, and I would like
> to contribute something that is actually useful. Is there a small task
> in x86/entry or in kernel hardening that you would suggest as a better
> starting point, or a place where help with testing or review would be
> welcome? I can build and run kernels under QEMU.

Review and testing is always welcome. As you can see, we're drowning in
patches. What we're not drowning in is reviewers who poke at submitted patches
critically and ask nasty questions.

And nowadays, reviewers even have help from Sashiko's LLM so doing that should
be even easier.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

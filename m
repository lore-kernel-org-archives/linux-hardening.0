Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF81F12FB;
	Thu, 15 Oct 2026 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026645; cv=none; b=Jmp8528lZN2RuOcoYmotsmzQ/jjh2TiREXvEWmSQSqu4LSV8x2MW443ozbdKQbY2VRQ8seaqRJZ60u6KThOiuFldNoQ2lDZkh0X+EUC+xMUqmIv5U2UcLiZMI9pcg8a1ivbrS/Y8Ahc3VHIXdfMxHnvnzj8kHUKKdE1V055Qqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026645; c=relaxed/simple;
	bh=2URK1kMf/Fl3K3X7+J5+nGS0pM95QwXxanHag1AgiVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocS/i53UyFKiUWcw6YFz1CViJodW1P5ZsXtL3o94MRtDdUdrkwPgix/5GCCGAcVbc+qsCyV4G8CvISxWnP01gTdoqtEtmKTh+LR8A1kTf/nISkm50F2yYeLpUjHBZn2hfxmS53g84oLKFNtMRxkL4GHugExtUWvltYEueJpAZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKZtaDe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKZtaDe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1093F1F000C5;
	Thu, 15 Oct 2026 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792026644;
	bh=Kb9X/vVPaBS5PmmJTv9N7AbomZftgYqIDYhNlvtwuqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SKZtaDe97GO/xuHcK3Cuu/Vhg5xDG7YB+bN7mTbhiCDKc2m9/TbXQLmBi/vR9eQkc
	 EisxrxD9TV3RXvoBWZLFYkxpZfcd4S+W9ujoCUGzhDoR1gxCSfwGte6q9e9CXf38uH
	 A2aMLoSFvSwA2/XEr/fOoM8pOJOQnGlPW4OF+ZRTgPGx3tOKPGHOwTYnLHEPRzwTvz
	 efKDWe+Dk7FhPRq4fZ7ApG6QeguE6hnMxhVzOFDHuzzGseDfnWrexeEDvcSDMgwM5/
	 iyOzpXvEuUZLOs/Ur/tDYRDfD9t+FY0WRn2TnxO1IGT9YrxYyj9K6w1OGoerDHHR7P
	 YkEnu72dy/rTg==
Date: Wed, 14 Oct 2026 18:10:43 -0700
From: Kees Cook <kees@kernel.org>
To: Iurii Trukhin <yuri@trukhin.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and
 52-bit VA
Message-ID: <202610141810.779BBFF@keescook>
References: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>

On Wed, Oct 14, 2026 at 07:26:48PM -0500, Iurii Trukhin wrote:
> Since commit f101c5644771 ("arm64: Support ARM64_VA_BITS=52 when
> setting ARCH_MMAP_RND_BITS_MAX"), arm64 supports up to 33, 31, and 29
> bits of mmap ASLR entropy on 48-bit and 52-bit virtual address spaces
> for 4K, 16K, and 64K pages respectively. However, ARCH_MMAP_RND_BITS
> still defaults to ARCH_MMAP_RND_BITS_MIN (18, 16, and 14 bits), which
> was set in commit 8f0d3aa9de57 ("arm64: mm: support ARCH_MMAP_RND_BITS")
> when 39-bit VA was the 4K default.
> 
> Set the default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA to 28 (4K
> pages), 26 (16K pages), and 24 (64K pages), matching x86_64's 1 TiB
> randomization range (5 bits below ARCH_MMAP_RND_BITS_MAX) while keeping
> ARCH_MMAP_RND_BITS_MIN unchanged for smaller VA configurations.
> 
> Closes: https://github.com/KSPP/linux/issues/371
> Signed-off-by: Iurii Trukhin <yuri@trukhin.com>

Yes please. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

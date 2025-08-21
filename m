Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381722D9EB
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803025; cv=none; b=gyaskUGi/9sXAKrmAijShSD0JLBG1ntV/YTMstSBRhOVd4V6pRkSlofmR0swFUm8JhyBbyGMejrWIyzvj5L/2DnGtB66GKiIigs8EV6+7TiPnrWuM3O9+qG6B8obZFWQeDlOqvORzulhAWhf0VhE5+wRRjrEMbKOviDUjTWea4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803025; c=relaxed/simple;
	bh=nJ74J04huQGhrFmf1dN3pnzsHuvvPuvYlb1fJOidHYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztn5rfxuEXG/ktLKOnR4XwB/TJf+BEQ27MmVjcjpjh/mdJrJKGiVMvsg52X6CQEKuNI4g2sk3PZSGqECA9HqfQ/TaKCMgfpD4aCniZcjtBQ3stKJYWFK/eedmM+Y0n6DUQdKXq/aLLqDjEH+Xad6QFDgWIGNKGRDRm/NkKwfVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTN6RPnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTN6RPnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935AC4CEEB;
	Thu, 21 Aug 2025 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803024;
	bh=nJ74J04huQGhrFmf1dN3pnzsHuvvPuvYlb1fJOidHYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTN6RPnPiB8Pk4UnCwX2ihjFmhnzsmJHDcOnaGrhdvZiIomkllixvQVIhOVR2Z1qM
	 rlvKwyQ70yvOm1myCINOe0ScPzzxX05LCeRIzP7XS4lQo789/PWiBFGazxaw2EYhvX
	 VBERBC4aP9Zhbw91l23ZKmsOHW/r31/I2SxC6p409isQzGJ3gvUffkdsdq10le3UPi
	 4qm8hld5Rao4M3+Tx8l4jWVQgdL+dMgpE9+6kGOU/AV5GTefpN29rtyNe4PoC5rsKn
	 uQr1e3HBDZRZ2VJCKeJa/qP7j7fcgdIqYpCANTKYjldce2KTdQ0UuBkMVl1FVKmjfG
	 fc67PuObykHCQ==
Date: Thu, 21 Aug 2025 12:03:44 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <202508211201.13E62611@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
 <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
 <202508210916.71079E4BA8@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508210916.71079E4BA8@keescook>

On Thu, Aug 21, 2025 at 11:46:17AM -0700, Kees Cook wrote:
> On Thu, Aug 21, 2025 at 11:29:35AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 21, 2025 at 12:26:37AM -0700, Kees Cook wrote:
> > > Build and run tested on x86_64 Linux kernel with various CPU errata
> > > handling alternatives and FineIBT.

Turns out my configs were broken -- I only tested non-retpoline.

> > 
> > I'm a little confused, does this force r11 to be the indirect call
> > register like clang does? The code seems to suggest it is possible it
> > uses another register.
> > 
> > The current kernel FineIBT code hard assumes r11 for now.
> 
> Oh, it looked like it wasn't always r11. Does clang force the call
> register to be r11? I only do that here if the call expression isn't a
> register (similar to -mindirect-branch-register). Looking at the retpoline
> implementation, I see __x86_indirect_thunk_* being generated for all the
> general registers. Hm, but in looking now I see all the hard-coded r11 use
> in the fineibt alternatives. I wonder if my boot testing is somehow not
> triggering the FineIBT alternatives patching? I will investigate more...

I've found my Kconfig problem now. Confirmed that this RFC does _not_
work with retpoline (much less FineIBT). I will get that fixed for the
next version.

-- 
Kees Cook

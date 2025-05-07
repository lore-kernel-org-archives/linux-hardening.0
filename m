Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0368216399;
	Wed,  7 May 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633190; cv=none; b=stXP240Ur6QZrK0CcuLGvPDuj56PBsmX5I4V700FEkI4O0KtCQ3b4b0r6NQCWMBL6HFvH/klLSqOVnHMvNegAMl6LAVxhJlUeb/5HKG0R4BaOsF+92X82Si1og2eBgPwnsnCNFBkNfrsCVIrdV5FKPCZhqSckhfVq/57GRV3zYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633190; c=relaxed/simple;
	bh=dQ6/dOrcudgEAPxTEmiwSX0trOKteBtMndxMn1uhuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7YJ1T+DY8VVA4v3BDlBllojY4B6lPvl1nkk2QH3r2ep/2vyPh3ArjgVKa6ZVd3ohGHSj7gRkcv32UxPJMmM2bgxTcS2bkt28i3qvfJjfBmBus1N0hBz9XsDCai+DV6UjuXydK/Mf3Bkz6qhle5fZsnl90fk6iaos2TW+4lBfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD5KLnsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD5KLnsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93BEC4CEE2;
	Wed,  7 May 2025 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633189;
	bh=dQ6/dOrcudgEAPxTEmiwSX0trOKteBtMndxMn1uhuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD5KLnsyy1dAPUedHuHoLykE9F5YJ+uFe0Jxk174GYQN7J52NIkHKrrls9IUr3Cvb
	 Z00nkXAVLV84lYk1qeaZISAAdGzPgJisyRkTz6VsmxImfmAVtSbpifqxVWa2C/1o4+
	 HrB+ARCNvYFcK0DHviVlsGBhZ/jkn5YnVOGuv0BAl5TQPyhZzNn60Gs8yAzzkMbcg0
	 tujtpdzGaaeoV7ZArCcZQS1JzP3O6vUNAGFn8+W7l2lvwud0HzKHcjGeDQxkF+/ogB
	 ld1UdT9AGPTTHlABlbDuRYhjrWM2PTZVKvszXlaGsR6SWYjjDv4I3LbUOSVr08vUdt
	 kQcoflvBgBr2w==
Date: Wed, 7 May 2025 08:53:06 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <202505070849.1F48789B6@keescook>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
 <202505062255.130383D3B7@keescook>
 <20250507065913.GA31959@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507065913.GA31959@lst.de>

On Wed, May 07, 2025 at 08:59:13AM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:55:31PM -0700, Kees Cook wrote:
> > On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> > > On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > > > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > > > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > > > to inline the function. Under special circumstances (sanitizer coverage
> > > > functions disabled for __init functions on ARCH=um), the compiler decided
> > > > to stop inlining it:
> > > 
> > > Can we place just fix um to still force inlining inline functions instead
> > > of needing these workarounds?
> > 
> > Oh, I don't have the history here. Is there something about UM and
> > forcing off inlining?
> 
> Maybe I'm misunderstandng your report, but what causes the failure
> to inline?

I don't know precisely, but whatever internal heuristics the compiler
uses to change a function from "static" to "static inline" got disrupted
by the build options, and manifested with this failure. It's fully
reproducible on all architectures if I mark the function as "noinline".
:)

So, the solution for the "accidentally depending on a function to be
inlined by the compiler" is to mark it as _required_ to be inlined,
which given its singular use in BUILD_BUG_ON(), looks like the correct
solution.

I took your comment about ARCH=um to mean there was some kind of
long-standing "UM regularly fails to inline stuff; can we fix UM
instead?" But regardless, I think this patch is still correct given
that the compiler could, at any time, decide to make this function not
inline, since it's not marked that way at all (but its usage depends on
it being inline).

-Kees

-- 
Kees Cook

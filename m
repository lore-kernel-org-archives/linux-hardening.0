Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E64215066;
	Mon,  9 Dec 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738626; cv=none; b=TfskQzFgeGJ/EYHLH49SjywWlSk4pK4VJ/G7G6wecbzLABtyXagK39zhpwvzgjEW8TQYrYyzR9vbTiOTi2LYIkRBXnFkMxMaUNmt4s2WeH6AOoWwtj+SXt5p/Hc/7QvwFc9VwG1fanlj1+f0t8LHXTZrEaqqh0ctAK23BK6VwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738626; c=relaxed/simple;
	bh=nCwMuDvhkyuM0eXuivILRKaAOOTv9qfQ+ABElFuMKXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDbzpg0BilKuKoBrDeN4w6Cf+1IMqeQy/utd4+WhC7y70w6hsDrxVXF5+3xvYcLWLcxurz2dTTN44fSRuSLZeJlTSraygTbf1IElDCoRDjxzBCMTDEuwoT8rTwyWLDwDi4vEKAIsgvE5IatzEuu5BK+PsEIuj0751HaFGNwJIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I300jKpf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I300jKpf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aEDAbaOt7g6WeLBENFVnG/KXVfGSTAbCAHZK9utoSas=; b=I300jKpfjZCcYr326Pjm86HuTv
	KuoDBL+tDkBePOb6odylz3aBVO7IhJsRH2CX0CFu9icNySnEcf+wIWCRKRAOeJhi2eSoR0+zCyG3D
	k/rYzH0qtLZ1I8mHWquXBdvlzQ4RF3/3anbme9zzpydGFcO6PFsRLiyDOaHGnu7pTqmkiPbDKxVh/
	L9PCZqlZXj0PeFwMSF7JYdgPNNf88oZr2trbJIkRroe8TwR5jHsvp8HJOqcsFsggTHgak2Q882WPU
	X1YEcC0ESgH+b9p04on7prgL/s/Yvc5yJO7tAu7v+0US+TiiYU35ii/N/a0CycnTOOv//qMaPDTkE
	oMCrCFfQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKac4-00000003WXn-0Pr8;
	Mon, 09 Dec 2024 10:03:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72A683003FF; Mon,  9 Dec 2024 11:03:35 +0100 (CET)
Date: Mon, 9 Dec 2024 11:03:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	aruna.ramakrishna@oracle.com, broonie@kernel.org,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	jannh@google.com, jeffxu@chromium.org, joey.gouly@arm.com,
	kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com,
	qperret@google.com, ryan.roberts@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [RFC PATCH 08/16] mm: Introduce kernel_pgtables_set_pkey()
Message-ID: <20241209100335.GH21636@noisy.programming.kicks-ass.net>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-9-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206101110.1646108-9-kevin.brodsky@arm.com>

On Fri, Dec 06, 2024 at 10:11:02AM +0000, Kevin Brodsky wrote:
> kernel_pgtables_set_pkey() allows setting the pkey of all page table
> pages in swapper_pg_dir, recursively. This will be needed by
> kpkeys_hardened_pgtables, as it relies on all PTPs being mapped with
> a non-default pkey. Those initial kernel page tables cannot
> practically be assigned a non-default pkey right when they are
> allocated, so mutating them during (early) boot is required.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
> 
> It feels that some sort of locking is called for in
> kernel_pgtables_set_pkey(), but I couldn't figure out what would be
> appropriate.

init_mm.page_table_lock is typically the one used to serialize kernel
page tables IIRC.

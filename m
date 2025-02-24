Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA419C54E;
	Mon, 24 Feb 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423861; cv=none; b=hXK0B3uX8og26fOwwCycvGSbQSGhAkP8bYznW0wqAJfID6Oi8tA0qq+K0I+d9yIbcQXzNou2XGtDDxOlME/V81J8c64MphaOvPdJn54pXRWqXjgVdObERM0yr6orr2oIw20Bpykc/+AfvpKm+C4Fe3Oicq/5xW0hBSFT62TrCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423861; c=relaxed/simple;
	bh=xMoC4h74QI4gnf3Qt5Y1FKVR08U13EPZGjKC16qEVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI78mAGEPoDMvy7LupNAacyvAK7BodCLyy10kz95GEsgdJWr0CMrhwAk7YLaCgNKrHKpr4wCuoDl0SixS4DBEaG22cpOajWWpG/HBWdencItjSq0eN1pBy3YwJHvfSLMJo3dOFOICztIiXV4E9ih64H6YS7MNV+ezX9dGpzR4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bROOIGrK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bROOIGrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8735CC4CED6;
	Mon, 24 Feb 2025 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423860;
	bh=xMoC4h74QI4gnf3Qt5Y1FKVR08U13EPZGjKC16qEVmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bROOIGrKoWLzUnjge4knoLx59IHp0f31zaUOw/wQX6OOonuYB7XSVA5Kj7BvXWMVV
	 bcwwGM8SYfqQjYg9O+kUgqdP1wp4aI30m7eeK3XjxDxFQAv60GX7+1bAyg4WX6+Vmf
	 /aqKyUh4ntUt12SAi892qAyDnoFn7FvYcyyeib5R5+JR7F0QERxEjiaqA0Eui5TAOM
	 RDjdSjTCZ2ygHT5lqaHR/zz++/+obl+CkPjsoMMTs4jsE4fnj7BwxisG6tR+f+fXtQ
	 LPtFbJnlCxafIhqNAnZkIySyy40qhZTLlR3pIdAHpo6Rhpa5uXHqlVbvSdVsIFsuJ0
	 a4xpJrar/8kwg==
Date: Mon, 24 Feb 2025 11:04:17 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Message-ID: <202502241103.E7C207F2@keescook>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-8-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-8-jeffxu@google.com>

On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update memory sealing documentation to include details about system
> mappings.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks, I think the list of programs is good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718362361DE;
	Thu, 16 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056698; cv=none; b=p9gQeOx4+60z8203t40F5RheXsMKG0L4kmm1TcFQzIFBZ+oipUtM/mBvz+fGTlN+2MuFnAt09DlDYNGBTki6PqAs4dbRbZoAkm0xiYt9i4rqLyiY36Mk8gSE6uQA8bWn7+5EMPvrJwTXE/43WtTD0dg5JydpVwB0G9AWe8HCvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056698; c=relaxed/simple;
	bh=TEcInxXqaWQt2rTOxvGzHMAPLNcnkyzDnNrvv/XTaRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW5hTml20UI+XzZ5/2aWzgYzVs3F+RHwtThUe45N86EpmeD7pgZtVayE33c4ng8CIvmzhQp7z3LEzhdpLfiwW31haLqFnl0i0AVQswpjP1b9OL+YSzkwlhSH+8niiEUgy7EEqF5AHA/c098mf6Me8RQ0LcA3lvgYjLAH13Hw+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1phd/oy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1phd/oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A5C4CED6;
	Thu, 16 Jan 2025 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737056697;
	bh=TEcInxXqaWQt2rTOxvGzHMAPLNcnkyzDnNrvv/XTaRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1phd/oyfXGx+f1iN3ieRDZSgWJvrTkIJupTdJAbOo07OKZJ+/FLjEmTBZtaBWj2a
	 2OBLnhtezAFnkL17d/XZlOJKEHBYaEZ7nDYS/SX7k3xu5S4uRi+TcpDU1P7EMhO3Hk
	 fnMfi5exQu7WjcuQLj2T1VJ875vCMcVMru16s8KnZUk2i+BSUHoJ3C/OZYefz2+ra8
	 pzfUQb9x80VfmMHjBNk4Tc9S/mADK0RB0h6DFYbBSseLXOBpcUArTN8t+gqS5LlPBT
	 apEPSCPASWUxpLTrzffIS0cvqQ9Mn2K6lUS2jom1rLyhogbf46Kzbb+4MBby1CeExQ
	 uPx7ht5rQRW5g==
Date: Thu, 16 Jan 2025 11:44:54 -0800
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
Message-ID: <202501161142.FBA5CDA116@keescook>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <202501151538.3E757401@keescook>
 <84c6a105-4486-4bae-bbd3-787a4566c143@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c6a105-4486-4bae-bbd3-787a4566c143@lucifer.local>

On Thu, Jan 16, 2025 at 03:34:40PM +0000, Lorenzo Stoakes wrote:
> This was originally addressed with config flags, but then boot options were
> provided which completely overrode this.
> [...]
> Again, I have no objection to a version of this series which explicitly
> disallows known-broken scenarios.

Okay, thanks. Honestly, it will motivate me to finally make CRIU a boot
param too. I'd like to run distro kernels but keep CRIU fully disabled
(it provides some "extra" introspection of seccomp filters that feels
wrong to me, but is needed for CRIU -- but I don't use CRIU...)

-- 
Kees Cook

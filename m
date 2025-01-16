Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C641E505;
	Thu, 16 Jan 2025 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005230; cv=none; b=tJFLZU97ZMq77SMprjcTPTvBerGxOhBxHpx34W8yv/zZB8ZWepxbwz2nBJeRlF9fnXS2gih3zs+kkseQMcCLfMbGpw2NLJO9MKjutgTkT+HO9xdwYbvBc6w1l9L7ev2N37BpWeOIPFsL23ymYEBlh5a6wfHuVbmumktuayQe4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005230; c=relaxed/simple;
	bh=BIEFozehT/2S6vOKwqsPOpRkNqkCyQdO8QRALd2o8P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz5JWWDZfDt9qHKTIH5xUE/Tw5Ep0I4+t6ynhYD/19fLY5Fa9PWLW4skZU5e35N098gBdFP/dFF6dXUhpXLlGxiQdSwDKmeJ0bTIxdv3L7DA5zltoKh/Q2mExIGysxiDGENXou0sZrSgusCF9X5EO8qfC1oz6hB50VH00YwJQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C80B568BEB; Thu, 16 Jan 2025 06:26:55 +0100 (CET)
Date: Thu, 16 Jan 2025 06:26:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
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
Message-ID: <20250116052655.GA23894@lst.de>
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com> <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local> <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com> <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com> <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <202501151538.3E757401@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501151538.3E757401@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 15, 2025 at 03:52:23PM -0800, Kees Cook wrote:
> > You seem to be saying you're pushing an internal feature on upstream and
> > only care about internal use cases, this is not how upstream works, as
> > Matthew alludes to.
> 
> Internal? No. Chrome OS and Android. Linux runs more Android devices
> than everything else in the world combined -- this is not some random
> experiment.

All of which are tightly controlled by Google and not actually open
to users.  Which doesn't say they don't matter, but they matter a
lot less than fetures widely useful to the open not locked down
userbase of classic Linux.


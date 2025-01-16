Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1B4414;
	Thu, 16 Jan 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056441; cv=none; b=VDbKX+JkXn/397tO98bxynGAigX9WApn1+Ec5pWs8zOJn2fB3VlOZLMlv9gRIopGNpIe3geW6eUvV+2M4+GQ8MfWvzPYSzPWz4NyRxeVRggN4x8R3dkOlCVMmzwOLgueet/4CUu4tNB9WQT5ke7PlaYkyXCH+6ZRcejWSYlfqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056441; c=relaxed/simple;
	bh=okrWJ6ZGx3VQgI670QxFKBYwNPpwrQNlJy8qTomC4nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FibhWvTCI1oFzgSUDe4PcZhcOewMRYlxXgoHZLzh0D/60iFvPx6qEjOPQrbZ+tHSjaS2NXC8+kgszs6b4trlri7npgv9j0nsPtXB+kOQcW269PILSQYOnfLYQ9HMIpmm5HzyMJCY992q6U5CJ6qLzbLw5U123yBgcHBisIIR4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaC41c+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaC41c+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A47C4CED6;
	Thu, 16 Jan 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737056440;
	bh=okrWJ6ZGx3VQgI670QxFKBYwNPpwrQNlJy8qTomC4nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaC41c+8yUkHqXDrCDOBYKqZqVz6XU8ziq+umZmvNdijUrym9LLBD1DoilzZWTqGE
	 BOd8imeZQAlMNHPPftkOxT/rrVTfLLAxKSHpMGZMQwFKeu85np97dzws5sM4tK2CJV
	 X2V3zCRPkwoJr27U7uYXxYDiOYS3qK7QINVPtX9cqTNyZERN4Zaf7BpdnWiHUiO2vp
	 tcKPKJ8Mm5mywWzSuMj+oQIcRbCrRB/TBSqKwGWXYW2tRmzVsyAyQ/4gPbR0d5u0c1
	 a4HTSyxcot2qYbA7dFlJeR2vYi9AnNJSiv0srvwMNZ/Qe4Pvmibn0iGxI3Q4U2H6jp
	 VZz81rlqbYDIg==
Date: Thu, 16 Jan 2025 11:40:37 -0800
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <202501161137.D76EE5CEC@keescook>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
 <202501151538.3E757401@keescook>
 <20250116052655.GA23894@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116052655.GA23894@lst.de>

On Thu, Jan 16, 2025 at 06:26:55AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 03:52:23PM -0800, Kees Cook wrote:
> > > You seem to be saying you're pushing an internal feature on upstream and
> > > only care about internal use cases, this is not how upstream works, as
> > > Matthew alludes to.
> > 
> > Internal? No. Chrome OS and Android. Linux runs more Android devices
> > than everything else in the world combined -- this is not some random
> > experiment.
> 
> All of which are tightly controlled by Google and not actually open
> to users.  Which doesn't say they don't matter, but they matter a
> lot less than fetures widely useful to the open not locked down
> userbase of classic Linux.

I get your point. Though in my proposal it would be available to anyone
without CRIU too, which is, for example, defconfig builds (excepting
s390 and riscv).

-- 
Kees Cook

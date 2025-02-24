Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B81FCFE2;
	Mon, 24 Feb 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425187; cv=none; b=iFnkqLeIoL0C7X5k4HDnc3i1kAilvM7oLQEyAGS3UAfY0sJViWThwfftSESWFe9dFE/jq5+vrUGAp7pvJk4izL4lGskqhIIiT2QIPulRRF+9oCwCPsGW1ReM9AA5M3QOCp39OhAGvL2UJZ6VjuTI/QJ1eWv4knfOXAntYL5yt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425187; c=relaxed/simple;
	bh=3FT9s1t6iJB4QohyR9vPRCV6YPVdGd4Yaqn2jw8n9ss=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfXegUtjBaLeo0LYeAgSppvwTjHlzotgbl7t0YXvvmsGlGKvWnbSs21Xa1YydGd2yH+Asmt691JFLc870NKNtHqJ0Ip6W7Q5o+i0SpMrLl/MRuBBW77dLgusWHC0LJv+4QUXjVAYSq5ykWYrPD+aT7RUOAPxYoGVIOETpBdaBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz0Rl+93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz0Rl+93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15E6C4CED6;
	Mon, 24 Feb 2025 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740425186;
	bh=3FT9s1t6iJB4QohyR9vPRCV6YPVdGd4Yaqn2jw8n9ss=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Oz0Rl+93ss0qSQdiDaK8lNcvvfq3+OmN1KTMEiHko1yuF96EIMp6UQCqFBHrWVYn4
	 RcDQOWXO37K4zyNxLHYdFWIDDlD08TPlZ/XH1EwXc9XxgTRXrt10/P8hUMzsEavydl
	 VYWt9XTv0uLtek0ozimYehbWUlpjdApwAyhp6Kc1aAhgEUPT2LV38pP/F+Eb4g8TEC
	 OYEjLQ7VgaXzvC0a2Cn/R2qnuTAIDwnrTccHtQMVDZB3TYP/Vt0DBrcYk2Jmz6+TQx
	 Tw+jE8421EuyzsEkmMjvk4PB33YJSWQRztCaL27/NP85XbOTEoyAfY7A4AnRgDMh5L
	 GANp+jV5WhznA==
Date: Mon, 24 Feb 2025 11:26:22 -0800
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, Jeff Xu <jeffxu@chromium.org>,
	akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
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
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <202502241125.75EF4FC783@keescook>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com>
 <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>

On Mon, Feb 24, 2025 at 02:10:58PM -0500, Liam R. Howlett wrote:
> * Kees Cook <kees@kernel.org> [250224 13:55]:
> > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > For example:
> > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c,
> > > > 
> > > > #ifdef CONFIG_64BIT
> > > > [ilog2(VM_SEALED)] = "sl",
> > > > #endif
> > > > 
> > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > > 
> > > > Please note, this has been like this since the first version of
> > > > mseal() RFC patch, and I prefer to keep it this way.
> > > 
> > > That logic is reasonable. But it's different from the _vast_ majority of
> > > other flags.
> > > 
> > > So what justifies VM_SEALED being so different? It's leading to pretty
> > > objectively ugly code in this series.
> > 
> > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The define
> > for "should we perform system mapping sealing?" is intentionally separate
> > here, so that it can be Kconfig and per-arch toggled, etc.
> > 
> 
> Considering Dave is the second person that did not find the huge commit
> message helpful, can we please limit the commit message to be about the
> actual code and not the entire series?
> 
> I thought we said that it was worth while making this change in v5?

Right, please minimize patch #1's commit log to just what it is doing,
etc, and leave the rest of the rationale in the 0/N cover letter.

-- 
Kees Cook

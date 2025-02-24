Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3013B5B6;
	Mon, 24 Feb 2025 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423775; cv=none; b=T2LuCyYH04AojMUTXiIvhjHtn3dnSglYqZJuCf5vRCYQ7WriWvkHv4xvABQn938qBujrpfA+9yYqYihoS2sVQ/TSbMcrX9nR5kIc9yHGGe2qXmy0wldT6sNOw+9IOK7VvI3jVEGgyIibaDyyd4EI26Dt0EKXnBY4uhqyTTtqJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423775; c=relaxed/simple;
	bh=A6IpvWzpqr1JITL6jOxep5JLmWREXE9w1Dp2+ShNZBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzWFiRP0zCnQ9cmcEMj3FeAmBybJ7J1LuwStTEU+FgG/2gxmEvN+LeKlA1S5anaAFuDRFooMY6VmPBqjo58CGeK061TWmWj7U+1YoHu2TckBwYhv/D5Nuv4X8GfZogN0ZCQAEGR0lSF4SIBOKUboTNM1faF5RSnUjA+UUyA8vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f914usR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f914usR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1DBC4CED6;
	Mon, 24 Feb 2025 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423775;
	bh=A6IpvWzpqr1JITL6jOxep5JLmWREXE9w1Dp2+ShNZBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f914usR1jbCJ/6Oc0mcZQQ06cjOMAsT/Ym7JbP0pCRxiD6MArnIgC132mw6KNPNBQ
	 vf3Hwlx893t8DI6zOvc44iB+8Te/XdxFwcNzy3IKT0BJTdRM7/KpxqJeblAnasxb1G
	 ItAS2jlgVOFtg6CMVRksApiKX0YeF7GWpYKmKVoKFIjMrcXIC4Ogz77nXrVFUmk+5K
	 R+cmopUvhcp9awN7eslQ98kA2e/4kdrKXJxdXbPttcpi5yWD7jJgie2AEbY/tJ6BFk
	 h25ZAEw6SC3meApbEzlAaOqhB4cM2AnYiLnLlRrvICcngDAe3hnNiTimdaFRbhGnVU
	 ooMbQuapR/3Ag==
Date: Mon, 24 Feb 2025 11:02:51 -0800
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
Subject: Re: [PATCH v6 2/7] selftests: x86: test_mremap_vdso: skip if vdso is
 msealed
Message-ID: <202502241102.AB138D32C5@keescook>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-3-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224174513.3600914-3-jeffxu@google.com>

On Mon, Feb 24, 2025 at 05:45:08PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add code to detect if the vdso is memory sealed, skip the test
> if it is.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Thanks, after my full 360 on reading this code, I'm back to where I was
originally: it looks good to me. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

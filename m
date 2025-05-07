Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC928C03F;
	Wed,  7 May 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632937; cv=none; b=B0mrwVl7GAQ/2k2VWxSqjGAmkjb0/8Xzqpm4HL4T3NDmXuJG2jFv1nnANxEb4ROUOuIRSWnwozlvVUgXYuGbfLuDvS5z0RkQ0VuW+81v/lYmuoUozfH9VR55cKpoTimg+sABLbWqrkuPy+uBMcHK+MusocQgyukqnI2SK6tUioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632937; c=relaxed/simple;
	bh=UHyH9xc477VqXmBLiEScRWz038/NcXm8zp58HihWw7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGb40gkCdVdqYp15SEkkVubIBJyqgfl/xAyVZQ8JXTqK+AIXHjv1uA2sk7PlpfPkRgm6dyFpvvnHUE9hOwiIvmIuexmT1HGR5OEYkRNK+7N4ddEhpLjYOkuWBJlzROJLGiiAWn3aTdaBrxvFdGGVTxk539BH/Rjq6qvUoCLrmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiKd327C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiKd327C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D268EC4CEF0;
	Wed,  7 May 2025 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632936;
	bh=UHyH9xc477VqXmBLiEScRWz038/NcXm8zp58HihWw7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiKd327CYRTcNvsJllqCn/wURpo7Z+rNQKeJWaD97XYE6ArmfhFQrbfO9Ho7cSpiv
	 KyFi27+AqJtWGH8jG5dKJp+jpQNIXH2bwuEf2AL2FUAnWOhaBs3KsfhHtP3v3PP7he
	 joSnPyxQ7pXZzXS2liOVsMxtZBBkp1H0b+CxxKclu8/qSgVYZRjmWTHbr8218lHdUJ
	 LUVo7vFIYDkpk8JGP5YMmW8ZQ1XfHcFIOUe1a8axCHJKOx3TW8Q/Y6ZZXyGuy2XXVI
	 EQhO5BG8deeQXmEbgeEqbaxhSrKNR+uTNlUISJs8QtFt6C4GEPtXyRLw9SgDXg0V0U
	 oaxwg4222KJRQ==
Date: Wed, 7 May 2025 08:48:53 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-hardening@vger.kernel.org
Subject: Re: [kees:for-next/hardening 6/14] mm/kasan/kasan_test_c.c:1504:7:
 warning: argument to variable-length array may be too large due to
 conversion from 'int' to 'long unsigned int'
Message-ID: <202505070847.F9BEC6E@keescook>
References: <aBr42psLtchaluNU@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBr42psLtchaluNU@rli9-mobl>

On Wed, May 07, 2025 at 02:08:26PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> head:   48b79238694db6e7eb3dd6153cf71107db624a11
> commit: 1ca6c23046d30abfe57d8706248ad5888aafa3bf [6/14] kbuild: Switch from -Wvla to -Wvla-larger-than=1
> :::::: branch date: 33 hours ago
> :::::: commit date: 9 days ago
> config: arm64-randconfig-002-20250502 (https://download.01.org/0day-ci/archive/20250507/202505071331.4iOzqmuE-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 8.5.0
> [...]
>    mm/kasan/kasan_test_c.c: At top level:
>    cc1: warning: unrecognized command line option '-Wno-vla-larger-than'

Man, GCC 8 and this option is pretty broken. I've update the patch
again to just do option removal instead of traditional warning
disabling:

https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=a81be1e542c0f35e171bc564d8b60785a12cff29

Thanks!

-- 
Kees Cook

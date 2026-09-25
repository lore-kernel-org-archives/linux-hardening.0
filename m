Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22778369D7B;
	Fri, 25 Sep 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363798; cv=none; b=pFqmdvMq54Vw5QplTUptvECoXgbBW2fAdinqwaaw0KBTTzm5H29eADsNx+KUp2oXfxoog+8Q/279rk3ueoUin8C0XaQMZZJ3FqEjxfNiX9P0ZoSO7bhrXbgOGCgXzRjfP8yU3g61fy6Fbzgr+pTibLjHL2nJmvmhzJkJoW23cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363798; c=relaxed/simple;
	bh=ciqAqHKZFqUwNJiT/mEjmsE0Q8QhLdWu5sXU+qXgbUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvxIh+ky5VoRwKPZDfJHbY7RpDT87AIs7NHUBr9Jha16Yhn2h5XSD7kivMIZWA8g+QuF4cXHFSE2aMh4sRwF+7l8HOc+RkTt8niXNjYaX4IjQbZXvuEJrl4+KvW/bRU8boqhEL2Ou6PCwgWwWxdmupOdRAX6or8vmrjjhygqWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4d4tHpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4d4tHpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B44F1F00893;
	Fri, 25 Sep 2026 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363796;
	bh=YTYRm/xoixV6fXMnDS8ROSQRp8DdXpSaJEUlFSgdyrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U4d4tHpXzsjaz91N51UlHo1rM8lrE1YQ0fGQZAxeaQ+QTXtIh4k8PIVPFOsntkGFs
	 qfsW/sYS0vo892ERmIteXgDQiBUrGkc+bcojeYtktwiIkDW5Ki1aZ3Muj/FCJN2OtE
	 udppRWabXQGaR65ZTA38L/mL5XulW4+NoDN5nK392vsI45d2I9XIfGEdBPKdCvx7xy
	 RLN1Q3mL2FrWPZADKe+CCoMitepCitntz6CUVvrynNTZYJH/FRD1u+cGXC1b11tVBN
	 yxD2hGbMcts8MOkFv21ifqPrmvxeq2UwkwksnsT9/UTJLhBucSVknYldessbOCfxBv
	 0ekeqdnJKiOYw==
Date: Fri, 25 Sep 2026 12:16:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kees Cook <kees@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Compile purgatory with -D__DISABLE_EXPORTS
Message-ID: <20260925191635.GC2060@quark>
References: <20260925130217.3912329-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925130217.3912329-1-arnd@kernel.org>

On Fri, Sep 25, 2026 at 03:01:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch fixed compile-time issues by setting __NO_FORTIFY
> for all of the purgatory code, but this is insufficient and still
> leaves build failures that appeared recently in linux-next:
> 
> ld.lld: error: undefined symbol: __memset
> >>> referenced by string.c
> >>>               arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memset_2)
> 
> ld.lld: error: undefined symbol: __memmove
> >>> referenced by string.c
> >>>               arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memmove_3)
> 
> Set __DISABLE_EXPORTS as well, to avoid pulling in a reference to the
> wrong string functions.
> 
> Fixes: 65cbe410d312 ("x86/purgatory: Compile purgatory with -D__NO_FORTIFY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/purgatory/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

I dropped the patch this fixes already, as I mentioned at
https://lore.kernel.org/linux-crypto/20260924174911.GA1978@sol/ .  It's
gone from linux-next now.  I think Thomas Huth is planning to send a
fixed version, together with the two patches that depend on this.

But compiling all of purgatory (and not just sha256.o as is the status
quo) with -D__NO_FORTIFY -D__DISABLE_EXPORTS sounds good to me.

Alternatively it could be just sha256.o and purgatory.o specifically.
But it seems it might as well just be all files.

- Eric

Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9961EA90;
	Thu, 19 Dec 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610899; cv=none; b=YpSUS0pnuAuHt0N0oXhXl709h88+VE+H2/a5+L7Gr4aPH8q0rbM6TYUWv1HzGAwR4Jr+7SYz+JLP5LvITXENm2LUiZUbRBKkC1puwvwuUECcChDu0WzTX0PoiLAuDBymvhiE5Opxt/yWdcRRNyO6XMNKOt/SVJoAWJJopuV2nT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610899; c=relaxed/simple;
	bh=iNqHc/hFVwreyFwmh8kRENxtTCYK9r5eoM0q1Jsqe5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CroBEfWkuwlIdqFzMgiVrQ3fF1HAhTCgkQ7N1fTvWVmlhN+D2l7KQylWngTCiQJBxCuWTPv60pdmnZjjavaQgzxCda3Nawe1xP3MZTwGfXSDW7yOm+xAqXOvnL31ZyYHO4+dMi3ElGWbv8pGUYjmd6XDYsZVacQwvUKco8+O76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XgZ/DosZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XgZ/DosZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=HyDHpVyGkyiWe5AIbIldTgJU4aH/JavV7tDiinsekbs=; t=1734610897;
	x=1735042897; b=XgZ/DosZLBROVksgGkJMbN2fqqPaqM+K8wjfH75jIgX2su1RSOp7idyXLaPej
	cw6SvTQe9tjgZEXCDmtr1Nnuj5q3Q5ULnyJwdjK8CcJohK9jcCBRFoqLaQYtQkfB0IKh/a66NtEWw
	j4Z/F9COWLnkFw40113pyF0h4u5GVYDMsBNaYi3VFqMQ2RznuEGERLsaJgDK36Ya6mT+o5R88++y9
	bZ+l+dezXy3NZQKNUUDYN2VGNff+O5k8M+j2ikWHVzirW5ysVEmbc5ov8L8SmGV9DTl/Ot0qyIzMl
	Xt7BguLyLMysyTHHOU2fBoGyo0nHMqKAK5OSu31qlJsan6KlYg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tOEsz-007vOW-12;
	Thu, 19 Dec 2024 12:40:09 +0100
Message-ID: <244ed3fd-c989-497a-853b-b8894911df9e@leemhuis.info>
Date: Thu, 19 Dec 2024 12:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: git SHA prefixes are for humans
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, regressions@lists.linux.dev,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241216012743.work.705-kees@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20241216012743.work.705-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1734610897;e86d0434;
X-HE-SMSGID: 1tOEsz-007vOW-12

Hi! Thx for picking this up!

On 16.12.24 02:27, Kees Cook wrote:
> Clarify that the preferred git SHA abbreviation length for the Fixes
> tag is 12 characters[1], as the tag is intended for humans (though, yes,
> it is parsed by machines too). Collision resolution needs to be performed
> using the parenthetical patch Subject that follows the abbreviated hash.
> [...] 
> diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
> index 1f5ab49c48a4..a0e8715c6cd3 100644
> --- a/Documentation/process/handling-regressions.rst
> +++ b/Documentation/process/handling-regressions.rst
> @@ -29,9 +29,9 @@ The important bits (aka "The TL;DR")
>      * For mailed reports, check if the reporter included a line like ``#regzbot
>        introduced: v5.13..v5.14-rc1``. If not, send a reply (with the regressions
>        list in CC) containing a paragraph like the following, which tells regzbot
> -      when the issue started to happen::
> +      when the issue started to happen, preferably with a full git SHA::

How about "when the issue started to happen using an unique identifier
understood by git like the commit-id::"?

Regzbot handles tags, too. And I guess the term "commit-id" is more
common and easier to understand for non-developers than "SHA". And in
case we ever start using SHA256 sums in the kernel that maybe can just
stay as it is.

> [...]

> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index e374b67b3277..658b489705be 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -284,7 +284,7 @@ following tag ordering scheme:
>  
>       Commit
>  
> -       abcdef012345678 ("x86/xxx: Replace foo with bar")
> +       ab0123456789 ("x86/xxx: Replace foo with bar")

Ignore the following side note, I just need to get this off my chest:

Why does that file even mention this and a lot of other stuff how to
create a proper patch description at all? We already have two documents
that explain this; a third just for one subsystem seems somewhat wrong.

But whatever. :-D

> [...]
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 1518bd57adab..efd4fb1109e9 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -163,6 +163,12 @@ An example call::
>  	$ git log -1 --pretty=fixes 54a4f0239f2e
>  	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
>  
> +Note that the "Fixes" tag, while it does get parsed by machines, is intended
> +for humans (hence the Subject portion). It is preferred that hashes remain at
> +12 characters even in the face of prefix collisions. When encountering hash
> +prefix collisions, tools (and humans) need to resolve such collisions using
> +the parenthetical patch Subject.
> +

submitting-patches.rst to my understanding and the header of that file
is the shorter of two approaches documenting how to contribute patches.
So this text should likely go to the longer one, which is
Documentation/process/5.Posting.rst. Or both, if we consider this
important enough -- but I'd say it's not.

Ciao, Thorsten

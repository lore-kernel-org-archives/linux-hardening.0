Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5710F1
	for <linux-hardening@vger.kernel.org>; Thu, 11 Dec 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765411641; cv=none; b=DChI4Rwazpcrnpya9fZx9Pezg1/UEBm1yoj9SljUQ3UaQpTZ92ADEgaGZHcuaiWTkPIvLJNAm3SpYA1k32MLcwJHTVSTu2l0qBm5QMqawlS7yPaQ6kX1UUoNC6onC9OY+A3sicbXF1zLVZWr/GAVZFztUIg6OEVZAFNdDf91eIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765411641; c=relaxed/simple;
	bh=9/DbNe6QAvsvJJOcxI5Tvzroime4dcFby/skyTKhvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ+s2Fwna7L1zA5m6mcavmyHOsh453OoAf2aAJtUHGET/9Hb5/YERHzCWolsJppY+P95G019tCPku3u1+yU66ju6C4srZRRwrtLW4G5tvNf2lp5MUUnmkoP5IazD5AE+wCMgYyDxo6bbwY2Mz1DwczexA+FbC3aDUlQS2ZVsgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB1lzYyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB1lzYyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097ADC4CEF1;
	Thu, 11 Dec 2025 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765411641;
	bh=9/DbNe6QAvsvJJOcxI5Tvzroime4dcFby/skyTKhvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB1lzYyYbVtS0HsTMkf0WThp/6exzctiZYh6z5RA589iIXJ5L2xo1p3bGaa+tnN/c
	 jVmeU9pT2k3rCT6PIOdI6Yea7n0uSXVY7Jqz+xPxoh4dqpXJ2bOiwjnLpGN/0LO5ul
	 XEbU6A4eXrymHVFVbNbaV0PSnQrhFZ98vF/nsjE72IpqCvQNik64TbzVna+QSURSaZ
	 qJIs8mZ2WdComx8+dMJ+nayqrKgPw3A0aQ86fLvfOOdNalfu4vx2YtmgofjBmae3DA
	 W7SJ501IZmpIkWxpxL9Fcd30snQbmjgvogqh1W3cE3y8zTWfujn00qCmAHVfXOr3i+
	 JIY94Ppxp3eLg==
Date: Wed, 10 Dec 2025 16:07:20 -0800
From: Kees Cook <kees@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI
 [PR107048]
Message-ID: <202512101558.C8A68633@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <875xaei2u4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xaei2u4.fsf@gentoo.org>

On Wed, Dec 10, 2025 at 06:55:31PM +0000, Sam James wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > Hi,
> >
> > This series implements[1][2] the Linux Kernel Control Flow Integrity
> > ABI, which provides a function prototype based forward edge control flow
> > integrity protection by instrumenting every indirect call to check for
> > a hash value before the target function address. If the hash at the call
> > site and the hash at the target do not match, execution will trap.
> >
> > I'm hoping we can land front- and middle-end and do architectures as
> > they also pass review. What do folks think? I'd really like to get this
> > in a position where more people can test with GCC snapshots, etc.
> 
> What's the status of this on the kernel side? Could you link me to
> patches so I can have a play?

This works already with all standard config Linux versions that support
KCFI, though prior to v6.18, you'll get a confusing "CONFIG_CFI_CLANG"
config option for it, which still works since the feature gets detected
as present in the compiler.

Regardless, here's the CONFIG_CFI_CLANG -> CONFIG_CFI renaming patch
that landed in v6.18:
https://lore.kernel.org/all/20250923213422.1105654-3-kees@kernel.org/

And a clean-ups series that also landed in v6.18 I did just to help with
my own debugging while developing GCC KCFI, which contained 2 corner case
fixes:
https://lore.kernel.org/all/20250904033217.it.414-kees@kernel.org/

So, I guess, tl;dr: if you don't want to think about it at all, use
v6.18. Prior to that, it should work as long as you aren't building
without retpolines.

> Thank you for working on this. We get a lot of requests for it and
> pressure to build the kernel with Clang for this feature.

It's been a hoot. :) Thanks for any testing you can do!

-Kees

-- 
Kees Cook

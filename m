Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721792F2619;
	Wed,  5 Nov 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347846; cv=none; b=a0DavKA7lTnfW7ynuoZxL/pmDE/F8Us4JKsD8QYZX+9KRr64lfnsm70vojRARvyGSI03oZe0144G/HkwdFaWLZxJpSp7tIErf94zEAYGQnIUyAuSnW6FA2l72XbiHf4DhP/1XWTdofPHDLR1irK6lg/Q1AHWkUOnqInO2N8rZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347846; c=relaxed/simple;
	bh=yMMEvCFvy1D/FLf8ZdEsUZE9AALFl5pwluhKlPDJ97Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCoixstqBQiN6k6Sqo82okvKMlviNXlgURLHl/ClcOd9xOzYnJt4kvQyogBFkJy9rBc01TU8bXlzxhmSPDqGRiFajJYBJdn5kz8cr7Affhl48lECbWRMXxHpBAB2IPW3VKflnsqABslJhCVGMrPDbX5h4ecoaVauUcPo7fSRQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6oGVhuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6oGVhuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C604C4CEFB;
	Wed,  5 Nov 2025 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347843;
	bh=yMMEvCFvy1D/FLf8ZdEsUZE9AALFl5pwluhKlPDJ97Y=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C6oGVhuUB1w/3E69QFhrG+4ya4gA+b/fGIculz/ZcL48cooSrZrSlxjmTQ335ouUX
	 +Q7oJNdJ+BlQa0pZ4455dhVmh1HGLXdDRyB1VuMUT/BtEARRAunHZNXLnjcPXDQDwA
	 iKLV6qkBafUcRzevKYXFgB5LugK+XDfIZBrWZdZQupHwnaRTn3RALu3lKYI0bUgL3j
	 M0eImLnm6h/lI6fqPChirCmU/VVxyOxH+OHiJDZbrmbYdvQhHTcT5YC5fpNvi9WYjI
	 5bwZZJspHV14G/HcNHBoR7AONB5C1Ek1wBcwZr5QS771esAHjjaqBFaOeSYzSztzQv
	 UYh3mSvPvq6kw==
Message-ID: <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
Date: Wed, 5 Nov 2025 14:03:59 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
To: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
 Malcolm Priestley <tvboxspy@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251010030348.it.784-kees@kernel.org>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251010030348.it.784-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2025 05.06, Kees Cook wrote:
>  v2:
>  - use static_assert instead of _Static_assert
>  - add Hans's Reviewed-by's
>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
> 
> Hi!
> 
> A long time ago we had an issue with embedded NUL bytes in MODULE_INFO
> strings[1]. While this stands out pretty strongly when you look at the
> code, and we can't do anything about a binary module that just plain lies,
> we never actually implemented the trivial compile-time check needed to
> detect it.
> 
> Add this check (and fix 2 instances of needless trailing semicolons that
> this change exposed).
> 
> Note that these patches were produced as part of another LLM exercise.
> This time I wanted to try "what happens if I ask an LLM to go read
> a specific LWN article and write a patch based on a discussion?" It
> pretty effortlessly chose and implemented a suggested solution, tested
> the change, and fixed new build warnings in the process.
> 
> Since this was a relatively short session, here's an overview of the
> prompts involved as I guided it through a clean change and tried to see
> how it would reason about static_assert vs _Static_assert. (It wanted
> to use what was most common, not what was the current style -- we may
> want to update the comment above the static_assert macro to suggest
> using _Static_assert directly these days...)
> 
>   I want to fix a weakness in the module info strings. Read about it
>   here: https://lwn.net/Articles/82305/
> 
>   Since it's only "info" that we need to check, can you reduce the checks
>   to just that instead of all the other stuff?
> 
>   I think the change to the comment is redundent, and that should be
>   in a commit log instead. Let's just keep the change to the static assert.
> 
>   Is "static_assert" the idiomatic way to use a static assert in this
>   code base? I've seen _Static_assert used sometimes.
> 
>   What's the difference between the two?
> 
>   Does Linux use C11 by default now?
> 
>   Then let's not use the wrapper any more.
> 
>   Do an "allmodconfig all -s" build to verify this works for all modules
>   in the kernel.
> 
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lwn.net/Articles/82305/
> 
> Kees Cook (3):
>   media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
>   media: radio: si470x: Fix DRIVER_AUTHOR macro definition
>   module: Add compile-time check for embedded NUL characters
> 
>  include/linux/moduleparam.h                   |  3 +++
>  drivers/media/radio/si470x/radio-si470x-i2c.c |  2 +-
>  drivers/media/usb/dvb-usb-v2/lmedm04.c        | 12 ++++++------
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

I have also tested a build of v6.18-rc3 + patches using allmodconfig:

Tested-by: Daniel Gomez <da.gomez@samsung.com>


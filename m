Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9883AA1AB;
	Tue, 11 Nov 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864502; cv=none; b=CWoWcbufpy4l6zRYIO4E4xwRYIJrNv/CfQiaIbmCUOeZbQgYzXhdD+ZeZUZlmxl2Zt2FLhlJcSAEb5JMai7o8/uaCDYVCGYcpooiETahgBEPE89Q6jeXvN5A0Q5ekhWcSTOlW3j52EWbPX4hXesEKioLM4MH7O05pRNfXF4IR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864502; c=relaxed/simple;
	bh=P9kSJYPFha9VBnjvxXS0Y2nT53KXisQsU5JE1jGqHp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0/qGOFIxkkHWTpZscK9pwDSxdbSM5/iFHo07gwbdGDtCR0BCtMxMegWJAvEasr7onEEWJK3KjN4N+O8ZHnoS5OyGUv0vBWIyl5PgbjSGJR5JikxH/zZk41W+fxCtegqrRVV9TKQR2kpCYJWPuq1QGACqMsvzJJtkqrqB5EFnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e955swYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e955swYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93172C19425;
	Tue, 11 Nov 2025 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762864501;
	bh=P9kSJYPFha9VBnjvxXS0Y2nT53KXisQsU5JE1jGqHp0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e955swYiMNNYCa7VwRQlSOyFTTfCDSmSdI6bJgsUoU2yhrRFa1DdQu4RLICy+kYem
	 sjrHJxwqY1uaIzocJnJFb5g0XGYJ4O9VQHKAHILWdLsFXBhZqgtuVDdw4WRqGAHOKB
	 KOP4i2enGCjielpqLssCrG3oDgBHvsmlqYXEEe2jl7Ie1ThdZrmCbaH+5dJekpgWaP
	 KKWTRYegj4o6a+C6hZoP5pfbfdk4JQKTFeVdwO02CEFo0a9WiiuzTozni/Oqzas7+p
	 mHGLn4/d2ArGJ6y19mT0BBdwY3lTqIUlxKKM2iT04fITVrZGeTJEJyDtui736jtK98
	 ZCobIORO1MfTA==
Message-ID: <ded3ba14-d2d8-40be-8c0c-d41c4307347c@kernel.org>
Date: Tue, 11 Nov 2025 13:34:56 +0100
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
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Malcolm Priestley <tvboxspy@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251010030348.it.784-kees@kernel.org>
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
 <aRMhLEs9NpGexL7B@black.igk.intel.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <aRMhLEs9NpGexL7B@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 12.42, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 02:03:59PM +0100, Daniel Gomez wrote:
>> On 10/10/2025 05.06, Kees Cook wrote:
>>>  v2:
>>>  - use static_assert instead of _Static_assert
>>>  - add Hans's Reviewed-by's
>>>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
>>>
>>> Hi!
>>>
>>> A long time ago we had an issue with embedded NUL bytes in MODULE_INFO
>>> strings[1]. While this stands out pretty strongly when you look at the
>>> code, and we can't do anything about a binary module that just plain lies,
>>> we never actually implemented the trivial compile-time check needed to
>>> detect it.
>>>
>>> Add this check (and fix 2 instances of needless trailing semicolons that
>>> this change exposed).
>>>
>>> Note that these patches were produced as part of another LLM exercise.
>>> This time I wanted to try "what happens if I ask an LLM to go read
>>> a specific LWN article and write a patch based on a discussion?" It
>>> pretty effortlessly chose and implemented a suggested solution, tested
>>> the change, and fixed new build warnings in the process.
>>>
>>> Since this was a relatively short session, here's an overview of the
>>> prompts involved as I guided it through a clean change and tried to see
>>> how it would reason about static_assert vs _Static_assert. (It wanted
>>> to use what was most common, not what was the current style -- we may
>>> want to update the comment above the static_assert macro to suggest
>>> using _Static_assert directly these days...)
>>>
>>>   I want to fix a weakness in the module info strings. Read about it
>>>   here: https://lwn.net/Articles/82305/
>>>
>>>   Since it's only "info" that we need to check, can you reduce the checks
>>>   to just that instead of all the other stuff?
>>>
>>>   I think the change to the comment is redundent, and that should be
>>>   in a commit log instead. Let's just keep the change to the static assert.
>>>
>>>   Is "static_assert" the idiomatic way to use a static assert in this
>>>   code base? I've seen _Static_assert used sometimes.
>>>
>>>   What's the difference between the two?
>>>
>>>   Does Linux use C11 by default now?
>>>
>>>   Then let's not use the wrapper any more.
>>>
>>>   Do an "allmodconfig all -s" build to verify this works for all modules
>>>   in the kernel.
>>>
>>>
>>> Thanks!
>>>
>>> -Kees
>>>
>>> [1] https://lwn.net/Articles/82305/
>>>
>>> Kees Cook (3):
>>>   media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
>>>   media: radio: si470x: Fix DRIVER_AUTHOR macro definition
>>>   module: Add compile-time check for embedded NUL characters
>>>
>>>  include/linux/moduleparam.h                   |  3 +++
>>>  drivers/media/radio/si470x/radio-si470x-i2c.c |  2 +-
>>>  drivers/media/usb/dvb-usb-v2/lmedm04.c        | 12 ++++++------
>>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>
>> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
>>
>> I have also tested a build of v6.18-rc3 + patches using allmodconfig:
>>
>> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> 
> Folks, are you aware that this change blown up the sparse?
> Now there is a "bad constant expression" to each MODULE_*() macro line.

Thanks for the heads up.

I can see this thread:

https://lore.kernel.org/all/D1CBCBE2-3A54-410A-B15C-F1C621F9F56B@kernel.org/#t

And this:

https://lore.kernel.org/linux-sparse/CACePvbVG2KrGQq4cNKV=wbO5h=jp3M0RO1SdfX8kV4OukjPG8A@mail.gmail.com/T/#t

> 
> Nice that Uwe is in the Cc list, so IIRC he is Debian maintainer for sparse
> and perhaps has an influence to it to some extent.
> 

Would it be better approach to postpone patch 3 from Kent until sparse is fixed?

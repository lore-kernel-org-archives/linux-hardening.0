Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2F31194A;
	Wed,  5 Nov 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348018; cv=none; b=mo6TEMrxldmVW5lOSv90+nsQ1Rf8FJIphIlezwfcWzVIEZnVbB+kZ/aXy0HK47mX68En7awrz/AljCi4XDZcCYKXZnF51iPnJ77rltLgS6ehj1v+FMF0EaWqCFAqvYQz8hzCcRLtQXAf/9r2gtdZcMYW/12wDeTZVafEQvus6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348018; c=relaxed/simple;
	bh=+4Rmh2jH7v1L2uybiPV4dfANf4BcCWtayRUUahK4lMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sKP0CJmLF0Ry8FKCo/QRNCIM30lDo4VcGBNenqJXH3XKiBljIyx9L8dbWuUeC8/6vjcHXDvEakvWpDfgGiaT3SYnVn2v37PZDqS5tTpkHjQPTxeeOUNIkkfbBAecYT26Jqt9+s/IRRpJXzJm8soYLApRjEaRF9xO/oTsNXwwqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn2d8oD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn2d8oD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E63C4CEF8;
	Wed,  5 Nov 2025 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348017;
	bh=+4Rmh2jH7v1L2uybiPV4dfANf4BcCWtayRUUahK4lMk=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dn2d8oD6bd93AVreTu0LVIICEpyh+MDa/JReOd1Co4xlVBdEO6R1ryIVsGiLgQdzI
	 p7OrF5YQKY4ARvb3puan527xw6BCxZ5X6r0pnfBZbslRNEGE+Smg5utXF88YmkxOoh
	 sllLe+/2zsGa4ff0IWf6rFBETcwJM6yFOHPeQjPfJXEeWkcxt5SBx5ePzWIKlda/TG
	 9fr5FZqdkO1S8cWPf1QIc59XwEsXPeW6aSq19yfjVMx54LfN4UpX6Oug0QGrfC8WG5
	 NBlqUDVwHIscpUeJi4tNJC9lATMsHiDL9Awut0DajibDwm7ba9IDF13SQusJ0qj6NU
	 q5/bCIf4p0lkg==
Message-ID: <bc1fe0a9-a034-45f2-9633-a0ccadce60b3@kernel.org>
Date: Wed, 5 Nov 2025 14:06:53 +0100
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
From: Daniel Gomez <da.gomez@kernel.org>
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
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/11/2025 14.03, Daniel Gomez wrote:
> On 10/10/2025 05.06, Kees Cook wrote:
>>  v2:
>>  - use static_assert instead of _Static_assert
>>  - add Hans's Reviewed-by's
>>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
>>
>> Hi!
>>
>> A long time ago we had an issue with embedded NUL bytes in MODULE_INFO
>> strings[1]. While this stands out pretty strongly when you look at the
>> code, and we can't do anything about a binary module that just plain lies,
>> we never actually implemented the trivial compile-time check needed to
>> detect it.
>>
>> Add this check (and fix 2 instances of needless trailing semicolons that
>> this change exposed).
>>
>> Note that these patches were produced as part of another LLM exercise.
>> This time I wanted to try "what happens if I ask an LLM to go read
>> a specific LWN article and write a patch based on a discussion?" It
>> pretty effortlessly chose and implemented a suggested solution, tested
>> the change, and fixed new build warnings in the process.
>>
>> Since this was a relatively short session, here's an overview of the
>> prompts involved as I guided it through a clean change and tried to see
>> how it would reason about static_assert vs _Static_assert. (It wanted
>> to use what was most common, not what was the current style -- we may
>> want to update the comment above the static_assert macro to suggest
>> using _Static_assert directly these days...)
>>
>>   I want to fix a weakness in the module info strings. Read about it
>>   here: https://lwn.net/Articles/82305/
>>
>>   Since it's only "info" that we need to check, can you reduce the checks
>>   to just that instead of all the other stuff?
>>
>>   I think the change to the comment is redundent, and that should be
>>   in a commit log instead. Let's just keep the change to the static assert.
>>
>>   Is "static_assert" the idiomatic way to use a static assert in this
>>   code base? I've seen _Static_assert used sometimes.
>>
>>   What's the difference between the two?
>>
>>   Does Linux use C11 by default now?
>>
>>   Then let's not use the wrapper any more.
>>
>>   Do an "allmodconfig all -s" build to verify this works for all modules
>>   in the kernel.
>>
>>
>> Thanks!
>>
>> -Kees
>>
>> [1] https://lwn.net/Articles/82305/
>>
>> Kees Cook (3):
>>   media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
>>   media: radio: si470x: Fix DRIVER_AUTHOR macro definition
>>   module: Add compile-time check for embedded NUL characters
>>
>>  include/linux/moduleparam.h                   |  3 +++
>>  drivers/media/radio/si470x/radio-si470x-i2c.c |  2 +-
>>  drivers/media/usb/dvb-usb-v2/lmedm04.c        | 12 ++++++------
>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>
> 
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> 
> I have also tested a build of v6.18-rc3 + patches using allmodconfig:
> 
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> 

I forgot to mention it required the following patch for the build to succeed:

dmaengine: mmp_pdma: fix DMA mask handling

https://lore.kernel.org/all/176061935426.510550.684278188506408313.b4-ty@kernel.org/

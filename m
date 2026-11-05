Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892075;
	b=HlXJf6AIxv2YmSvwTWT/gpiNggj6nEah/XVJ0dgYArkf/EIa9jQOaZ1fPlW9n9meAI/y
	 vdEJ55+1g7TQIW1OXB0PSCaw3rrx75QH6mToNgQ/Tue7BIzF/p29CBa70QP3cbDqh9aW1
	 5PcYANuBeT8MqnML4hyWW6gD+V62YCDxzPuwYwE9DE5N3mRrT3Gqr9CVK+YzhaZFzN40S
	 EQtHoCnIfQEkNs9qDUABc8ZSUsgTzm/tmOXY/9Q+YxAOEwqhTRAlSrRNlASsM57Hce+Q0
	 CLr+Pc9MXUkHICyM13VZ3PJbI0Tf5spw0uWObhVz3SmzJsGn8YVx4Bt3ggYJ6eYMx7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892075;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:List-Id:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NzjDcogdjGLC/Z3rU4KyBTyFDp1K6wM2WbeYqpBBZB8=;
	b=LvfpEQgBT1SwxkieSxgQcFETyu5c+ndWw9d6gCFyXOmEQLK91DilWvUyOg0o1EA9AtQ4
	 K01aoyaoFdQlJGSnuEskFtCSZXCGCLdiIyQt2qePllMw7I0QKdTuyRS/zE3UaB0UuBFAO
	 lQLf71wRTbZtqn7cSMfI/r2Gbze6zvClI/wauKlBdP/BHvLgpJ1hswG5YZSntCmUGY3P3
	 t5bWgVG9nwuP1If3tVjypNwjkr2ptl0y40F3h61l4yNqyReuzX30VDx3CXZ/NbPR+lgeV
	 btcvnR4jhuk65TdekTqOOMB4UZtzgNqy2OahQE0yI9n+u1vL/GomXl9QFZTzlOFO3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPtiiDW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7597606A32D;
	Thu,  5 Nov 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPtiiDW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8BA1F000C1;
	Thu,  5 Nov 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892074;
	bh=NzjDcogdjGLC/Z3rU4KyBTyFDp1K6wM2WbeYqpBBZB8=;
	h=Date:Subject:List-Id:To:Cc:References:From:In-Reply-To;
	b=gPtiiDW7VtcwOZuPjL74NRmVyBGWaOGiWCF3GFXluwlU0ZxlvNe+cQJokH6UkM7tA
	 3qDv2ZKXsX+7KWH/6JY+NDNNht/+GEjiUinSV2dYzxUzsHYE05Vz0+YfMsGu+LZ9pv
	 I6SwbzEc4tJSGd+Gu4v73xaU+3hCQ12Oey1rYlZhLCwAJcDBwfr8IobWu62rMt261t
	 X8lkbvN2XIooPjgUCA/W1j2wL+CCU0D9Wmu4DDAvCWUeXiRwv+qjKbIOwdU4WyhYFF
	 bjQoLlzYSg3gb+rEh7JGgMZJID6QbmAg1XYlDMu0SDOhed5UtIPWg1OvWMGqiYyn7m
	 gmgLFOu+PzFUA==
Message-ID: <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>
Date: Thu, 5 Nov 2026 16:21:02 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
To: Alejandro Colomar <alx+linux-hardening@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>,
 Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Saravana Kannan <saravanak@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <auyOkL1Vb1iKicS9@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2026 15:16, Alejandro Colomar wrote:
> Hi Bart,
> 
>> Date: 2026-11-05 15:01:22+0100
>> From: Bartosz Golaszewski <brgl@kernel.org>
>>
> [...]
>>
>> I have no idea what causes it but I'm getting so many patches lately
>> that are subsequent iterations of a series sent with In-Reply-To: header
>> pointing to a previous thread.
> 
> I don't know what others do, but in my case it's a conscious manual
> action.  I use --in-reply-to in git-format-patch(1) to make all
> revisions of patch sets be descendants of the cover letter of v1.
> 
> We do this in the Linux man-pages, as it helps me keep track of all
> revisions of a patch set easily in mutt(1), without having to follow
> links or use more-complex tools like b4(1).

My mailbox gets 200-300 patches per day (not counting replies), so I
have no idea how that could be manageable if all versions of some series
were threaded to itself. Some old thread popping up to the top,
half-read, deeply nested like 20-deep indentation?

But even in second workflow, reviewing individual patches via b4 or mutt
after shazaming (my main workflow of DT) not via inbox, would get huge
irrelevant thread of past discussions requiring me to look for stuff
actually for the review. How to find actual patch to review in this huge
thread? I tried many times, takes much more time than reviewing simply
current version.

b4 is not so more complex, honestly it's just new interface and after
learning a few new commands is straightforward and easy. And solves
successfully, without creating noise or problems to others, all problems
which you might be trying to solve: referencing earlier versions, easy
comparing between any version, collecting trailers, sending nice
thank-you letters with commit and tree references etc.

I believe there should be no excuse for modern maintainer to not use b4
in the workflow. The same BTW for submitters of anything bigger than
3-patch series.

And for maintainers, along with `b4 review tui` above statement will
only grow.

Final note, you will receive template-nags from several maintainers if
you keep send them series threaded to past versions, but of course there
are also folks who are fine with that.


Best regards,
Krzysztof

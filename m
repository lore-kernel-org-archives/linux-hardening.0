Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722223184F;
	Wed, 30 Apr 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006845; cv=none; b=kkFmZ91BAK9cp/WBZdKIOuV9rWFo36irjpnBtnLS0F5OTcOdSvnMowSjQGGKeM79fP83KPTH+jfp/uIgRc2w3M2uE3JEL8ssHLgn7z+l1F4/LTMHhOjQpFGjc+D4PzsAApvnrfLLXcb1b8nBobr9k9lW4ghvFuwGk62efpSw0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006845; c=relaxed/simple;
	bh=r06vbbdYSeyDhKUVj0TSgJTSH4wivO5RW6Zk56/fEZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6HO6bZuwBFMoqSwBIxnyMQW3OAb3ig79v+NbDG7oCqFRmEJwtGud4B5wcGy6sZHmcn0a8XVVvUrrWn004FLb8aj8uAOb5hq47rmfvuoRFykEgn2J8b4K2s9orATMEl4GRLcYCwNCRAfO9vlEYrOMDded8/C5YSwxB8JoOvbxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f0CXsBPi; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f0CXsBPi"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A039B5850FF;
	Wed, 30 Apr 2025 09:33:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4642B4331A;
	Wed, 30 Apr 2025 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746005625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ8rQQEEj/pGpG4T8FIv47iidj+XTjL64Au76KsPOSU=;
	b=f0CXsBPiFX0HawPxuZE3wtGbYmyChyVKoPw2z9vegzKah9s0+NLUYqCaq+xi5Gmtk2NNGg
	BvZwvqWageoMCQpSEXLqf54axgiVZ4TeucppIJadSb1ZbfFmlIxAGOquuB6N/R3n+eW3zh
	vTG4wD6Iev39dfna3+P35FZtbQ6pSUyhz58CdgZToR0FTNrC0DfGi3SFQVEVxQzFi/YpHG
	ZcYcSTLTEPzwk5ouKXNScKIhZu7OzP5kgFUg9rFatsDKh1JUatY2rWC3AJyj2BjQQoiwmr
	eOVGXTQ/1srPsbwyuXV3UbD17wQtq7nKx6cjxxssTXZlgZaxB/y2jBUSKPnijA==
Message-ID: <752fb7bc-8666-4912-aac1-9778f8779067@bootlin.com>
Date: Wed, 30 Apr 2025 11:33:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] pinctrl: remove extern specifier for functions
 in machine.h
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, linux-hardening@vger.kernel.org
References: <20250429-aaeon-up-board-pinctrl-support-v4-0-b3fffc11417d@bootlin.com>
 <20250429-aaeon-up-board-pinctrl-support-v4-2-b3fffc11417d@bootlin.com>
 <CAHp75VcRYE6meHB9+MhcH242eXbA0jzYXhL-+WidvvLXiLX=MQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <CAHp75VcRYE6meHB9+MhcH242eXbA0jzYXhL-+WidvvLXiLX=MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeifeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhhohhmrghsucftihgthhgrrhguuceothhhohhmrghsrdhrihgthhgrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehudehuddvgfdvfeetgffgleeuveejgfejtdehkeetheevheevgedujefgvddtteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegutgekudemrggrugdtmehfuggtrgemtggtudgrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegutgekudemrggrugdtmehfuggtrgemtggtudgrpdhhvghloheplgfkrfggieemvdgrtddumegtsgdugeemheehieemjegrtddtmegutgekudemrggrugdtmehfuggtrgemtggtudgrngdpmhgrihhlfhhrohhmpehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghro
 hdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: thomas.richard@bootlin.com

On 4/29/25 21:49, Andy Shevchenko wrote:
> On Tue, Apr 29, 2025 at 5:08 PM Thomas Richard
> <thomas.richard@bootlin.com> wrote:
>>
>> Extern is the default specifier for a function, no need to define it.
> 
> Suggested-by ?
Oh yes, sorry about that. And also for patch 11/12.

Regards,

Thomas

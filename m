Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7C2DEA9C;
	Tue,  8 Jul 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986151; cv=none; b=Z1LifgGRkExWghvDq7vN/1NRIkjtcs1v9MQh5e8oytMYIY7j3SGsQVMGHkg+uZMYlI2R3mjgD9Zmf4RLkAgcX8MQFSio7n7Alroh8ehIYSyBWr+OQZoOTJUz5qs5NsNV1h3DBO3/HyDb24vIbwzdzslrgRe/tMd91ObT8zd345k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986151; c=relaxed/simple;
	bh=s6+ijH8T2ivYj6DmS7Raj2ccV8f0pTktqIvZlSEBCcU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rzmUJQGxFcvcAiBIRzrY3Yf1MvRHh7OkuxUf4lcGLAgnOvoJ5STqmlj+RTArEoZg8x0Xqcv7Fhq9NW28bqxEY9r35rHtmeK9fgR39H8kNt94IS6eKcApLULVsJtlC+wWw03TAReXtpEM0zSCScbZ7s5Ep38uUcIjpe/5UWrmzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JEkuu8Zd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtX4vtSx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JEkuu8Zd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtX4vtSx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 39375EC02B4;
	Tue,  8 Jul 2025 10:49:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 10:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751986148;
	 x=1752072548; bh=/WBSkyzsjblPqMc6jAKsnf4HWuKydEDDpsElennMUhQ=; b=
	JEkuu8ZdBG7Jp8AslcSD8Pax+tCLla1vuxj8EmVQaqmUDsQaQmqY7u63R/hwU08Q
	G9Bk2A+youfDFKYDUE0++68bdcZHUkOEToNxqyPaBuR6sW006PPoYDmIIz9YOYKo
	mUBmAdi0ZK/oVFmoa6k9M/nBxe40cDYJdBbAhdJhBCeJ+LaLJfEOd8M1WecPUqVv
	1+f0iTyZFbdhUgn3Yl4xHzEMgSuWBbU9BBajMteSGZRfEjEoya4HtrIdb5YekINH
	+MsuaTEkD2HUEIRX/LEwMwDAaue4tn7hBBWClQUCJXTp8ihkYtaKE9BjBr9VjEtf
	hyp3Ad8LwjnH5iydhz60Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751986148; x=
	1752072548; bh=/WBSkyzsjblPqMc6jAKsnf4HWuKydEDDpsElennMUhQ=; b=j
	tX4vtSxGTGz3DxtJMP7QsUE+ZMLvd4u08ZOBQ0TuadUBliq68pzEPWwOSCkVg8ZS
	SOaquOPySFEQV+2gDetrGsAXE3yqqKp9Xwp4PXJg0+vlgVmbEdJb4XVbFOb8q8NZ
	CtMHKpssgIsWuLMn17ukK/8F2A3WsaA5y11V9/uekcEc69Yh4ZNRkDTun+ytksI2
	ogWjxwj+5JU/7XcZ4T5Mzzw4AXdfTzJLLvHy0XGhTvxKvKxdDBamUuq+ZDPsVurL
	j83u40/71gw3jCYCjw9tmYUFM9msmz4gc3mYoi1j86NlJfnMo8Ji4R6288IODsc6
	PDgo2+XHgNJUJWK9bgO8w==
X-ME-Sender: <xms:4y9taMOcZovW-v17QXEj06NfpHripHLbbKZ44XoK4qz6OhiPT22gUA>
    <xme:4y9taC8NQnGZWda2-ZxLxsbzYn02L5AcArHoijNRePdNhPsOnMgjIHuF_z2rCqkC6
    T5LVpHiY1rCyckF4S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtg
    hpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegurghv
    ihgughhofiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhi
    nhgrrhhordhorhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhroh
    hnihigrdguvg
X-ME-Proxy: <xmx:4y9taMoo_EbKL_GGNdG6DIiu0Oq7xNSY8SwzuVT6QkaYAvF4xMHimw>
    <xmx:5C9taAK9KAZBuFJrbnGsav3lNIYKsRyluUdJ1URmuB8fcXejJj_bAA>
    <xmx:5C9taD05xtCLM5vPGnxci6gUKRzCmLQKvV2TiTkzEvnUREKo-TMPnQ>
    <xmx:5C9taJV6hm0iymefq4vfY263mDLR-OFDCItiy9E7upk2hqODCYJdiw>
    <xmx:5C9taKMUAeuc7XRbN7wUZVxeLDZhF-zDHUlo6xC9l51Vvm8wvL_VWAak>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9CE5700065; Tue,  8 Jul 2025 10:49:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3edb9637e006aa12
Date: Tue, 08 Jul 2025 16:48:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Petr Mladek" <pmladek@suse.com>, "Nathan Chancellor" <nathan@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "John Ogness" <john.ogness@linutronix.de>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David Gow" <davidgow@google.com>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-Id: <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
In-Reply-To: <aG0qLaeAoTGaRs0n@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com> <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 8, 2025, at 16:24, Petr Mladek wrote:
> On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
>> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
>
> Thanks a lot for the nice report.
>
> The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:
>
> #ifdef CONFIG_CPUMASK_OFFSTACK
> typedef struct cpumask *cpumask_var_t;
> #else
> typedef struct cpumask cpumask_var_t[1];
> #endif /* CONFIG_CPUMASK_OFFSTACK */
>
> And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
> is a pointer.
>
> I am going to solve this by adding a wrapper over free_cpumask_var()
> which would work with a pointer to cpumask_var_t.

I'm not familiar enough with the cleanup mechanism of kunit,
but can't you just move the mask allocation outside of
test_readerwriter()?

> + */
> +static void prbtest_free_cpumask_var(cpumask_var_t *mask)
> +{
> +	free_cpumask_var(*mask);
> +}

Or you could pass this as a cpumask_t pointer instead,
which should do the right thing without the indirection.
> 
>  	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
> -	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
> +	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, &test_cpus);

In my original version, I did not have the
KUNIT_ASSERT_TRUE() here, which seems sufficient since this
is not what you are testing at all, and in normal systems
this would just be a stack variable.

    Arnd

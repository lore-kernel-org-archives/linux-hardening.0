Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428821CC56;
	Thu, 10 Jul 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156530; cv=none; b=M8Qq7wojs+pHV4ZeHn+Nj6Zl5fTOAZlE8E2H+EZH7Ydetjjer3SMGBTr3UFSeKJkgoR9hJCn5WZehQIybieMr+VHIu3w+oHZllojoQnszxH+T4f0EQpm7MBw4SiPeV51/z9kjMcreVd1B6qt3yewQNmlG6qC6LxKI3whrkGP92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156530; c=relaxed/simple;
	bh=LdHW4scnqsHfJNi+z+aY+QuwZS4odaeHwwcp4ZccYOI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qE2UXm73Sw6kZX6P0XDeeVMwPVPIH27o77KZ2Ayo3P4LH54H8FxWEtC3iurhvGPIbcyB3ITaC7pKlkyUlUYcamLD6jJTXIZ/EbRZKO4oYIMa0BtKmGbOjrikTNu4ypxcRo/I8DzxiwkfBN0SnOewh7QY+QpE2o78h5HhF6URuc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y903VsOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQzyFSLx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y903VsOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQzyFSLx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD3B814001A8;
	Thu, 10 Jul 2025 10:08:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 10:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752156526;
	 x=1752242926; bh=FD2YBdD1KzfifETLS+nVTFe4fJmG+2JdL6R1J8FFS6o=; b=
	Y903VsOnwv+176MRUk6jsxMR738xAvC5TcoOZ8NCaZzhnBpNgQ1MnkzIbqMzijen
	zaFMitpHfvh4czekVzl8ApXfo/MhZYfGD6DGOlVei/7m+75PzICKbLPYBFeFof/Q
	LR5zJubB5w8q/IExjJBFFrB5CzJ5b5cDFsLkRHdgqmeRpziz6G8o4UWW0P7rwQ1X
	IWm8NP3bcsUqgDEJFtm7GMjNNztdz+ZTl3i2NmROGx0mSIWDt5/9J08eNwwt3/Wx
	reaRgQ2APLexzoj8LfZAL7NcqwKgoncFm7juPt3V1zPKh3HS25j4cOq3ETjyRABE
	VCN6UdOu0qisQgIITdJgqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752156526; x=
	1752242926; bh=FD2YBdD1KzfifETLS+nVTFe4fJmG+2JdL6R1J8FFS6o=; b=A
	QzyFSLxpb6oSzGTsBGGI2o3Hf+4zjCzGrxjx8V9DN3I/66w4627JPJvJJvwC+jNO
	AYNhh/Yp6tGL+xATfdMfbBgmJBDmqum/DXKEmSEqethYmsNlKdAagbLYQrGbRGEI
	hJVLvj6eQKggoBq8Wql4Dki0iQzHXi+ZKk8qTL+AOWRleMxTMGxcgrZ7d8gFaew0
	6ZswismGCrxH3d4JdYSETA/lsV4ewzQRuXEFmzy0fiCV1zQWBy+SMlyetELv0K/E
	l32wRq+SYt2sgtK5ELvOXY7hG/mvzB69ZFPminDz7MIKSVEwRVFF/b8noOXE3VO5
	FVDkCISLfPl8sdEhWD0HA==
X-ME-Sender: <xms:bslvaNHn7wyivYI_Dd68vCMyTFVR3MB2zta4GT5RHZftN_LSpTaKnA>
    <xme:bslvaCWWDUe5nATP8UA922dWiUpiqN2udN95k3Q2FwpVcdXeQHUeqaMUSfEM3z9T_
    Qn4QOkFeJp9yojii3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
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
X-ME-Proxy: <xmx:bslvaDjMeaZUEVuywSx3TVctqkAqtW6-IDqxQrxgKruY_6G5S1LCsw>
    <xmx:bslvaNgm5Jxil1AzUGLA8nW0gPbZj_y5i9NUU3Il644ub9TmMGmlIg>
    <xmx:bslvaFuN8ITYO7sK-qA8Y6LT7eZ6ji0zhARCmp91pWJiAuGGm8wScQ>
    <xmx:bslvaFs_x7qt2gVFgSPxcww14lCNygtAB2oAkLoex6gyPvBAEcjcDQ>
    <xmx:bslvaBH0JGduiDhw5p6EpF2aiGSgVlVYn8SZuhfCLpjcjEPF-Sp0EVXz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36534700065; Thu, 10 Jul 2025 10:08:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3edb9637e006aa12
Date: Thu, 10 Jul 2025 16:08:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Petr Mladek" <pmladek@suse.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Nathan Chancellor" <nathan@kernel.org>,
 "John Ogness" <john.ogness@linutronix.de>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David Gow" <davidgow@google.com>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-Id: <85b5d75c-8c89-4687-b3ac-3041c1f109be@app.fastmail.com>
In-Reply-To: <aG_FbyF2HujeHfcw@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com> <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
 <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
 <aG5ULpdSoAR6nF5R@pathway.suse.cz>
 <20250709144706-efda2e7c-c3e4-4905-91ad-7553c46ed2e2@linutronix.de>
 <aG_FbyF2HujeHfcw@pathway.suse.cz>
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025, at 15:51, Petr Mladek wrote:
> On Wed 2025-07-09 14:53:29, Thomas Wei=C3=9Fschuh wrote:
>> On Wed, Jul 09, 2025 at 01:36:14PM +0200, Petr Mladek wrote:
>> if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK)) {
>> 	err =3D kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, tes=
t_cpus);
>> 	KUNIT_ASSERT_EQ(test, err, 0);
>> }
>
> It is likely a matter of taste but I like this idea. It looks better
> than passing an invalid pointer and hope nobody would do anything
> with it.
>
> The only problem is that
>
>     if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK)) {
>
> did not prevented the compiler warning. I guess that the code was still
> compiled and later just optimized out.

Right, gcc does some of the warnings after dead code eliminations
and some before. clang tries to do all warnings before eliminating
dead code, so you still lose.

> /*
>  * A cast would be needed for the clean up action when the cpumask was=20
> on stack.
>  * Also it would leak the stack address to the cleanup thread.
>  * And alloc_cpu_mask() and free_cpumask_var() would do nothing anyway.
>  */
> #ifdef CONFIG_CPUMASK_OFFSTACK
> KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var,=20
> cpumask_var_t);
>
> static void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *m=
ask)
> {
> 	int err;
>
> 	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(mask, GFP_KERNEL));
> 	err =3D kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, *mas=
k);
> 	KUNIT_ASSERT_EQ(test, err, 0);
> }
> #else
> static inline
> void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *mask) {}
> #endif
>
> which will be called in test_readerwriter().

Looks fine to me

> It seems to work, ..., sigh. I did not expect so many troubles with
> a tiny detail.

I wonder if just making the cpumask_t 'static' would still be
simpler, given that there are no concurrent callers.

    Arnd

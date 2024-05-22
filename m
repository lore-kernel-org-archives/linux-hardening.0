Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B0148314;
	Wed, 22 May 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406124; cv=none; b=KJhOUJ9qTpRs4goPOi8kHcbRzeuFs7s2etDBpYhjGhkZyMyumBvuGhfUSC921u2xzbDOKiMnAgX0aVZaWISuuJhsRxwIvtg3einy3isBtWSeXqBPHOmY3FwRLFR9CPBRYxS72ZBKLmoMpzYSiVEajQBvrbWfGRWSCX8Rvt02tYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406124; c=relaxed/simple;
	bh=+HIgq/76YrSpoSHZQMGZD7wasDol7pRR2YrI24eJaRc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PyXN4BJ0Lcen6v6UYXhRhtXUZlyrzzocA7uw0aAbCP/VIaQC0Jb4na3BcrOzljk63lU7YKMO88NaU9X20AVKBw/sHSxGOQVitHGEa3w8taw3p1Xp+EkNLkkgsiyIV+hXBuJBxo1HEDdTGjKIb9eOAP+FP307CjocwZhwXKBXeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ODVAjdMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIN/Ok6A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ODVAjdMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIN/Ok6A"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6DF1C13800E5;
	Wed, 22 May 2024 15:28:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 22 May 2024 15:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716406121; x=1716492521; bh=pllOxeaFWD
	cR8Doa6DvpzS5mFzmOse3mS7XlUVEkPaQ=; b=ODVAjdMFooUC6RtWgQ05G4aIno
	CjqNq4EzzPwn4EyzyXNNKhAs7pWzoHJDlCixeY+2KjImjXwmNpiSdhbo8cULcl+S
	Fcep/k2NS7uz5gcu4FTHYvRvYjm8FH2MPdTjgBwucpByTRUrsvSrb5UmilHrkOqT
	uZN3zoMP3G65tb4lu7+nZyFd8tKNmt5TvNlULbUFOYWYuVGRrW698TjxJUkYkPIQ
	uaZu2EWfxDmbzgsIjPFiPNLb6sDqNXqeQvsybzyd/tKLhNostdt0F9vPWtv6fQRL
	yPFlMCVsrpcSE78kfQPqhPT+RJGuMW3EJdUg0JKW0jh/Tty/qvyZ3I4JZgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716406121; x=1716492521; bh=pllOxeaFWDcR8Doa6DvpzS5mFzmO
	se3mS7XlUVEkPaQ=; b=JIN/Ok6AyH+phSgmoWwBUTlMMrIgFd5BF2l37ZVfKd1m
	68BoX727+72560uwvRkkyhMqihkFCRF6pBko8hDe8btk1MtzaY1to+r7jdSfrOgt
	NyEa1rDXeAnQJlWzWBEaxdie7q2cpSyyFKp+30W0o9XAU/9pbR/aXlVS1wXe9/Po
	85XjJQtNtAdg4/CgWWbSFVTksGzt3FFR6xGpwO0hDMVWPHZUycyQXD3Fc9TNEM1x
	nytgae0skluwJj736YRCvn5lY7pgHhIvp2StijeV2OobiBr6K3foVF12IUKZiRM/
	2/7qoCwkY/j17xbvWgBQYdmb3zIhN5qoUWSjht/ZZA==
X-ME-Sender: <xms:aUdOZsqoS2bPYdMMkNRAraJ_9foHojotVK01oEoj2nUTwduugaKJNw>
    <xme:aUdOZip2CpZ7Wbrr9g7ZYqSxf11WZxjtkqKV8kyK7k1LDZ3YKN9R-SgTuMpYH4KBR
    xZlgw-chm6AfjAhZ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aUdOZhNktpru_bQ2z3icIo0h20DUBZKP7b_SFsQ61Kz0ICkAlmoQdw>
    <xmx:aUdOZj4a-b3aq_PeWPVmn3a9krhK1RNjOyXtwPoM69bYSfBOp_ww7w>
    <xmx:aUdOZr6kD-JeTjJc2057GD5V5xX68vKxffF8RUW2CB33aGTbbvBKDg>
    <xmx:aUdOZjh1unIg_yrrgmeOlIpsvNEJ7nwS6s9zTDgs7Z2ekfQT38Lz0g>
    <xmx:aUdOZubeBWu_FR3h3IcpQyoXG0h_UumJKSvBc-2LFbdwQ1wKZllt-TTu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EC110B6008D; Wed, 22 May 2024 15:28:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ee4cd4fa-9c5b-444c-803f-1075c7425109@app.fastmail.com>
In-Reply-To: <87seya452v.fsf@>
References: <20240309202445.work.165-kees@kernel.org> <87seya452v.fsf@>
Date: Wed, 22 May 2024 19:28:19 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolai Stange" <nstange@suse.de>, "Kees Cook" <keescook@chromium.org>
Cc: "Jeremy Linton" <jeremy.linton@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org,
 "Elena Reshetova" <elena.reshetova@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] randomize_kstack: Improve entropy diffusion
Content-Type: text/plain

On Wed, May 22, 2024, at 08:35, Nicolai Stange wrote:
> Kees Cook <keescook@chromium.org> writes:
>>
>> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
>> index 5d868505a94e..6d92b68efbf6 100644
>> --- a/include/linux/randomize_kstack.h
>> +++ b/include/linux/randomize_kstack.h
>> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>>  	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>>  				&randomize_kstack_offset)) {		\
>>  		u32 offset = raw_cpu_read(kstack_offset);		\
>> -		offset ^= (rand);					\
>> +		offset = ror32(offset, 5) ^ (rand);			\
>
> Hi Kees,
>
> I'm wondering whether this renders the per-arch mask applied to 'rand'
> at the respective choose_random_kstack_offset() invocations ineffective?
>
> Like e.g. on x86 there is
>
>   choose_random_kstack_offset(rdtsc() & 0xFF);
>
> I would argue that while before the patch kstack_offset had been
> guaranteed to stay within the bounds of 0xFF, it's now effectively
> unlimited (well, <= (u32)-1) and only capped to 0x3ff when subsequently
> applying the KSTACK_OFFSET_MAX().
>
> Or am I simply missing something?

Hi Nicolai,

I think you are correct and this is an unintended side-effect
of this patch. We could either restore the previous limits
or try to come up with a cross platform policy here, which
may be better in the end.

I see that out of the five architectures that have randomized
kstacks, only powerpc and riscv actually use the default
1kb range of offsets, so those are unaffected by the unintential
change.
arm64 uses a 512 byte while x86 and s390 use a 256 byte range.

As far as I can tell, there should be nothing architecture
specific about that limit, though we might want to reconsider
the total size of the stack. On architectures with 4KB
pages and CONFIG_VMAP_STACK, we should be able to have
arbitrarily sized stacks (e.g. 12kb or 20kb instead of the
default 16kb) as a compile-time selection.

If we increase the stack size by 4KB, it would be trivial
to set the random offset to the same 4KB range instead of
256/512/1024 bytes. On the other hand, I always feel
uneasy about enabling kstack randomization without
CONFIG_VMAP_STACK, so we may want to also tie it to that.

     Arnd

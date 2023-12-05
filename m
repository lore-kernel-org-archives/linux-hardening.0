Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nKkQEoBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBb4xJ6D"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8C122;
	Tue,  5 Dec 2023 15:47:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C06CD5C0099;
	Tue,  5 Dec 2023 18:47:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 05 Dec 2023 18:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701820020; x=1701906420; bh=v1AF7u8uyhL5eTCK0aLokAy6KSNNe4qNX9h
	wmxep6io=; b=nKkQEoBFCEngX8kMNRRFmVuttVFB1DLZ7o+9DXrTBtsmwB5Iz1Y
	tPVAjWSj8NXpHiGfap+IjroN2uT3B8fVXJhLk/+M1Unb5B3+uLETyQuax1Wv+q+t
	/okMrQbBvy1qcu2PAztdw/nsNi5I41FLPQ5zrFpcyjWgxVrbwjkRqGMJX/Pw6EIu
	TkBwpaXcIuFILIaU9V/pVg7Jr17YxI9XlOThRj6Qv5dfOtyK8ngvw1sZs41VOfFp
	DCWmcHHNY7S2AakMHTYZqfpS3YwoKf9hxlwiCuH8kSgM+rK56BBAztTVyA5jpO71
	PpDNkso7KhZ+evVGEF/vvy/id2yVqDySOew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701820020; x=1701906420; bh=v1AF7u8uyhL5eTCK0aLokAy6KSNNe4qNX9h
	wmxep6io=; b=bBb4xJ6D+VfjxbfscIlwlcKLH6erIAl59Jjl51+g4B825FQh4aQ
	EjBIbZbofeuM+xeVMmZXmVCHgR9G7aLzPXpbIUDyrprcK9X/LeBz1OVsfT9GMk32
	xh0UsSWuOcIH9v8SGhX6IYcL6DjFA/25sEBYJelozqvx9BG0eLORsJhXBBapSFlS
	i1y+tZMu1HdcwR10apfb/VJ2ZzAesAH7B+OXGXHSiQnaVW5QdZuR+CV+XnW5evHb
	WyIOr/T+hPCctGPXHp3aensKohAjJg1NqHuNkEbIvSlN+Bnw42Jfl9zN2cfnarTl
	LpShoSKvmi9M6bVU32GrVdvyJIb0d6SYV9A==
X-ME-Sender: <xms:c7ZvZR-R9UKBl1cE9WQB5g6BarDXhmu1oRztT8F8Auv9fRL9fMFq8w>
    <xme:c7ZvZVvAehVMvLAhoPKOIh6u6QWEBPGJiReVIrBsQ4sDO9EslynX_x219teVXxGaQ
    ih5eL6gi0nYuQ>
X-ME-Received: <xmr:c7ZvZfAAWqMQNzJ1_SrwgxAhcRqTvNCrVm1ZEKrRAJZ4_VYvDzbSwBMBlrIdvO04xO2rab2EEkvgD-rOYj6xSOi6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:c7ZvZVdyTaw2ffvejqSWsTPFp-EkcFftMvxVtcWO-Vg4V8UT0ZCuTw>
    <xmx:c7ZvZWOdKwhdb5gT2HQ1A4DsHppU6-TEID5G2mGszykyhbUzm7v3SQ>
    <xmx:c7ZvZXmRIxymqCPSQusJmHn-I2ZdMj2ulJmyhEVoM1eJm2qFbvCWqQ>
    <xmx:dLZvZRE9bGSuMrEkB-gqL-RqrzetrqNEwrjRFPdBn0R2F4oywpp34g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:46:58 -0500 (EST)
Date: Wed, 6 Dec 2023 08:46:50 +0900
From: Greg KH <greg@kroah.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <2023120657-henna-spongy-9ef6@gregkh>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>

On Tue, Dec 05, 2023 at 02:14:55PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 5, 2023 at 1:59 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > > On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > It also breeds includes of asm/*.h, by the look of the output, which is
> > > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> > > > outside of linux/uaccess.h is a bad idea.
> > >
> > > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > > convention here that I'm missing?
> >
> > General rule, NEVER include asm/*.h, there should be a include/*.h
> > instead that works.  So much so that checkpatch.pl should catch this,
> > right?
> 
> ah, shoot, I was showing Tanzir how to use `b4` for patch development,
> and forgot to check this.  Indeed it does.
> 
> I can see how the check works (scripts/checkpatch.pl L5881).  Decoding
> that will probably help us improve the tooling.
> 
> >
> > But of course, it doesn't always hold true, there are a few minor
> > exceptions, but they are rare.
> 
> $ grep -r \\#include lib | grep asm
> 
> shows quite a few exceptions, and just in lib/.
> 
> For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
> where lib/math/int_log.c should be #include 'ing linux/bug.h rather
> than asm/bug.h?

Probably yes, but we don't normally go back and take coding style fixes
for old files like this as it doesn't make much sense to do so.

But, if you are cleaning up the headers for large portions with the goal
of faster builds, that's a good reason.

Good luck!

greg k-h

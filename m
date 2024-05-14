Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CE13A271;
	Tue, 14 May 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683087; cv=none; b=B5Ek35Zrb4O2rRqT+oU14eqR02aS4KeZ95IsVAamvlDLhx1ERtXstZvY7S4De0k3/ierHvnXw4kEBpCwpGL8i1h0oNpbe/L9gE3e0Aj0Fwt5hS2vg0rFLjRq4EF958XjcdNM1b434PviUkr4E5O0Td0hYC3PD9pKIWn7FDO6xIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683087; c=relaxed/simple;
	bh=gXV/oqhmaQ1tdC9JRFSJVqEuie1cUMVVNhKnd6xNMRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msJ7F9kPHzw5CKtk6+B/kE+obfnciNQ7uplxvyBry7S/P7pLCwfzSTD+rsbp7Sck1eWngvkBi28YHplXgOiIIrxVHbpj7oDPzJ5RytYKFVxGlgCvwCJhpFc6+WWi8jU6ordbT/Y+8KcfoAPuRqusO/8tsErkg3rddyu2kK6W7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TM1nUYLK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byghsQKk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TM1nUYLK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byghsQKk"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715683084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDStsWVDKLJBA8425Wty2TlT2DjOQySOPO1UJZBTK/s=;
	b=TM1nUYLKS/rtDO6b+mZa35J2FOZtfg5jpN5AWCz3I8aEFExTnGThvTdTuGyZlrMPr22FYh
	Pl8roHl3KzZ0U5Ov5TpnAehWZNnQdC7r9rWBa6pnXmzWmbzcypELEmmgSnP85LxmjJbKGQ
	DQdOaHtl1hH7kZrQvXOaWBDCgDGiVQ9AHMVbTc7fNkamWhibDWbBBdpaXGikoxO5SD3KOb
	Ub4QGDncE/fW/5pcT/v6HVFxfaxsdjirOvzmUc6PZ0sdB3yn70FbUo3CL1LWAMehLGcyrk
	ablNYNXbAXWjRR1oz0muqBn/sQ9SISYJ4AVS4XNHs0yiwd67fLYWa1psHVHZlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715683084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDStsWVDKLJBA8425Wty2TlT2DjOQySOPO1UJZBTK/s=;
	b=byghsQKks4BdQGcAkosA2dEhmuZsi2ivt9KDLL4SFctUS/5Linbpj3luNP7BCYw6lOVoh3
	DGNSvwatQH4TOKCQ==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] ntp: remove accidental integer wrap-around
In-Reply-To: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
References: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
Date: Tue, 14 May 2024 12:38:03 +0200
Message-ID: <87v83gllv8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 04:34, Justin Stitt wrote:
> Using syzkaller alongside the newly reintroduced signed integer overflow
> sanitizer spits out this report:
>
> [  138.454979] ------------[ cut here ]------------
> [  138.458089] UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:461:16
> [  138.462134] 9223372036854775807 + 500 cannot be represented in type 'long'
> [  138.466234] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-00038-gc0a509640e93-dirty #10
> [  138.471498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  138.477110] Call Trace:
> [  138.478657]  <IRQ>
> [  138.479964]  dump_stack_lvl+0x93/0xd0
> [  138.482276]  handle_overflow+0x171/0x1b0
> [  138.484699]  second_overflow+0x2d6/0x500
> [  138.487133]  accumulate_nsecs_to_secs+0x60/0x160
> [  138.489931]  timekeeping_advance+0x1fe/0x890
> [  138.492535]  update_wall_time+0x10/0x30

Same comment vs. trimming.

> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").

Again. Irrelevant to the problem.

> Let's introduce a new macro and use that against NTP_PHASE_LIMIT to
> properly limit the max size of time_maxerror without overflowing during
> the check itself.

This fails to tell what is causing the issue and just talks about what
the patch is doing. The latter can be seen from the patch itself, no?

Something like this:

   On second overflow time_maxerror is unconditionally incremented and
   the result is checked against NTP_PHASE_LIMIT, but the increment can
   overflow into negative space.

   Prevent this by checking the overflow condition before incrementing.

Hmm?

But that obviously begs the question why this can happen at all.

#define MAXPHASE 500000000L       
#define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5)

==> NTP_PHASE_LIMIT = 1.6e+07 = 0xf42400

#define MAXFREQ 500000

So how can 0xf42400 + 500000/1000 overflow in the first place?

It can't unless time_maxerror is somehow initialized to a bogus
value and indeed it is:

process_adjtimex_modes()
        ....
	if (txc->modes & ADJ_MAXERROR)
		time_maxerror = txc->maxerror;

So that wants to be fixed and not the symptom.

Thanks,

        tglx

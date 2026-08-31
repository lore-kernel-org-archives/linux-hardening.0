Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45B47DD74;
	Mon, 31 Aug 2026 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183456; cv=none; b=dcAiQZqS6E4k9LalNBc/ydCmv05eCgVfeC7z/yhgVpo0RcxY9QcVD2MtiERHR/3KKK+c/aHEDXbZ6xJByj+mDZZ7Gqvg6GXd2e2jng9ztD1D6+sbjwp7gpqahJ/glUn8enLdiOxpJBmlR2GJgd7dJf/V5AKFvxF6DtNkBcI9jzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183456; c=relaxed/simple;
	bh=jTqOhgw+BRMvoL6z5eBoSYqqOeveZyXGd47IfWrFETc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBazD/7zVgxAwYOXEoBKutOYsmx9uvdonQ1HfSz09IxXC8MzBSiYBJ/quiIbcyc8tr01FlmWmDVRtAA+UpS5EDgT9sBK3RGtFNDvv5DiBGJaxyIWiFRv0Qv2xbj30L369CYfoUTLf6TgknYlpKKqFES4C112auDi+wEarHOrF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUImY220; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6o8edEIW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUImY220";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6o8edEIW"
Date: Mon, 31 Aug 2026 15:37:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788183451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2ci4tLZ9oBc4LSTM3VwFCIrggir7M/la1ymcw0iFQ=;
	b=RUImY220VlRqdV5Hyq3eLwEN/9wi85RepNBYLIlRwNKYjRSWMRN9alPonILncinzyGfBEu
	XNBirMMnbx6ZmNVApiuEgNbloguhJoyBcc1eY/5Vt/oTGyuBLasbmolk3Betx424xhuE/K
	z56FREkD+5dAtmT7h3GFzJjD44SX8E2slBuNfxQ4bt/dEMiNyRq6L+VEGVsHW+y3MHGZ20
	ReK/IHYUpYnywQYokmcWyoHLRTPMFEf/rTZVFFA2f5M2w+3v00fJ1powTMwRUXTFfM0gW4
	fyiisAx5RBGBmOm2ZEFvxPu0exariBznefngANrUwjyJxNm9flwuqUFAEPSICQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788183451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2ci4tLZ9oBc4LSTM3VwFCIrggir7M/la1ymcw0iFQ=;
	b=6o8edEIW+u2TuXzIZl3KpWO1JTButC6ffPt3sYJlqKsWodpopNm4g0HxjjJPlatTs/PjU6
	9/o47J9S/C7NMoBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are
 revealed
Message-ID: <20260831133729.p5ylO7O6@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-3-bigeasy@linutronix.de>
 <ao8SeCCG65uwH-Tk@pathway.suse.cz>
 <20260827102411.NsziRXyJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260827102411.NsziRXyJ@linutronix.de>

Could someone yell here, please? I convinced myself that hiding
unresolved pointers is the good thing to do here since a "wrong" pointer
would be seen in backtrace anyway.

Thread starts at
	https://lore.kernel.org/all/20260821152614.2202196-1-bigeasy@linutronix.de/

On 2026-08-27 12:24:13 [+0200], To Petr Mladek wrote:
> On 2026-08-26 18:21:12 [+0200], Petr Mladek wrote:
> > Adding Linus into Cc.
> >=20
> > On Fri 2026-08-21 17:26:14, Sebastian Andrzej Siewior wrote:
> > > __sprint_symbol() is supposed to resolve the passed address to a symb=
ol
> > > name. If the symbol can not be resolved it will print the actual poin=
ter
> > > that was passed. The pointer policy is to not reveal actual pointer
> > > values. However for post-mortem analysis of crashes it is helpful to =
see
> > > the raw pointer if it is a corrupted pointer.
> > >=20
> > > Document why raw unresolved pointers are printed.
> >=20
> > > --- a/kernel/kallsyms.c
> > > +++ b/kernel/kallsyms.c
> > > @@ -482,8 +482,13 @@ static int __sprint_symbol(char *buffer, unsigne=
d long address,
> > >  	address +=3D symbol_offset;
> > >  	len =3D kallsyms_lookup_buildid(address, &size, &offset, &modname, =
&buildid,
> > >  				       buffer);
> > > -	if (!len)
> > > +	if (!len) {
> > > +		/*
> > > +		 * Print the raw pointer to allow post-mortem analysis of corrupted
> > > +		 * pointer in backtraces.
> >=20
> > This might be acceptable when the system is going to panic().
> > But is this formatting used only during panic?
>=20
> panic, bug, warning, stack backtrace, =E2=80=A6 everything using %p[sSB] =
where
> the symbol can not be resolved to an actual function.
>=20
> > > +		 */
> > >  		return sprintf(buffer, "0x%lx", address - symbol_offset);
> >=20
> > I expected that we would replace this by "%p" so that the pointer got
> > hashed by default. After all, we suggest to use %ps because it should
> > not leak pointers.
> >=20
> > Hmm, I see %ps or %pS used by many interfaces, like procfs, sysfs,
> > ftrace. Many of them are accessible only by root. Maybe, people expect
> > to see the valid pointers.
>=20
> For %p[sS] it should something in .text area either kernel or module. If
> it can not be resolved then something went south. This can be either a
> legitime case like in commit b86280aa48b67 ("kernel/kallsyms.c: fix %pB
> when there's no symbol at the address") or the IP gets invalid due to
> $reason and the system panics. Making this %p would mean you have to use
> unhashed pointers just to see the unresolved pointer in the crash case.
>=20
> > But we do not want to repeate the %pK eperience here. We could not
> > reliably check the access rights of the vsprintf() caller.
> > So, we should agree on the default behavior which does not
> > depend on the caller.
>=20
> We don't want that, yes.
>=20
> > And I think that we want to reduce the risk of leaking.
> > So, I would use %p here.
> >=20
> > If some callers really want to always print the real pointer when
> > the symbol is not resolved then we might add some modifier for
> > this, e.g. %p[SsB][R][p], where p would mean plain. But I am
> > not sure if we really want it.
>=20
> That sounds like too much. The general policy should be what we want. So
> if the IP gets to be entire nonsense I get
>=20
> | BUG: unable to handle page fault for address: 0000000012345678         =
                                                                           =
                11:52 [2/1960]
> | #PF: supervisor instruction fetch in kernel mode
> | #PF: error_code(0x0010) - not-present page
> | PGD 0 P4D 0=20
> | Oops: Oops: 0010 [#1] SMP NOPTI
> | CPU: 6 UID: 0 PID: 1915 Comm: kworker/6:2 Tainted: G        W          =
 7.2.0+ #72 PREEMPT_{RT,(lazy)}=20
> | Tainted: [W]=3DWARN
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2026.05-2 08/0=
6/2026
> | Workqueue: events inv_func
> | RIP: 0010:unresolved
>=20
> The %pS that did get resolved (instead 0000000012345678).
>=20
> | Code: Unable to access opcode bytes at 0x1234564e.
> | RSP: 0018:ffffc900024c7e78 EFLAGS: 00010286
> | RAX: ffffffff812691a0 RBX: ffff8881080f2780 RCX: 0000000000000006
> | RDX: 0000000000000000 RSI: 000073746e657665 RDI: 0000000012345678
> | RBP: ffff8881000ada00 R08: 8080808080808080 R09: ffff8881080f2808
> | R10: ffff8881000964c0 R11: fefefefefefefeff R12: ffff88817bdaa500
> | R13: ffff8881000ada05 R14: 0000000000000000 R15: ffffffff8280e000
> | FS:  0000000000000000(0000) GS:ffff8881f8c09000(0000) knlGS:00000000000=
00000
> | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | CR2: 0000000012345678 CR3: 000000010858d000 CR4: 00000000003506f0
>=20
> and on x86 we have CR2
>=20
> | Call Trace:
> |  <TASK>
> |  ? process_one_work+0x174/0x350
> =E2=80=A6
>=20
> So given that "BUG:" here would print that information, the RIP %pS line
> might now have to.
> If I use a data pointer instead:
> | kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> | BUG: unable to handle page fault for address: ffffffff8280e000
> | #PF: supervisor instruction fetch in kernel mode
> | #PF: error_code(0x0011) - permissions violation
> | PGD 3049067 P4D 3049067 PUD 304a063 PMD 80000000030001e3
> | Oops: Oops: 0011 [#1] SMP NOPTI
> | CPU: 6 UID: 0 PID: 1731 Comm: kworker/6:2 Tainted: G        W          =
 7.2.0+ #73 PREEMPT_{RT,(lazy)}
> | Tainted: [W]=3DWARN
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2026.05-2 08/0=
6/2026
> | Workqueue: events inv_func
> | RIP: 0010:unresolved
> | Code: 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00=
 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 <00> 00 40 03 =
00 00 00 00 08 e0 80 82 ff ff ff ff 08 e0 80 82 ff ff
> | RSP: 0018:ffffc90001fc3e78 EFLAGS: 00010286
> | RAX: ffffffff812691a0 RBX: ffff88810364e240 RCX: 0000000000000006
> | RDX: 0000000000000000 RSI: 000073746e657665 RDI: ffffffff8280e000
> | RBP: ffff8881000ada00 R08: 8080808080808080 R09: ffff88810364e2c8
> | R10: ffff8881000964c0 R11: fefefefefefefeff R12: ffff88817bdaa500
> | R13: ffff8881000ada05 R14: 0000000000000000 R15: ffffffff8280e000
> | FS:  0000000000000000(0000) GS:ffff8881f8c09000(0000) knlGS:00000000000=
00000
> | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | CR2: ffffffff8280e000 CR3: 0000000100ac6000 CR4: 00000000003506f0
> | Call Trace:
> |  <TASK>
> |  ? process_one_work+0x174/0x350
>=20
> given that, we could go back to (unknown) instead in the hashed case
> instead of printing the pointer. I see the same kind of output for
> arm64.
> The only question would if that is enough for stack trace. But if so, I
> would indeed suggest to replace it with "(unknown)" as I already had in
> v1.
>=20
> > > +	}
> > > =20
> > >  	offset -=3D symbol_offset;
> >=20
> > Best Regards,
> > Petr

Sebastian

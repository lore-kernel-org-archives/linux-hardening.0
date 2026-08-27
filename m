Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06755413796;
	Thu, 27 Aug 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822055; cv=none; b=Xqin2jivFgGGu4oktSDIXMi59jhJmv6ho7d9fqn4pu2JF/j1QRJzfTItcZOSOnIVLJVf6BuBxzkQosTCEviZqW3AoP+/crE+PKrLL2h+v+Q4lQ0xXxGHvkTElwD8QoTksM/ztG+1TZUZqvTXaGnFe/V1wtfvN8lXIpkAZNRL9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822055; c=relaxed/simple;
	bh=ygShvwL25ORUOGZrD/kl+DaX+7KSw/txXgQE5NFIDss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWoeTKbonGkaJ+m/FZPxBeX/WiJVulGN9Mzhtn583OxxTxXXXRPPlBtLuQLyApp22sYB0hp1Va6/fG3zulZEL6qG0t4vPJmpXDM3guMPPMOvt4eibhqv/7t9At9uSC6osL2DSqBXiC7TCelEP8Ijfyc4OR+AaJeTr3kiM+H/pPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=McG4Degj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4S5wj43s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="McG4Degj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4S5wj43s"
Date: Thu, 27 Aug 2026 11:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787822048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIRTAYb/f87OGQFp9hzPxLVAzR1bU0s89QDuqkymiN4=;
	b=McG4DegjIm+tgHEeO2YQhPG+jPlv2qsQKnBKWRTO3W6xVv5DrsrZTV29vd6enJEqF7nZUN
	YlbBs5KEVw3m4q7ad2FWnOmBeMggS95R1p45j3DhCrtvLLqNVd7dmxuy076V6kFTs+tUmw
	LdmNkMcr048vIQWNzHfseDoYzgxqbDyUmLtsZtQbmI63xUtD4jBLm2K433/tf2Z03kQe/N
	2Jw5aSoTde4TOepkqXV6sqeM13jX0eh/ovHBQAPUYBby2Qwd+1pbH0qefYF4eYumjJYHnY
	A4gT96BhZiYgNHvTS21aEnpOlO1OGs+LVZDMIPSwFmL/FUqPdRSoeggvpV6UEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787822048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIRTAYb/f87OGQFp9hzPxLVAzR1bU0s89QDuqkymiN4=;
	b=4S5wj43sVtOa82DV4M8LCJRHSK/Z/IrMe6iYBgER/mSFz5DpHkUpn+eE8bNUNU5ZVgcMcN
	g3axnqYh8FeuoUAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH v2 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <20260827091407.yUpoFiuF@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-2-bigeasy@linutronix.de>
 <ao8MnDuF9nnI9KxG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ao8MnDuF9nnI9KxG@pathway.suse.cz>

On 2026-08-26 17:56:12 [+0200], Petr Mladek wrote:
> On Fri 2026-08-21 17:26:13, Sebastian Andrzej Siewior wrote:
> > The "%ps" format modifier prints the name of the symbol which is more
> > valuable in terms of debugging and does not leak the actual pointer.
> >=20
> > Without KALLSYMS it will leak the pointer which is not intended. The
> > default policy for pointers is to print a hashed value and not to leak
> > the actual pointer.
> >=20
> > For !KALLSYMS, print "(unknown)" for any symbol resolution. If hashed
> > pointer are disabled print the bare number.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  lib/vsprintf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 2bc6ef483576c..fcb63f22b1997 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1008,7 +1008,9 @@ char *symbol_string(char *buf, char *end, void *p=
tr,
> > =20
> >  	return string_nocheck(buf, end, sym, spec);
> >  #else
> > -	return special_hex_number(buf, end, value, sizeof(void *));
> > +	if (unlikely(no_hash_pointers))
> > +		return special_hex_number(buf, end, value, sizeof(void *));
> > +	return string_nocheck(buf, end, "(unknown)", spec);
> >  #endif
> >  }
>=20
> My understanding was that we were going to use
>=20
> 	return default_pointer(buf, end, ptr, spec);
>=20
> It would print the hashed pointer unless no_hash_pointers was set.
> IMHO, it would make the handling of pointer values more consistent.

The difference is that prints "Unknown" instead a value where a name was
expected. Look at this, we have now:

| # cat /proc/timer_list
=E2=80=A6
|  next_event:     89340000000 nsecs
|  set_next_event: (unknown)
|  shutdown:       (unknown)
|  periodic:       (unknown)
|  oneshot:        (unknown)
|  oneshot stopped: (unknown)
|  event_handler:  (unknown)
=E2=80=A6
| [    1.584810] ------------[ cut here ]------------
| [    1.584811] WARNING: init/main.c:1572 at (unknown), CPU#2: swapper/0/1
| [    1.584813] Modules linked in:
| [    1.584816] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0+ #6=
6 PREEMPT_{RT,(lazy)}
| [    1.584819] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2=
026.05-2 08/06/2026
| [    1.584820] RIP: 0010:(unknown)
| [    1.584821] Code: 74 46 e8 89 7c 2d ff e8 14 e5 42 ff e8 df c8 09 ff e=
8 ba 01 21 ff c7 05 04 2d 75 00 03 00 00 00 e8 8b bf 2b ff e8 56 1b 5c ff <=
0f> 0b 48 8b 3d bd 41 4a 00 48 85 ff 74 33 e8 33 60 09 ff 85 c0 75
| [    1.584823] RSP: 0018:ffffc90000023f30 EFLAGS: 00010292
| [    1.584825] RAX: ffff8881f8d0b000 RBX: ffffffff8216a030 RCX: ffff88810=
2cae000
| [    1.584826] RDX: 0000000000000000 RSI: 0000000000000012 RDI: ffff88810=
02a3480
| [    1.584827] RBP: 0000000000000000 R08: ffff8881002a3480 R09: ffffea000=
40b2b80
| [    1.584828] R10: ffff888100041180 R11: ffffc90000023ec0 R12: ffffc9000=
0023f58
| [    1.584829] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
| [    1.584833] FS:  0000000000000000(0000) GS:ffff8881f8d0b000(0000) knlG=
S:0000000000000000
| [    1.584834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| [    1.584835] CR2: 0000000000000000 CR3: 0000000002e46000 CR4: 000000000=
03506f0
| [    1.584837] Call Trace:
| [    1.584846]  <TASK>
| [    1.584847]  (unknown)
| [    1.584847]  ? (unknown)
| [    1.584849]  (unknown)
| [    1.584850]  </TASK>
| [    1.584850] ---[ end trace 0000000000000000 ]---

while printing a hashed pointer instead would give you:
| # cat /proc/timer_list
=E2=80=A6
| next_event:     66384000000 nsecs
| set_next_event: 0000000095ee31e0
| shutdown:       00000000c838001a
| periodic:       000000002e3ab76e
| oneshot:        0000000019def7ac
| oneshot stopped: 00000000c838001a
| event_handler:  0000000053e7a80d
=E2=80=A6
| [    1.498126] ------------[ cut here ]------------
| [    1.498127] WARNING: init/main.c:1572 at 000000007224a107, CPU#6: swap=
per/0/1
| [    1.498131] Modules linked in:
| [    1.498135] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0+ #6=
8 PREEMPT_{RT,(lazy)}
| [    1.498138] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2=
026.05-2 08/06/2026
| [    1.498140] RIP: 0010:000000007224a107
| [    1.498142] Code: 74 46 e8 e9 7c 2d ff e8 74 e5 42 ff e8 3f c9 09 ff e=
8 1a 02 21 ff c7 05 64 2d 75 00 03 00 00 00 e8 eb bf 2b ff e8 b6 1b 5c ff <=
0f> 0b 48 8b 3d 1d 42 4a 00 48 85 ff 74 33 e8 93 60 09 ff 85 c0 75
| [    1.498145] RSP: 0018:ffffc90000023f30 EFLAGS: 00010292
| [    1.498147] RAX: ffff8881f8e0b000 RBX: ffffffff82169fd0 RCX: ffff88810=
2d9d2a0
| [    1.498149] RDX: 0000000000000000 RSI: 000000000000001e RDI: ffff88810=
02a3480
| [    1.498150] RBP: 0000000000000000 R08: ffff8881002a3480 R09: ffffea000=
40b6740
| [    1.498152] R10: ffff888100041180 R11: ffffc90000023ec0 R12: ffffc9000=
0023f58
| [    1.498153] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
| [    1.498159] FS:  0000000000000000(0000) GS:ffff8881f8e0b000(0000) knlG=
S:0000000000000000
| [    1.498161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| [    1.498162] CR2: 0000000000000000 CR3: 0000000002e46000 CR4: 000000000=
03506f0
| [    1.498164] Call Trace:
| [    1.498171]  <TASK>
| [    1.498172]  00000000cb9bc262
| [    1.498174]  ? 00000000eb5021dd
| [    1.498176]  00000000ed1a9938
| [    1.498178]  </TASK>
| [    1.498179] ---[ end trace 0000000000000000 ]---

isn't this confusing? There is no added value in printing some random
numbers. Before this change you would also see "other" random values
with address randomisation. It confuses at best imho.

> Best Regards,
> Petr

Sebastian

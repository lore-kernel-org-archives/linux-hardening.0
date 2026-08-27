Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5493E4C69
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824267; cv=none; b=Se/8GjaEGJWKHOtxIksE+hfhD8TRPfsILnc41Tqtmg6t+lbNUWWh3hCPkmz1kVHDIZVI11eLBIGahj4zVrGd0Gqm1BNzpu+IJl3cBIxG4x6M78h6hGeOoxg44DII79/jdfoPKuQuSnQZ5RwgoFcaVHhnWF6P6t3XspHV8HosqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824267; c=relaxed/simple;
	bh=p9qynxuXnCSDqXmTisxl8bxLG19vZfA62pIhXDZ21ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWpujwuCk5AaTjlyKmJuC6rnzbDpHOuhWcedZ3Fo9WAvb+3WQ1wdlRcfjk5SB7zX/Fhndgzr1VECOQjOTve3gstgWcczzqLHst7meW/JUlx0Rqcz+O+J5No/CfxdHKQDqBbFn2vysgS+/1e8j/yX5DNf0JgObtdXMpfLwB5BADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b05IaV8+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b05IaV8+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso2040485e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787824263; x=1788429063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvteblxH5nYFfb+EAsKyOZNIrojLVp1eYbJGqfwWPGU=;
        b=b05IaV8+QEZ5mfKoI0wbuHZiBj/eJxvnmT6fMHzarhP9qeiARusJXynX136DSovtr5
         6NH38avPtcFAa7Olt+Q7TbsHSJ1J+3eY36V3RLQtP0aJJGm6T1BJjzAtM+yx0SR9KLQ8
         oZ0hbONq8x+Nfn3fo42QfQIgAtXNb8otQ5ZGlqpKXbgzlCHR1cs4fhdj87U46b9pCCHm
         P5lr2/13Qvi7baUsrkEYsH+xn03sKHaZhiuEa+AKoZuW2E9MdZepN4CqAmopM6ZjY0+7
         81KV0LenFFlRYPIU+8MZlYNli3xYudT4s+63VzQJKSmBrz9lezPgJa+CcFI6UHWxV6ZV
         urjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824263; x=1788429063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pvteblxH5nYFfb+EAsKyOZNIrojLVp1eYbJGqfwWPGU=;
        b=Iu88u8aC8CwR2Scyj5vYxKJI0zwcg1T0Y+KXRAKUfLhCcOEysbDnooV8pu2+xjxMzr
         JUvrHmItPnFewOG4dorAuRuao2rHnaNjtqS2AeFVw7LtDK9qv17QF0f9Z8G8a7chjSTI
         nlmk/uNwGngBenKQ1yguoFBxQjIpnu/m1viDP1+VRvHMLYn8VUqyqlVc2JbYIjmH2j2P
         bbzhXS6K/N0dFMNKDoCGOg/5fRN3nqh7otXKN6yunao/0M0oFJYed51UG/pa7et4PDoa
         Uy9YIb7EhEcMMKKWAbgaHd9lJCAM2V9JuOsRG5BAUGgOExloyMcA9YEKpZ9oqaIWxLXt
         C8Qw==
X-Forwarded-Encrypted: i=1; AHgh+RoOqyFLgwdKJ4da7jlHiPUwjDMFOd8yvyQyutKnHiQ9QyrgaccBZVpDRoFkGW/8EChPUQPZpRlHVxqEvubtnM4=@vger.kernel.org
X-Gm-Message-State: AFuF++kAj1nihhy/TyZwz8zeeEeNywyqYIOEhfpN6bGIs331fqSRhcHm
	FQYx6OxRn/VWON4N5XfPaYcXxungb1QLM1xOu5mK4dKlV+UdhzU4DmaYwqQOAui8XtY=
X-Gm-Gg: AR+sD10x8C0bplioLP8oHzevUmTmbn8+UgsD/2acv0LoNC7yupj7yoPot6Iz8d3v7Vn
	jUgp49S+Lp7TzqhCoxqRWSDXFMp5jd38TZSpEzx8rXfFXEkK2YRD6WK2dDVSSNQUEyKOpA5OmnJ
	CltcZRlzYEeqEj2MycrCQ8fXonYGVT3YJRyivK28vxtDGym3ECZHbmomD7zacyCJ9/5ZJjVS4m5
	qFxR/JO0fWLcVmI+0Sxov/XhirOSCvrv9p08g05E5uSaWREw1QMeUwyYCAWt4VyxRxcL2QvDZkx
	XAO8v6awtGPAPGncWLXau2j1gyR5wFS28mG0KNS8QOPobAAH3LqE++GE5TJTlsbe8frGh7Thqb8
	Q3LzSSTtT54q7ZoTRPonX6Eqlpa4Vx21JCaMosTFCoa392KXs2C03whnoXMVIC01a4erkKmMn3p
	4mN0LjuVcMpQ09qPnrPvk/d44pzXbEHVQY2NWr2wWnV5e7/0Wo41GDSxk/5p0ytA==
X-Received: by 2002:a05:600c:3511:b0:499:adb4:a922 with SMTP id 5b1f17b1804b1-499dc830670mr134370765e9.12.1787824263250;
        Thu, 27 Aug 2026 02:51:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab569sm7658196f8f.16.2026.08.27.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:51:02 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:51:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <apAIhJImGHCCPEH-@pathway.suse.cz>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-2-bigeasy@linutronix.de>
 <ao8MnDuF9nnI9KxG@pathway.suse.cz>
 <20260827091407.yUpoFiuF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827091407.yUpoFiuF@linutronix.de>

On Thu 2026-08-27 11:14:07, Sebastian Andrzej Siewior wrote:
> On 2026-08-26 17:56:12 [+0200], Petr Mladek wrote:
> > On Fri 2026-08-21 17:26:13, Sebastian Andrzej Siewior wrote:
> > > The "%ps" format modifier prints the name of the symbol which is more
> > > valuable in terms of debugging and does not leak the actual pointer.
> > > 
> > > Without KALLSYMS it will leak the pointer which is not intended. The
> > > default policy for pointers is to print a hashed value and not to leak
> > > the actual pointer.
> > > 
> > > For !KALLSYMS, print "(unknown)" for any symbol resolution. If hashed
> > > pointer are disabled print the bare number.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  lib/vsprintf.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 2bc6ef483576c..fcb63f22b1997 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -1008,7 +1008,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
> > >  
> > >  	return string_nocheck(buf, end, sym, spec);
> > >  #else
> > > -	return special_hex_number(buf, end, value, sizeof(void *));
> > > +	if (unlikely(no_hash_pointers))
> > > +		return special_hex_number(buf, end, value, sizeof(void *));
> > > +	return string_nocheck(buf, end, "(unknown)", spec);
> > >  #endif
> > >  }
> > 
> > My understanding was that we were going to use
> > 
> > 	return default_pointer(buf, end, ptr, spec);
> > 
> > It would print the hashed pointer unless no_hash_pointers was set.
> > IMHO, it would make the handling of pointer values more consistent.
> 
> The difference is that prints "Unknown" instead a value where a name was
> expected. Look at this, we have now:
> 
> | # cat /proc/timer_list
> …
> |  next_event:     89340000000 nsecs
> |  set_next_event: (unknown)
> |  shutdown:       (unknown)
> |  periodic:       (unknown)
> |  oneshot:        (unknown)
> |  oneshot stopped: (unknown)
> |  event_handler:  (unknown)
> …
> | [    1.584810] ------------[ cut here ]------------
> | [    1.584811] WARNING: init/main.c:1572 at (unknown), CPU#2: swapper/0/1
> | [    1.584813] Modules linked in:
> | [    1.584816] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0+ #66 PREEMPT_{RT,(lazy)}
> | [    1.584819] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2026.05-2 08/06/2026
> | [    1.584820] RIP: 0010:(unknown)
> | [    1.584821] Code: 74 46 e8 89 7c 2d ff e8 14 e5 42 ff e8 df c8 09 ff e8 ba 01 21 ff c7 05 04 2d 75 00 03 00 00 00 e8 8b bf 2b ff e8 56 1b 5c ff <0f> 0b 48 8b 3d bd 41 4a 00 48 85 ff 74 33 e8 33 60 09 ff 85 c0 75
> | [    1.584823] RSP: 0018:ffffc90000023f30 EFLAGS: 00010292
> | [    1.584825] RAX: ffff8881f8d0b000 RBX: ffffffff8216a030 RCX: ffff888102cae000
> | [    1.584826] RDX: 0000000000000000 RSI: 0000000000000012 RDI: ffff8881002a3480
> | [    1.584827] RBP: 0000000000000000 R08: ffff8881002a3480 R09: ffffea00040b2b80
> | [    1.584828] R10: ffff888100041180 R11: ffffc90000023ec0 R12: ffffc90000023f58
> | [    1.584829] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> | [    1.584833] FS:  0000000000000000(0000) GS:ffff8881f8d0b000(0000) knlGS:0000000000000000
> | [    1.584834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | [    1.584835] CR2: 0000000000000000 CR3: 0000000002e46000 CR4: 00000000003506f0
> | [    1.584837] Call Trace:
> | [    1.584846]  <TASK>
> | [    1.584847]  (unknown)
> | [    1.584847]  ? (unknown)
> | [    1.584849]  (unknown)
> | [    1.584850]  </TASK>
> | [    1.584850] ---[ end trace 0000000000000000 ]---
> 
> while printing a hashed pointer instead would give you:
> | # cat /proc/timer_list
> …
> | next_event:     66384000000 nsecs
> | set_next_event: 0000000095ee31e0
> | shutdown:       00000000c838001a
> | periodic:       000000002e3ab76e
> | oneshot:        0000000019def7ac
> | oneshot stopped: 00000000c838001a
> | event_handler:  0000000053e7a80d
> …
> | [    1.498126] ------------[ cut here ]------------
> | [    1.498127] WARNING: init/main.c:1572 at 000000007224a107, CPU#6: swapper/0/1
> | [    1.498131] Modules linked in:
> | [    1.498135] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0+ #68 PREEMPT_{RT,(lazy)}
> | [    1.498138] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2026.05-2 08/06/2026
> | [    1.498140] RIP: 0010:000000007224a107
> | [    1.498142] Code: 74 46 e8 e9 7c 2d ff e8 74 e5 42 ff e8 3f c9 09 ff e8 1a 02 21 ff c7 05 64 2d 75 00 03 00 00 00 e8 eb bf 2b ff e8 b6 1b 5c ff <0f> 0b 48 8b 3d 1d 42 4a 00 48 85 ff 74 33 e8 93 60 09 ff 85 c0 75
> | [    1.498145] RSP: 0018:ffffc90000023f30 EFLAGS: 00010292
> | [    1.498147] RAX: ffff8881f8e0b000 RBX: ffffffff82169fd0 RCX: ffff888102d9d2a0
> | [    1.498149] RDX: 0000000000000000 RSI: 000000000000001e RDI: ffff8881002a3480
> | [    1.498150] RBP: 0000000000000000 R08: ffff8881002a3480 R09: ffffea00040b6740
> | [    1.498152] R10: ffff888100041180 R11: ffffc90000023ec0 R12: ffffc90000023f58
> | [    1.498153] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> | [    1.498159] FS:  0000000000000000(0000) GS:ffff8881f8e0b000(0000) knlGS:0000000000000000
> | [    1.498161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | [    1.498162] CR2: 0000000000000000 CR3: 0000000002e46000 CR4: 00000000003506f0
> | [    1.498164] Call Trace:
> | [    1.498171]  <TASK>
> | [    1.498172]  00000000cb9bc262
> | [    1.498174]  ? 00000000eb5021dd
> | [    1.498176]  00000000ed1a9938
> | [    1.498178]  </TASK>
> | [    1.498179] ---[ end trace 0000000000000000 ]---
> 
> isn't this confusing? There is no added value in printing some random
> numbers. Before this change you would also see "other" random values
> with address randomisation. It confuses at best imho.

I think that it is a matter of taste. I could understand that
"(unknown)" might look more obvious to some people.

I would still prefer the hashed pointer. It make it consistent with
%p handling. Both print addresses in this case.

The motivation for the hash in %p is that it is slightly more useful
than a static string, e.g. "(address)" or "(pointer)". The hash allows
to match the same addresses. It is not 100% reliable but better
than nothing.

Also the hash makes it more obvious the connection with "no_hash_pointer"
option.

IMHO, the only drawback is that people might confuse the hash with
a real value. But it is easier on 64-bit systems because the higher
32-bits are zeros.

Best Regards,
Petr

Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983D37F727
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504347; cv=pass; b=WiUew8qhtXG4pf5Bg7Iejg23FFS0r5bcIf4FYuY7HC9dXyhRPzc8nH25UN2icC0zMxkKDMJbvUi3JE/Etu07N8FmHOGcQ0BD9kBfchaWqM0py580rUaRXpvaH4pBffT7qF3bh6VplkBPOauOE2FNk+aKQGdmQ3qgtvlRsvZcVio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504347; c=relaxed/simple;
	bh=5NreJYqwuGWVCez0WcJb8jRx8VuxVSyJwwqP+1Zb7lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNAKPYlWd1oGAGSMo/cCWgzZF7L67AYdV5ARQqQKUCekl45pSoujNdvPKn0oGxyfxuQiaiHIJx9/H0jC8HXY+SQfaFtO7qAuDbuTT1ubRlmJjS3Duo7UO//8MIZr9wshA8os1udpyrbwdvc4/GFHykh2fBh5oAaj2dn5NLoXTJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hD9O6I9T; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hD9O6I9T"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c899550c840so910267a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 13:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782504345; cv=none;
        d=google.com; s=arc-20260327;
        b=CC57o1YVehGirRbvSTkcyWFVBIFesg8B0HKGCBKLtOfEaHCINP5yx0P80K6+HMJfte
         vzBmREH3lMsOoVxC2FDtB0a41aRH5n0k+9JQSpl3YcWTHQp7bPlahmD/SkekAeSyqMsE
         jZ6GDLQoZcocIBpOvxovoN68WbtGrsoQLBibSYrUl8RRr0Qy1KCb45oiz+DBFGoqiM5l
         zAsI9fOqmuAVEZEzBkEF+zeDJtBPKBiu3X5iZzhLlMqhr9sWPhU3U5ThytqRKZqlMPrb
         eNJUkh4IGwbaYrKOHisuKYy90VldYghKNjzcAK2pOo6PGdFuDObw1v5U8P9Cf/tisSs3
         7UPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2Sr1Voge+YPmaHj1KHoOulPw7Fr0ziUVv0mpLGt8YA=;
        fh=XKYShy16OSCKr4QNABrXA4VV2Jk8GnVh1zoztOckRyM=;
        b=kULI/6doYR97y0rMbgXkjA9PVkzU+2PJsELAN+lwHnwNTEufoyjeOBoD2znJG0KJFh
         JHgOo4F2oiFYScQR7lNvt8mndIBpI5TfgKjVbnW4RdKy7RH0wP7liLIntbaFrGdunRFf
         wFaxEsJr7Ujfrv6LheK6ohDbsDwCf7w8UVD6u/G85Yxw/Ayl0oBpaOq5sf2HRCofIzK1
         2oSXxyxmnevyhhx9NtWwn4EyGRivCNg+WDmqhBscwKWa/7qdwL6wLQCiFQ6m45ZiIUpK
         Xs6lSOZ3yHt04TQ5i7rYKD+0x8lQp0TuXNyWHbOpDbTcpmlYHCRA6EcS7lpn5PDGTQJ+
         Prgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782504345; x=1783109145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2Sr1Voge+YPmaHj1KHoOulPw7Fr0ziUVv0mpLGt8YA=;
        b=hD9O6I9THChNQipWYzCWWl+ZeKy9WsAfTWZ6GzSe4pFHz2qzwsde5LjzFq8/1Yw1SH
         s9nq1cO5O1ucDbSPOlO1bU2Mqel2TIk2E3MW519HUXOeXYKnMPJRNO/xUi2x/0HIR8Jz
         h2rdlNovRp4p6iz3iie4AjjYOTB/QhfZzDYc0Po6GCsDsuQK1VhtxCfHnV98giWro1Ih
         NqefYgtCVbSnUmWYiW9rbc0ln40xU6YgB59ZW9nxBBIxRBgLJUBx9YFRrA6TpP2MvyrD
         sfBpiHJzCRIOfLFiHpBwApBC4bEkZICn7mgF++jLvHyIiPDfiXWKsXpSxgscoF338pLW
         tnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782504345; x=1783109145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2Sr1Voge+YPmaHj1KHoOulPw7Fr0ziUVv0mpLGt8YA=;
        b=XILLs2tGJSv7ow/WN4MZYAF7IRssOKqAUGIlioQQW20Npm7sfZ5S1VPZMtZJ3vZL8N
         3zkTwuiFgc8g97F9m9F7aE3PppDgQDxdzSUCCr54Vq5jWObZe9F2gnm4ZaC/1HQNKBy5
         ohW2Jkm4DOSVt8wbPo3wqiQRWeqvjpxWWbFEzM+w8/vMxIHsJY7hA3VyNnIjHBf7DeXd
         DihOqgOH4ZDYGN5D4van+Ej+IUIo+zFDRcHsj0HFvNodCoEqm4Il5OLQNFKWOX88JMTC
         DCV8mJbin2U0aFetdtNArcjfeoFPUzVNPHfUcdPmCrSXwjzIiYLmJJTdCG7lFCCvo7jL
         QftA==
X-Forwarded-Encrypted: i=1; AFNElJ+A8VwdFzNb10gWR3mN3teJhVJvmGv3hetWJ/mcz86bm6y0jH3SZSmzGd9KX5kKKcBf8GQ9MVGBwwvipwNSoK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yXhE7HC6xDpL8lBDrfJQlECr6VvRB3Z5zwv/oMJwcgI79QrU
	wFwpV6sQ7yt0nfRIXD4AY75gPRD+E3GMVCIeX+0cUTs5e1fgQQPrUHRQB92DaRZxmrdtDPaX0uL
	IdLFeabNdE4x7yqtYG4w2GFjLH4VyZesQeWiDSJGK
X-Gm-Gg: AfdE7cm2Fb7F+BDQ7RblrWSx38Nd5RENxSray4owta84Sh9VeHqyNNIGND1pSxOdxCK
	/04KwZ0bt25hDXVJsQnWMBaFqiUqC/POFmDclF1QDH19U+fZxR0/hG0Ydn5Bh4bisJ/Ji4j/vAr
	hOeBhX4Ed2dRVS3RLhyjIRwFFzMSEUyzUHJwvb0s1F1JqJ8rUgpq2TtVZ9GfxhqNuyLmAGNu2AJ
	Kxpns9w2L9vfCiCVM9TCHVKSPOU1Axu63cbklHYhMCLJAjdD+GNQb/BSDMGq1LrOHNT3F6ZDBs4
	OccfeqWzHgdLkD3P9cOZGv1PKw==
X-Received: by 2002:a05:6a21:a38d:b0:3bf:6c08:fb9d with SMTP id
 adf61e73a8af0-3bf6c091486mr1297599637.49.1782504344619; Fri, 26 Jun 2026
 13:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <aj7UNceukU9zYeGH@pedro-suse.lan>
In-Reply-To: <aj7UNceukU9zYeGH@pedro-suse.lan>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 26 Jun 2026 13:05:33 -0700
X-Gm-Features: AVVi8CfdLihLYVRtAh89OO3_pCn0nmJaCpMOZTZHdN5ZsIoEpOA4Iy53bZxlagw
Message-ID: <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 12:39=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> On Fri, Jun 26, 2026 at 10:34:44AM -0700, Xiang Mei wrote:
> > With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area=
,
> > which an unprivileged user can surround with attacker-controlled data b=
y
> > spraying vmap allocations adjacent to a target stack (for example via
> > XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
> > guarded vmalloc allocation is followed by a single unmapped guard page.
> >
> > A single guard page is not enough to contain the x86_64 ENTER
> > instruction used as a one-instruction stack pivot. ENTER imm16, imm8
> > builds a stack frame and lowers RSP by:
> >
> >       imm16 + 8 * (L + 1),  L =3D imm8 & 0x1f
> >
> > imm16 is an unsigned 16-bit operand (ENTER never raises RSP), and L is
> > in [0, 31], so the maximum displacement of a single ENTER is:
> >
> >       0xffff + 8 * 0x20 =3D 0x100ff bytes
> >
> > That is more than enough to step off the current stack, across the
> > one-page guard, and into the adjacent sprayed pages. When those pages
> > contain a return sled feeding a ROP chain, reaching any ENTER gadget
> > (opcode 0xc8, abundant as both intended and unintended gadgets) turns a
> > control-flow hijack into full ROP execution without any register contro=
l
> > at the hijack site, making it a one-gadget-style primitive that
> > significantly eases exploitation. The pivot happens after the control
> > transfer, so it is not constrained by CFI (kCFI/FineIBT).
> >
> > Widen the guard region from one page to VMAP_GUARD_PAGES (0x11 pages,
> > 0x11000 bytes), which is the smallest whole-page span exceeding the
> > 0x100ff-byte maximum single-ENTER pivot. A pivot off the top of the
> > stack now lands in the unmapped guard and faults, instead of in mapped,
> > attacker-controlled memory. RANDOMIZE_KSTACK_OFFSET only perturbs RSP b=
y
> > a sub-page amount, so it does not change the required width.
>
> What's so special about enter? Why do we need to design our guard pages
> around it? FWIW, I can't find enter instructions in any of my kernel buil=
ds,
> nor can I convince gcc (on godbolt) to generate an enter instruction.
>

Thanks for your questions and attention.

1) `enter` can do big enough stack pivoting (where we can't find many
`add/sub/adc/sbb rsp, ` doing so)
2) `enter` is not rare since we can take part in the instruction.
Therefore, we are searching for `\xc8.*` (lose upper bound).

Take its subset as an example and perform the search on a default
config kernel, we search for gadgets and filter by `grep ": enter
0x5...,"`
```
0xffffffff853d9c44: enter 0x5157, 0xfc; mov eax, ebp; pop rbx; pop
rbp; pop r12; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff85514c34: enter 0x5e9f, 0xfc; mov eax, ebx; pop rbx; pop
rbp; pop r12; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff855d2034: enter 0x52cb, 0xfc; mov eax, ebx; pop rbx; pop
rbp; pop r12; pop r13; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff8589e155: enter 0x5c41, 0x41; pop rbp; pop r14; pop r15; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff85d1f06a: enter 0x5d03, 0x41; pop rsp; pop r13; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff85d51a2d: enter 0x5c41, 0x41; pop rbp; pop r14; pop r15; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff862e8d3c: enter 0x5822, 5; jne short 0xffffffff862e8db0; add
rsp, 0xc8; pop rbx; pop r12; pop r13; pop r14; pop r15; pop rbp; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff863a551e: enter 0x5c41, 0x41; pop rbp; pop r14; pop r15; pop
rbp; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff8658b134: enter 0x573a, 0xfb; mov eax, ebp; add rsp, 8; pop
rbx; pop rbp; pop r12; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff8658d434: enter 0x5717, 0xfb; mov eax, ebp; add rsp, 8; pop
rbx; pop rbp; pop r12; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff8679fcd6: enter 0x5d5b, 0x41; pop rsp; pop r13; pop r14; pop
r15; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
12:55 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": enter 0x5...," | wc
     40     672    5269
```
Each of them can be used to perform one-gadget stack pivoting for a
Control Flow Hijacking primitive.

> If it's just "this is a single instruction that adjusts RSP", why is e.g.
> sub imm32, %rsp ok?
>
These gadgets are common, but most of them can't skip the garden page,
and the operands are less than one page.
On the same kernel, we found 0 usable gadgets (pivot the RSP out of
the current stack frame) for such gadget family:
```
13:00 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": sub rsp, 0x....;"
13:01 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": add rsp, 0x....;"
13:01 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": adc rsp, 0x....;"
13:01 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": sbb rsp, 0x....;"
13:01 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": sbb rsp, 0x"  | less
13:01 n132@p1 /home/n132/kCTF/fx0
% cat ./gadgets | grep ret | grep ": add rsp, 0x"  | tail
0xffffffff86864d99: add rsp, 0x60; pop rbx; pop rbp; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86864e85: add rsp, 0x60; pop rbx; pop rbp; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86864f7b: add rsp, 0x60; pop rbx; pop rbp; jmp
0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86865248: add rsp, 0x90; pop rbx; pop rbp; pop r12; pop r13;
pop r14; pop r15; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86865fd2: add rsp, 0xd0; pop rbx; pop rbp; pop r12; pop r13;
pop r14; pop r15; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86866fcc: add rsp, 0x68; pop rbx; pop rbp; pop r12; pop r13;
pop r14; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86867463: add rsp, 0x90; pop rbx; pop rbp; pop r12; pop r13;
pop r14; pop r15; jmp 0xffffffff86869bf0 <__x86_return_thunk>;
0xffffffff86867944: add rsp, 0xa8; mov eax, ebp; pop rbx; pop rbp; pop
r12; pop r13; pop r14; pop r15; jmp 0xffffffff86869bf0
<__x86_return_thunk>;
0xffffffff86867b8f: add rsp, 0xb8; mov eax, r12d; pop rbx; pop rbp;
pop r12; pop r13; pop r14; pop r15; jmp 0xffffffff86869bf0
<__x86_return_thunk>;
0xffffffff86869b7d: add rsp, 0x80; mov qword ptr gs:[rip+0x5001490],
0xffffffffffffffff; ret;
```
> FTR, I think it's fine that you're proposing more guard pages; virtual ad=
dress
> space is virtually free on 64-bit architectures (apart from lower page ta=
ble
> density, which may take a little toll on memory usage and/or page table
> caching). I'm just wondering why enter is being used as the concrete targ=
et
> for this.

Thanks for your feedback. We are glad to provide more information and
its practical success for real CVEs.

Xiang
>
> --
> Pedro

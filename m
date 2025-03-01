Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A551C6F55;
	Sat,  1 Mar 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740869360; cv=none; b=tDNsFECWqk05yOlRO58yN+0pRRJaTNT2gMXQp4ePrvJ1mQLUJy/Ipl4LC15oc+3pu2R9CbtrIsLqiP1+zLaHyUzESfwm+OxaWTWKnxP0nYaxSajOMKD3ZDDxieRpdz9a54lRs1+K9eg5KAc6sYFN11BqGfWnH6BykI87CC1nsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740869360; c=relaxed/simple;
	bh=J9aQiHPLwZA7cSMgxamZ2r0PfwFbg/GZmOfaKtFHzmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sckdWx+NizjKvfE9W8tbnHfmkb3N4viRQBm5ZXkc8AmmWX945sSDbFx4PY+mhNbPS/CrMBXOA6311XVDrZKn+n+wcW8WcQ3EvPsdCP11Qj6XS9REYI1A1ziAhtrEHRaBx6WYepXcy1MO2t/u0bwd5E0mrBshJmcgUKI0tyxqP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <b99d222e-e65e-4865-8035-12ce889c4388@assembler.cz>
Date: Sat, 1 Mar 2025 23:48:58 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Andrew Cooper <andrew.cooper3@citrix.com>, Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
 <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
 <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
 <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
 <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
 <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
 <73ef8000-661e-47b4-a8b0-a02d3a849645@assembler.cz>
 <e3f98cf1-71ff-4425-9deb-31d2ae989eac@citrix.com>
Content-Language: en-US
From: Rudolf Marek <r.marek@assembler.cz>
In-Reply-To: <e3f98cf1-71ff-4425-9deb-31d2ae989eac@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Hi Andrew,

Dne 27. 02. 25 v 1:41 Andrew Cooper napsal(a):
> For SYSCALL/SYSENTER it's a little more complicated.  I think you want
> to move the selectors so they don't alias __KERN_CS directly, so you can
> then move back to __KERN_CS in a similar way

Yes I thought the CHECK_CS could be right before KERN_DS so at least kernel SS 
is right.

> Give or take paranoid_entry for the IST vectors, any entrypoint that
> finds itself on __KERN_CS did not get there through the CPU loading a
> new context.

Yes

> It would depend on an attacker not being able to include a FAR CALL into
> their exploit chain, or be able toe write the IDT.  I don't know how
> reasonable that would be if we're ruling out all architectural paths not
> beginning with an ENDBR, but FAR CALLs are rare in general owing to them
> being dog slow in general, and an attacker who can write the IDT doesn't
> need these kinds of games to pivot.

In fact I wanted to use far jump, but is it OK? On 64-bit architecture, there is 
no absolute direct jump with CS change, only indirect one. Do all CPUs with 
FineIBT somehow reasonably handle all the spectre v2 and various other indirect 
branch speculation problems? To speed it up we can use "fallthrough" speculation 
to our advantage and include the target right after the instruction.

> Anyone fancy doing a prototype of this?

Maybe we can discuss following before, if you find this conversation still 
entertaining :)

1) Implement the different %cs for entry points

Looks non-trivial for an attacker to obtain right %cs before landing on the 
IDT/SYSCALL entrypoints.

Each entrypoint would check if current %cs is __KERN_CHECK_CS, and if not panic. 
Then it would change the %CS back to __KERN_CS via far jump.

I don't know how slow is to do the jump back via far jump.

2) Implement some weaker version of what I was proposing and mostly checking the 
%ss. The attacker would need to control/load %SS before jumping to endbr64 or 
provide a reasonable exception stack

SYSCALL:
- maybe do "cli" to avoid issues with interrupts/nesting
- would use valid but different %ss selector from __KERN_DS
- would check if %ss == __KERN_CHECK_DS, if not panic
- reload %SS with __KERN_DS selector

IDT entrypoints:
- maybe do "cli" to avoid issues with interrupts/nesting
- if %SS == 0, skip other checks because CPL changed (maybe too weak?)
- perform more sanity checks on exception stack maybe in a direction what I 
proposed in other email - depends if it makes attacker life miserable or not
- reload %SS with __KERN_DS selector if CPL changed (maybe needed?)

>> And very last idea would be to somehow persuade the Last Branch
>> Recording to record exception entries only and just check it from MSR.
>> But maybe it is too costly and/or not possible.
> 
> This doesn't cover all cases, I don't think.  It also won't work under
> virt, where LBR isn't reliably available.  Also LBR is reasonably full
> of errata, and quite slow.

OK thanks, it was just an idea.

Thanks,
Rudolf


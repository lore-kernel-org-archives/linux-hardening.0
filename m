Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8325E81A;
	Wed, 26 Feb 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610135; cv=none; b=MNUeYpyROeh+4PzTwDpqbu5X1wQVzcbO9M3L3Gtwf2lPdGEwagSEHhAOfffJ6p8+Qy1XSKBX80wxagfkazQJy+ZCJsS030OULBiOvZwaJJgNJ2ZOJlRshEpzVCvBnsx5VeM/lLaq77HZdsNX33UPO2G/WzralSqnEfT+GT5QsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610135; c=relaxed/simple;
	bh=GB66l7DCSsgFBNQM0YRk5SJK5IcBy6j62f4sABcXj3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV+DOjUN6PGR7uGWnvJPiMKxEKmOsmg0KUF8/9+kf5SclMVPbP5qkvt/+OkCKJpWNQ0UV85IOZJxQmtGpTpKarAEw+0/D0Rm+S1v3m/sUe80poFy3YzDtR/W0NaiabeAV8HJWnf2JS3AaImbXGILwMzalShCkgbcxfGWBSL2IEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <73ef8000-661e-47b4-a8b0-a02d3a849645@assembler.cz>
Date: Wed, 26 Feb 2025 23:48:14 +0100
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
Content-Language: en-US
From: Rudolf Marek <r.marek@assembler.cz>
In-Reply-To: <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Hi Andrew,

Dne 25. 02. 25 v 22:14 Andrew Cooper napsal(a):
> As stand-in for "the reader", I'll point out that you need to add #DB to
> that list or you're in for a rude surprise when running the x86 selftests.

Thanks for pointing this out. I forgot about the interrupt shadow on SYSCALL
and possibly some breakpoints possibilities in the kernel.

>> The SYSCALL/SYSENTER startup has interrupts disabled, so it is the
>> problem of NMI/#MC
>> handler which would need deal with the normal case and attack case.
> 
> Right, but in the case of the attack, regular interrupts are most likely
> enabled too.  And writing this has just caused me to realise a
> yet-more-fun case.
> An interrupt hitting the syscall entry path (prior to SWAPGS) will cause
> the interrupt handler's CPL check and conditional SWAPGS to do the wrong
> thing and switch onto the user GS base too.  (Prior research e.g.
> GhostRace has shown how to get an hrtimer to reliably hit an instruction
> boundary.)

I don't see it, because if attacker starts at syscall entry and interrupts are 
enabled and the interrupt happens right there the handler will just see proper 
IRET frame with %cs of kernel and will not perform swapgs. I will try to think 
about it again tomorrow I likely missed something.

> Interrupts and exceptions look at %cs in the IRET frame to judge whether
> to SWAPGS or not (and this is one of the main things that paranoid_entry
> does differently).  In the case of the attack, there's no IRET frame
> pushed on the stack and the read of %cs is out-of-bounds, most likely
> the stack frame of the function which followed the corrupt function pointer.

Thank you for your detailed explanation.

> The SYSCALL entrypoint is simply the easiest to pivot on, but all can be
> attacked in this manner.  Fixing only the SYSCALL entrypoint doesn't
> improve things much.

Maybe more elegant and cheap check on IDT entry "authenticity" would be to check 
for current %ss which needs to be NULL and possibly check the %CS on stack frame
by checking kernel %cs and not just two CPL bits and/or perform more checks.

Another ideas if you think it is still worth to discuss this topic:

What about to use completely different %CS selector for all entry code? The 
early entry code would check the %cs selector and panic if it is wrong one.

After swapgs dance, we need to perform far jump to normal kernel %CS, which 
might cost something.

To fix the interrupt on fake entry problem, we could check in relevant IDT 
handlers that we never come from "completely different" %CS used above for the 
early entry code.

And very last idea would be to somehow persuade the Last Branch Recording to 
record exception entries only and just check it from MSR. But maybe it is too 
costly and/or not possible.

Thanks,
Rudolf



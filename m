Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AA1D63D3;
	Sat, 22 Feb 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257444; cv=none; b=DuMDz2QEcgVNdL4xVDE+YgDSG8CeE5aX65FZioQPc6GRoW3BG6kKMMUqdFrMFdREey3DTBRugqEh9m+zEilWWNeNGCNLQZve86bYOTmOGtouQqJwEDrEe6eo+udJ38o1rTl4X2Ph/KFReTZqYERXN8xBVK+F8BQPmyklPervDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257444; c=relaxed/simple;
	bh=kcHyPYJb28bHH5abHA7/j70IiajgjFyIlnoc2KlKKqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTniV5vCKmoL7HK7/Vcdf41HSsQ/Juv8JgakIAH0Dys6bfbwNd6PnFHIVrcV8Eq0l5O3mXJulJgcbF9Fcy/1Bxzppxs16MWan5iURB2L0XDmkoEpt/8inyN+zrc48rGguvoSrxN8PFeJiKRWSppz32/6nO7s08NfH7aWvik1n6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
Date: Sat, 22 Feb 2025 21:43:42 +0100
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
Content-Language: en-US
From: Rudolf Marek <r.marek@assembler.cz>
Autocrypt: addr=r.marek@assembler.cz; keydata=
 xsBNBFN2VH4BCADpv+3Tkikr+X489Xso9UC719YdxgGiy0xBjDiWC22wAd3tHy6G3nEhWfh4
 1UNGcqscPAvJMn2GhgSJRfBzj0wALXLkoTYta78wEK+Ji+Gs7PX9VhqRKt9/OIn/2XJ1Yv9i
 e8uo9MFBGFCB5roz+Ws8rdXq0Quu7VZylzRv7qqhxMAk9RvXCT2tyt6XY16R7ZEL9wbSLRAl
 h8LRPMF0iiLH1YenfSCX2XkW7eA7CJSjh9pwIBFOF5cd5mcT69OPO+TuAbdvgCcZPEoQQBhk
 QmOr2PlUOl3CSgqtTxjAjAxXhPTU7Q3xxgB2Oa7xbt3Eic2Z4lltP/dowULZqXvsC5DxABEB
 AAHNI1J1ZG9sZiBNYXJlayA8ci5tYXJla0Bhc3NlbWJsZXIuY3o+wsCVBBMBCgA/AhsjBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBJmYg4ih63dUUwlgxcBvbatkz11wBQJnOaU1BQkV
 pALyAAoJEMBvbatkz11wgYUH/2Cs+hmNUj5f8z1xI8O07OL8KfxiWAv1DVq+QEGsbhdub/pH
 cNbCP52hioIjr48ylpE4PriuxPxC5zd6/s/z1fJQXPc2rd9xfKMsC7ZmpIjfzTzoX9JuINhW
 cwY+SFXOFuVUT2UacaowLTVX1NVevLhqb1wxSgGe1KAyqWBllrUYI/tqDF20MuzYDkuL0TdJ
 fSk3mfrF+GWG7DSzH27kwmY1ui4QUnW7PQ23c56xuRAtRDPhTgaglk52Pz7IsQHfy8rPZmTE
 jFTaN6kdW324wZYGYJBCriffNaIekz+C+i7aRivABNpeAY2O5ae6qcZknalGrU71M8p2TULA
 tSGNCc7OwE0EU3ZUfgEIAOyD3W4D+aaXoA875pbKqSI+MQ2t5PYNPaCahoSSnTuNmvM1xCsv
 I2EaGwfr5S0IktX1g0dt8lvvCx9eZeEhGH5NBgsmWtTi0Gq9UHQXbj4wQAV23/X+MCZqKFFl
 Yp0T86C23RhXsEQp8mTYpnGsbjAsHgaDnuQj5pWahVGXv9aYzjomk4mEGq8jr8/D9kgOEll+
 s5cIJYzeliPHR+2SRQs+XoTp1e/dXs310xXhuo2Pg8N/Kym0WhWjTYBuUeoyaYFDYtwj6jkc
 2baI/JOSUoyarxnmRuVcNHoZd7as7lzmPS9Dqrm5LJVrfQk0lx+XaJRPZqQW/uf5FFaGXIIi
 2OkAEQEAAcLAhgQYAQoAJgIbDBYhBJmYg4ih63dUUwlgxcBvbatkz11wBQJnOaU1BQkVpALy
 ABQJEMBvbatkz11wCRDAb22rZM9dcA/zCADBJl5FizQY1GWQ0hdaRLpFelc5TMnB58LQXLs+
 b0cbCGHSCYdB8u4EwBcMF55qF2MT6Owd7ydjFoLY7WdQYcorbMPw91LFqLEuA/mQnaWtrSV5
 XyBcFHIRNH1ZtHL+28ywyDZY0GE13R3IoNh8E25JFeEBdR5uWH/1+Y7v3VCFkDp8VX3Pa+66
 AyicyWjrWKf0ADPWcAuyF8kVqJv+61FnOUE9M/23CNp5y+9cWJnViYK015c9l04xdrcwPra9
 XVGi/hKZ6EIEiqFa55LHmoB4QLOYbYVC9xMoDnKYDuBfU4VlyTe6//eSRHc3wer7/avb1gKC
 EDihgW9OFim1SsU6
In-Reply-To: <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Hi,

Dne 13. 02. 25 v 3:42 Andrew Cooper napsal(a):
> The SYSCALL behaviour TLDR is:
> 
>      %rcx = %rip
>      %r11 = %eflags
>      %cs = fixed attr
>      %ss = fixed attr
>      %rip = MSR_LSTAR
> 
> which means that %rcx (old rip) is the only piece of state which
> userspace can't feasibly forge (and therefore could distinguish a
> SYSCALL from user vs kernel mode), yet if we're talking about a JOP
> chain to get here, then %rcx is under attacker control too.

The SYSCALL instruction also provides means to create "incoherent" state of the processor selectors
where the value of selector do not match pre-loaded values in the descriptor caches.

Would it work to have KERNEL_CS as last entry in the GDT table? Therefore executing SYSCALL would set the CS as usual,
but the numeric value of SS selector would be larger than GDT limit?

That would mean that "impossible" selector is loaded into SS if we came from usermode,
but operation with stack would still work as the descriptor caches will be sane.
The "impossible" selector value can be fixed by loading SS with NULL which is cheap.

The check in hotpath could maybe use VERR %SS which would fail because of GDT limit is reached. The VERR with mem operand
does not use any GPR!

Or simply check for "impossible" selector would work if we misuse zeros in high32 of R11 (usermode rflags) maybe like:

entry:
endbr64
rol $32, %r11
movw %ss, %r11w
cmpw $IMPOSSIBLE_SEL, %r11w
jnz panic
; load null to SS, fix R11 and pretend above never happened

If attacker would execute SYSCALL in the kernel, likely we could check the %RCX if it is OK or not?

Bit variation to this "theme" would be to have SYSCALL SS GDT entry still in the GDT but set as "not present".
Another brainstorm idea would be to misuse RFLAGS.ID and clear it in MSR FMASK but run kernel or most of it with RFLAGS.ID set.
I don't know what is the threat model you are trying to fix.

Lets fight x86 insanity with yet another x86 insanity - I think it is fair.

I hope above helps or at least I will learn why not if I overseen something obvious!

I tried to CC all the lists. I'm not subscribed.

Thanks,
Rudolf

PS: I'm leaving as an exercise to a reader NMI and #MC handling!


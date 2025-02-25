Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0239ACC;
	Tue, 25 Feb 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514041; cv=none; b=OF4IqaUFz7EaEd6NjBgDvZHorhHWTb4yHsOuuGoKBayG1rducYwwHeZOkSHnewrI8gqom4x18/LoWdOSB1lbRLh+9Rn81mIKdgNTx/DgfN+s2MjonXpuDfI6Lljjbh8CAi3p0EoWwTvEXpAvzZ9vHvD2QwKSQ9aaTv80KIflg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514041; c=relaxed/simple;
	bh=O1Syw3fgKkrvZzVika0gY7DMfDsb5ZEuf9BQ7yVSbM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phI8U85BY2CI4mngxICz//9QRUKpcS6kj/58jECD5J40zN58beaIpwuAEc7Oi5jRNvWK48ttYoj/Y236DhrVkDtJCQK1+JZ2+PBiMGI3P0Qqy1h58zILyKwq3433QEpVpYkTpGrTcqZyWe0qsUiK2rYWsIyjC1jZaO8j5SBLNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
Date: Tue, 25 Feb 2025 21:06:39 +0100
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
In-Reply-To: <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Hi Andrew,

Dne 25. 02. 25 v 19:10 Andrew Cooper napsal(a):
> Very cunning.  Yes it does, but the state needs to be safe to IRET back
> to, and ...

... And intellectually very pleasing!

>> Would it work to have KERNEL_CS as last entry in the GDT table?
>> Therefore executing SYSCALL would set the CS as usual,
>> but the numeric value of SS selector would be larger than GDT limit?
> 
> ... this isn't safe.  Any exception/interrupt will yield #SS when trying
> to load an out-of-limit %ss.> i.e. a wrongly-timed NMI will take out the system with a very bizarre
> looking oops.

Hmm I was hoping that "the reader" will perform this NMI/#MC exercise :)

The SYSCALL/SYSENTER startup has interrupts disabled, so it is the problem of NMI/#MC
handler which would need deal with the normal case and attack case.

It would need to check if it was executing that critical part of syscall64 entry
from endbr64 to checkselector section, and if yes, the saved %ss needs to be
"impossible" one. If it isn't -> panic.

For non-attack case it just needs to forward RIP after the check...

> You can do this in a less fatal way by e.g. having in-GDT form have a
> segment limit, but any exception/interrupt will resync the out-of-sync
> state, and break detection.  Also it would make the segment unusable for
> compatibility userspace, where the limit would take effect.

Yeah couldn't figure out what else could work "vice-versa" :(
  
> Finally, while this potentially gives us an option for SYSCALL and maybe
> SYSENTER, it doesn't help with any of the main IDT entrypoints which can
> also be attacked.

I see, sorry I wasn't aware of this. But if I recall correctly only "paranoid"
IDT entries do something with swapgs. But is there also some stack pivot where
it would depend on GS? Or is it somewhat unrelated issue, that you might just
redirect to "any endbr64" which are IDT entrypoints?

Maybe you can share some details of how the attack would work in this case,
or point me somewhere where I can read about it.

If it is "any endbr64" case, would it work to just do "sanity check" of the exception stackframe?

I mean if it is real or some random kernel stack state?

1) check %RSP alignment if it was ok
2) check if %ss and %cs for all possible valid values (16 bit)

Unfortunately I think intel is not clearing high 48 bits of saved selector, AMD is.

3) check if %rip is kernel range
4) check if %rflags is sane (bit1 is 1)

Because if the attacker has no or limited control on the stack content, it would be difficult to fake it.

Thanks,
Rudolf


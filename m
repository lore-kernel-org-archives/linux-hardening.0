Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676F3597E;
	Sun,  2 Mar 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740942995; cv=none; b=BWnhzXDvhds/7Ig94NEwQ7LGOJv9izrpNarYbBIoVhVKgNM2ujWCferiPann8GyoZfACEXh4d+CuI2RGyw34OektlYtP/osLwR2DVJ7lXyTUTWZs2Bj+mPnzUs9/RmkfVpwyucL4CrCbUs/dbjHaFRg3c2LEtqIVaeqa04Y73ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740942995; c=relaxed/simple;
	bh=iXG+3XqgniYQOuEizDmWM33l60dJOaoVCrQKxTxtltU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ri7gIDVQeUv/pyKAUTD0xNo4W5Rd3j3WZ0ELMZ2ZuWFnc5RVh7z5TupShQulqNPxF1KnZF+6wjeioC35TcgaZkbOVpjNk1bkNeJ1UIVhaWMnhzbbQbB5PkJn1INR7CeAOHpJIuBViI8aKL813OGARp5lXTYqZFxEsZdnBaR11vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <aae74f5e-454e-4de7-839e-bfd5be865a82@assembler.cz>
Date: Sun, 2 Mar 2025 20:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
From: Rudolf Marek <r.marek@assembler.cz>
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
 <b99d222e-e65e-4865-8035-12ce889c4388@assembler.cz>
Content-Language: en-US
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
In-Reply-To: <b99d222e-e65e-4865-8035-12ce889c4388@assembler.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Dne 01. 03. 25 v 23:48 Rudolf Marek napsal(a):
> I don't know how slow is to do the jump back via far jump.

I did some micro benchmark on Raptorlake platform using other operating system I'm very familiar with.

I added following sequence to the SYSCALL64 entrypoint:

  .balign 16
syscallentry64:
     .byte 0x48
     ljmp *jmpaddr(%rip)
continuehere:
      swapgs
<...>

jmpaddr:
.quad continuehere
.word KERN_OTHER_CS << 3

And well, it is  1.5x slower. Unmodified syscall benchmark took on avg 261 cycles / 104 ns and the one with the indirect jump with %cs change took
386 cycles/ 154 ns.

This whole thing is quite literally a trap next to a trap, because GAS wasn't adding REX.W prefix and somehow complained about ljmpq.

Thanks,
Rudolf


Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8D155733
	for <linux-hardening@vger.kernel.org>; Fri,  4 Oct 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041872; cv=none; b=rGX+o+KM6lN3F+U1e/5T8qbrdVx/UBiWSSrVLl0ZTsPowEsKeZUnx0UwKmsuCZW2Ovt/OL7lumPiPRSM5fJUjYQzK8NxjH7+z3cJ6scrhwYFQNDtZrHjXWCqb2vegY8sa6YvNENh1UoZRG4vuvgtM+yKnil9l1vauhXcTtUUj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041872; c=relaxed/simple;
	bh=sH3VJvUt/ZZiYrCq6joa70NKvu6D+uNYLHx6ls09DW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISRR/KcHpCADyl5S8nqSOELiSucTfCRD/tYhLIx+Qeh1lz0KQKHSHaTIF1nfcPs/y6bqzzSSBxyB5oIg8hidFC9RhX3NOKFPRbRg4eBjhVDhkp6Q+4Ji3+0vgL93pxR/nLJW3z/630sOOVZoBQHfjo3Yf1ysc4nmcT43+lSir/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 109F3FF803;
	Fri,  4 Oct 2024 11:37:44 +0000 (UTC)
Message-ID: <0c9371f2-e8e9-479f-856d-408a81213747@ghiti.fr>
Date: Fri, 4 Oct 2024 13:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
To: Kees Cook <kees@kernel.org>, Jason Montleon <jmontleo@redhat.com>
Cc: linux-hardening@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-riscv@lists.infradead.org
References: <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
 <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook>
 <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
 <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
 <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
 <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
 <CAJD_bP+ZYKFaeZ2hQXjAZda=RhLkfnXfGLW-ZYTrOV4GfNRzpA@mail.gmail.com>
 <202410031417.A5AB8BA5@keescook>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <202410031417.A5AB8BA5@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Kees, Jason,

On 03/10/2024 23:21, Kees Cook wrote:
> On Thu, Oct 03, 2024 at 01:12:59PM -0400, Jason Montleon wrote:
>> On Thu, Oct 3, 2024 at 10:41 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>> So I was able to reproduce the issue on qemu by adding a few tweaks, and
>>> indeed we trap in __warn_printk() on a virtual address but MMU is not
>>> enabled yet.
>>>
>>> The following diff though allows me to pass this failure but I can't get
>>> much further in the boot since the tweaks I added won't allow it, can
>>> you give the following a try?
>>>
>>> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
>>> index 8a27394851233..4913f3b3f198c 100644
>>> --- a/arch/riscv/errata/Makefile
>>> +++ b/arch/riscv/errata/Makefile
>>> @@ -2,6 +2,10 @@ ifdef CONFIG_RELOCATABLE
>>>    KBUILD_CFLAGS += -fno-pie
>>>    endif
>>>
>>> +ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
>>> +KBUILD_CFLAGS += -D__NO_FORTIFY
>>> +endif
>>> +
>>>    obj-$(CONFIG_ERRATA_ANDES) += andes/
>>>    obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
>>>    obj-$(CONFIG_ERRATA_THEAD) += thead/
>> Yes, this worked.


Great; thanks!


> Thanks for testing!
>
> Yeah, this matches similar fortify disabling in other early boot areas.
> Usually it's part of a common header, but setting it via the Makefile
> also works. I'll leave it up to the riscv maintainers! :)


I found a few other spots where we did not disable fortify, the easiest 
path I found was indeed to do that in the Makefile.

I have a question though: should we do something about the following 
warnings? Is there something wrong somewhere?

Wanted to write 8 to a 0-sized destination: oldptr at 
arch/riscv/errata/thead/errata.c:185
Wanted to write 28 to a 0-sized destination: oldptr at 
arch/riscv/errata/thead/errata.c:185

Thanks,

Alex


>
> -Kees
>

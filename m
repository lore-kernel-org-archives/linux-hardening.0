Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80803502A9
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595633; cv=none; b=m0rHr9nJiiLd9eQQb5h0vAaJHK1Cz8uk0+vdmaK90URzSDbkTiQdy6wx/ohk7hO/yeKFsQV/5eRenQTQicu/JfSCf7VpHk71lNwhp0tS+ps1UjrkamZAwz4qpxB+0ElqyBhJJeOMRXqcbUf5XaORhmJXvw45jKxc3Ou5BOZpndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595633; c=relaxed/simple;
	bh=OYsKNV19PQX62y7E4qX/SuXOfdCpxHs4fHWwNa85hN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dz3kYJCmT6LivnkEs0UIQVkjdWqcsQDfNWReZbG17s4qvgNQWi8Og262DPFVbQpFVUgzqr1Jw+4Oq98oaimW0pq1KOOazEWyISh2FE5oeKevSIAlEdPPGipiyQ0Z5bi8JTwkCUmCx5yqrXFLFzm8bj7XgOHsFoXPqXQ/+qs4NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cobfuJBk; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cobfuJBk"
Message-ID: <e9a8e91e-cbf0-4f97-b103-cbb0fad9d29d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781595619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouP0UoBWS15UkYwpNT7tDCm7yXpR85KS/mDkr1eYXeE=;
	b=cobfuJBklIyILuFPp2Exfsxs7v/7kepnLYhnJkfQ4gyKnInOVXxMR+HhNCnvV3N2TPn29s
	soZnt7CTUOTmRacfQiLQ3pdDfg3AMf7qLmjRn3qN8VZgxFUcTNGelZJtZcEAvfAiQKu18E
	hSeGluHmod7pwCLG8wyIfgdm04vYDqs=
Date: Tue, 16 Jun 2026 15:40:10 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] genirq: Add the entropy pool function to the PPI
 interrupt handler
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
 linux-hardening@vger.kernel.org
References: <20260616055042.3923-1-enlin.mu@linux.dev>
 <2026061620-unselfish-barber-c467@gregkh>
 <476066de-b7e0-4400-a9e1-17b045defa80@linux.dev>
 <2026061658-unable-rarity-3253@gregkh>
 <1ec9d261-1f42-4553-8a09-0ba40c93f786@linux.dev>
 <2026061633-preseason-framing-7acc@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "enlin.mu" <enlin.mu@linux.dev>
In-Reply-To: <2026061633-preseason-framing-7acc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/16 15:24, Greg KH wrote:
> On Tue, Jun 16, 2026 at 03:17:00PM +0800, enlin.mu wrote:
>>
>>
>> On 2026/6/16 14:48, Greg KH wrote:
>>> A: http://en.wikipedia.org/wiki/Top_post
>>> Q: Were do I find info about this thing called top-posting?
>>> A: Because it messes up the order in which people normally read text.
>>> Q: Why is top-posting such a bad thing?
>>> A: Top-posting.
>>> Q: What is the most annoying thing in e-mail?
>>>
>>> A: No.
>>> Q: Should I include quotations after my reply?
>>>
>>> http://daringfireball.net/2007/07/on_top
>>>
>>> On Tue, Jun 16, 2026 at 02:26:18PM +0800, enlin.mu wrote:
>>>> Hi KH
>>>>
>>>> hardware: raspberrypi 5
>>>>
>>>> other patch(These two locations impact the entropy pool acceleration.
>>>> comment them out temporarily):
>>>> acer@raspberrypi:linux $ git diff drivers/of/fdt.c
>>>> drivers/char/hw_random/iproc-rng200.c
>>>> diff --git a/drivers/char/hw_random/iproc-rng200.c
>>>> b/drivers/char/hw_random/iproc-rng200.c
>>>> index 33bc28f429f6..af105faa88c6 100644
>>>> --- a/drivers/char/hw_random/iproc-rng200.c
>>>> +++ b/drivers/char/hw_random/iproc-rng200.c
>>>> @@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
>>>>    };
>>>>
>>>>    static const struct of_device_id iproc_rng200_of_match[] = {
>>>> -       { .compatible = "brcm,bcm2711-rng200", },
>>>> -       { .compatible = "brcm,bcm7211-rng200", },
>>>> -       { .compatible = "brcm,bcm7278-rng200", },
>>>> -       { .compatible = "brcm,iproc-rng200", },
>>>> +       { .compatible = "brcm,bcm2711-rng2000", },
>>>> +       { .compatible = "brcm,bcm7211-rng2000", },
>>>> +       { .compatible = "brcm,bcm7278-rng2000", },
>>>> +       { .compatible = "brcm,iproc-rng2000", },
>>>
>>> What is this change for?
>> This driver accelerates the initialization of the entropy pool. If this
>> dirver is added, the optimization effect of my patch will no longer be
>> clearly observable.
> 
> Great, obviously your patch is not needed!
> 
>>
>>>
>>>
>>>>           {},
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>> index 331646d667b9..13308d58785d 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>>>
>>>>           rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>>>           if (rng_seed && l > 0) {
>>>> -               add_bootloader_randomness(rng_seed, l);
>>>> +               //add_bootloader_randomness(rng_seed, l);
>>>
>>> Why did you comment this out?
>> Before the kernel boots, the Raspberry Pi bootloader injects the rng-seed
>> property into the kernel's Device Tree to accelerate entropy pool
>> initialization. Therefore, I need to temporarily comment this out
>> to avoid interfering with the testing of my current patch.
> 
> Again, that seems like the correct fix, don't change the common code
> path of all systems just because you don't want to accept the changes
> that have already been made for your platform to resolve this very
> issue!

I think there might be a misunderstanding. The code below adds entropy 
pool initialization, but this logic is missing in the PPI interrupt 
handler. I believe this was simply an accidental omission.
---------------------------
irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
{
	irqreturn_t retval;

	retval = __handle_irq_event_percpu(desc);

	add_interrupt_randomness(desc->irq_data.irq);

	if (!irq_settings_no_debug(desc))
		note_interrupt(desc, retval);
	return retval;
}
> 
> thanks,
> 
> greg k-h


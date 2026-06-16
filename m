Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602130F94B
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597782; cv=none; b=rXZPaX8FETee5+ctiCuaRf+Xz88VK9i7WOlMLaAKxvBmNaeGymu/zwIix8bBUUc7e3OnQTxsHNJhg89SFopsdtxvkex4X389klVxlC7nWSEKreUW1/FYdVkXjsngvDqe6zpz79uch4Y9Kdzqc9fuNm4cYXE0501VLwChjvkzYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597782; c=relaxed/simple;
	bh=9gpqymqX/Y/FeGjY9AL/xA8zq4ZVNtXlwL1BkUGmUvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqPCfzBaoJ6/Gd3jUKWz2wSkui4STUGMdW5+7r+pRLENkZbcDIe5sZjyYr32omxkLDvlftd9P7o/tracnWo3W9ruEupkYZ4nJo/nCy+bx3ETpN4Wbe9Z367u6YIKkZu/mPZfOjQpXBmvzPnowgHtsQDUxJqC42GyRtFzbB8jJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ob/J475e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ob/J475e"
Message-ID: <c740b778-88f8-4083-8d20-4455f259e2a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781597778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yb8EP4E9sWi30kza3cexIJGDgQEyaJB3Iwbf/bFQ1g=;
	b=ob/J475e8gc1fjBwJ1Hfvo+9RRba8DRBj8o5bHuig2Fq/vUUWDWsNXsuJDBCdG76wMk4g4
	Hp+RwrlLd4BsGtxlcioNz6QrrWuikq2BS8WPWAQsUFM9YcPhdzaF9cRS5EtC8IBJw9Pe5E
	McuFgg3GkM38uuG9876wO644KQOrjZM=
Date: Tue, 16 Jun 2026 16:16:10 +0800
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
 <e9a8e91e-cbf0-4f97-b103-cbb0fad9d29d@linux.dev>
 <2026061636-boxlike-trimmer-13ca@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "enlin.mu" <enlin.mu@linux.dev>
In-Reply-To: <2026061636-boxlike-trimmer-13ca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/16 15:49, Greg KH wrote:
> On Tue, Jun 16, 2026 at 03:40:10PM +0800, enlin.mu wrote:
>>
>>
>> On 2026/6/16 15:24, Greg KH wrote:
>>> On Tue, Jun 16, 2026 at 03:17:00PM +0800, enlin.mu wrote:
>>>>
>>>>
>>>> On 2026/6/16 14:48, Greg KH wrote:
>>>>> A: http://en.wikipedia.org/wiki/Top_post
>>>>> Q: Were do I find info about this thing called top-posting?
>>>>> A: Because it messes up the order in which people normally read text.
>>>>> Q: Why is top-posting such a bad thing?
>>>>> A: Top-posting.
>>>>> Q: What is the most annoying thing in e-mail?
>>>>>
>>>>> A: No.
>>>>> Q: Should I include quotations after my reply?
>>>>>
>>>>> http://daringfireball.net/2007/07/on_top
>>>>>
>>>>> On Tue, Jun 16, 2026 at 02:26:18PM +0800, enlin.mu wrote:
>>>>>> Hi KH
>>>>>>
>>>>>> hardware: raspberrypi 5
>>>>>>
>>>>>> other patch(These two locations impact the entropy pool acceleration.
>>>>>> comment them out temporarily):
>>>>>> acer@raspberrypi:linux $ git diff drivers/of/fdt.c
>>>>>> drivers/char/hw_random/iproc-rng200.c
>>>>>> diff --git a/drivers/char/hw_random/iproc-rng200.c
>>>>>> b/drivers/char/hw_random/iproc-rng200.c
>>>>>> index 33bc28f429f6..af105faa88c6 100644
>>>>>> --- a/drivers/char/hw_random/iproc-rng200.c
>>>>>> +++ b/drivers/char/hw_random/iproc-rng200.c
>>>>>> @@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
>>>>>>     };
>>>>>>
>>>>>>     static const struct of_device_id iproc_rng200_of_match[] = {
>>>>>> -       { .compatible = "brcm,bcm2711-rng200", },
>>>>>> -       { .compatible = "brcm,bcm7211-rng200", },
>>>>>> -       { .compatible = "brcm,bcm7278-rng200", },
>>>>>> -       { .compatible = "brcm,iproc-rng200", },
>>>>>> +       { .compatible = "brcm,bcm2711-rng2000", },
>>>>>> +       { .compatible = "brcm,bcm7211-rng2000", },
>>>>>> +       { .compatible = "brcm,bcm7278-rng2000", },
>>>>>> +       { .compatible = "brcm,iproc-rng2000", },
>>>>>
>>>>> What is this change for?
>>>> This driver accelerates the initialization of the entropy pool. If this
>>>> dirver is added, the optimization effect of my patch will no longer be
>>>> clearly observable.
>>>
>>> Great, obviously your patch is not needed!
>>>
>>>>
>>>>>
>>>>>
>>>>>>            {},
>>>>>>     };
>>>>>>     MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
>>>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>>>> index 331646d667b9..13308d58785d 100644
>>>>>> --- a/drivers/of/fdt.c
>>>>>> +++ b/drivers/of/fdt.c
>>>>>> @@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>>>>>
>>>>>>            rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>>>>>            if (rng_seed && l > 0) {
>>>>>> -               add_bootloader_randomness(rng_seed, l);
>>>>>> +               //add_bootloader_randomness(rng_seed, l);
>>>>>
>>>>> Why did you comment this out?
>>>> Before the kernel boots, the Raspberry Pi bootloader injects the rng-seed
>>>> property into the kernel's Device Tree to accelerate entropy pool
>>>> initialization. Therefore, I need to temporarily comment this out
>>>> to avoid interfering with the testing of my current patch.
>>>
>>> Again, that seems like the correct fix, don't change the common code
>>> path of all systems just because you don't want to accept the changes
>>> that have already been made for your platform to resolve this very
>>> issue!
>>
>> I think there might be a misunderstanding. The code below adds entropy pool
>> initialization, but this logic is missing in the PPI interrupt handler. I
>> believe this was simply an accidental omission.
>> ---------------------------
>> irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
>> {
>> 	irqreturn_t retval;
>>
>> 	retval = __handle_irq_event_percpu(desc);
>>
>> 	add_interrupt_randomness(desc->irq_data.irq);
>>
>> 	if (!irq_settings_no_debug(desc))
>> 		note_interrupt(desc, retval);
>> 	return retval;
> 
> Look back at your original patch.  It contained none of this
> information...

My apologies. I mistakenly assumed the context was obvious, but I 
realize now that it should have been explicitly documented in the 
original patch. I will send a v2 patch immediately with all this 
information added to the commit message.


Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1936F909
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594232; cv=none; b=QPnofYDoEt+S0r4YQu5Mqd6iksFuLeZlHiysgG9RJ0tNR4tuMOFGwQyDp/9XF1QYmjbvapij5xRy1tRsKEVhzoaTIXfToq0GHq9JD7Y0Y73dCeQdZR2RX3R/IyUnkAaYv7O3AwtnF9sv7mKyUq8PKJE54iSY2AIsL+DZykN7t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594232; c=relaxed/simple;
	bh=QxOMsOcVVymKa/YCLC2radDDB7ND7v4zalY/4rd13zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL5zFCyq8mS487MYGEi4CwQJ3qz07RvHhLDa6EisgE5fYmpiqaDfE+DZNqKIxoBi0NXPEXMLwronuNFUlGvckBOSDa5xVUnc/cYwHK6O7DS0rzBrl6GWocG+yI4EixtonyDe0n+2GxO/WL9IoEdquwHkAt83+XpMDw9BDum0OYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFrPfm0h; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFrPfm0h"
Message-ID: <1ec9d261-1f42-4553-8a09-0ba40c93f786@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781594228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZseWj4+6+BmJ2wcoMRM94msK+xhEYJpTMy+obLbWLw=;
	b=kFrPfm0hksvu7GXWNjc6OEMLtlIJPDOwFMqjVRMBfxFJfAq96dRhZ3eVkC/ptU05AyFMuW
	PMPYvod9J91ARCqkxPoLxu0twlRKKLqtdNZxUjtgfOYctB+K/QhWQOMJGZno7GiGqRF87t
	+xaBA0QuG5hdt8Y2XvRgKgrq2IlTBvA=
Date: Tue, 16 Jun 2026 15:17:00 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "enlin.mu" <enlin.mu@linux.dev>
In-Reply-To: <2026061658-unable-rarity-3253@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/16 14:48, Greg KH wrote:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Tue, Jun 16, 2026 at 02:26:18PM +0800, enlin.mu wrote:
>> Hi KH
>>
>> hardware: raspberrypi 5
>>
>> other patch(These two locations impact the entropy pool acceleration.
>> comment them out temporarily):
>> acer@raspberrypi:linux $ git diff drivers/of/fdt.c
>> drivers/char/hw_random/iproc-rng200.c
>> diff --git a/drivers/char/hw_random/iproc-rng200.c
>> b/drivers/char/hw_random/iproc-rng200.c
>> index 33bc28f429f6..af105faa88c6 100644
>> --- a/drivers/char/hw_random/iproc-rng200.c
>> +++ b/drivers/char/hw_random/iproc-rng200.c
>> @@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
>>   };
>>
>>   static const struct of_device_id iproc_rng200_of_match[] = {
>> -       { .compatible = "brcm,bcm2711-rng200", },
>> -       { .compatible = "brcm,bcm7211-rng200", },
>> -       { .compatible = "brcm,bcm7278-rng200", },
>> -       { .compatible = "brcm,iproc-rng200", },
>> +       { .compatible = "brcm,bcm2711-rng2000", },
>> +       { .compatible = "brcm,bcm7211-rng2000", },
>> +       { .compatible = "brcm,bcm7278-rng2000", },
>> +       { .compatible = "brcm,iproc-rng2000", },
> 
> What is this change for?
This driver accelerates the initialization of the entropy pool. If this 
dirver is added, the optimization effect of my patch will no longer be
clearly observable.

> 
> 
>>          {},
>>   };
>>   MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 331646d667b9..13308d58785d 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>>
>>          rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>>          if (rng_seed && l > 0) {
>> -               add_bootloader_randomness(rng_seed, l);
>> +               //add_bootloader_randomness(rng_seed, l);
> 
> Why did you comment this out?
Before the kernel boots, the Raspberry Pi bootloader injects the 
rng-seed property into the kernel's Device Tree to accelerate entropy pool
initialization. Therefore, I need to temporarily comment this out
to avoid interfering with the testing of my current patch.
> 
> 
>>
>>                  /* try to clear seed so it won't be found. */
>>                  fdt_nop_property(initial_boot_params, node, "rng-seed");
>> acer@raspberrypi:linux $
>>
>> Before testing:
>> acer@raspberrypi:linux $ dmesg | grep rng
>> [    3.360898] random: crng init done
>>
>>
>> After testing:
>> acer@raspberrypi:~ $ dmesg | grep rng
>> [    2.808880] random: crng init done
> 
> I think people have talked about irq "randomness" lots of time in the
> past, you need to provide lots of real documentation about why this time
> it is somehow "different".
The test results shown above are just from a single run. Based on 
multipe test runs, the overall performance gain is approximately 0.3 to 
0.5 seconds.
> 
> thanks,
> 
> greg k-h


Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C80231A41
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591196; cv=none; b=hJEg09/Z5EPUCxpWpaKoYtrTHUnTYkNTuaKW2ba5+QQY+TfaJcUhsDERzqFVf8t3cRQhbLaysl02gX1/8apmanCVFRkJzD2BNjTYjAERommfglngoDTtWOy4efu4Btz8R5uhNIjS9AR0EB/o4olVhmrc5iAEcKiIuZjftLN0oUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591196; c=relaxed/simple;
	bh=y4Mts+W6GWMTn8KZxumdRCqGOMp9UI9iyMFzplnbND4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B571ltQCvEfQIcAq7EuIL5Dm4pvTq2m0QeJ0bijWeDdKoiUPCpfKmTqNdM0y1Viyj8aAJyxcOtUUon4nwnwTW3DzvmvvPdzXkAvUdOx/vZAXdDYmLqedlcep/WBdda0VqM7xsi1tbjAIXbR8oUSMze8XOI6CylEJCjPteJZj+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bqlzaz/s; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bqlzaz/s"
Message-ID: <476066de-b7e0-4400-a9e1-17b045defa80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781591192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDf91FLyveH+14P0UvDDhOR2uCIt+iq8Z/mS3yd4J78=;
	b=bqlzaz/s872hC5FPbPp/8rGjmJuvVy6Q3n4D/zEVJ4TsqFoWskjPbbDqA23f1BgPrDC3KO
	v+zfxgVQ9u+TUzttzKVj/3Am94t4d/QIEM7xNfTczRG5cwfn0dAc14xFZ+M3WNytqt6cHA
	1x/wfQzbP64Kwu2wmRUA/F9taGQN6Ro=
Date: Tue, 16 Jun 2026 14:26:18 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "enlin.mu" <enlin.mu@linux.dev>
In-Reply-To: <2026061620-unselfish-barber-c467@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi KH

hardware: raspberrypi 5

other patch(These two locations impact the entropy pool acceleration. 
comment them out temporarily):
acer@raspberrypi:linux $ git diff drivers/of/fdt.c 
drivers/char/hw_random/iproc-rng200.c
diff --git a/drivers/char/hw_random/iproc-rng200.c 
b/drivers/char/hw_random/iproc-rng200.c
index 33bc28f429f6..af105faa88c6 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -296,10 +296,10 @@ static const struct dev_pm_ops iproc_rng200_pm_ops = {
  };

  static const struct of_device_id iproc_rng200_of_match[] = {
-       { .compatible = "brcm,bcm2711-rng200", },
-       { .compatible = "brcm,bcm7211-rng200", },
-       { .compatible = "brcm,bcm7278-rng200", },
-       { .compatible = "brcm,iproc-rng200", },
+       { .compatible = "brcm,bcm2711-rng2000", },
+       { .compatible = "brcm,bcm7211-rng2000", },
+       { .compatible = "brcm,bcm7278-rng2000", },
+       { .compatible = "brcm,iproc-rng2000", },
         {},
  };
  MODULE_DEVICE_TABLE(of, iproc_rng200_of_match);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..13308d58785d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1100,7 +1100,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)

         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
         if (rng_seed && l > 0) {
-               add_bootloader_randomness(rng_seed, l);
+               //add_bootloader_randomness(rng_seed, l);

                 /* try to clear seed so it won't be found. */
                 fdt_nop_property(initial_boot_params, node, "rng-seed");
acer@raspberrypi:linux $

Before testing:
acer@raspberrypi:linux $ dmesg | grep rng
[    3.360898] random: crng init done


After testing:
acer@raspberrypi:~ $ dmesg | grep rng
[    2.808880] random: crng init done




On 2026/6/16 13:59, Greg KH wrote:
> On Tue, Jun 16, 2026 at 01:50:42PM +0800, Enlin Mu wrote:
>> Accelerate the entropy pool initialization process
> 
> How?  Please explain.
> 
>> Signed-off-by: Enlin Mu <enlin.mu@linux.dev>
>> ---
>>   kernel/irq/chip.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index de754db414d1..cbbd7e7d1156 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -926,6 +926,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
>>   		trace_irq_handler_entry(irq, action);
>>   		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
>>   		trace_irq_handler_exit(irq, action, res);
>> +		add_interrupt_randomness(irq);
> 
> Are you sure this does anything measurable?
> 
> thanks,
> 
> greg k-h


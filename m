Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2BB2836BE
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286490; cv=none; b=XTfx2P3tWoZN/QtcQiKKcPFQ8TFuxy26ouNoGaykE0x/OqMMTj2WKhmVkFCupGFgsCbUpx0AIBo6JgAANwskdH/H4LHzKtb+lEtNILX1qrVVFULMEHqwmNzvurIfSjEzQiCuTjCsJVrhPiE0B98H50zp7vpmcTHMokdpcIKt0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286490; c=relaxed/simple;
	bh=8aKH3DYFXObiPNEfF4VluDyh0rfCmk2SNK5Buc2hyeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVX1mSzn6hRIdxNi9QsPAsO8bIohww13vFcBCvCEjs6KulSK7fvaFfn0ZWx2b7j5pXSji+OVaV9/zo15bLJ2b9MdPvVzDzZy48wcwpFAFnVKuPBe7eA7GfBANLd1eI0mD/9FK51f3+FIDt95a7wu7eve0Lp3IlgPgGf6KFSg1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IePDcwXE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IePDcwXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744286487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9wD4CHs9nQd9+31B+aaGfzekonlDYHicg/bIUqSeTk=;
	b=IePDcwXEpJmjXhjxkqTAJ+rVwIyPNVKfN9dRkHs2ZwIHy473tFXzz8Zr7VxyKr59GcXfYk
	bfTf8u+PnoiVdXquPS3q5rEofa8vtR5Rbbm+F2WwXFi4U55EbuhayWtUAxzXIdXk2c59zZ
	k7czpvw80oEJevdnXMALJQheEfxd0B0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-aX7JGYKDM--MYmheBJ358Q-1; Thu,
 10 Apr 2025 08:01:20 -0400
X-MC-Unique: aX7JGYKDM--MYmheBJ358Q-1
X-Mimecast-MFC-AGG-ID: aX7JGYKDM--MYmheBJ358Q_1744286478
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A33180034D;
	Thu, 10 Apr 2025 12:01:17 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45883001D0E;
	Thu, 10 Apr 2025 12:01:12 +0000 (UTC)
Message-ID: <6facfb1d-eafa-432c-9896-321ea9cd9a88@redhat.com>
Date: Thu, 10 Apr 2025 14:01:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-6-ivecera@redhat.com>
 <a5d2e1eb-7b98-4909-9505-ec93fe0c3aac@lunn.ch>
 <22b9f197-2f98-43c7-9cc9-c748e80078b0@redhat.com>
 <5af77349-5a76-4557-839b-d9ac643f5368@kernel.org>
 <40239de9-7552-41d1-9ee4-152ece6f33bc@redhat.com>
 <138d0e3c-ccab-48e2-b437-aec063d1d2dc@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <138d0e3c-ccab-48e2-b437-aec063d1d2dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 10. 04. 25 12:42 odp., Krzysztof Kozlowski wrote:
> On 10/04/2025 12:23, Ivan Vecera wrote:
>>
>>
>> On 10. 04. 25 9:11 dop., Krzysztof Kozlowski wrote:
>>> On 09/04/2025 08:44, Ivan Vecera wrote:
>>>> On 07. 04. 25 11:09 odp., Andrew Lunn wrote:
>>>>> On Mon, Apr 07, 2025 at 07:28:32PM +0200, Ivan Vecera wrote:
>>>>>> Add register definitions for components versions and report them
>>>>>> during probe.
>>>>>>
>>>>>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>>>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>>>> ---
>>>>>>     drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 35 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>>>>>> index 39d4c8608a740..b3091b00cffa8 100644
>>>>>> --- a/drivers/mfd/zl3073x-core.c
>>>>>> +++ b/drivers/mfd/zl3073x-core.c
>>>>>> @@ -1,10 +1,19 @@
>>>>>>     // SPDX-License-Identifier: GPL-2.0-only
>>>>>>     
>>>>>> +#include <linux/bitfield.h>
>>>>>>     #include <linux/module.h>
>>>>>>     #include <linux/unaligned.h>
>>>>>>     #include <net/devlink.h>
>>>>>>     #include "zl3073x.h"
>>>>>>     
>>>>>> +/*
>>>>>> + * Register Map Page 0, General
>>>>>> + */
>>>>>> +ZL3073X_REG16_DEF(id,			0x0001);
>>>>>> +ZL3073X_REG16_DEF(revision,		0x0003);
>>>>>> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
>>>>>> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
>>>>>> +
>>>>>>     /*
>>>>>>      * Regmap ranges
>>>>>>      */
>>>>>> @@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>>>>>>     
>>>>>>     int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>>>>>     {
>>>>>> +	u16 id, revision, fw_ver;
>>>>>>     	struct devlink *devlink;
>>>>>> +	u32 cfg_ver;
>>>>>> +	int rc;
>>>>>>     
>>>>>>     	devm_mutex_init(zldev->dev, &zldev->lock);
>>>>>>     
>>>>>> +	scoped_guard(zl3073x, zldev) {
>>>>>
>>>>> Why the scoped_guard? The locking scheme you have seems very opaque.
>>>>
>>>> We are read the HW registers in this block and the access is protected
>>>> by this device lock. Regmap locking will be disabled in v2 as this is
>>>
>>> Reading ID must be protected by mutex? Why and how?
>>
>> Yes, the ID is read from the hardware register and HW access functions
>> are protected by zl3073x_dev->lock. The access is not protected by
> 
> Please do not keep repeating the same. You again describe the code. We
> ask why do you implement that way?
> 
>> regmap locking schema. Set of registers are indirect and are accessed by
>> mailboxes where multiple register accesses need to be done atomically.
> 
> regmap handles that, but anyway, how multiple register access to ID
> registers happen? From what module? Which code does it? So they write
> here something in the middle and reading would be unsynced?

OK, I'm going to try to explain in detail...

The device have 16 register pages where each of them has 128 registers 
and register 0x7f on each page is a page selector.

Pages 0..9 contain direct registers that can be arbitrary read or 
written in any order. For these registers implicit regmap locking is 
sufficient.

Pages 10..16 contain indirect registers and these pages are called 
mailboxes. Each mailbox cover specific part of hardware (synth, DPLL 
channel, input ref, output...) and each of them contain mailbox_mask 
register and mailbox_sem register. The rest of registers in the 
particular page (mailbox) are latch registers.

Read operation (described in patch 8 in this v1 series):
E.g. driver needs to read frequency of input pin 4:
1) it set value of mailbox_mask (in input mailbox/page) to 4
2) it set mailbox_sem register (--"--) to read operation
3) it polls mailbox_sem to be cleared (firmware fills latch registers)
4) it reads frequency latch register (--"--) filled by FW

Write is similar but opposite:
1) it writes frequency to freq latch register (in input mb)
2) it set value of mailbox_mask
3) it set mailbox_sem to write operation
4) it polls mailbox_sem to be cleared (write was finished)

Steps 1-4 for both cases have to be done atomically - other reader 
cannot modify mailbox_sem prior step 4 is finished and other writer 
cannot touch latch registers prior step 4 is finished.

The module dpll_zl3073x (later in this series) and ptp_zl3073x (will be 
posted later) use this intensively from multiple contexts (DPLL core 
callbacks and monitoring threads).

So I have decided to use the custom locking scheme for accessing 
registers instead of regmap locking that cannot guarantee this atomicity.

Would it be better to leave implicit regmap locking scheme for direct 
registers and to have extra locking for mailboxes? If so, single mutex 
for all mailboxes or separate mutex for each mailbox type?

Thanks,
Ivan


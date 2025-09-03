Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3512FC87A
	for <linux-hardening@vger.kernel.org>; Wed,  3 Sep 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903400; cv=none; b=QlCu9c0DS2kcAXIIjdXm6P+J4b3pa+JKEWaxGSEE8bQP9yQ3cXFVMH3VkfGg/7Ph06a0UX9pn5hb5kKI8UBmu2LiVxtWY1EKuBsqGWrdAIWwP96zR9e3hr7G9faDB/sFSQv2O9t1qegL0ntKHsOHa+GaBV5VtIyyEMynGj4XDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903400; c=relaxed/simple;
	bh=HQ3VMbDjr7VjvTfjTlzDn4O+W5z0G3h8J21Loi+EOCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmXrPZ1ML+KDaD5E2uDJMSNyrXSXHCiEyeSmngBTNCmqMT1p4nYUufRLmKEcxxN7DjmpteysiIBDlID/DfLM9EBXdX2+snBaXE/5f/pl0s8ks64tGMwPYleN+/tKByJb9sQ93G+7vd67EP9ptQ+dp0BBeZ0HzaHc8FSzc4N2VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIAG0WhX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIAG0WhX"
Message-ID: <861c5b23-2d51-40b1-8363-67e666431251@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756903386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAUWIxBkjWta2hnn76FZubOcaNeLcydHbkTxSsCe2sc=;
	b=iIAG0WhX1/Er6AZv5EKBUQHsRBDPvraJRUWVdvX8FUwQWOozJhIUxBl8EgwQoIqcG1Rjth
	J3PXEuJvevnbiIOZSw5E6zFlE1lPmQB9MtUBrIsxfbhA63hhvWhF7sVgc2zx4d9188/aPc
	jp9lQc5YnCGcYu74vfO2990TBFbuL6k=
Date: Wed, 3 Sep 2025 13:43:02 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <be2b4af0-838e-4c7c-bae1-e74c027ad8fe@linux.dev>
 <9156A3C8F1EFA452+20250903111237.GA967815@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9156A3C8F1EFA452+20250903111237.GA967815@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/09/2025 12:12, Yibo Dong wrote:
> On Wed, Sep 03, 2025 at 11:53:17AM +0100, Vadim Fedorenko wrote:
>> On 03/09/2025 03:54, Dong Yibo wrote:
>>> Initialize basic mbx function.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>> ---
>>>    drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>>>    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  16 +
>>>    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
>>>    .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
>>>    .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
>>>    5 files changed, 439 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>>>    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
>>>
>>> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>>> index 179621ea09f3..f38daef752a3 100644
>>> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>>> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>>> @@ -1,8 +1,11 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>>    /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>>> +#include <linux/string.h>
>>
>> I don't see a reason to have string.h included into rnpgbe_chip.c
>>
> 
> You are right, I should add it when it is used.
> 
>>> +
>>>    #include "rnpgbe.h"
>>>    #include "rnpgbe_hw.h"
>>> +#include "rnpgbe_mbx.h"
>>
>> I believe this part has to be done in the previous patch.
>> Please, be sure that the code can compile after every patch in the
>> patchset.
>>
> 
> You mean 'include "rnpgbe_mbx.h"'? But 'rnpgbe_mbx.h' is added in this patch.

Ok, so what's in rnpgbe_chip.c which needs rnpgbe_mbx.h to be included?
If the change is introduced later in patch 5, the move this include to
it as well.

> I had compiled every patch before submission for this series. And as you
> remind, I will keep check this in the future.
> 
> Thanks for your feedback.
> 


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22622284683
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513387; cv=none; b=HObWiI3si1HGzmwJE+dliANRx0df4XMuNjBvFWGNLZlJ6f25TcoP5fW/pyxUobeUX6OmFxRqpxVlJW0M23nQaEm6f3qIU3cLeaebexqbnyrQ9SnJKsqP9ZLNv6AI17a/P7o3yR2ZZ815HAYXZPQIRwdCKheoutNf7XOftvOuH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513387; c=relaxed/simple;
	bh=yaFz9KVuXbQ3WoPpBhphcE4kDzD4jDZLdKjUo00JrCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scsZa3OwRQYOcowdq3O5oO6eUcgAI3gNNpjCZ84Md9Nyyx1+EY1oZo+sVQ5e+1zltHS9RlGCK4wf58X+7eDg41Bs+z7etbnJaQzmqNutGWy2LOzJpDsHQEuK4FKvXoAtyli409Srd1DhLyXfgjF9kMb6DNvipG8CyuBs/Sdtyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGADD76O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGADD76O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745513384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJKWPsrSIdki3Sut593ts9jKeKHpTjZdnwCIv+v7d1Q=;
	b=fGADD76Os0c6N6QQlhuH9PDcc0TTIIOs21QNDktIn08kc42SYV3j6mnWWzhH+KiXMJI9Yg
	TJe6T0SKgENc+Wo0P11FcpLN6T+IrU9ffBz+lU9m+Omo0UeEja/wRZ4YY6KOLzhd2p40dD
	HDxR3jQTKeXKmxKOIC7IjUZOzs6pJcc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-3aBPdaY6NSOa_mg84J2AZw-1; Thu,
 24 Apr 2025 12:49:39 -0400
X-MC-Unique: 3aBPdaY6NSOa_mg84J2AZw-1
X-Mimecast-MFC-AGG-ID: 3aBPdaY6NSOa_mg84J2AZw_1745513376
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A54D1955DCD;
	Thu, 24 Apr 2025 16:49:35 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B2619560A3;
	Thu, 24 Apr 2025 16:49:29 +0000 (UTC)
Message-ID: <c67a65c2-e0c2-438e-a71b-3325e8e2bc3f@redhat.com>
Date: Thu, 24 Apr 2025 18:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/8] mfd: Add Microchip ZL3073x support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-4-ivecera@redhat.com>
 <4fae1a96-ac19-46b8-8eff-2a38d28414fc@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <4fae1a96-ac19-46b8-8eff-2a38d28414fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 24. 04. 25 6:34 odp., Andrew Lunn wrote:
>> +++ b/drivers/mfd/zl3073x-regs.h
>> @@ -0,0 +1,74 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef __ZL3073X_REGS_H
>> +#define __ZL3073X_REGS_H
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +
>> +/*
>> + * Register address structure:
>> + * ===========================
>> + *  25        19 18   16 15     7 6           0
>> + * +-------------------------------------------+
>> + * | max_offset | width |  page  | page_offset |
>> + * +-------------------------------------------+
>> + *
>> + * page_offset ... <0x00..0x7F>
>> + * page .......... HW page number
>> + * size .......... register byte size (1, 2, 4 or 6)
>> + * max_offset .... maximal offset for indexed registers
>> + *                 (for non-indexed regs max_offset == page_offset)
>> + */
> 
> Something i missed earlier. This does not really describe
> hardware. The upper half is meta data about the register, which you
> encode into the register number.
> 
> How many other Linux drivers do you know about which does this?

This was proposed by Andy S.

Cite:
V4L2 (or media subsystem) solve the problem by providing a common
helpers for reading and writing tons of different registers in cameras.
See the commit 613cbb91e9ce ("media: Add MIPI CCI register access helper
functions").

They encode register address and size in register value. I have just
extend this approach to cover indexed registers. The max_offset is for
sanity during access to such registers, potential access out of
bounds is detected and error returned.

One can use just two simple functions for both register types:
zl3073x_read_reg(zldev, ZL_REG_NONIDX1, &value);
zl3073x_read_reg(zldev, ZL_REG_IDX1(idx), &value);

> 
> Also width vs size.

I'm sorry, just a typo during reworking.


Ivan


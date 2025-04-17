Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BB254AFE
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907359; cv=none; b=EMrYiS+ABttGTmZcLoOuHhqSgY0aRcCsD8cm8lNsSgAJ5L84QBF1MOXAN1D8Gl91c88dn3daY+dLu9DLqUDWsPBQhNCjCIGH9Yx4ak3WeSGi3Qm44YKcNngH9YvIPujYOP4kChLN7r1ODZiFMTKLbvS4OlGK/IlyB7UTp/oVj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907359; c=relaxed/simple;
	bh=qF64HvVcNeOtdcAyYqmJvGVg1ef1aF3j7UwB3Jxqk10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkwfJ9V4XDbAvtZWYh2LSJs/VQVt32n6SdUBFoGPkv1Vlznl8Z2BwBAWkbjZhxdOW2FJ2gV36wFdb0kd/kD4rhlcycldyEgBNlTOnkHmnsmz7CszvP9xKwrggo+R0PafxJ2zrPf1d+VyW1nf1pAk+xffGN/FzEvxHbyAi9/EVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwCvqZhZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwCvqZhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744907357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf0SiIJa577BE6VX/+yFMxhpko9CxfxqOGL55lMVi9U=;
	b=NwCvqZhZzewGV1bEfYWHsFDpQbmmf7mcPA1ZB9mCvDe7i7QxPEEM2g8dric5WnfspFliLT
	xHBP3DqrIKVa4czyOoSfOo6Crxw3wopLQnxS+W4VinFJ/M73gaAnz6fxwYCBHXSlwanfOw
	avrwIopOtnVWZilSx8U3XBTr6q494Mc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-eouRYUvgOb2bYhII0hSnYA-1; Thu,
 17 Apr 2025 12:29:12 -0400
X-MC-Unique: eouRYUvgOb2bYhII0hSnYA-1
X-Mimecast-MFC-AGG-ID: eouRYUvgOb2bYhII0hSnYA_1744907349
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D97B19560AF;
	Thu, 17 Apr 2025 16:29:08 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D67F1956095;
	Thu, 17 Apr 2025 16:29:02 +0000 (UTC)
Message-ID: <514f9861-9d16-4c62-a7a0-5c9182a44927@redhat.com>
Date: Thu, 17 Apr 2025 18:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
To: Andy Shevchenko <andy@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
 <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
 <03afdbe9-8f55-4e87-bec4-a0e69b0e0d86@redhat.com>
 <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>
 <aAEhb-6QV2m21pm2@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aAEhb-6QV2m21pm2@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 17. 04. 25 5:42 odp., Andy Shevchenko wrote:
>>> Would it be acceptable for you something like this:
> V4L2 (or media subsystem) solve the problem by providing a common helpers for
> reading and writing tons of different registers in cameras. See the commit
> 613cbb91e9ce ("media: Add MIPI CCI register access helper functions").
> 
> Dunno if it helps here, though.

Bingo, this approach looks very good.

I can use unsigned int (32bit) to encode everything necessary:
Bits  0..15 - register address (virtual range offset, page, offset)
Bits 16..21 - size in bits (enough for max 48)
Bits 22..26 - max items (32 values - enough for any indexed register)
Bits 27..31 - stride between (up to 32 - enough per datasheet)

Only thing I don't like is that MIPI CCI API uses for calls u64 as value:

int cci_read(struct regmap *map, u32 reg, u64 *val, ...);

This forces a caller to use u64 for every register read. I rather to use
'void *val' the same way as regmap_read().

Ivan


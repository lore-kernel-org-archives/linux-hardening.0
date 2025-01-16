Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2C18B464
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jan 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062075; cv=none; b=k0XuUk3zbOk6NIQIjlQo2b5aXYqFsbJrPyNmcYKEDvJAnxtaDqryyyr1/oLfznad5VW8oAXXuN8ZcgQmk4RhuryoKH71JnAwnpkoZO80lRBtKOSGvfdS9mLCPiH90HXcvKZdsFhwnwZV5tbXhJ7T3gIluxpZ39WlbnUX4k5CUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062075; c=relaxed/simple;
	bh=MGBib0tFc4Mt7nFpjYBY3nIiHXDGFGEVckyPAG8rE1Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jZtCXUztykjw0qjoVfyvK+mPP239MX/2WDpcyldALQ1WyDUSAd/zF8Kn9k4nD+WjoyuUkc+odGauzizJGnzYL/+zMm2U1uXmWWQQ33S9P53kQSH7yysX35KOLGKGhdtEKC0terrLzaUz4cHfNLRx3II10GhNbfOSvMZEHPSgY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKueeeyW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKueeeyW"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737062070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVpKJFnS9Cthaj+9oR5CHFCEbUN25b085qHph7QNXLI=;
	b=uKueeeyWIS0iForfF8np9pUjWwF7eZo5CchmI51kDWdL+Xz3P3+x1NSbhr+UM7polBmooE
	9HWxwPUJAN/u+2ZbZSM4YvVLBfawUn05A4f3IeS1ElLBorQsrqG8j9aEIBhPFIw7ldE8+b
	LdsoCBRMmsbRmIc6cLUEzt6pJ5sM/H0=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hv_netvsc: Replace one-element array with flexible array
 member
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d136130c-6895-4394-88c2-2911123afce5@linux.microsoft.com>
Date: Thu, 16 Jan 2025 22:14:17 +0100
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6624650C-6D9E-49FA-8CC0-7E5B53C2AAB3@linux.dev>
References: <20250116201635.47870-2-thorsten.blum@linux.dev>
 <d136130c-6895-4394-88c2-2911123afce5@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On 16. Jan 2025, at 21:45, Roman Kisel wrote:
> On 1/16/2025 12:16 PM, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible array
>> member in the struct nvsp_1_message_send_receive_buffer_complete.
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  drivers/net/hyperv/hyperv_net.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/hyperv/hyperv_net.h =
b/drivers/net/hyperv/hyperv_net.h
>> index e690b95b1bbb..234db693cefa 100644
>> --- a/drivers/net/hyperv/hyperv_net.h
>> +++ b/drivers/net/hyperv/hyperv_net.h
>> @@ -464,7 +464,7 @@ struct =
nvsp_1_message_send_receive_buffer_complete {
>>    *  LargeOffset                            SmallOffset
>>    */
>>  - struct nvsp_1_receive_buffer_section sections[1];
>> + struct nvsp_1_receive_buffer_section sections[];
>>  } __packed;
>>    /*
>=20
> 1. How have you tested the change?

Compile-tested only.

> 2. There is an instance of
>=20
> `sizeof(struct nvsp_1_message_send_receive_buffer_complete))`
>=20
> and your change decreases the size of the struct. Why do you think
> that is fine?

Sorry, I actually changed this to struct_size_t(,,1), but forgot to add
it to the commit - will submit a v2 shortly.

Thanks,
Thorsten=

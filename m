Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82B284662
	for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711321; cv=none; b=qdmk6L4yrl5zN2OTp2dZjGp0za2NmVksEMlpGsQFzScrY87Jvb2u+6vmLZCtk4JuofcZQBYsJM+wROfHk1B+BnGiRJ8yx/PXjvCfg7q2LH4D5bNx6pkfB+sxx0Y5KxXCjxeBhgYP8yyd8vPMJFQLPcRYa8Js4IR5LqIWgAaTy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711321; c=relaxed/simple;
	bh=FFl5sm7Pdvz6wgDPyj/MaZX9FxPABLdOMgxgZjnyAZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9xbrGBFF3VhcJ0BExR10eW2lDDXHTQ0oY33040sr/ywomDVTkkO2wN5PH0LwfYSLdGIH7Z8jRsM6zqUI2TerlHT9xgM4fXfXhFQg6Iu4uFb32/DXh5GSxTrMU07K7t8Yd9oYCGiwH93yO5aDqNjvEAohjDp08GNDjr1S2wU7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyPlXuao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyPlXuao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744711318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Og5QmpBeRfTcKCNY2isgPCvYLtP+0K9FKE9am/x/sVw=;
	b=HyPlXuaooeBYnJII+TGq4UDDgbLcMyw73nHXBD51WHwMiolDPkrIgasUZkEULNAxHlAzWz
	mjGmWoiKjPjlPbNT1/ulWBF3XuH26HOqnW0qSnMY+jz6CVNIDxrxFd9aRALNQqAhX+kRQ8
	4fLs3kVKJwX/yRi1RaDnKARc2VKhtNk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-OLk8wTxMNGq241XKqSO-yg-1; Tue,
 15 Apr 2025 06:01:52 -0400
X-MC-Unique: OLk8wTxMNGq241XKqSO-yg-1
X-Mimecast-MFC-AGG-ID: OLk8wTxMNGq241XKqSO-yg_1744711310
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF2901800259;
	Tue, 15 Apr 2025 10:01:49 +0000 (UTC)
Received: from [10.43.2.2] (unknown [10.43.2.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACA4219560AD;
	Tue, 15 Apr 2025 10:01:44 +0000 (UTC)
Message-ID: <9de10e97-d0fa-4dee-b98a-e4b2a3f7019c@redhat.com>
Date: Tue, 15 Apr 2025 12:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andy@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
 <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
 <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>
 <8c5fb149-af25-4713-a9c8-f49b516edbff@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8c5fb149-af25-4713-a9c8-f49b516edbff@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10. 04. 25 11:54 odp., Andrew Lunn wrote:
> ...
> 
> So a small number of registers in the regmap need special locking. It
> was not clear to me what exactly those locking requirements are,
> because they don't appear to be described.
> 
> But when i look at the code above, the scoped guard gives the
> impression that i have to read id, revision, fw_vr and cfg_ver all in
> one go without any other reads/writes happening. I strongly suspect
> that impression is wrong. The question then becomes, how can i tell
> apart reads/writes which do need to be made as one group, form others
> which can be arbitrarily ordered with other read/writes.
> 
> What i suggest you do is try to work out how to push the locking down
> as low as possible. Make the lock cover only what it needs to cover.
> 
> Probably for 95% of the registers, the regmap lock is sufficient.
> 
> Just throwing out ideas, i've no idea if they are good or not. Create
> two regmaps onto your i2c device, covering different register
> ranges. The 'normal' one uses standard regmap locking, the second
> 'special' one has locking disabled. You additionally provide your own
> lock functions to the 'normal' one, so you have access to the
> lock. When you need to access the mailboxes, take the lock, so you
> know the 'normal' regmap cannot access anything, and then use the
> 'special' regmap to do what you need to do. A structure like this
> should help explain what the special steps are for those special
> registers, while not scattering wrong ideas about what the locking
> scheme actually is all over the code.

Hi Andrew,
the idea looks interesting but there are some caveats and disadvantages.
I thought about it but the idea with two regmaps (one for simple 
registers and one for mailboxes) where the simple one uses implicit 
locking and mailbox one has locking disabled with explicit locking 
requirement. There are two main problems:

1) Regmap cache has to be disabled as it cannot be shared between 
multiple regmaps... so also page selector cannot be cached.

2) You cannot mix access to mailbox registers and to simple registers. 
This means that mailbox accesses have to be wrapped e.g. inside 
scoped_guard()

The first problem is really pain as I would like to extend later the 
driver with proper caching (page selector for now).
The second one brings only confusions for a developer how to properly 
access different types of registers.

I think the best approach would be to use just single regmap for all 
registers with implicit locking enabled and have extra mailbox mutex to 
protect mailbox registers and ensure atomic operations with them.
This will allow to use regmap cache and also intermixing mailbox and 
simple registers' accesses won't be an issue.

@Andy Shevchenko, wdym about it?

Thanks,
Ivan


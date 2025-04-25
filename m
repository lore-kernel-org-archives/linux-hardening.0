Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2523AE84
	for <linux-hardening@vger.kernel.org>; Fri, 25 Apr 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576966; cv=none; b=lQv2AuqJ2nA+PVCxApqxZghSpCQp7RxRmmh9jL7pyANgLKymBNdGCUNiiVWMpXuGshuSdLqtNWCSf11YAp8R2AD9ZDh9iDGPdg5cz7ucfrdznX6uCCLQJNcszTCWk78xTwI13aXuVh+gCdvrwZ5nxNY7uMUTWI0c7Q8UCW+/P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576966; c=relaxed/simple;
	bh=bATCZiARSUssO2ZIH/xUNtRe6CaGwmUzTSOfrxkJEOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duq7D0gIxMdnGlvTZLBxCVHXaFPUMd8w+peX7khw3xm48VD9WDWjlT1rRIr/L0r6quO+qMoNX76T2TI6dDMrcGzhaa1Fo9iZW1hl1IXFQemAnx3pOMeWO8tTK1NtfrqLHw3lOhRkJojUiXVZY5U+Ppiim4YoHnbJz7qAkEcmQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caD8Iayw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caD8Iayw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745576963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RXe4Y65IEuPaaEunMb2XpqKXPKoXPCVAnkRhWHAai8=;
	b=caD8IaywEYc2gng3tACrsCs9q81gwN1JjHHwBSzSJ/s1YeWrtX2j5IzDNBtwI3hPSHiPZe
	TgOMkLriZCxBuLFbYKcSJUW998Zb1zc1dK5gdlKrxfdgPaX3JyzY/xhYtRC7rMIlvqB4n4
	LBKj9eEFeNa4+znPZ9SmypyoHI5YW7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-ElFa1BBnOLmWMdknhLmnlQ-1; Fri,
 25 Apr 2025 06:29:20 -0400
X-MC-Unique: ElFa1BBnOLmWMdknhLmnlQ-1
X-Mimecast-MFC-AGG-ID: ElFa1BBnOLmWMdknhLmnlQ_1745576958
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A85D51800374;
	Fri, 25 Apr 2025 10:29:17 +0000 (UTC)
Received: from [10.44.33.33] (unknown [10.44.33.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 938BA195608D;
	Fri, 25 Apr 2025 10:29:12 +0000 (UTC)
Message-ID: <ae7f8b87-5cf5-493d-9cff-eb76bebda513@redhat.com>
Date: Fri, 25 Apr 2025 12:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Lee Jones <lee@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
 <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
 <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>
 <20250425065558.GP8734@google.com>
 <98e471cc-ec66-4c89-af9a-57625c0c2873@redhat.com>
 <20250425101721.GC1567507@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250425101721.GC1567507@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 25. 04. 25 12:17 odp., Lee Jones wrote:
> On Fri, 25 Apr 2025, Ivan Vecera wrote:
> 
>>
>>
>> On 25. 04. 25 8:55 dop., Lee Jones wrote:
>>> On Thu, 24 Apr 2025, Ivan Vecera wrote:
>>>
>>>>
>>>>
>>>> On 24. 04. 25 9:29 odp., Andrew Lunn wrote:
>>>>>> Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
>>>>>> initial configuration.
>>>>>
>>>>> O.K, so the mailbox code needs sharing. The question is, where do you
>>>>> put it.
>>>>
>>>> This is crucial question... If I put the MB API into DPLL sub-driver
>>>> then PTP sub-driver will depend on it. Potential GPIO sub-driver as
>>>> well.
>>>>
>>>> There could be some special library module to provide this for
>>>> sub-drivers but is this what we want? And if so where to put it?
>>>
>>> MFD is designed to take potentially large, monolithic devices and split
>>> them up into smaller, more organised chunks, then Linusify them.  This
>>> way, area experts (subsystem maintainers) get to concern themselves only
>>> with the remit to which they are most specialised / knowledgable.  MFD
>>> will handle how each of these areas are divided up and create all of the
>>> shared resources for them.  On the odd occasion it will also provide a
>>> _small_ API that the children can use to talk to the parent device.
>>>
>>> However .... some devices, like yours, demand an API which is too
>>> complex to reside in the MFD subsystem itself.  This is not the first
>>> time this has happened and I doubt it will be the last.  My first
>>> recommendation is usually to place all of the comms in drivers/platform,
>>> since, at least in my own mind, if a complex API is required, then the
>>> device has become almost platform-like.  There are lots of examples of
>>> H/W comm APIs in there already for you to peruse.
>>
>> OK, I will do it differently... Will drop MB API at all from MFD and
>> just expose the additional mutex from MFD for multi-op access.
>> Mailboxes will be handled directly by sub-devices.
>>
>> Short description:
>> MFD exposes:
>> zl3073x_{read,write}_u{8,16,32,48}() & zl3073x_poll_u8()
>> - to read/write/poll registers
>> - they checks that multiop_lock is taken when caller is accessing
>>    registers from Page 10 and above
>>
>> zl3073x_multiop_{lock,unlock}()
>> - to protect operation where multiple reads, writes and poll is required
>>    to be done atomically

Or maybe just define zl3073x_dev.multiop_lock and allow callers to use

guard(mutex)(zldev->multiop_lock)
--or--
scoped_guard(mutex)(zldev_multiop_lock) {
...
}

> Looks sensible.  If this is aligned with the discussions that have been
> taking place between you and Andrew.  Let's see the code before we make
> any binding agreements.  =:)
> 


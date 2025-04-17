Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959824E010
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899355; cv=none; b=QGbW30jBNFfC/GOcyCkq9dn9YNrL4Ue4F4DGebZiFdpzITKyyRTTDDzQQdTR3/9kwOiFhj6+T5tvu9Eo+pO8fuyD8fNwmRU2LxM/HS909wnn+XZuZw0wz5+HhCA+g8QZ04DnoAQWhJFEsr9KzOCp2Jhzul6LsSzSP0VcbymnyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899355; c=relaxed/simple;
	bh=P9h4O8gdB+tlOXx6aUyTO8Xc61OwjUm9m2At/cnifiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxxD7IPCNPjCHs2daEvLzaQRwkHf7NrsQykQ5LL4lXeDLkkBBGEdkLdaJJEzDw7blBN0ZO6JHmrUqNxp9/3Vgc+ch9EqFruDh32LN5EGir89exo2OlZePPHNiAsaVdvsWEcSljIrMisCwAMIKMXHBlq+m8vrYKI3vOcFg4LZhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8gAJpex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8gAJpex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744899352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhAPzg/hAd+522tJiICzEiLKQ/EOBtk9V+Wlmbrgn3Y=;
	b=U8gAJpexsI7r67d6w6Y1etkjlEaxPyv5r+Oc3LTF9+5nqJBT72OZZWrmSEOujEYNNYk4yG
	n5XkwRkLRVRsBWzfvBPTF6H1G1xtyHNT72B2RWYXb7XgNOTwzW1GuuMAdAv6G7rUBsT5pn
	FsVKNFZ/OeS9k0T0mZbdVGHjsR74DxI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-tn0r6BnUMEanhjbv4LTkHQ-1; Thu,
 17 Apr 2025 10:15:48 -0400
X-MC-Unique: tn0r6BnUMEanhjbv4LTkHQ-1
X-Mimecast-MFC-AGG-ID: tn0r6BnUMEanhjbv4LTkHQ_1744899344
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2B501955DDE;
	Thu, 17 Apr 2025 14:15:43 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33C61956095;
	Thu, 17 Apr 2025 14:15:38 +0000 (UTC)
Message-ID: <f9149df7-262e-4420-87b4-79c8a176c203@redhat.com>
Date: Thu, 17 Apr 2025 16:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
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
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
 <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>
 <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 17. 04. 25 3:27 odp., Andrew Lunn wrote:
>> Anyway, I have a different idea... completely abstract mailboxes from the
>> caller. The mailbox content can be large and the caller is barely interested
>> in all registers from the mailbox but this could be resolved this way:
>>
>> The proposed API e.g for Ref mailbox:
>>
>> int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index,
>>                          struct zl3073x_mb_ref *mb);
>> int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index,
>>                           struct zl3073x_mb_ref *mb);
>>
>> struct zl3073x_mb_ref {
>> 	u32	flags;
>> 	u16	freq_base;
>> 	u16	freq_mult;
>> 	u16	ratio_m;
>> 	u16	ratio_n;
>> 	u8	config;
>> 	u64	phase_offset_compensation;
>> 	u8	sync_ctrl;
>> 	u32	esync_div;
>> }
>>
>> #define ZL3073X_MB_REF_FREQ_BASE			BIT(0)
>> #define ZL3073X_MB_REF_FREQ_MULT			BIT(1)
>> #define ZL3073X_MB_REF_RATIO_M				BIT(2)
>> #define ZL3073X_MB_REF_RATIO_N			 	BIT(3)
>> #define ZL3073X_MB_REF_CONFIG			 	BIT(4)
>> #define ZL3073X_MB_REF_PHASE_OFFSET_COMPENSATION 	BIT(5)
>> #define ZL3073X_MB_REF_SYNC_CTRL			BIT(6)
>> #define ZL3073X_MB_REF_ESYNC_DIV			BIT(7)
>>
>> Then a reader can read this way (read freq and ratio of 3rd ref):
>> {
>> 	struct zl3073x_mb_ref mb;
>> 	...
>> 	mb.flags = ZL3073X_MB_REF_FREQ_BASE |
>> 		   ZL3073X_MB_REF_FREQ_MULT |
>> 		   ZL3073X_MB_REF_RATIO_M |
>> 		   ZL3073X_MB_REF_RATIO_N;
>> 	rc = zl3073x_mb_ref_read(zldev, 3, &mb);
>> 	if (rc)
>> 		return rc;
>> 	/* at this point mb fields requested via flags are filled */
>> }
>> A writer similarly (write config of 5th ref):
>> {
>> 	struct zl3073x_mb_ref mb;
>> 	...
>> 	mb.flags = ZL3073X_MB_REF_CONFIG;
>> 	mb.config = FIELD_PREP(SOME_MASK, SOME_VALUE);
>> 	rc = zl3073x_mb_ref_write(zldev, 5, &mb);
>> 	...
>> 	/* config of 5th ref was commited */
>> }
>>
>> The advantages:
>> * no explicit locking required from the callers
>> * locking is done inside mailbox API
>> * each mailbox type can have different mutex so multiple calls for
>>    different mailbox types (e.g ref & output) can be done in parallel
>>
>> WDYT about this approach?
> 
> I would say this is actually your next layer on top of the basic
> mailbox API. This makes it more friendly to your sub driver and puts
> all the locking in one place where it can easily be reviewed.
> 
> One question would be, where does this code belong. Is it in the MFD,
> or in the subdrivers? I guess it is in the subdrivers.

No, it should be part of MFD because it does not make sense to implement 
API above in each sub-driver separately.

Sub-driver would use this MB ABI for MB access and
zl3073x_{read,write}_u{8,16,32,48} for non-MB registers.

Ivan


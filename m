Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96322949F9
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524746; cv=none; b=OoIzKLma8vfhyQMJFu8lsch5QpHK2pMHjdpx5q5cCbMJNiW19aYd3s6IRDvPfIxTRdxPmLSS+Z78v3TU13xwSihFKfNBBSsN1uinN1C2o0bfwasDgRcmyKdAVLvanCswKiuSDkzJJST4CrFhI/DBzIFjVNVl/aMzjzDCmOZFjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524746; c=relaxed/simple;
	bh=S256UgLsAfrU64+LkzGesSug2ELdCLZJ3BM5GSBy3A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZHD5+bJkyn29AjgNdywI64FhRHztnoqnnG1CheULMBHpef/6AT0Sq0PbpStcnRm/X//u22/hLaF5l5ojmqTxsJaxV5iLeXhWffRc8VyU16Od/wR7oeEltg83iCVBhxV4apG+n7xTmoV3RrUPFmDGpg9d28Warz8ZxHVi9H3k8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9A9+6pG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9A9+6pG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745524743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBXTdv+sLZhhh3HMrE26Hq7ELTP03d30ZG0+ag31+Z8=;
	b=U9A9+6pGKpRW35eKX4cA4rrLLViDnDHTA40scc2RVJCrvXM6+FgX/N15IrswPgMHnbsT/d
	J0/yJLagHAGJksHcR0rbEIZeqBHWDMJenmr2/fLTJTiHOoAOyTkVtlq7y/ef9I5WajPhsi
	MhFhhYJyggCii53QoX6IRR7nfx9hyug=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-Il5dtNCfOpy9lrqf63iSaQ-1; Thu,
 24 Apr 2025 15:58:58 -0400
X-MC-Unique: Il5dtNCfOpy9lrqf63iSaQ-1
X-Mimecast-MFC-AGG-ID: Il5dtNCfOpy9lrqf63iSaQ_1745524736
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877A41956095;
	Thu, 24 Apr 2025 19:58:55 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E3801956095;
	Thu, 24 Apr 2025 19:58:49 +0000 (UTC)
Message-ID: <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>
Date: Thu, 24 Apr 2025 21:58:48 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
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
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
 <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 24. 04. 25 9:29 odp., Andrew Lunn wrote:
>> Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
>> initial configuration.
> 
> O.K, so the mailbox code needs sharing. The question is, where do you
> put it.

This is crucial question... If I put the MB API into DPLL sub-driver
then PTP sub-driver will depend on it. Potential GPIO sub-driver as
well.

There could be some special library module to provide this for
sub-drivers but is this what we want? And if so where to put it?

>>> The mutex needs to be shared, but that could be in the common data
>>> structure.
>>
>> Do you mean that sub-device would access mutexes placed in zl3073x_dev which
>> is parent (mfd) driver structure?
> 
> Yes.

So, some helper functions for taking and releasing lock... The v4
approach uses (will use) one mutex per mailbox type but one mutex for
MB access is also sufficient.

Ivan


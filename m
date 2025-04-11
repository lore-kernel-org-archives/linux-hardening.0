Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336B2AE99
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377577; cv=none; b=t7nFghZVnizTjtAMwbMl3l4c87H0hjNcglJYZLQfjdX1nN2LAX4dFm3DorJ1C6tJtR8AEjMYINRbS+ZD+RrvfG+C7KkRXh/tXB9Q1Te5OYs7UlPDof5PCqp9aCiRbK7p90fAd+iQrV8hsNEqnWoEOcBJKi+YtbiBjt8v2YlLfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377577; c=relaxed/simple;
	bh=DvdCNV3kj/5TD9O7DSU/WxOtcVOvJSx4AkDTYs+lxkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkRQt9Mmkp9dgSjtwXu6htoZ6UM5YBzUL5y8XJ7cqUnkusyPO3tTtHSJGJE9d+LGgTn8WMi1Q/7UlsSDbMUhxzlI7StGY3lu+tT9Gtgu6gtWtkoU0BWMZ0kZqh+0VyuDO2u9Dwk1z/XjME8FEbHsuAfLC1c68n+ophK0G+aaAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSNaIRsB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSNaIRsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744377575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shuX7fon/hIq4duj4t+qKrqkD2Z+ua79QnTf8iIlD5c=;
	b=aSNaIRsB0F44gThI3ZK/qVC1UaWLURlK6UWGR8WCfryV8Uzd67Xh4sL2nKdwTqd3ZfjlaW
	EIks+tgG+Wu4J3ulQySWqNJzEeF3OSEfSjYlLUMQOfEYKqGm4zeg2UYnUsLlZB5IT7kKSc
	DHvDBwLdOPkkcqsmGaQooW79cDM5Prc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-7Bs_rkfVNzqHaoE-430wBA-1; Fri,
 11 Apr 2025 09:19:30 -0400
X-MC-Unique: 7Bs_rkfVNzqHaoE-430wBA-1
X-Mimecast-MFC-AGG-ID: 7Bs_rkfVNzqHaoE-430wBA_1744377568
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2197C1801A1A;
	Fri, 11 Apr 2025 13:19:28 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2043180B486;
	Fri, 11 Apr 2025 13:19:22 +0000 (UTC)
Message-ID: <e80b24f2-a936-4f7a-a86b-af3bc9b6a380@redhat.com>
Date: Fri, 11 Apr 2025 15:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
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
 <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
 <b7e223bd-d43b-4cdd-9d48-4a1f80a482e8@redhat.com>
 <8c9e95e2-27da-4f3d-b277-ca8e98ab61ef@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8c9e95e2-27da-4f3d-b277-ca8e98ab61ef@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 11. 04. 25 2:31 odp., Andrew Lunn wrote:
>> 2nd regmap for indirect registers (mailboxes) (pages 10-15) with disabled
>> locking:
>>
>> regmap_config {
>> 	...
>> 	.disable_lock = true,
>> 	...
>> };
> 
> Do all registers in pages 10-15 need special locking? Or just a
> subset?
> 
> 	Andrew
> 
All of them... 1 page (>=10) == 1 mailbox.

I.


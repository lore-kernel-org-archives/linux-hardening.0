Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94D28C5DB
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522779; cv=none; b=a0RyRaGGxxCks9l8lQV23KgxOKHFzfDq0jstSqHoteILi5P7HzMSo9BdZJGVa8duD91MuwKy3XZ91MILv5cmM0/+FZVxZFK2VfTOz/REDE3doknT1bTpYbH8HjbVFpNajzGj1Z5GbyiHsYaTIFe5YuNN9tvr57B4Fl70decCgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522779; c=relaxed/simple;
	bh=bu059oOGZ2b1GzECqaoT83+HulR1dptsnBlbt42RbG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG0TYNo4NqJELP1D2byMoHqrzlDRfTXfcn0BInz576ktLmN4YpaJsU//N9cAd/TPAqUBUy1U3BmGV2IxZCmujTL1TRKO5s2ZxyZN7qLScI0N1wL3C/BwBdPgUgMwKffNx4iaG/h0Sl+kSniM1qkPIBFjOp9aYB5eWuu46mtLS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvYEhLwZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvYEhLwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745522773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXxRuxHtNOEgElVP80hKhstwAJQ4wypAH+ISjl66nlw=;
	b=OvYEhLwZ951MRpYQCJu/ww0fer+8xu+19SOzJI41pJ4+nf+/JM3GrK+lXGl2IiIVWY/2KG
	gQqQhioceuM7okzWYN2eIlDU6ciEpq2uoxP2QJq0wRRH2KCLW9KNFbJN/ruACj7auR+een
	RwHf3IZB25OX5AtHGM81rKKzbtj+4J0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-jm5CuxR5NgiLIg5U_j-wPA-1; Thu,
 24 Apr 2025 15:26:11 -0400
X-MC-Unique: jm5CuxR5NgiLIg5U_j-wPA-1
X-Mimecast-MFC-AGG-ID: jm5CuxR5NgiLIg5U_j-wPA_1745522769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B105D1800877;
	Thu, 24 Apr 2025 19:26:08 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AA6C19560A3;
	Thu, 24 Apr 2025 19:26:02 +0000 (UTC)
Message-ID: <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
Date: Thu, 24 Apr 2025 21:26:01 +0200
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 24. 04. 25 9:10 odp., Andrew Lunn wrote:
>> Each sequence has to be protected by some lock and this lock needs to be
>> placed in MFD. Yes the routines for MB access can be for example in DPLL
>> driver but still the locks have to be inside MFD. So they have to be
>> exposed to sub-devices.
> 
> The point of using MFD was gpio? Does the gpio driver need access to
> the mailboxes? Does any other sub driver other than DPLL need to
> access mailboxes?

Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for 
some initial configuration.

> The mutex needs to be shared, but that could be in the common data
> structure.

Do you mean that sub-device would access mutexes placed in zl3073x_dev 
which is parent (mfd) driver structure?

Ivan


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19B1EFFB9
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310044; cv=none; b=VoPS5sSKoyaVUlrqm4g53A1z851oZu79lEPY83vcSIT6vLFhgIfEqncubZXZ2e8p8NgoIcpjM5QAnpep30ErjjHL7PgTYq1fet2mUilkhKxtNqNfck39rI6DwTShnzoKbnNHvP0hOy0cPOvkQ0cxY5qMiUdH8ysWSPZRTyb5gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310044; c=relaxed/simple;
	bh=9KlmQeAoXoGZEM4bOvBwhJ1UGM0zKQo5dWBsGIIep/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iByot/hPNXJwMnwgZI7oY/4YxAAyQTqPILk4/sTyueblbEqmMJFDIV8yhSuhZE6w+rcderCVVAjCGQK98I7WrJNIK8Xs1Z+VKPEqX1S/vImkg+fe9K7J2XJTg6JrNcmNTZELi9q73oYKZX1Ss+kakCR3jZWwjpmv2PQuAfdJbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUOAqX93; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUOAqX93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744310041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSBbHi8H/bOU1K7rbDyF3c8ZPtNJqVj6ZsZVCoONkCc=;
	b=LUOAqX93Xm6qZPeU5zf58XSJTUV5Eu2olxBeehfk2f/NVIK9dhrVPqGDmilyQPegA58c0y
	kel+WoHa9f1wfVl3i6q/fEfVBma1HPOHazr1KonTtXv8vQlPF9cTU+ShIPCyNmE0tHCNSn
	Hfvzf2l73TjgFCYLKYPsz2V8vGDjEhY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-AIs8-EMgPp2fTgrz4dX1SQ-1; Thu,
 10 Apr 2025 14:33:57 -0400
X-MC-Unique: AIs8-EMgPp2fTgrz4dX1SQ-1
X-Mimecast-MFC-AGG-ID: AIs8-EMgPp2fTgrz4dX1SQ_1744310019
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADE331800EC5;
	Thu, 10 Apr 2025 18:33:38 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26B2E1955DCE;
	Thu, 10 Apr 2025 18:33:32 +0000 (UTC)
Message-ID: <7ab19530-d0d4-4df1-9f75-060c3055585b@redhat.com>
Date: Thu, 10 Apr 2025 20:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Andrew Lunn <andrew@lunn.ch>, Prathosh.Satish@microchip.com
Cc: conor@kernel.org, krzk@kernel.org, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
 mschmidt@redhat.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
 <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 10. 04. 25 7:36 odp., Andrew Lunn wrote:
>> Prathosh, could you please bring more light on this?
>>
>>> Just to clarify, the original driver was written specifically with 2-channel
>>> chips in mind (ZL30732) with 10 input and 20 outputs, which led to some confusion of using zl3073x as compatible.
>>> However, the final version of the driver will support the entire ZL3073x family
>>> ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc
>>> ensuring compatibility across all variants.
> 
> Hi Prathosh
> 
> Your email quoting is very odd, i nearly missed this reply.
> 
> Does the device itself have an ID register? If you know you have
> something in the range ZL30731 to ZL30735, you can ask the hardware
> what it is, and the driver then does not need any additional
> information from DT, it can hard code it all based on the ID in the
> register?
> 
> 	Andrew
> 
Hi Andrew,
yes there is ID register that identifies the ID. But what compatible 
should be used?

microchip,zl3073x was rejected as wildcard and we should use all 
compatibles.

Thanks,
Ivan


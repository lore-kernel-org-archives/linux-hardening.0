Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBE2853E3
	for <linux-hardening@vger.kernel.org>; Thu, 10 Apr 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288723; cv=none; b=Jo3Z0kh4DutPZ65J/CKjWl35Z349IEFJtiM1KIiXLuDDL2GwWt6rvOdBKfvN4+bRF+//X5Xc4ylYS+vmo2tNA+O6gtvJ1DO21/irbB6Smdq9h4EB8sraoAwKfP7+G0fPhqCc4dOUksxJhsSSTa1ZIiXEKDW2Hh0i4e31rK3egGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288723; c=relaxed/simple;
	bh=O3N2BtvGK2gJmwWJnCkrJEaQrB/DtG48u01XU3dcyZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj29U2GBxKimhg39SSy1ZWjXWQ3RIaDF/RNVsCFKforLdlmyJ8N1Pp/GxF3zuuc6Hzdww7UsE4qcfWzHmIrfxrTpsHq+ZpZcBD/WlmDtCfUtoCERErlmUiPMTGF0NbDlXZswEfjkcc78BlQvH4KlGs5XEWROz/1nVZ48cXwneSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeaDkyTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeaDkyTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744288717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yPAXnrs3Gs5dvTBMjDIRB1XmlVJFG57qJldfBUqlIs=;
	b=UeaDkyTZ2SwapsCy/+oDM97ddivlebhy1NjWvM7t6AKBqixyKWIX/bGX3NmwLyFGGHN5ze
	h5e+C76sVh8tC/9aRqsLJXisEn3YJ0rt/LlNFFydEVGCmN4aCU3UHFZ6Q0gfpwLy0z6bsG
	VVwvyaW1GjGDS4N3tJ84ihwuNTqfKfY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-RVSYrwK8M_qjKQRELUP2KA-1; Thu,
 10 Apr 2025 08:38:32 -0400
X-MC-Unique: RVSYrwK8M_qjKQRELUP2KA-1
X-Mimecast-MFC-AGG-ID: RVSYrwK8M_qjKQRELUP2KA_1744288710
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A251800259;
	Thu, 10 Apr 2025 12:38:29 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC69A1956094;
	Thu, 10 Apr 2025 12:38:24 +0000 (UTC)
Message-ID: <905b14c0-2129-4dcf-b267-e66e23b6b236@redhat.com>
Date: Thu, 10 Apr 2025 14:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/28] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407173149.1010216-7-ivecera@redhat.com>
 <7dfede37-2434-4892-8c8d-4d005fa1072b@kernel.org>
 <280e8a8e-b68f-4536-b9a4-4e924dde0783@redhat.com>
 <b65daab2-8184-45f4-af18-8499e80fbc04@kernel.org>
 <b4d22372-ae85-421c-8ce4-669787160da2@redhat.com>
 <ecde1c37-0fa2-4c2e-ad81-bee3cc7d58c0@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <ecde1c37-0fa2-4c2e-ad81-bee3cc7d58c0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 10. 04. 25 2:19 odp., Krzysztof Kozlowski wrote:
> On 10/04/2025 12:28, Ivan Vecera wrote:
>>
>>>>> 2. What is 'x'? Wildcard? If so, drop and use specific compatibles.
>>>>
>>>> Microchip refers to the ZL3073x as a family of compatible DPLL chips
>>>> with the same features. There is no need to introduce separate
>>>> compatible string for each of them.
>>>
>>> So a wildcard, thus drop. Use full product names. Google search gives me
>>> no products for ZL3073x but gives me ZL30735.
>>
>> I will use more appropriate microchip,azurite compatible.
> 
> Hm? What/who gave such hint? Please read writing bindings or any other
> guide/speech about it. If that's a zl30735 then use "zl30735" as device
> part. If you have more devices, use fallbacks. See writing bindings.
> 
Something like this:

1)
properties:
   compatible:
     enum:
       - microchip,zl30731
       - microchip,zl30732
       - microchip,zl30732
       - microchip,zl80032
       - microchip,zl80732

or

2)
properties:
   compatible:
     items:
       - enum:
           - microchip,zl30731
           - microchip,zl30732
           - microchip,zl30732
           - microchip,zl80032
           - microchip,zl80732
       - const: microchip,azurite

If 1) what should be the filename ?

Thanks for patience.

Ivan

>>
>>>>
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/dpll/dpll-device.yaml
>>>>>> +
>>>>>> +unevaluatedProperties: false
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    i2c {
>>>>>> +      #address-cells = <1>;
>>>>>> +      #size-cells = <0>;
>>>>>> +
>>>>>> +      dpll@70 {
>>>>>> +        compatible = "microchip,zl3073x-i2c";
>>>>>
>>>>>> +        #address-cells = <0>;
>>>>>> +        #size-cells = <0>;
>>>>>
>>>>> Again, why do you need them if you are not using these two?
>>>>
>>>> The dpll-device.yaml defines them as required. Shouldn't they be
>>>> specified explicitly?
>>>
>>> But you do not use them. Where is any child node?
>>
>> I though I have to specify this due to existence of 'input-pins' and
>> 'output-pins' in the example.
> 
> They do not have addressing, so no need for cells.

Thanks for explanation.

> 
> Best regards,
> Krzysztof
> 


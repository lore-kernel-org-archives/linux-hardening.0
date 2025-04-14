Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C862DFA4D
	for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639651; cv=none; b=Sy8xIvjUUXi+rpx3dQymIchfryVqt7SAVv6zGXHMZhAieO0wI9ZHtsTACscYj4Otq/jz7Zj2W5QnxGrceSS/eN3X3/mMuwDcLnzmcq/vyqtYm58KZG4F8sJOU9UhMRsjTFJtk4bdHYbBRTA8b8q3C2gTIuRIBG2HQKGrT6oCxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639651; c=relaxed/simple;
	bh=owHWIY8G9dE/hySzkTSjv2xJMegT+zdNhRU1GpKxit4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I9c4cHeEFbNqLpjWpMBKHnuCP5XBymaKoGZdQhR5ii6tIxGtIwr0mHfybIfeBblIne9TAvb40+Jea29I/lYN7D6oh4yzFVXGIwDgc/Znxw2PGIJ6cFufMfN9rfqkq8U7qW96q8AitVGCfJQ1iXJjDZxMuXJdIrXSmKKa+nUcDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALbZUaxm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALbZUaxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744639647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw8iNW0CAqgedgdW2qInmCuGxnmBcBhtLpgF3wRIE48=;
	b=ALbZUaxmn5RwZHz0hY2+cgDfZPf3M8KXpv7JCT3zNSJId2kFFoM3FTT2YvzAiAo9II85Q7
	DCgIG3Oe1TB/3xCGQQDW+2ftEhw/UIVwEgJL2aLS6Wibu49O3thwqhfL72v+DHtgweJGFb
	G4vNGbszjf1NqV3QHIaUP1Qw6/xa6jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-3dCrszCnP32jH9NoVP44KA-1; Mon,
 14 Apr 2025 10:07:23 -0400
X-MC-Unique: 3dCrszCnP32jH9NoVP44KA-1
X-Mimecast-MFC-AGG-ID: 3dCrszCnP32jH9NoVP44KA_1744639637
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24ECF195422E;
	Mon, 14 Apr 2025 14:07:17 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13E20180175D;
	Mon, 14 Apr 2025 14:07:11 +0000 (UTC)
Message-ID: <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
Date: Mon, 14 Apr 2025 16:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
From: Ivan Vecera <ivecera@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
 <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com>
 <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
Content-Language: en-US
In-Reply-To: <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 14. 04. 25 1:52 odp., Ivan Vecera wrote:
> 
> 
> On 14. 04. 25 1:39 odp., Ivan Vecera wrote:
>>
>>
>> On 14. 04. 25 8:36 dop., Andy Shevchenko wrote:
>>>> What is wrong here?
>>>>
>>>> I have a device that uses 7-bit addresses and have 16 register pages.
>>>> Each pages is from 0x00-0x7f and register 0x7f is used as page selector
>>>> where bits 0-3 select the page.
>>> The problem is that you overlap virtual page over the real one (the 
>>> main one).
>>>
>>> The drivers you mentioned in v2 discussions most likely are also buggy.
>>> As I implied in the above question the developers hardly get the 
>>> regmap ranges
>>> right. It took me quite a while to see the issue, so it's not 
>>> particularly your
>>> fault.
>> Hi Andy,
>>
>> thank you I see the point.
>>
>> Do you mean that the selector register should not be part of the range?
>>
>> If so, does it mean that I have to specify a range for each page? Like 
>> this:
>>
>>      {
>>          /* Page 0 */
>>          .range_min    = 0x000,
>>          .range_max    = 0x07e,
>>          .selector_reg    = ZL3073x_PAGE_SEL,
>>          .selector_mask    = GENMASK(3, 0),
>>          .selector_shift    = 0,
>>          .window_start    = 0,
>>          .window_len    = 0x7e,
>>      },
>>      {
>>          /* Page 1 */
>>          .range_min    = 0x080,
>>          .range_max    = 0x0fe,
>>          .selector_reg    = ZL3073x_PAGE_SEL,
>>          .selector_mask    = GENMASK(3, 0),
>>          .selector_shift    = 0,
>>          .window_start    = 0,
>>          .window_len    = 0x7e,
>>      },
>> ...

No, I will answer by myself... this is non-sense.... window_len has to 
be 0x80. But I probably know what do you mean...

regmap range should not overlap... so I should use something like:

       {
           /* original <0x000-0x77f> with offset of 0x100 to move
              the range outside of <0x00-0x7f> used by real one */
           .range_min = 0x100,
           .range_max = 0x87f,
           .selector_reg = 0x7f,
           .selector_mask = GENMASK(3, 0),
           .selector_shift = 0,
           .window_start = 0,
           .window_len = 0x80,
       },

With this I have to modify the driver to use this 0x100 offset. I mean 
the datasheet says that register BLAH is at 0x201-0x202. So in the 
driver I have to use 0x301-0x302.

Then the _regmap_select_page maps this 0x301 this way:
window_offset = (0x301 - range_min) % window_len;
window_page = (0x301 - range_min) / window len;
thus
window_offset = (0x301 - 0x100) % 0x80 = 0x001
window_page = (0x301 - 0x100) / 0x80 = 4

Long story short, I have to move virtual range outside real address 
range and apply this offset in the driver code.

Is this correct?

Thanks,
Ivan


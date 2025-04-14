Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEE26B971
	for <linux-hardening@vger.kernel.org>; Mon, 14 Apr 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631548; cv=none; b=Xm5kU7Tn/OnG7I9yYGVgqe4e01FVywFr2IeoLK96bbA/zBekMGe/E9R6LzgaCIYU6ky1WP3S9Y1/Qe9wrnHB7k6YgfKlldAiBEeUsGD6h46Nz6QkVLZEybsdBiEs1hO6O9vBvA3cixpCS8UpyFo8CdCh0R4WS7el0A595QK0vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631548; c=relaxed/simple;
	bh=D91Ia1pGKZJkmlOIZvvVBQnMUMbHaF4O3dvtsIBon9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l1Zd11k/3s+Su18m9nbL1JcdyzBdSSL1CEGbCiAtWx8DKwjqR4LjqqkT07KlQMueHV3m1pyF0woXXfLKBWwnRWNgwaasKF7mUN1AhRlg2pyx0tyilDIpksOZIw7FKd8p+LSjjaOK8HmHFIJHGhtffT8s+KoSQsjOSLGnBhWycxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cp2AqGDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp2AqGDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744631546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00kkU7VDnxwaz8Oj1ywsgzfiYZTZml1BEDq6NOcZlJk=;
	b=cp2AqGDnh7CWd39pobMeOrspVDhOecpHyuL4jQIV4GKVu8Uay3CtawWxJouOmf9yVyZuo8
	I1be23xWYv9mhg44yGOyh/q8PakBKrBlploa460D2Lodrd+38uimFeBPJ9cOHgluaEAgai
	58mslzyBLI/lMIJP+HhlmBdUC8VPvlY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-wGqhvCzaMKWjkn9M7OImMg-1; Mon,
 14 Apr 2025 07:52:24 -0400
X-MC-Unique: wGqhvCzaMKWjkn9M7OImMg-1
X-Mimecast-MFC-AGG-ID: wGqhvCzaMKWjkn9M7OImMg_1744631542
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2B3A180034D;
	Mon, 14 Apr 2025 11:52:21 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 877E3180B487;
	Mon, 14 Apr 2025 11:52:16 +0000 (UTC)
Message-ID: <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
Date: Mon, 14 Apr 2025 13:52:15 +0200
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
Content-Language: en-US
In-Reply-To: <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 14. 04. 25 1:39 odp., Ivan Vecera wrote:
> 
> 
> On 14. 04. 25 8:36 dop., Andy Shevchenko wrote:
>>> What is wrong here?
>>>
>>> I have a device that uses 7-bit addresses and have 16 register pages.
>>> Each pages is from 0x00-0x7f and register 0x7f is used as page selector
>>> where bits 0-3 select the page.
>> The problem is that you overlap virtual page over the real one (the 
>> main one).
>>
>> The drivers you mentioned in v2 discussions most likely are also buggy.
>> As I implied in the above question the developers hardly get the 
>> regmap ranges
>> right. It took me quite a while to see the issue, so it's not 
>> particularly your
>> fault.
> Hi Andy,
> 
> thank you I see the point.
> 
> Do you mean that the selector register should not be part of the range?
> 
> If so, does it mean that I have to specify a range for each page? Like 
> this:
> 
>      {
>          /* Page 0 */
>          .range_min    = 0x000,
>          .range_max    = 0x07e,
>          .selector_reg    = ZL3073x_PAGE_SEL,
>          .selector_mask    = GENMASK(3, 0),
>          .selector_shift    = 0,
>          .window_start    = 0,
>          .window_len    = 0x7e,
>      },
>      {
>          /* Page 1 */
>          .range_min    = 0x080,
>          .range_max    = 0x0fe,
>          .selector_reg    = ZL3073x_PAGE_SEL,
>          .selector_mask    = GENMASK(3, 0),
>          .selector_shift    = 0,
>          .window_start    = 0,
>          .window_len    = 0x7e,
>      },
> ...
> 
> 
> Thank you,
> Ivan
Sorry,
.window_len = 0x7f /* Exclude selector reg */

I.


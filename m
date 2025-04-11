Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F427E1CA
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357527; cv=none; b=twZlBQl1LvrzT36NiOA/Js/51wgDh3G4PdK21v7wihxOnSwZHH07B7nbofkdEU9dBlGyoAD+93fpp5WB3qxvIvi1aSjy6TVMTsITKtlYHjz6i2lLiS2auiPHEf1XhlTpf6RGgbgpIChSEIt0H2ObAMXfASCfd8xQ2adn+MegJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357527; c=relaxed/simple;
	bh=yFKMfa01fVvPA/+6vycPplB6hZ2RANSH3ciaj5Nszps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2rCS8lgLihwUhq01Bs+73++qXtrhwoZB2+H5Zy6XO7WOMnMlTrHq78EcOKHL1Ms6cxoW/c0GnIUE19N3b+GEgD+JU1ZnNXEsf6Z2sSvr+JW1Msqoanxcf+pmNqThgpa5oUYwKDy4HlEcBvD+gT9XQnKPBCMPGbmVvHE7JIaLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTaFuD6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTaFuD6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744357524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLsgjOWVS7DH/+x2sDLX0Yn/8o48chOiekDq1vSoRQw=;
	b=FTaFuD6jKxDJqJbpUKuyaB6aWTxPu7cnSjTiL+JCD7CSEGKAowE4XortsKu+SvTRExtL58
	Fsij/Cu4ta9r63Nt4hvmSC2a8DnR8/2uB00QDFht60gB7l4Uv8tkecQ18JDUqh88Z+5DKn
	rT3MTKW8x4dCuTeCCLBy0M3EHVah9Vs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-xey1FPZXNUSijoA8bZBwMQ-1; Fri,
 11 Apr 2025 03:45:20 -0400
X-MC-Unique: xey1FPZXNUSijoA8bZBwMQ-1
X-Mimecast-MFC-AGG-ID: xey1FPZXNUSijoA8bZBwMQ_1744357518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C489F180025E;
	Fri, 11 Apr 2025 07:45:16 +0000 (UTC)
Received: from [10.45.225.124] (unknown [10.45.225.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE9B8180B486;
	Fri, 11 Apr 2025 07:45:10 +0000 (UTC)
Message-ID: <b69e1d87-7c07-4482-b156-196cb60b1870@redhat.com>
Date: Fri, 11 Apr 2025 09:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
To: Jakub Kicinski <kuba@kernel.org>
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
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409171713.6e9fb666@kernel.org>
 <889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>
 <20250410155710.067a97f7@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250410155710.067a97f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 11. 04. 25 12:57 dop., Jakub Kicinski wrote:
> On Thu, 10 Apr 2025 11:18:24 +0200 Ivan Vecera wrote:
>> On 10. 04. 25 2:17 dop., Jakub Kicinski wrote:
>>> On Wed,  9 Apr 2025 16:42:36 +0200 Ivan Vecera wrote:
>>>> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>>>> provides DPLL and PTP functionality. This series bring first part
>>>> that adds the common MFD driver that provides an access to the bus
>>>> that can be either I2C or SPI.
>>>>
>>>> The next series will bring the DPLL driver that will covers DPLL
>>>> functionality. And another ones will bring PTP driver and flashing
>>>> capability via devlink.
>>>>
>>>> Testing was done by myself and by Prathosh Satish on Microchip EDS2
>>>> development board with ZL30732 DPLL chip connected over I2C bus.
>>>
>>> The DPLL here is for timing, right? Not digital logic?
>>> After a brief glance I'm wondering why mfd, PHC + DPLL
>>> is a pretty common combo. Am I missing something?
>>
>> Well, you are right, this is not pretty common combo right now. But how
>> many DPLL implementations we have now in kernel?
>>
>> There are 3 mlx5, ice and ptp_ocp. The first two are ethernet NIC
>> drivers that re-expose (translate) DPLL API provided by their firmwares
>> and the 3rd timecard that acts primarily as PTP clock.
>>
>> Azurite is primarly the DPLL chip with multiple DPLL channels and one of
>> its use-case is time synchronization or signal synchronization. Other
>> one can be PTP clock and even GPIO controller where some of input or
>> output pins can be configured not to receive or send periodic signal but
>> can act is GPIO inputs or outputs (depends on wiring and usage).
>>
>> So I have taken an approach to have common MFD driver that provides a
>> synchronized access to device registers and to have another drivers for
>> particular functionality in well bounded manner (DPLL sub-device (MFD
>> cell) for each DPLL channel, PTP cell for channel that is configured to
>> provide PTP clock and potentially GPIO controller cell but this is
>> out-of-scope now).
> 
> Okay, my understanding was that if you need to reuse the component
> drivers across multiple different SoCs or devices, and there is no
> "natural" bus then MFD is the go to. OTOH using MFD as a software
> abstraction/to organize your code is a pointless complication.
> (We're going to merge the MFD parts via Lee's tree and the all actual
> drivers via netdev?) Admittedly that's just my feeling and not based
> on any real info or experience. I defer to Lee and others to pass
> judgment.

I followed an example of rsmu mfd driver that provides an access to the 
bus (i2c/spi) via regmap and ptp_clockmatrix platform driver for the PTP 
functionality of the RSMU chip. The ptp_clockmatrix device is also 
instantiated only from rsmu mfd and it is not shared by multiple mfd 
drivers.

I.


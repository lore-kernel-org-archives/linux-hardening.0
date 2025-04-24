Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139BA28CF61
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514646; cv=none; b=Kry8VrRTutuP9zpUdng/J2jN5AbkvHdLs/O2Vx9/oi9q0GSXzUqvsYVRIAGlaKvSxUgaS/urxlwDKH937kZLsFAsgsap0VjXkueFIF/E3SKJ8MHubPr4EgI/Pt0u568J807Np92+LV7sCgZHg8sauSaMFl/FPWmzOOjcCQbNar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514646; c=relaxed/simple;
	bh=oF1NiTtEacTqF3RLBSswQrIwgxYtQdzMVmz599t3alQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSoWRKvZJkvsDrAl4ICZkv4Ve8LPHQUcPoc5arE58qQWrVP+atOaBF9LeVeQ8AHewKf4JTSUkqtU1bRQ6J6GLdshBEHON2k5fmjBGaDg275dZjUat2HoMUsZcT3QsTqmN+NDD3SXmLKNPmTHtsbwsuHE6mMlvCbY4ehnQQ6qVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaJBGojm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaJBGojm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745514644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75yfjythih+wunclCO7cTJd0mONqo7R4hD/vWWRNvoY=;
	b=IaJBGojm1l+guP1m5+iGRpmR0a35fMadcyXH7Hu6Vb+tDNEtJSzJjUeQPJnFRPbpylcHGl
	3VaTENgbRFFSlfXSDjfKYpaR2p2QterelYw2VYaae3SB4I5F5ezSZFIOJwN66lu9cfeSLk
	HlgwQmCyv7Hxm/UtDaZN6wbzIjr95zA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-OyTcm1S3Nous0ajXC8OwFA-1; Thu,
 24 Apr 2025 13:10:39 -0400
X-MC-Unique: OyTcm1S3Nous0ajXC8OwFA-1
X-Mimecast-MFC-AGG-ID: OyTcm1S3Nous0ajXC8OwFA_1745514637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 966EC1800874;
	Thu, 24 Apr 2025 17:10:36 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9321D1955BCB;
	Thu, 24 Apr 2025 17:10:31 +0000 (UTC)
Message-ID: <bd645425-b9cb-454d-8971-646501704697@redhat.com>
Date: Thu, 24 Apr 2025 19:10:29 +0200
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 24. 04. 25 6:43 odp., Andrew Lunn wrote:
>> +static int
>> +zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg, const void *val)
>> +{
>> +	unsigned int len;
>> +	u8 buf[6];
>> +	int rc;
>> +
>> +	/* Offset of the last item in the indexed register or offset of
>> +	 * the non-indexed register itself.
>> +	 */
>> +	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
>> +		dev_err(zldev->dev, "Index of out range for reg 0x%04lx\n",
>> +			ZL_REG_ADDR(reg));
>> +		return -EINVAL;
>> +	}
>> +
>> +	len = ZL_REG_SIZE(reg);
> 
> I suggested you add helpers for zl3073x_write_reg_u8(),
> zl3073x_write_reg_u16(), zl3073x_write_reg_32(), and
> zl3073x_write_reg_48(). The compiler will then do type checking for
> val, ensure what you pass is actually big enough.
> 
> Here you have a void *val. You have no idea how big a value that
> pointer points to, and the compiler is not helping you.

During taking 613cbb91e9ce ("media: Add MIPI CCI register access helper 
functions") approach I found they are using for these functions u64
regardless of register size... Just to accommodate the biggest
possible value. I know about weakness of 'void *' usage but u64 is not
also ideal as the caller is forced to pass always 8 bytes for reading
and forced to reserve 8 bytes for each read value on stack.

> I suggest you add the individual helpers. If you decided to keep the
> register meta data, you can validate the correct helper has been
> called.

Yes, this should be easily implemented, will follow this.

Anyway, still don't know what to do with mailboxes (aka multiple atomic 
register operations). Lee seems to be against the placement of this
code in MFD parent driver.

Each sequence has to be protected by some lock and this lock needs to be
placed in MFD. Yes the routines for MB access can be for example in DPLL
driver but still the locks have to be inside MFD. So they have to be
exposed to sub-devices.

Thanks,
Ivan


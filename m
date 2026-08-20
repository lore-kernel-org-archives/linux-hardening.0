Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0137F00C
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239481; cv=none; b=UTlC2ntJKujEsPnGyy/E4+LFHTqb7ON4k5qtyNZhVker2A7F/ej5SLTOTUFdrgQFtLTdI8s0Azm/0q4hqk+WxcejrXpNHWcc+u+BsIzgUTeZi//EMPLbRmpxMZnpzI7gv+PMVklhGsev+VZjM/jt5+qt8HGtiWUo505A9VnHcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239481; c=relaxed/simple;
	bh=5mospAeJ+WQFvDOFffDJlYorx2Ldl9egIIWSX5JuVkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCfkgrmYtAd4UEhKhJEd2tJCyc42bO47CCPcC8j4YaMfr2MQA6NTgIh1TaU5ZhYhL4SC8zxpevndCdXIaxnOYamZRBzyhrYMpJ2iS2VBU2Z0tcfOzG7Jot68OLeMEWleM79IFbHGzpsKEV2tH+piiHmJwQJbWjmhWC9RQdkIi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK6Cx7cQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK6Cx7cQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so23173985e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787239478; x=1787844278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/98bX+CH+lFllKiqKstls0WsvphSuEf3qS82oTyBRRs=;
        b=NK6Cx7cQ7fIyzPhzqnCWqFrZAWtt8kA41FQhGcdhHhTjnDsHD8IWUoLhVxqhhjTnOK
         zTfnWP0xxyI213euP2FOSTpTMnYaxHR338mvS7rSFMIrwP/iRuVYZWtJfwa75EwRQO5Y
         8eMD4RFLkHmWk0WnxEdiqDjc/t4tH22dGLlqZu41tBAyTseUNShFNWbO1KgWQbFP2pES
         1+UaPCIIuJEmrEve710vhZ+16JW4DjPVVXQULQWyEBut7nWUL2uFArTnHLRzi5v3qe9C
         TpO+49jlxuW1lfSmg6Tdq/2WFWGpsrDI9CcRTOVlfslasY/Pm8CP4ssd+2zfZyrq78au
         fpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239478; x=1787844278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/98bX+CH+lFllKiqKstls0WsvphSuEf3qS82oTyBRRs=;
        b=KnM1M2zOoDUBI4ujrHvvruXgP/TpDZhWxkYLnV882CG/ZalqxigEU7jNThp4nW+3X4
         VAqV2h5FiRnH4H6SmITpYMuc1aTnW22jg5L+NQBAAUZwBIlpg7AxsaD6ZD5kZYmOMASh
         Yh9obzsg30/oE4qAdKfDQ3bsFfycZ2nF4Dk20Trfx+gigWs4cHjkGyNSZzBXf7S8i+WC
         R2qpqEwcvxFbihVcdf7EHqWY11si7np4psAG+qQmlY3Q0diA9JvTlI9WAQUjKUb5lA1K
         XSG2+yCCNOWp3IWrbDJ54d18pBuBtvuGOoGrS8J/fVNDYU+6AbXSutN0uWoUtwAsXz1T
         rTYg==
X-Forwarded-Encrypted: i=1; AHgh+RqIcUXIyDVugLejKBThqQAZ6bPl/6Iy6bX3ElWF4NJfIQZ368g1MJ572FscvpBX5F7dsVAcv5BdPwgj8ElxD/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcETK0qPrPZvlqUGZNY90BWb2dgmUKqo/vo5qbO0dbJJqjKoIq
	w1mJOF+VEugoegk+aIOLBJ0uoN3bZN3t5Q4HzpX2EdtV3OfBeagpISph
X-Gm-Gg: AR+sD11BBW/YcViYyJaXRrFYt8qcmctlqEmNDnF9R6mFyY1U5zx+QMDAE60Ab8iDHCN
	eWZYWa8Fu2rru9ClqT1kk1EbELIoMzcZZ3aBxsXeduylkID7duiALSSJDb3kR6gvC+UJeAmW3/0
	1PA78Y4lFdmkaC07AoB5cfdffmrHa4wuKvULlmI9tAyToxomkPs/h7HLzjx8KYhXSM0OaoX0pbA
	2Q8QfYnbGfvVJC+FRFxoiauBwn3ZPEbJRs6vq+Cjh4CGqnaELOHXmdrW97bwVO5IDX6fDsgQgy4
	Hk8bXcUmbxMNARd/6kGfEpx05ri5EnLGkU2lWl5Qb2JkVrmSyo36ErmGGw4aA7TYvsOpWEPzX6G
	CPM5/rpjUBorT1/Ll7/9Vi0LFw0Tn5LGiecJtoDdfb2yV10wpFkJcHfHXgK5jdDpL/y46NvjK6d
	fXn4vGatFO0p6bppVyNSXnakqRBoS0G0Li7kCTLabyKUERoUsOtfXgwwAwb7UUWjK4N3w+VUll7
	lf3JLbzD1WW6jmIg/1VTVllstGAyw==
X-Received: by 2002:a05:600c:6748:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499aa1d0670mr268427225e9.9.1787239477402;
        Thu, 20 Aug 2026 08:24:37 -0700 (PDT)
Received: from [192.168.1.118] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm12618644f8f.27.2026.08.20.08.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 08:24:36 -0700 (PDT)
Message-ID: <4dc461a9-68f8-407d-b458-695ac263ca37@gmail.com>
Date: Thu, 20 Aug 2026 17:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: Add Motorola One
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
 <20260820-next-patches-v2-3-7130d68183d9@gmail.com>
 <e16a7122-18c3-4bc5-80c5-1cda458fa2c6@oss.qualcomm.com>
Content-Language: en-US
From: Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <e16a7122-18c3-4bc5-80c5-1cda458fa2c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/20/26 12:17, Konrad Dybcio wrote:
> On 8/20/26 11:42 AM, Adam Skladowski wrote:
>> Add a devicetree for the Motorola One smartphone, which is based
>> on the Jacala/MSM8953 SoC.
>>
>> Supported functionality as of this initial submission:
>> * I2C peripherals (Touchscreen,NFC)
>> * Power Button, Volume Keys
>> * Regulators (PM8953)
>> * Remoteprocs (ADSP, MPSS, WCNSS)
>> * USB
>>
>> Device tree also contains supply maps to other subsystems like MDSS
>> but due to missing dependencies like panel those are disabled.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> ---
>
>
> [...]
>
>> +	typec-portc@22 {
>> +		compatible = "fcs,fusb302";
>> +		reg = <0x22>;
>> +		interrupts-extended = <&tlmm 9 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&fusb302_int_default>;
> nit: outlying sort
>
>
>> +
>> +		usb-role-switch = <&usb3>;
>> +		vbus-supply = <&fusb302_vbus>;
>> +
>> +		connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			power-role = "dual";
>> +			data-role = "dual";
>> +			try-power-role = "sink";
>> +			typec-power-opmode = "default";
>> +			source-pdos = <PDO_FIXED(5000, 500,
>> +						 PDO_FIXED_DUAL_ROLE |
>> +						 PDO_FIXED_DATA_SWAP |
>> +						 PDO_FIXED_USB_COMM)>;
>> +			sink-pdos = <PDO_FIXED(5000, 3000,
>> +					       PDO_FIXED_DUAL_ROLE |
>> +					       PDO_FIXED_DATA_SWAP |
>> +					       PDO_FIXED_USB_COMM)>;
>> +			op-sink-microwatt = <2000000>;
> This is inconsistent with the sink-PDOs you defined (5 V 3 A vs 2 W)
>
> Konrad
To be honest i don't get what's this about.
Based on docs it says its minimal W value taken by port
and based on PMI8950 Charger it should be about 100mA@5V
while SMB1351 can also take as low as 70mA@5V
I could see it being higher when port is used to power SBC or something.

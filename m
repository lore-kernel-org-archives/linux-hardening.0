Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00342503BCE
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902293; cv=none; b=SKXpHg/qAIz4VSe1fKj/lpQ6whzDDnC2as3i0mWk4Xst50bM4oyHeZigdaGlc5hBbwBfQp2/R6t1RCSvGyF+0yGwXL59FZVGUPrP3nkZ4ng1bDZxNBw4so+2FtjxpJy/6it14Ja+/BkWRh+plRq2PNug9xOmJC8XbT/k0UxsNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902293; c=relaxed/simple;
	bh=Fy4hww/bwmxQbL1BwdmGfWhDcfwRm+UBIieq6CF5cl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkkmKpU86vJQ04w2V/YpNl8rNnQFETCxu+S1UcDn0tkqbcK3nnvAUZQaMAF5kPvHfBXoMm+mTb3X0q8zu9KoZ6SPNGrwHgZzGxBP0wMi8vsOyt3CwXbS9RwxbtHRsQvpe5KSl+bjcXtbXDWp9cRQmWpYUvm1/JsQd2/0PlymBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1pbe1si; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1pbe1si"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so24483005e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791902290; x=1792507090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fy4hww/bwmxQbL1BwdmGfWhDcfwRm+UBIieq6CF5cl4=;
        b=b1pbe1si2E3iCvTwpnUvD68ItEgscrvhe6z0QxoCT4Lk9Q+AaVPC8gosjyH+hNVD5Q
         n6H3H6tqols9NIuIA8vK8bzggzNpPcL+1V0bGEPaLuHRCWItBkIAQ9vzqCMfqmI9duvB
         W4nkhH6e2QrqNSUtASVrG5tSq1C/73+cYsWeXh21p6wpAk4IaeWDR2AYzCBBlFq2Mfm5
         WqidzRV1LIfUgOjXwc/3uwZ6i0LFczf5l83yd8xX2eh0DMtOI7f9qpSpgmEdMI2xcC6k
         1sQSRAWM9D/zdnr6eMD9aGPQINnLnByV1S5sQnfxZV16fDr/YLuB9ZZqSkP3XJTSPcm/
         VGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902290; x=1792507090;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fy4hww/bwmxQbL1BwdmGfWhDcfwRm+UBIieq6CF5cl4=;
        b=KhfH25GwfQysHsYX/t4MRiR/3cIgIHV9TbPjhLcngDl0u8wjFqA6hqv4UOi+TXyN9A
         JNeJbJutyYR1Za6R/7VWpOGwpc6zw1DTAeEthGnGTzyTSq4Mh8R3yNsM4mKLhM+wJ5AO
         xM49XbApmLtz63T78hdwcarLAODP1pTMIL44R67I2vWm5YzfbTavwCso7H2ArK5x74KG
         rn+SqgUHkCV6ACJdpeg+w6PsgZxZCr3frocsDBLr6kkhn2Y7un+h5nDpNPP6FiwZ2KXs
         tuOc3m9iVCdXo/VX05KiwFOpwZ6YgtbqMIRa2qlQiFQz9DFUoQ3wXnwBD4qsy9b+B+Q9
         o7Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxLcKSf/B+zGSDIm5uOrokZK8m1g9jsf7Y7vJTPAKMvmGqB4cHNw971m1cp1AwjklK8/ues/72mPENl2GB1ffM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4znfGATwIA284JQl2FpO72uoVp5SH1drgG0ZBgm+kusSlNmh4
	npznIrTzyfWLXKFgS/R45/RBmN2A5Egzy4+/DcgylvOSjUW/ArDpUcxtELWPsrIuMy8=
X-Gm-Gg: AYBFou0hYVn2x9Ktxwq3JMNNCOZ5qWHqkPT/2KAVt+t67RN5b3BZ7zWZjOzEt8jJv8v
	PXu1eJ9yzmQfFIrg1z03PKfVKh/A8caLhgeGeNiYCpcnPJck8OC9lhIYxiK5JLDsQW2dVqfbMnD
	BieNidy3URDrFwBfY3xbJ5pJwcAvgqiSZeEx7WFvKzlGJcd0kAaDmV1JO354ZQMZgZuZfFZGRkO
	vv1l9RluQslKT91YblYc9OOOWyrYZQVUY0pZoeqwz+2K3I6PgltDNNNwxQE/uZ0440vrvNjK4df
	Rc5TdYbakAMfEw5vplKD2skbhxkvrj8OpEfnE4NNOKPW4vSjYAbBRfOEJUyYzYWVWCwtgGkn+lP
	eE878shdIPPYiB+lSNPlN7lNti0Ed0K9u4xlbcEPsX6FabTJUE9wkYNY43L7xPRMQpKhSoQsm6T
	Yx+MkQ8UwlnmGEEfv2212R4ohq+8FY/E3QUr3n0RfjSAvN9b8uUT/WttWNsw3pyx1BL63fptKXK
	b7uTpn6
X-Received: by 2002:a05:600c:310b:b0:4a1:813f:2a5b with SMTP id 5b1f17b1804b1-4a18e4a9da8mr235341925e9.14.1791902290063;
        Tue, 13 Oct 2026 07:38:10 -0700 (PDT)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c8244edsm198277585e9.2.2026.10.13.07.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:38:09 -0700 (PDT)
Message-ID: <4576292d-2c3c-47db-8422-9f9e730cfecc@linaro.org>
Date: Tue, 13 Oct 2026 17:38:06 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
 <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
 <04a1331f-1375-471e-a674-87039aeb0328@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <04a1331f-1375-471e-a674-87039aeb0328@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/26 5:31 PM, Daniel Lezcano wrote:
> On 10/13/26 16:26, Tudor Ambarus wrote:
>>
>>
>> On 10/13/26 4:33 PM, Daniel Lezcano wrote:
>>> Hi Tudor,
>>
>> Hi!
>>
>>>
>>> I noticed I picked up your series without notifying you
>>>
>>> However, I did not pay attention but picked also the dts files.
>>>
>>> Shall I drop them ? (AFAICS there is one comment) and let you handle them separately ?
>>>
>>
>> Yes, please. dts and defconfig patches shall go via the Samsung SoC tree.
>>
>> About the driver itself, I was about to send a v9, where I addressed
>> some issues sashiko spotted. Do you prefer to drop everything and wait
>> for my v9? Otherwise I can do incremental patches.
> Well the v8 is in my tree since a while now and I'm about to send a PR. The patches can be dropped but the v9 will have to wait for the next release. If you want this v8 in, it depends on the sashiko report. Is it minor or major ?

They are minor corner-case races (an interrupt firing midway through
system suspend after runtime PM is force-suspended, and module unload
racing with a concurrent sysfs temperature read), plus a few small
cleanups (adding `select REGMAP_MMIO`, implementing `.change_mode()`,
and renaming the driver from "gs-tmu" to "exynos-acpm-tmu").

None of them affect normal operation, so please keep patches 1-3
(dt-bindings, driver, MAINTAINERS) for your PR and just drop patches 4
and 5 (dts and defconfig). I will send incremental patches on top to
address those items.

Thanks!
ta

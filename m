Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBA50C2B5
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898666; cv=none; b=U8vmWtNsxmPy2v+EHc/HL586P1/dFVd4bslBuDurShGoQLBXUHKJKnoiHwhCpAtt+RUYVPEHSJKDNzaUD/6R94/mPni2Hmw4jFUFYM9IpXxGeTFFoXAY6O6jyTnsWYx65IP+EJgfcirZhzgfAKLd8ciFhI1bDHLjVYkvH22wGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898666; c=relaxed/simple;
	bh=T0gEegxxkJPIJDhKcCpy+DVBH0Q0d0FvbE/A5IUsvbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icGKO86+ZLrblDgtHon8lILxis1eHvn0CDcIiRvGrCjdj+sGVH3/wCxzbtznPskYBYQZGRMhF988n22seQKWrkqsTxXAidRRgePQWk+eetm7DsAnW60wO+TM5EQ3elKoU0z61qTNlaxvlSGLmjTR9Cc+HedaR7tfE5GVRo/oH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=TL7pSfW2; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TL7pSfW2"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso305866137.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791898664; x=1792503464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlsVFfaIIuPKHvN4DoxnWGx5DKD1aHI/E2hCDA2/ghQ=;
        b=TL7pSfW2iIIhSF2TEhM/vxIB9SfrTmjZdMcNTWKth8xaBLIX3+rhpyp0SYFbUoRtts
         +0t+Ni+pKRBZ6ZNepix1UAvxH/pzM4uUQeUg8HZwqyOsa0r6akylP95qF/u2Xl68H9Pk
         4IO3ldQ+UzdQ6Ifwzj61xpsDr6n9LByKxPq3RXwhA9RFjlhxpzm18pyJz0PfoJ6XF5fD
         ohYN/S1MAX7nvIozXAUDhifK7XfMWiwJ6nxEofXU6IoEw8UZN5JfKpy7xn3vRMzo7zH7
         kq17qcS3pbn4Bhwwb2Lb68J2acACQ/rndtSE50zjiAktJXxc/jgKUSA++2ZnGgYdm2qU
         XZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898664; x=1792503464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlsVFfaIIuPKHvN4DoxnWGx5DKD1aHI/E2hCDA2/ghQ=;
        b=1vq4nL90KdVclneatQTJlvAyEKHJ8xobRNU+omJd/grc4p/h/xlXgaErbfE/tJgfi/
         Rd40+3KeBTY7gwpVlG3vjDCt2zIC2bP1ar9zZklwkeYbsLvJmypC02sXesbImD57qOV7
         NQevAbWRay/ywgM41S+JZ61YYzAOyVUeHmn9aNico+oOTwl9TZGP8yqO/RQd7BG2pogb
         vaFZRnWMzvbp3OBXz4ieuWFwT3Q72oKiXqfGLUQjQrC23GxF4yb6PHGuytaWNw+Hx7F/
         2XBHD98VwDUlIUdDAtGIALq7E7mS7vIL4YLPnRAg8vA+Mmj09UUN6c9IrGNlpIgoIO8Q
         e78w==
X-Forwarded-Encrypted: i=1; AKwUvBwSNitr51ETxIfBNVvnJQ2/rnncrflr/XoyVghVqHGdwdygvLm6RCO5Ujg5Yj9GG6qzAjEsUgQGRzYUAfIcFHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz6OM9Yx/9TyPzG30FXlRgo6XxBVnCPScV1W+Vgj01HRDzdG6a
	KPWgoKyBTGs7G762eHS+iH7QTPB12eOmaA7+Gl5LcKeJOw1vgr1jwtRbDf9s6tZ4bVU=
X-Gm-Gg: AYBFou2ZIXq7E023sLIDvPA5OLQGkAjD3Q6HXoP+5hBYwSP4uOuXi2g/HH46mzI+0OG
	e9ZR8fBA5OQGgNuHR2o8hMs0cTWW9l9DtB/QmUZlKmzo4T33ql5XvT9T8p9ERylQ4oeJDh0L6Kn
	2ybwLkGzQZb6deZNoE2uIBJKn5jlaYI1NxSw6Izpqhh26JQ7kYGFsOFjOJJqyzOFkgPoRho2COu
	cPxgimkM0AVWVqOtaMKcXLTWjeLhvUZ/N7sITh3SLn0QUKDiYGY0oV+hoJnLQswdV9100zAwncs
	2bVfZ/r3FPX/Zsu/Pmn9vcVg1vqzYv7xvSSdKDDOSy0pIIP/kHHzA4DIpZl2L40L7JYcSxl+KHX
	sUE7P4gSvrgq2muxpRpJZhvhc8+xCrxi7cZXY0MR/u74EQ1XGupkB0HrJieLuk/psrWw7ilDXVO
	FBHg2x8rm+detbfbKdWh41Dq+4z/e17OFIceIMCdzmeGT6uAwdqr1JXe5Y33UfBk6GfyS9INo=
X-Received: by 2002:a05:6102:441e:b0:7c3:fcb7:8c8f with SMTP id ada2fe7eead31-7cb3659063cmr2890865137.1.1791898664075;
        Tue, 13 Oct 2026 06:37:44 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb39d6396asm8528133137.1.2026.10.13.06.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:37:43 -0700 (PDT)
Message-ID: <155e6870-db07-4d28-af36-9b570280fdaa@riscstar.com>
Date: Tue, 13 Oct 2026 08:37:41 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: toshiba: introduce a TC9564 SoC clock driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>,
 Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-3-elder@riscstar.com>
 <179183220207.266355.11690534397452731561.b4-review@b4>
 <10007ecc-3604-4c58-9da7-f056dd4355a1@riscstar.com>
 <1jtsmq9j5l.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <1jtsmq9j5l.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 2:03 AM, Jerome Brunet wrote:
> On lun. 12 oct. 2026 at 14:59, Alex Elder <elder@riscstar.com> wrote:
> 
>>>> +	TC9564_CLOCK_INIT0(MAC0_TX, 7),
>>>> +	TC9564_CLOCK_INIT0(MAC0_RX, 14),
>>>> +	TC9564_CLOCK_INIT0(MAC0_125M, 29),
>>>> +	TC9564_CLOCK_INIT0(MAC0_312_5M, 30),
>>>
>>> Are those really just providing the oscillator parent ?
>>> That is what they will appear to do without a proper recalc_rate()
>>
>> They are fixed clocks that can be gated, but their
>> rate cannot be changed.
> 
> It is not a problem if the rate cannot be changed but still
> a consumer could call clk_get_rate() and change its behavior
> based on the result, so it is better if it does reflect the
> reality to some extent.
> 
> Just add fixed_factor clock elements on the path of clocks
> where do know the output does not match the input osc

OK.  And because I'm not sure whether it matches reality, I'll
do so in the code, and not expose these in devicetree.  (If
this is not correct, please say so.)

>> Looking at __clk_core_init(), should I define a
>> recalc_rate() callback that just returns the
>> equivalent of get_rate()?
>>
>>> Their names suggest that maybe, it is not the osc coming out
>>> of them ...
>>
>> We have requested a clock tree that explains exactly
>> how these clock rates are derived from the 25 MHz
>> oscillator.  They're all fixed rates, and although
>> we could easily speculate how they're derived, we
>> don't have the documentation.
> 
> If you know the input and output, you have enough to figure
> out a fixed factor. If later on someone gets more information
> than you, they'll just modify the clock tree.

OK.

> If you no idea what the ouput rate is, at least clearly say
> so in the comment so a future user or contributor can easily
> understand the situation.

I'm pretty sure I know the output rate of all clocks, but
if not I'll make sure there is such a comment.

>>>> +	TC9564_CLOCK_INIT0(MAC0_ALL, 31),
> 
> [...]
> 
>>>> +
>>>> +	clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(clk))
>>>> +		return dev_err_probe(dev, PTR_ERR(clk),
>>>> +				     "failed to get input clock\n");
>>>
>>> Nothing is using this. This is not how you set the parent. See above
>>
>> It will once I have the clocks get properly parented.
> 
> No it won't. You don't need a consumer clock reference. just drop it.
OK, yes, the parent(s) will be specified in the init data.
Sorry for this, and thank you for pointing it out.
>>>> +
>>>> +	clocks = tc9564_clk_init(dev);
>>>> +	if (IS_ERR(clocks))
>>>> +		return dev_err_probe(dev, PTR_ERR(clocks),
>>>> +				     "failed to initialize clocks\n");
>>>> +
>>>> +	/* Force all clocks to be initially disabled */
>>>> +	tc9564_clock_disable_all(clocks);
>>>
>>> Why is this needed ? In general a provider should never act the provided
>>> clock on its own. Let the framework deal with the used clocks
>>
>> The intent was to start with everything disabled--a known
>> state.  Sashiko pointed out this races with a user that
>> could get the clock right away, so I intend to do this
>> by initially disabling all the clocks before they're
>> all registered.
> 
> We do not do that because (in general) there maybe devices already using
> a clock provided by your device and setup at a prior stage (like the
> bootloader). Doing so would break them.
> 
> Leave this alone, the framework will disable the unused clock for you
> once the init is done and most devices have probed.

OK, I'll drop this.  Thank you very much for your review.

					-Alex

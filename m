Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9C542EF0
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080680; cv=none; b=MMFB+KBEF+64OO/lwancANYx2HXQeV+OVaIqYT6ZlHeFAWYfs4QXG94EFVE593sDMk0TONKQ92KeJQg3pzyruL2aHTsPnxb3b7B6fGGi/df1b/dZP5gRWAIurEt1OXE+QBXeF0f8qaglLL+za2elvSE333FvvRG+hy2nEg5oQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080680; c=relaxed/simple;
	bh=H/P/6p4tn/F1HONtpik9rVj8NHKsX7jwfbvX1rYbyC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZITdheuBhWC5tRCvrti8zQS2hmLz8rugU9iC6qRuG1beWlRgpXOEqrJ0VuoXhL6wKjb3gn//Rj9hyOHLD4eYo8Ha6OTZP7+A50Pe64hAOKmAP1KXGh9GjXbc1MYrEtAf9/HsqSlR5L0Hsw2OLTs4OZIIrEcJ8XwBQL6vScT7CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=FkfWRGaZ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FkfWRGaZ"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530301ff353so54395831cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790080676; x=1790685476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMkuwapQF5xBh7yi5E/o9NS5zNE7MVMoqBZQFdDzhrg=;
        b=FkfWRGaZwREVIsrqzjVFGBGzPV1U1peitkJIphN7YFqzJ6K67G2ePRscEg1Sldl5Ap
         mZr741X53n5wqw2unVOMRQJqYlVP2vgxX1CgV3LDSH2QHN64dDiK9wTXTx1E1cZFu+iG
         4wIUG+I5m/uwL/t7YZixMmRU4tlLbZYRPWOKO8NrM0aT3wZT+/2JzoF530Xyn4d5GXpA
         GkSb9lmn5d2QL3o6aRABwaKepKcHuIm6Y4Vv/EG+Tr14bqDOiIY+EDphfJE70aeiDUzl
         t0hlGCLOI91vmsUOolLi67nxaV3NokjtYRjiXM+BWRxsqkwJu2YnrJC/MnfJ7CsEDZG1
         ciMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080676; x=1790685476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DMkuwapQF5xBh7yi5E/o9NS5zNE7MVMoqBZQFdDzhrg=;
        b=h1nKD8yNvoXAs2BTxx+Zz3yV6GfHU4mPWAQLR0LhewOAX9UjesYQUjPBhDmHy/4UzO
         eVyL/H2ElI9Px+Ssd0E9p0U59PqFdIlmP2wjdIXMOw3dyZbIuxnEYeBqlqUZA4LcyWWM
         hu/k5RYgTUhfX14uuOLOs0LOTAD7usPXykQ+7+dWFf/EXr7EKWIipdziAU3vyiA/8WSp
         uzQ2i170iTPs7IFHBiLtahFwYFQgXF5woDMRc2y0excE+ypBCRdSE9HEUmYCqqt56SaE
         2OMyiClcI8NfHRzObKDNVi42QCBIvV8XYARjiNSoKneFUbGWHetCk9hLmw29Q+JnF6Xc
         MqXw==
X-Forwarded-Encrypted: i=1; AKwUvBxz9OfIHdFbJbqNLPv6uJ1KTfNKqWrMDXl+yPt37v7moL0C/jhSMfxN+PusyPtH48rMNfxP/wM0BGU2XsS51oI=@vger.kernel.org
X-Gm-Message-State: AFuF++loaRt1eabPvRhv6qvYij7UWCUS+5hbVy3+2hSvljZn5LdihMEx
	8OaSJVU7kfMNos5a5BSTuCyXhK5Dm97Nb30WG5cPWhq1hiNU7gQsM/1eGFoMU4AbbYs=
X-Gm-Gg: AYBFou0sH0/JSeagCHFgpXuPbRpCk5gUtqRiq26DM/W83m8GWXCc4panXrdG2JyC6Vx
	gS6g6dhmjCQG1KoX9tM/xySHNtp6y1oi6sHZSFwO9RuzuK9hTJaGwTWD8C6xMjrlePS3SRXeroL
	TdjYSUJGP1njpeKtay64KLe2suTfMyqT0IwTWvaabn3fUioWvyYUuXtaEtxT06CjKaaJRfQXtgZ
	pWyidjsUL0+zkBOEznHnYmxwd13ta819pJnYzSEsBiC68/lqyuizedY11ZjY1zq9+fsU+n24ZQF
	7xplluT4ARgLmCY0vZxFdYyNoV4i7CGe3wKTm7TFZhO8fiDnUGVpaQNndsjo7gwsuc5EixjOkAc
	vdGBFpu21hBGNoWBm0sD0NmYg96GYvNcs4YpHR+NV/vtF14kggzRc3TfQ39Qe6zD0kuyY3091GT
	6b8SgEm5fTq8TjbZjNTdfFQZ8N/eVyOPKPeTB6tGJyer/LunGUNWP5eSF/DAxWMCiAh1bCtHHr
X-Received: by 2002:a05:622a:1790:b0:531:190c:85d4 with SMTP id d75a77b69052e-532dd3ccc11mr36804681cf.1.1790080675565;
        Tue, 22 Sep 2026 05:37:55 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18d753fsm11687481cf.13.2026.09.22.05.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:37:55 -0700 (PDT)
Message-ID: <28ebbf27-24db-4b5f-87f0-831d13f93b8f@riscstar.com>
Date: Tue, 22 Sep 2026 07:37:53 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: toshiba: introduce a TC9564 SoC clock and reset
 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-4-elder@riscstar.com> <arA1svdQzaj3VanR@monoceros>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <arA1svdQzaj3VanR@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/26 2:39 PM, Uwe Kleine-König wrote:
> Hello Alex,
> 
> On Fri, Sep 18, 2026 at 11:52:32AM -0500, Alex Elder wrote:
>> +#include <linux/bits.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
> 
> Please rely on linux/platform_device.h to provide of_device_id and drop
> including <linux/mod_devicetable.h>. (If you want to go full iwyu,
> include <linux/device-id/of.h> instead.)

In general I would like to "go full iwyu" but have never heard
it expressed that way.  Can you recommend a tool available that
will help me do that?

It looks like "mod_devicetable.h" doesn't help much unless I
need struct_cpu_feature (which I do not), so I'll include "of.h".

>> +static const struct of_device_id tc9564_clk_ids[] = {
>> +	{ .compatible = "toshiba,tc9564-clock" },
>> +	{ },
>> +};
> 
> Drop the trailing comma after the list terminator please.

OK.  Only for the list terminator, right, because nothing
will ever follow it?  Non-empty final initializer is OK
to have a comma as far as you're concerned?

Thanks for your review.

					-Alex

> Best regards
> Uwe


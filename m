Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A811DE2A2
	for <linux-hardening@vger.kernel.org>; Mon, 28 Oct 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128752; cv=none; b=S0btSDyaw5tbSkMTOfR1Jk0PF0QfqLLYE28UZtbOOH6YJMuSTSEw2I9KIsGdenOzSzoxspfUk/r6bLIwSnHp2y7Og0kWG9VC519d/B84X1UzdKVr+9VAQi7RxxdFRLo6iCqCIRSY+oR2rEHmlABVZgTHGG1uJ5hin4r0CqczwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128752; c=relaxed/simple;
	bh=VllxgaeAxK8ya5awbEYif/GTv+HwiWvVjE+QOtBgID8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0D8E90/MgcHLkBPmFt1JO4mJAYRpD/PzlW/h1XysjRQMoXP5oNIG7xK32HnFa4yjZdaNbMbaBXD0UuPAVJQWGZq/h2Ia2LpFytjM29I4KZG7zjtCa7c5knpVscY+NVkr7IIF21Cu4gnbWtXSQFU2jPnLgs7YyeNPu5Z3XDzX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bvu6EdRW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvu6EdRW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso43554935e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Oct 2024 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730128748; x=1730733548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMehf1cmdH70vQG9fYSA+nflJUhXY7J4qMYXjLbnvAo=;
        b=bvu6EdRWRLN8I9W+o1Ysnp8pqn0fQ5dZ2rM1c3tcMvX5XjFicL4WDT92YX0XihPKZZ
         /LFaQWKdK7v6nvER9o+/np0eCCwOcVV0aXI/W7WCF9UX17z78gEjfYpG4+6CyCrx1RT2
         OKnjl18xymnuIRuu1Cu4npO1cB549Ks3DLAkCr6qbtMURbvvs9RhyW1PCTc/4aRqaUoZ
         SkesemltK91WcYBrhDXXsNWnSIlQ6srLFJ3+uLADyhw1HHJykxNVDhOfZiwIzSXHCW+I
         jJGNjy3RSbf16PnD/5OLS/HvLgxM6HElIutIiWdVAl31+KYoNBFm7dAzx/I0e5xsssnK
         5Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128749; x=1730733549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMehf1cmdH70vQG9fYSA+nflJUhXY7J4qMYXjLbnvAo=;
        b=HX4IB5Et6Cm3FeDGCHGj5VJvz2LhzQQLcYR4ovBlHdl4Kjm/ssQyO9l7ODYKl6cpeN
         5FwhAJuIEQ1QRPINf6XTbTorzhg9/Stqq5ncaicVKqSNnSiTHfSl//oPV9QOntqNkSOm
         e1sN9W/mgiDQn8H0F77zetkq8oPp6HkQPFy5wbq5VOw/YUU1FgXwi0Z5ydfXI96W0VI0
         7SgDOLf0ehJ8PS3vTCXy9wdC78tYY76sTTjoUmd7wYIDOHSPprNSAwJ2S6DJxSe/EhkP
         CthOFLt+SRsfQ8yh9Tq1038AuqiVONRFvvmM/Eg85dpLx0huGTT0cshexLU66Ws1uZVX
         x6+Q==
X-Gm-Message-State: AOJu0YwfufICAb9ko+9YuMcFeeFez/7fuqKrFQTjMPvPtZuITcgF2tqf
	DfY+GINaeTQynJOMxccIJGEXkOQhASZ4qt4KVqB7Hh3RJlDRBRp37VHwzbHp4ac=
X-Google-Smtp-Source: AGHT+IGqWBuggalF2VXXcJZ2EXD/713dHl0Cg5IYvuxKR1Y1NivxEcBCDFYslrN2INjSCJjCmJyyiw==
X-Received: by 2002:a05:600c:4eca:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-4319acad842mr94286995e9.17.1730128748659;
        Mon, 28 Oct 2024 08:19:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm145072845e9.47.2024.10.28.08.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:19:07 -0700 (PDT)
Message-ID: <56b07267-a192-42b7-a4e9-5fe7d86076f7@linaro.org>
Date: Mon, 28 Oct 2024 16:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and
 ARM64
To: Enlin Mu <enlin.mu@outlook.com>, tglx@linutronix.de, orsonzhai@gmail.com,
 baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
References: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2024 09:25, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> sprd timer is currently available on ARM and ARM64 based devices.
> Thus select it for ARM and ARM64


Can you answer Baolin's question ?

Or can you tell what is the rational behind this change ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

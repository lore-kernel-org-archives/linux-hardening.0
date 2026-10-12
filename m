Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FB4E0B7B
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835165; cv=none; b=T60vD8jc0iRxMW28/gCJqCtgGLj1WuuPU2rAqDpEbGpdP9CLWoSldMqA/QR6MBmRUDtg5HppQCEFQyV/Jg59N3JliP2oOwwyraFVJCx7QIHgRvfICS1yJEMiLpEXmRLoFj+Y0niDzJ+Yp+O8gM/R8bxmor8I8KOHsPqEtdTPb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835165; c=relaxed/simple;
	bh=cpWrm/qLrfCaxwKAvrTPQuxxJuyVWyZ8+EWRPwtSxTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRs9ICYCJZAq4lMsemDkzkj9MDZqA/K6ZS1HcusL9jTW+xoYO13lLNLLDRKS05GXPJqtyPpfCZ4QXmLKGyvVx5GUtyH5PUsbnVAHW7yPABC1gOqZFkluiLdbMebqSfbSYJbWDj84eljrbhG6LLog3d7E/iOI50a9H4F1zJvNedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=RTSYGB/8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="RTSYGB/8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53504882980so26730891cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791835163; x=1792439963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tu1RymioQvrQ4tyrLotMGHTUWkYq/MH4DS7yYk9IT7Y=;
        b=RTSYGB/8BMxgnq5xiH/1ZiufGRQSctbV3HCWADHFC3Lyxd0jG50BIBoByX5Hi4l70i
         iRcSixC0bw1MhxXW5EVIiTsSBvLIOKMj2IzXO8oTNTFtdjQP0KRIe/q5P8e63zk5o2yf
         3Sy/ksrFpebNDnwpRPdvwq56keIYVzJqRtlhSw7oku7VG6eGhrj4vVlD9D2ctc0SfduI
         dsCZe6o6zs+S3v4OP3yeo80AkSAD2z5p6NtFFA/cXhDNU7y6491xCyA7EtJTm1sYbvFS
         3Bo7mQ1EtskvS/oGvtLrp061x/NoS9Uecjep07mZ9/AHp+Z+Qf/mxieTdST2RzANOB0w
         bPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835163; x=1792439963;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tu1RymioQvrQ4tyrLotMGHTUWkYq/MH4DS7yYk9IT7Y=;
        b=t6B+fcWLKUss+zOG0/spJ26gUJIe1SLPTCuabd7RVllcx53n9oADg9rd5VTr/5vWMv
         c/suOq8gDZoenBUt3t/WQJyk4pCeLEeJ2/yIzGmsYikyDMvTVKZ1N+E46Es/ZU8TiGMj
         cdVjLQbrs7LZgDIOSxGoNQEMIOr2yvzAt8XApjPT0sA9Z0dhHxstuFWbKcgk+b6Vgvu/
         g0IJnchfCMZ3kDhJisclTw1s/3kRbjzzzZjFPrCoVJ0gRr6DKLApg+AYNHNa+Y+0aCQM
         gC/OwKRYAqUpVsJaP4VcOXgtgP2ME+rZGrjZqvkHx6ZqVZbHpPIMeRFmP6u3bek6iHuC
         0hAw==
X-Forwarded-Encrypted: i=1; AKwUvBzrLaOV/Nb+ePkvvMApdbVlDYHpuS+3T8zrq6HVZHLX1i6CCdYA9vL7z/RoSmYrLFqiFcLX9yOMUtUBx+eATCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIP1dMrQVbHJMYxbNNs+666J6XZjDgoXcE2wLpFxeGEKFwHuvVu
	7FQeWplP/anEmslHCpvUg9yCU6JhtZnoAzdq7gA1pMlqGtRxYr0nrtZGmgPW7Tre2KQ=
X-Gm-Gg: AYBFou0k/UYXS0PDbv6nT/ZKubzjAisUMMquIDhjmyb+19HaPctUjI206Hxi9JprBQa
	5bnFQK8dCEArH5vThql57KDHdbbuQFrZ5G84iLMZRntXWqSQzJSEOG4mWFychCa3HYKGk+JgngD
	6va2NuuWsFUc3VhxBjEvOVEGo76I7OEeSEBSiT5V3tu9n5CRIbNt7K6mIbifk6gly8NQe9NC7nC
	CIpJHKQTTMS45ocODsTo8h5sFjiq1oS8pK27tKHZAKuuJmWE5sDZbO4sHoRw23zDfjlZ1Ez6XAV
	3sMXprMVdMaZ+qeMHXmSCOaGOl4tN1QAan0bFFDjz0XTmypzCU0rMbe95DNGW4OhPwuZU9FtV1v
	fxpNYxQgIxkfypoqN0sbqkpj8byaXBGnYh5tAMJLWpjLjqR3XDwxx2KaiW6ZAd2Hen7WzMCgAeb
	14CaF0G5NRfmRnGITwSpRhQfmglilCLUmAOXrZYM6tiJFAJ4EC83yV0Miz39UH6u5YTwIKykc=
X-Received: by 2002:a05:622a:181a:b0:534:3634:6959 with SMTP id d75a77b69052e-535e88321cemr14254081cf.8.1791835162762;
        Mon, 12 Oct 2026 12:59:22 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b79a186sm87032691cf.20.2026.10.12.12.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 12:59:22 -0700 (PDT)
Message-ID: <dd01d09f-15a8-49c3-a505-6afa0e7c516e@riscstar.com>
Date: Mon, 12 Oct 2026 14:59:20 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] clk: introduce TC9564 clock support
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261012152408.3729237-1-elder@riscstar.com>
 <179183220207.266355.4262660703229090399.b4-review@b4>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <179183220207.266355.4262660703229090399.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 2:10 PM, Jerome Brunet wrote:
>> This series adds support for the clock controller present within
>> the Toshiba TC9564 SoC.
>>
>> This SoC attaches to a host system via PCIe.  It includes a PCIe
>> switch with three downstream ports.  To one of these ports an
>> embedded PCIe endpoint is attached, and it implements two PCI
>> functions.  BAR 4 for both PCI functions provides access to the
>> registers that enable or disable a set of clocks.
>>
>> Both TC9564 PCI functions can provide PCI endpoint buses via
>> devicetree.  Each PCI endpoint bus provides access to one of the
>> function's BARs.  Subordinate devices (like the clock controller)
>> can then be defined as nodes accessible on the endpoint bus.
>>
>> Only one of the two PCI functions is permitted to define the clock
>> device node.
>>
>> 					-Alex
>>
>> NOTE:
>>      This series is built upon linux-next, with this patch applied:
>>        https://lore.kernel.org/lkml/20261002181849.790275-1-elder@riscstar.com/
> 
> next AND a patch on top ?? you are not making this easy and this is mostly
> to accommodate the DT change that could have been sent separately.

Yes.  I considered dropping the DT change for this reason, but
on v2 I didn't say I would do this, and thought it would be best
to not change this.

Here I'll be clear:  I will send v4, and in v4, I will *not*
include the DTS file patch at the end.
> Basing on linux-next means there are other deps and you just did not explain.
> This makes it very difficult for me to apply your series if I wanted to.

OK.

> Next time around, please send a series on the clk list with only the 2 first
> change. That way we do not have to cherry pick, we can use your cover letter
> for the merge commit, which makes it easier to provide an immutable branch
> to another subsystem, if need be.

I understand.  Thanks for your feedback.

					-Alex

> *Clearly* list you dependencies if any. Please consider using b4 to list
> the pre-requisite.
> 
> Thanks
> 


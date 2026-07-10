Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7013A1A58
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678808; cv=none; b=N9iWvw//YXpLV34O/CXTwDlu35EqBrQmCUpK0EYEhOYmuHr9PJPBmoykLCThC6uh8jumbgPpg1daeidXcVS1Flin1Uh5AvFXj1sWB4Hj8RMnR2inNJ8XZLuoMstnmXypSCZUECaCrOie6t8T3Kr5EkzD4dE+qmjse6ti7Fw0sPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678808; c=relaxed/simple;
	bh=1dzTBexqxGti69sqvBwGnRyvqeh7Lyvxce7lH4TfQ/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwzVtKxYhrEeYiNhWwyCgdOLY3DrGb1BgLRGC10CLEvCLgvpsJlLG5vQhAgAhDx9skmqCbmclycPW/1hq5UBaBnd8c398zGTEVlRyz4LqyJd+wEQUcji2HAyzyt3t6G5dGodaPd4l6IUl+FSqAp5OOUloHZxyPCJvAm8sand0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o4z+NOca; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4z+NOca"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b1710405so3650865e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783678806; x=1784283606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1wsFkUbAtuG6pFWmJltsHSUWbIpvemvXO5QB3k7ZUl4=;
        b=o4z+NOcavdngiaT3I5g2DPgoylzGVWdYWbIpFvl+jFrcGALtsOZQKb76hNqCU27/sg
         pjjnOJfKDhVYV+la3wWRpOjw2n1oYShSG8b+r48hr51Dh/OxsoOJst7Uemoap3AYuxSD
         43tQ1SjlCPIOHxwUAGMWYV+0dPxPfC6IEWAcw99UxmHfYfqD+ReIHZqCVCv+x3VCrSo9
         wUBt13JM9nmdqbajQ8k5WbUQEodAgq7GT/44OVulbY5T+vZQozETkqq5foVwR+Be8QWR
         ThWSCMTiuiJRC7b7ViU+gzktI5Et0T3RxNAeGnQDdZJx4SiD9x2PzS/D6kT5riaf6NwU
         WNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678806; x=1784283606;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wsFkUbAtuG6pFWmJltsHSUWbIpvemvXO5QB3k7ZUl4=;
        b=H5EgKj+2LU8Xp0K/zBVNIC3y3dsljS+JmfapjRtzWKc+8+on1UbOyIlmxl0kLZyVYg
         XTZfYrqnWOA4+hGd0gjlRBqD6YlHjmTZO2gHZ+E923Lu7zv52E/PeepNGT5Zr8P0NFmO
         5rXz2xdt9hycWaJkt7GN8whEoQDtSTiiPGo5TIjIbizgEMhFV1Qd6+URHaVvyaJX/Han
         5nAYuNNxc09qZpfkKtS9PcXnOyOM/LLkbRIf0QkFQANXQar+NuEY3VubHSRI0NEa4Ykt
         nJLtrpLXf4s/hDxzHkMtpBzKdWg8z08DdIzMa8Xkw/wGQ7ViL6xxAiFnW27CqbVqdQ8W
         bS9g==
X-Forwarded-Encrypted: i=1; AHgh+RoOc92nKTl8/qNsKV2a+EJEkFO55ucH7fz18b79q0VKg81OiwguFTLeuI3wG97Gi9To5zMQSk1C5INBiVYo3Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtJaJkSIQM6CAoWM+7aP/u+C1mvmYHHW7uKWKQpu9riXrvpEJ
	OcpEZTGzMHK7bGOqAIE5w6ZRSlWBIRMrvU6pTMijbGgNh3SXilvLhV73awfxS20jO0o=
X-Gm-Gg: AfdE7cnspPndd7FEaeYM3onH2oRHuLHQY/WkU0WrcAqXuGBdhrFPORBRz/qwawWJ319
	e73Y0vtsy1r0xHA+rn5nzRr8iuaf23/jjwjrJlQl+Ro0PbSezuapRMp1b7YN/Q7XY5mdX9F7PcV
	iOV6esWlne3rj9gYufNIK+i7Jdfep6w11AT3guYulxs9yedqCQzb1Zz4JJt9l9y8kf+P1fDR6Bv
	L1XGAIj/hUeYG15lI3rPKyb9EG8KLT7E/Xxyafhz35wMdFRGMHqgBqFgDFa0pqEbVy0W07gkSHW
	crfmUte2+UN4ilcT9IB9syIkt4pjQMOP3WWhGEQeKSXXvQc3YfDZUkakxnHTib/mdGNfYTDODc8
	aLMiq9Zz+KLrXCEXqJzxiUS712GS91Bjvko344oBNUqOoPyajpvPtmsWpsWXpit/sCBP9LAlUOo
	lDfSYskF3/dVx67kGb6r3WVteo
X-Received: by 2002:a05:600c:a0d:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493e684a968mr116415905e9.15.1783678805526;
        Fri, 10 Jul 2026 03:20:05 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.243.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm125534085e9.6.2026.07.10.03.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:20:05 -0700 (PDT)
Message-ID: <d5475ff0-1296-437a-89f4-1d3d6e9ac637@linaro.org>
Date: Fri, 10 Jul 2026 11:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
 <20260710-camss-isp-ope-v4-4-51207a0319d8@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260710-camss-isp-ope-v4-4-51207a0319d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/2026 10:04, Loic Poulain wrote:
> +        reg = <0x5c42400 0x200>,
> +              <0x5c42600 0x200>,
> +              <0x5c42800 0x4400>,
> +              <0x5c46c00 0x190>,
> +              <0x5c46d90 0xa00>;
> +        reg-names = "top", "qos", "pipeline",
> +                    "bus_read", "bus_write";
> +

Does this register space cover the entire OPE i.e. where are the CDM 
registers ?

We should map those upfront even if they are not included in your first 
drop, we map CDM regs in the IFE even when not used.

Also, I looks as though you're missing CDM S1 SID entries in your iommu 
definition.

---
bod

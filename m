Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0A3A7599
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272236; cv=none; b=Z752yNoQ7C9SGC9Q/eM/SpCbY4Ao7N9aSltf/cvbwMvpy72BG5cIDZ3U2RzC09nZ1QXTvsqUGlvRPa66aHPF3EyS7KIyvX4oZMyNZ99zRlPiX3PWeS/KHo7bRAz6AdAoY4S9JcFMUjt5t56QVVlSDS2vBN5kr/aqcVir1h7f6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272236; c=relaxed/simple;
	bh=2eupapEfQNeHkUYEMcdS3p7DAYeAm6TzkamnfJ7DyWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYAOUtswJwRwsvsvmzraiXoJtbZ3LEeaK9hsmGRcg2Zvy5SWzeb+UCke6Oed2QPja3paESY2npxNonV1uv848XBfxdagOaR3cQYwrnGuGWYOPHcWKqklHuXn/vfDW3eiluLNf+xC86lV/lzBGAzRoMNwAoFPE1hWZ7rrDtL2pOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ps+yJ8fB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ps+yJ8fB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso2952945e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773272234; x=1773877034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz4JhHpkfUtvuhugX98hnbwV87DiIdMI+Eh59bG8IRE=;
        b=ps+yJ8fBp1nhZE28AcPJ6JyWkKdM4ixkKfpfWFfJN7bCO30rQt9aA+BjJlTRyg2SXi
         6lkNXP0qShkkMuZlW5O1e3Xzxu2qx7iEG+twb5wIXgQFLz+vBB8nfBVArFa0IoqSEHvc
         fuzmYeM4CnD3Dt16EolAIdqiYnk56T4MGK0UpTmJZZbA3t+urUTuCA/Fpq4FDoKPCAU+
         piNBGPtdLhQ7cK9xP82tzZ8M2qBqXNVD1/KlPIkjQvsKjPDVQjeddErHce2qpBfpY+dn
         jhsO4VZ1yOOq1j51XdftPUKOZ3MEkZhdpczwa8BMVcCfeWV3gYmJCrmCWfST8nkzrAef
         BYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773272234; x=1773877034;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xz4JhHpkfUtvuhugX98hnbwV87DiIdMI+Eh59bG8IRE=;
        b=vIzMJIM9ze7hyVa+HrGTYnVs9tUWjWpiuscBjbixVCE/4GH2lXAxMtP/jA4edKmRMS
         7ptzmaisFxF2bkryF5DTdd4o+pUGODp7CI5GcFXLVY/iuiHAVo5Ww9OGclWG8b+oJdzW
         ACbG0EmL017+GNhFGLEazMFGeiD8ciqNVNXc9Nd8knjxo53lSIxdP2kCRrrJWwd3RaQm
         HCPQqZOQl+EGBrU+G8djG9XwtzRC3G6l5P5ytwD6erYqVx5pokmnpzewX3BWYLHaGZDd
         OmboKchuQoC7b3mim2XZcZn3upTdisgJK+PRuWYd6WlC/x5j8fiv8L861aWtsqjnQF48
         m6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXOkvaii75AN95bQmJo6s43LE+GEdvt4+0OyupCuwTbY7oKtkAV5j8hMKfSf+piiSec/LVuTHB6oXmrq31CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQSRZULchmqlDhuI70YYQs8f7Nc15Y+2X7D0prlU+PLEOdhkl
	1qn7re5g5WKv07b57CUZ08xxpWTKqpRwrpl9a2gjZN4KHI2bmg1F8NjClFXj6fVX4qBY0rBG7lZ
	WbasC
X-Gm-Gg: ATEYQzwUeexd31WCHaS1RbZhTrKmqMO81zOmOnnY9Fov3b0x4lU42cD9qutAqiTkdd3
	1hdeMv1EDtMk6B6mm1D3aWZooLNNoSMdJQgSYlbTQVzrilIbg1jiZrj9Eusu+fz7GeCfNIJDupL
	e3QUOtgKIT3hUqqo+IY8eSbBfIQnvlnN3JLYzE39qAMMVnACvT0bPnoUmECxeyeHmiwCsi5ANr+
	RZx7WhntQ+6pQkZc1JyEuKCiCH7X0jVp6YG4ZELYC4hBJNOzLLz/Goq91DzzLMkBsz9T+ULZt+4
	7FUxSe7A5aExr0+OdtVnCHGk1/6M9gLHPQEBDFzrVqJR7iUetVKXxhKJw2kq6AogOvwsLe9Fh/S
	Ces32vJxDcbxyAhnywmXCscTqgDyuGdzVDy0F2pwykruomhFirbwkSAoSZGCYWe/7xnaGYe20uw
	30nHxI/aaeBuxkhO4GmZoO6pF88QaipG8/Cw==
X-Received: by 2002:a05:600c:6085:b0:485:3d9f:5510 with SMTP id 5b1f17b1804b1-4854b10a1f5mr74417745e9.19.1773272233921;
        Wed, 11 Mar 2026 16:37:13 -0700 (PDT)
Received: from [192.168.0.101] ([109.77.88.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm2657859f8f.10.2026.03.11.16.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 16:37:13 -0700 (PDT)
Message-ID: <223e0295-1819-4234-90d9-7db440f25be3@linaro.org>
Date: Wed, 11 Mar 2026 23:37:11 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] usb: typec: qcom-pmic-typec: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-usb@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM TYPEC PORT MANAGER DRIVER"
 <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260311232347.18257-1-rosenp@gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260311232347.18257-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2026 23:23, Rosen Penev wrote:
> Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> 
> Add __counted_by for extra runtime analysis when requested.
> 
> Move counting assignment immediately after allocation as required by
> __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Hi Rosen.

Thanks for your patch.

I have the same feedback as Greg gave you previously on this.

Each line-item in your log should really be its own patch i.e. v3 should 
be three patches

[PATCH v3 1/3] Change kzalloc + kcalloc to just kzalloc with a flexible 
array member.

[PATCH v3 2/3] Add __counted_by for extra runtime analysis when requested.

[PATCH v3 3/3] Move counting assignment immediately after allocation as 
required by __counted_by.

Or something pretty close to that.

There are several reasons for that

1. Bisectability
    The ability to more easily bisect patches.

2. Logical separation
    If a change deserves its own line-item in a patch
    then that change almost certainly deserves its own patch.

3. Mixing stuff up in a big patch is confusing
    I look at a commit log and see lots of things going on in one go.
    I as a reviewer or say someone tracking -stable and deciding which
    patches to pull into my tree can't look at a patch a "just know" what
    it is doing.

So v3 should please

- Have a cover letter
- Contain three patches one for each logical change

Oh and reason 4 is the most important !

Patch count bragging rights !

---
bod

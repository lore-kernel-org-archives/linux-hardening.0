Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391A40BCC2
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680298; cv=none; b=YOdlPMmZPMipD87hN/gi0acY1c4/YCHjKl3HFN7hQ4nB2erB8OaHFiGC2hh42QRniu0MEFZlXEIIZ2du8B+1hR435wFRGVfucUVMEXPElpEG5El3QuQ/gXjaG0E8XgQHB2lRhnkgOQqdcRzwXkNG4Qui7jex4BAHoFZS8LHrKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680298; c=relaxed/simple;
	bh=w+wGRAZeX7QLyoy91j3GSV4L9xJhSn7RrLgxxW7Bjzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SO7eUAEHKGgL3cwhbnclqyACk/8xckerx7s3nXp2NfTsnGTTgbG419X++X/r2vxe64qfyb0RC+n2oOoy1ICvPTNonNQSKtNj4YAUA3XuFI7TBnkFkQj4cAUKEdhECCfmhAvDxEWG2f2yfDKMjVrh+orIW4Sl+uH4sLLFiKauoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lMANLxrB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMANLxrB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b27c7451so23126865e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783680295; x=1784285095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eoyDGwp3qtW9jL5dYVqhKVgocL99cZP1Cm9KAwZE1z4=;
        b=lMANLxrB4GC0Jh7Dw7JVWLNLf1xtASm3pCwtfiwdVtpvlqGoRESQa7ZNwpwDdms/zc
         Cp8oC9PKk4qFqotFDRbdbTprnvfnwxj1FnoStEbZUvi7WpGaZ57plyTF3QKS9PD7j8Fx
         yvTN+cv6mgD8cBYdnc3gjTQvN0qqRJcZ2qGksTe+8AzJ5BmtAsY0JFwzKu6W4BjSaYvQ
         B0J0FC2eJuVueJYNIHYtD6QiOa9sH74TAydrBxvz2Ifu2C0VZOnM9f/dxaWAqKYNdrvO
         4339P3JHIHpw01GcylKagcPWP6rieh+1ywt6sgykySeQSpz3gUQAjibSlfgQykUi8o0I
         EGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680295; x=1784285095;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoyDGwp3qtW9jL5dYVqhKVgocL99cZP1Cm9KAwZE1z4=;
        b=Sk1lPzS4KJpvz2xLCqqi88cqB+RGlwk7BhMk7iprUQP6iSgcsibdQkbGo4f49Gi+c5
         9a3ZIu+jxiDmDHC6xxS3shY/evNK2v1WOYnXTzcSMJUMW8wMEUEiKn9dMK/HDfanEW7q
         SsIe9Uet/Tj87Nq492trN3y5WXu+TGUgjyTLjNqSlrGxS1goZP0RxvWzjk6aTJmGwxaf
         dv539yZlAnWN8w4mQomBqgVyIf1cXBw+MIGqpmt/IwP5psy8+HW4D7D2xEKd1GlXeQms
         RXjvSVEfJxOVQ+9mtiIrQx+xgns5hrLGIs1brYvYJ2yUVGPAWAbKtpnS762aoEFckB8M
         gstw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+wDTvQNf4fPKho8iGx0P0mNakW7UleXY0BfOZLrHNQ5NZ7d67jvPmJdgAKphnh4E/VLjFJbYRRUI8yB5m+pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1EZGE7M2460Aay3qmoqBUQkOtRU2eh0UOg/PZO+wnK5875LHl
	+tAi8aDrkRcl9SmfmAku8ChxHdYrEIYV274WfREaA5VcPgb89cJ9Ut1k9HZAOUQGtK+6AOdmqe8
	hGLem
X-Gm-Gg: AfdE7clccnYQlDKLAm0Tg2OT/ihGIwIc6/BaBN8N+6j6BTIiC6d1xxl37igZAMWrJEl
	7mbOz/e9QCZAMh2pK6sK4DuikarTleAJn9uEBculBhww3uIeGTB/ois/bkXHgb2uVs+ceOu9p9V
	UqS9OKHpS/efJMbXcEVXK7KgFhpjHtD+q6tFbOolVlgqMuIsFkgDk8b3IhcYOlf4s5vVfGmIBhp
	+HLMdRKOXCgEG2OGviV96fjFFd6lrJ0TjHXS2xNa1OW/GBUAAldwVakrRGXhievIV65SQZTaXTX
	/CCw3DIjQU4mkEsgoBtWnNYdtEvH7/Il2u41pYlnhXX9YMKgzSMSlQB8HcqEQnCLrypfPS8RyI/
	yUjGWaBUiAlTXA57uRUCm7NHR4ByiQ1JSiRPwBo/1qse2nmMy4zrd6ZxEGRcIx9AbZBZCtRNgkr
	2iweVgz9Nzkcv9deXKPydtJw7t
X-Received: by 2002:a05:600c:56d3:b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493f2b37187mr16432975e9.12.1783680295345;
        Fri, 10 Jul 2026 03:44:55 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.243.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm116251275e9.9.2026.07.10.03.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:44:54 -0700 (PDT)
Message-ID: <916f8a0b-4ef5-4c2e-833a-aa8d2ef13543@linaro.org>
Date: Fri, 10 Jul 2026 11:44:53 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
 <20260710-camss-isp-ope-v4-4-51207a0319d8@oss.qualcomm.com>
 <d5475ff0-1296-437a-89f4-1d3d6e9ac637@linaro.org>
 <CAFEp6-1j=kA=3=wxWOrn_A_=Ugj-kgxRgKzN=a=3UsAef9YiTA@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEp6-1j=kA=3=wxWOrn_A_=Ugj-kgxRgKzN=a=3UsAef9YiTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2026 11:38, Loic Poulain wrote:
> On Fri, Jul 10, 2026 at 12:20 PM Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>> On 10/07/2026 10:04, Loic Poulain wrote:
>>> +        reg = <0x5c42400 0x200>,
>>> +              <0x5c42600 0x200>,
>>> +              <0x5c42800 0x4400>,
>>> +              <0x5c46c00 0x190>,
>>> +              <0x5c46d90 0xa00>;
>>> +        reg-names = "top", "qos", "pipeline",
>>> +                    "bus_read", "bus_write";
>>> +
>> Does this register space cover the entire OPE i.e. where are the CDM
>> registers ?
>>
>> We should map those upfront even if they are not included in your first
>> drop, we map CDM regs in the IFE even when not used.
> My initial thought, especially when we first moved to the CAMSS
> subnode model, was that CDM would be represented as a separate node
> and referenced from OPE through a phandle. However, CDM may not be
> generic enough to justify that level of abstraction/complexity.
> Therefore, I'll reintroduce the CDM resources here instead.
> 
> Thanks,
> Loic

There's no harm in mapping the CDM regs here.

Worst case is we have a generic CDM driver and the regs appear here 
unused as well as in a CDM node right before OPE.

Not the end of the world.

---
bod

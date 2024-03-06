Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE5D8FA
	for <linux-hardening@vger.kernel.org>; Wed,  6 Mar 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713888; cv=none; b=cwYeIjvKQfFk/nrV5KDHuTMrogJ6atntoRMdyvvQn8z14P9AKAiG0NSlsu11W125V4WPy3Mc/ewD+Ymoco9AYQZis02TbNjc+eBJZkd3899TjYQNdqQuivFd6n3k67XlSIYSZDmQAbCTdcY9FbsVDv//YuINtKwHSFeRydBMhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713888; c=relaxed/simple;
	bh=KXp1t8lcI6Rolpam/MVl5z5Wbhly/pEhcZdfFhwVXFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUo1BwOOkxrO1j0d4g4Ik0DcaPNaumWuBOan0318BVYkiW2MogiQYTn1GJeSATw92s3xl/X03YBC9KpmkzF4hFR1Om6RNxPH2ybYMiuoQlYm6NKpZwqYJOWvRTIPm/e5BN6b/pMNFXkDhmE/e1gSY158Kt7QxEAnX5gMlR8T1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+GrPBUi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+GrPBUi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56715a6aa55so3825164a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 06 Mar 2024 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713883; x=1710318683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBclJ2321GquWpSv8u+UQ+5whGNSTBzwaiCmOO6tGzk=;
        b=i+GrPBUijLYBoaF9sEtBAFdM8iNzVXlF21Eg5f4zJLa8T/uaid8p+mLsTMljW81M/5
         ORDxjlu15wfF7iTAO+Z087PenxnfWljbm9qXwZ185HnH5CyauxZq8bLnZhsXkiJ+o+kT
         iEqSboipOZqne4oKF+/3mNSgGCWulKj622/lIMgNx2BqReAssQPcPOnvw7bLos10eY6A
         AQeqWDu0aMWd4cSlF08vhpzrA1mEEkuPucMhkky+9pUdS7UUX+GXi0yAW7+EWUfCEYTx
         +uWJJE6KsTFW7A6fyaJudTH2eVQIfKcfC9QYoOIOV0okhGJFzCteyKlUkru4kV7UgPCM
         Ml/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713883; x=1710318683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBclJ2321GquWpSv8u+UQ+5whGNSTBzwaiCmOO6tGzk=;
        b=tU4Qkq5P69OagTGWopbYm5mOSm4+piqfhDqSb+zvhNCGPnyltaZP+C4EK2mOBdeQDw
         nJvS9XKTOcQs+gJLzS5vAHr0K2ORGFT/z24oApWU9v/77Clr7omPNanXq1V0tts3FzfM
         lJs1Jk5PoU4/6+mvmiIl9RYu0CVjosr4yKgGgxYhV+1oHEfGBtSS/PPlrhzHcT/2CEQI
         ho+fRxnXVfVUF6YaJx8Zud1moronv66ZU+8fJkiscaj10SCl0/AGAZR09MrmQcNX64tI
         kIbQ46gJxMvDd0RmVKPtPvKGZYJC83PIuxhycTO+lIGS4Y4957ZceaVhSHC42Fm2NkHt
         3hbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5H2qg4hnqsI1bBi0sAelcy6ab5FwW4kscsN/g6GmYzfx8x0aWlizMZep07W5HDsOXGdPE1izUZ4OwTyBoGHSE58wJzkiI9bf30SoYZzOj
X-Gm-Message-State: AOJu0YyvC9UxDjn2OydIBs/G62CNA4PZR/gnx/8GK7zHUUGGRz1bzRGk
	UXQjaOXMQjxCjljP+brlazOmtm9hgPNYUbXGNTdm4wUxggoadQAP+2oIRiQCAYg=
X-Google-Smtp-Source: AGHT+IFXLHG2d3eNsyfX8iT7sDFkCoHDODjhVy+/H/nJ7HEyeKvGvO4QwcZJ1wamHysxGcI9VMcvjQ==
X-Received: by 2002:a05:6402:5c2:b0:567:6a66:d103 with SMTP id n2-20020a05640205c200b005676a66d103mr4903117edx.0.1709713883631;
        Wed, 06 Mar 2024 00:31:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id q12-20020a056402518c00b00563ec73bbafsm6640290edd.46.2024.03.06.00.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:31:23 -0800 (PST)
Message-ID: <e7105dd7-68ff-4af6-b91e-56b6e50ff949@linaro.org>
Date: Wed, 6 Mar 2024 09:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-2-quic_okukatla@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240306073016.2163-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 08:30, Odelu Kukatla wrote:
> It adds QoS support for QNOC device and includes support for
> configuring priority, priority forward disable, urgency forwarding.
> This helps in priortizing the traffic originating from different
> interconnect masters at NoC(Network On Chip).
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 105 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++++
>  2 files changed, 137 insertions(+)

>  
> +	if (desc->config) {
> +		struct resource *res;
> +		void __iomem *base;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res) {
> +			dev_warn(dev, "Skipping QoS, failed to get resource\n");

Why is this a warning? If the MMIO is not required, your driver should
not spawn warnings.


> +			goto skip_qos_config;
> +		}
> +
> +		base = devm_ioremap(dev, res->start, resource_size(res));

Combine these two (there's a helper for that).

> +		if (IS_ERR(base)) {
> +			dev_warn(dev, "Skipping QoS, ioremap failed: %ld\n", PTR_ERR(base));
> +			goto skip_qos_config;
> +		};
> +
> +		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
> +

Drop blank line.

> +		if (IS_ERR(qp->regmap)) {
> +			dev_warn(dev, "Skipping QoS, regmap failed; %ld\n", PTR_ERR(qp->regmap));
> +			goto skip_qos_config;
> +		}
> +
> +		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> +		if (qp->num_clks < 0) {
> +			dev_warn(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);

dev_info(), because current binding sais clocks are not required and you
are not allowed to affect ABI. While ABI here does not look broken,
spawning new warnings to proper users is not welcomed.

Best regards,
Krzysztof


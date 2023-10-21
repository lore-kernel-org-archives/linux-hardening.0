Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042B12E75
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQN6STL2"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D4D5D
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 10:01:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507ac66a969so2394510e87.3
        for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697907709; x=1698512509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2ulFsbDF3czFr6zxUgsLd/xeLdorwToAtgSH1EDPHo=;
        b=xQN6STL2tI+dfJwwQX2cwGeVI4yX7icK8FAhAqR/1jBx8XIu0fBHL8j3P497udO/7Z
         t5lq3Yq1xpf/vB+Oor5f1Tb5b1ork1oNRUXmci/JZBPv+nSzpYXqnFHpOTdGkx0Cz2NT
         A0Ea7EKzMb81gY1L2T5xZEck4xfceGIJv0Rzskyw2P/7XINXZmfvbBvO5LtKvpUyB43V
         k+Jnc29PPB1yod80R5Tlk2lkTVjqeycAJQcYvcZYiqMLdnVZ299fALFqG8kUT6Y7ChA/
         8HmnM2u/MGoZjTjPf50UNOS2r2O/moq1UKWcJpZA9B6XBw1NdgqmlF8Nt9OhsdTyv0aT
         m6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697907709; x=1698512509;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2ulFsbDF3czFr6zxUgsLd/xeLdorwToAtgSH1EDPHo=;
        b=gAW4UI4YZ+EiDrnfdBsGA1U1z1CYbW3HPD+Z+tQiBel7cykKKpUn+ctnIICxaFpsiB
         LEuuDJjjoJExl7z2wTRjV9nKmc2wloCMw4nemoGfL8gYY0oFnhkoBWfWslWZbEXWHTp/
         1MtKttz2yLlcMBf52ohNlxhZO2wuD8xdXjCu/nfyWXRkt8avq9v+VVH4cmbF2dROlc1l
         zl04zutAZDpxTyqDVp4qm52S8UJ7wQK4YX5PIgFmzFG+o6WiPgMfovt7nJ+JhkLpkVXw
         AZJOTsBuI/3oZWrTG0UhrocrsccpWCdla0zTt8+pnFZuXo9Ne0rQEoTyGWaBTUJb8ue4
         uP6Q==
X-Gm-Message-State: AOJu0Yz8U6ZzDUXJWLkeRSsT85JJ8U9eDVCs1KhA1eO8DBPbYaiIAERj
	IkWpHKWi3lXNLsFPOu0M5ePSAQ==
X-Google-Smtp-Source: AGHT+IF20BNrSOl6ROiewe231qDr7P6ltG0hdQnDM4JS6nqqUb3X+a0DD92GDPOj2sPxsttcYH3oRA==
X-Received: by 2002:a19:2d5d:0:b0:507:9e6c:e165 with SMTP id t29-20020a192d5d000000b005079e6ce165mr2953294lft.50.1697907709333;
        Sat, 21 Oct 2023 10:01:49 -0700 (PDT)
Received: from [192.168.1.116] (abyl4.neoplus.adsl.tpnet.pl. [83.9.31.4])
        by smtp.gmail.com with ESMTPSA id f10-20020ac2532a000000b004ff8cd27a61sm924443lfh.213.2023.10.21.10.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:01:48 -0700 (PDT)
Message-ID: <8737f195-673f-4837-9a2a-80c3be93e6cf@linaro.org>
Date: Sat, 21 Oct 2023 19:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree Initial support for Xiaomi Pad 6 tablet, that have sm8250 soc.
Content-Language: en-US
To: luka177 <lukapanio@gmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231021164654.146002-1-lukapanio@gmail.com>
 <20231021164654.146002-2-lukapanio@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231021164654.146002-2-lukapanio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/23 18:46, luka177 wrote:
> Signed-off-by: luka177 <lukapanio@gmail.com>
> ---
[...]

> +	/*
> +	 * Remaining regulators that are not yet supported:
> +	 * OLEDB: 4925000-8100000
> +	 * ab: 4600000-6100000
> +	 * ibb: 800000-5400000
> +	 */
These are actually configured by XBL and they directly talk
to the display panel over some magic 1wire-like protocol, you
can probably drop this.

> +&tlmm {
> +	gpio-reserved-ranges = <40 4>;
Would that be the fp reader?
Any chance you can leave a comment?

Otherwise this looks very nice!

Konrad

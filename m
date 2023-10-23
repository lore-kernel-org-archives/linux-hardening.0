Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639E18025;
	Mon, 23 Oct 2023 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7flUE3m"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9EF5;
	Mon, 23 Oct 2023 04:59:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b6559cbd74so488100666b.1;
        Mon, 23 Oct 2023 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698062358; x=1698667158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnqy7dSxOjQjqscv4DWvyJMFvfwEd0TnRvRI5+ZbjWo=;
        b=m7flUE3mJRnPL2h+1TVvA1/SxuXPj/RJldsppMLplwaffwRWSGl9j75jV2r2mD6n8D
         jqT4Qap+9N+Q3IIFQkmRVGRu6TC8Bdy6UcNOO8ri9kC+hhtkAwwnACPWMX8xFcYw+u7E
         vLQvWiQuS8FZdPJgAXBtf6Ttr/KOmgHDl2f8kFHT/SrFT0mnMSKty0rCoDkj5NeC88Y9
         jhKR+778paeJPa7eqc2FIzDiHOMyKUBzqdliNUVl6mJtJbzCm5rn7RBhFFn4L1NZPdrw
         1nenTcSL8YbSswoXJ4jMIp/WphuhIQVe5N/t8c8fCY3+2yGgoLnypnRBoJqpwSgjAsiR
         hnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062358; x=1698667158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnqy7dSxOjQjqscv4DWvyJMFvfwEd0TnRvRI5+ZbjWo=;
        b=Ae6vsQtzLEWHZMnMixxytO9M+8tvW7i4ZqHkE06olrzvNWtzddw7ePkNEY2ny/+gRN
         +1HawVZmH1A87Rjllk/YLRVLiomUP5TDXJQa7rimwP2PDsvaE79cIdLdl0dVkEviCj0R
         9Y54+bRMsotQZmnkMo/AGhGbQdkPjxQwZEQMdv0gzAgvj/uEAGWhjoJc0K8/tPtt5lg8
         M3zVXC4atrGCbeTgoUtKYz1sKBWiV9K+D2GI4dask5ByRTOqGDojcEqrB4EIjGlRl4b8
         CacA2bc1IP1rQoSJi9MtVSkrCPtmLIgMv7dYZHoWiwREWQciGOODyk7Y6vZdap/S4dZg
         JIbQ==
X-Gm-Message-State: AOJu0YxnN7RwjPuc1hyQMUo1EuGfFCUboXRfLQUgfNs6cOHFp4TgTFL5
	3NZIxnJBaEQJod4yx6tph/v5OzIOjOOczmHUJZL0873hk7Mj/6Qp
X-Google-Smtp-Source: AGHT+IEn0NHJ4SfG0P+T4S3NwQqFTArELhFnDro91pfObDGaOIHYbJg5GjpcRO9l38DOWF/Ws4+OojefE8nrEYCon5s=
X-Received: by 2002:a17:907:9485:b0:9be:f71d:9471 with SMTP id
 dm5-20020a170907948500b009bef71d9471mr7774826ejc.68.1698062358169; Mon, 23
 Oct 2023 04:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023090230.43210-1-lukapanio@gmail.com> <20231023090230.43210-2-lukapanio@gmail.com>
 <26b65551-1437-4e21-947e-1628052b7c36@linaro.org>
In-Reply-To: <26b65551-1437-4e21-947e-1628052b7c36@linaro.org>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 23 Oct 2023 13:59:07 +0200
Message-ID: <CACi=Ov7MXJsEazZZbisHWUfZD4B8WxtKROjwu-EEQfRgPHSGkA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ok sorry just didn't got it right. will send a new patchset tomorrow.
Thanks,
Luka Panio

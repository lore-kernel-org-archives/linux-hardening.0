Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD272E645
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fEtKcaBi"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524C2D75
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 13:49:07 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so63475281fa.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 Nov 2023 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307345; x=1699912145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMUtXedtMfHyVhpNXb+9y7B6UprnYxiJrIY/x/1tAbY=;
        b=fEtKcaBijM5yRdeB72nVnob3ImfXVWOdIGpNtRTrqZsEirDoanhYDVaXUCUli/qLZx
         Dz5ki8EzfTMSNP5pXZlRVr+yC1bSk/ysNq1B7iHexm0fl6+6c9f4j00TuQkqOxrpXNgL
         NoaT8eWUbxoGnFDZvtqkOIESybUndGAcPWGzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307345; x=1699912145;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMUtXedtMfHyVhpNXb+9y7B6UprnYxiJrIY/x/1tAbY=;
        b=h6jwCALdI+ipkzkAavRNiCX5/7rJ/6bfa9F020tsYmWQTYusz/Ld1XDzP/N9zLsqHt
         xNFoxC6UpYYfEhEHQhJPqhWOOGPt6ye5VZEaA18I7JDXGBtZow7DG+cV3RVf84puihD0
         WsN8oiyAMjzrAseeWCr4cXB9QLgHahMCEUtAIlH82xtNzec20w20dNaLIr29PnC6+8OW
         yGT4O5rM/on7CdMEvafzqurvh/gMhC4YTkP5bLwGe2OFtRW8nNbWD8010Qw7Gyi+9rIl
         6N4G6nI5C1vBsLtaidXrlbkUXChJsULPVXR0CIxOipzzYDACwa3IHoBSyttGP2i+fDzV
         u2dQ==
X-Gm-Message-State: AOJu0YyOfjMfPs8phcgiirsqQx9Oioy7T11GTijlRIFw36ey0m56l8s0
	EdNCQjNcuK+f84ym8VvSADbwJxZAHWVYWDudnM56+w==
X-Google-Smtp-Source: AGHT+IHCr0f4oobPmpg4io2bupLLG0IzNyyolPOrELq/1yG34ld0ri2ZpgidIQCoT1Gj/+EHt+le3Xj3RzSVW9Xl5Dc=
X-Received: by 2002:a2e:978d:0:b0:2c5:2357:c6a7 with SMTP id
 y13-20020a2e978d000000b002c52357c6a7mr253471lji.17.1699307345582; Mon, 06 Nov
 2023 13:49:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:49:04 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 6 Nov 2023 13:49:04 -0800
Message-ID: <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark
 interrupt edge triggered
To: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Guenter Roeck <linux@roeck-us.net>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Andy Gross <agross@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Kees Cook <keescook@chromium.org>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	Tony Luck <tony.luck@intel.com>, cros-qcom-dts-watchers@chromium.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2023-11-03 16:34:27)
> On sc7180 when the watchdog timer fires your logs get filled with:
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   ...
>   watchdog0: pretimeout event
>
> If you're using console-ramoops to debug crashes the above gets quite
> annoying since it blows away any other log messages that might have
> been there.
>
> The issue is that the "bark" interrupt (AKA the "pretimeout"
> interrupt) remains high until the watchdog is pet. Since we've got
> things configured as "level" triggered we'll keep getting interrupted
> over and over.
>
> Let's switch to edge triggered. Now we'll get one interrupt when the
> "bark" interrupt goes off we'll get one interrupt and won't get

"We'll get one" twice?

> another one until the "bark" interrupt is cleared and asserts again.
>
> This matches how many older Qualcomm SoCs have things configured.
>
> Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark interrupt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

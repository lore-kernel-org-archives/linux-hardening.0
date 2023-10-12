Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A23CCFA
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCWALsms"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A53C0
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 13:02:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-327be5fe4beso1228298f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697140975; x=1697745775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5PX3vmU8+Vj8vt9h1WPewaDZBGFm1gw8XnL4XGRfQI=;
        b=eCWALsmsmXm8MjUUwm8cVdU70Bpf19uu6rHCH3wRGUtfto+96fPcPSFjjNgbMaIX0w
         3OB1rqQFS3oLwP33wE2o1SODrIPf0DKsVb98fr6u81mircz4xYRDnLkXrZOFNGAXmLuW
         8GIUbmSmKcaJ5sIWxWfjSTbG1x1GzB76p6Gv3LpYXgClhIFjPQFBpdt04S18m9hzc82u
         pzr9CBZRLk8YgJ1wRMqykLqVNDo2MiPVvhpQ3HmKXafRaxJOFtzqL3CvOOquhMoQ/VJW
         X8BtQJNVXeDd4PZHy60Duai68j6+osyaQq5gvX+kT1OHMw2r9vAFBUBmop2gGcxo5xhs
         U3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140975; x=1697745775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5PX3vmU8+Vj8vt9h1WPewaDZBGFm1gw8XnL4XGRfQI=;
        b=RvMf07sbMlB9bMx3kFLk7bjXtT/H8hkoeYn6/sVlKy2tD+b2x1RKhzwTKfvkfG/SJN
         rbLOGucmpci+EH1HHxMCz4cSHvkIbC9UItYkp+ixVjruMIjh8SoDh1g23v86W+TvasRm
         3VrBq2fjC3ixrg6Jl3ttH136XyHzu2qErjc0x6X+hpwOp5yAg68dHHTz3R3NkIsPwgFz
         DvydI5/FBkkOPFGl2Mp5AAepta5O1pivVivd0B2d6CxTjPAz3AFxB6+O1/IO5ZwGhmph
         NgVNWW4VbU/oykkZ9A4R/ZV/qAZLoOCyfqzet5ne4I9P2UamxWhqQkS9dhvNB5aoOrlQ
         c3Nw==
X-Gm-Message-State: AOJu0YwqpQPp+erVWV4zh036wvowIrOsexKZ9ca3yyCJZhJ2T52/oIdG
	OGlowZLEO721blfuXo7PILuNvA==
X-Google-Smtp-Source: AGHT+IG75Ik8+NEqcFu/jc7KU/R2jkk0DH5rTrxFKbzC0EcDU+NsXwc2ZWc4tkvA4ZRUOpoB8JGL2w==
X-Received: by 2002:adf:f407:0:b0:31f:eed7:2fdc with SMTP id g7-20020adff407000000b0031feed72fdcmr22612405wro.35.1697140974743;
        Thu, 12 Oct 2023 13:02:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm19008694wrw.104.2023.10.12.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: exynos: Add reserved memory for pstore on E850-96
Date: Thu, 12 Oct 2023 22:02:51 +0200
Message-Id: <169714096778.12426.2726125345142435040.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008033633.21304-1-semen.protsenko@linaro.org>
References: <20231008033633.21304-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sat, 07 Oct 2023 22:36:33 -0500, Sam Protsenko wrote:
> Reserve a 2 MiB memory region to record kmsg dumps, console, ftrace and
> userspace messages. The implemented memory split allows capturing and
> reading corresponding ring buffers:
>   * dmesg: 6 dumps, 128 KiB each
>   * console: 128 KiB
>   * ftrace: 128 KiB for each of 8 CPUs (1 MiB total)
>   * userspace messages: 128 KiB
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: Add reserved memory for pstore on E850-96
      https://git.kernel.org/krzk/linux/c/23e4a49943624dd83199989c852565a3ff760fa7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

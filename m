Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5F1391
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 12:10:03 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D62101
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 05:10:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so1115308666b.1
        for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695557400; x=1696162200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSaR+L6f1m7u+tcvmJlO+a3NVKKfrp8TzdBW1XZxETg=;
        b=ww+dhZZUS08fr6ppS8i0rXazHxAoLi+tbci6CwNC3i7kZs8moZFLbqyP2Cfl+InwxC
         ANua2ibNEeFrKdqLgmJX+5OOF5mCRNDkhPzQywLbC6vUCfwUra1otlp2/Tww6K866KU8
         tZfB6pOc9PSil52EUeVvY6kLOknnMNPbMoP7eGOWA3tBLZFJqns+EZjQnHfm2g7znGw0
         egzwM+zo4jqNegTamqHZtRhgGNWRbGw/3ZDdPbKuUatbHrkEBo14ykzKqlO3EPt5LRyJ
         zME7n1LEHdfhdnLyQ9TAVr7PNvsVJKiNJz8gXxsPKhrEDHTgyKLgDe382bQvD3DEM4YG
         P3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695557400; x=1696162200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSaR+L6f1m7u+tcvmJlO+a3NVKKfrp8TzdBW1XZxETg=;
        b=GSgSeSHg1ZxJ9PQI+xKOJ/I/lAcL16+LdTRTpo9L1V4AwsZLOpHLy/Rtd2Gt4xpyRT
         /yA0SfFx2oPdDCb3Rp699Nu4VUvLG+bP3iIJYTLGclzKvQJlhWi0EVXY5P9ARnEdMIfY
         kozqCl7wMSae6A0BqK7dsPOfItYnrd5oYvsSgkT0+cEQ0f2pTllIqycI+44ZNrFopNfM
         OMcc83EelTu0sPoQjm9M4kBQepIlToDwigy4mIQse2cJGieyyWOisfZQ7w2nz4WknOkS
         dAvx9nnJ2SP8de3/oYIVht2yFh2VVYVX+EkwP3imvjvms3tiAImVLixv2LYy+jrkvcsf
         ShWQ==
X-Gm-Message-State: AOJu0YyWkKDVlDEhcVQjVhkd6uJI0d9Xj9Zsno1qkr/R/YS23kKXPRnz
	SmowUfYmrQIWxvKC7GFup7u/FA==
X-Google-Smtp-Source: AGHT+IESYrCzZQvTB73XFlkulKwL+gvntMR0RunpUbasR1i4r6vxyq92UsW0nCePWlX+r7XuUyXHwA==
X-Received: by 2002:a17:907:6e8a:b0:9ae:3768:f0ce with SMTP id sh10-20020a1709076e8a00b009ae3768f0cemr11340922ejc.0.1695557400559;
        Sun, 24 Sep 2023 05:10:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id fy20-20020a170906b7d400b0099bccb03eadsm4908664ejb.205.2023.09.24.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 05:09:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memory: atmel-ebi: Annotate struct atmel_ebi_dev with __counted_by
Date: Sun, 24 Sep 2023 14:09:56 +0200
Message-Id: <169555739436.7093.14241184537444848139.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175215.work.122-kees@kernel.org>
References: <20230922175215.work.122-kees@kernel.org>
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


On Fri, 22 Sep 2023 10:52:15 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct atmel_ebi_dev.
> 
> [...]

Applied, thanks!

[1/1] memory: atmel-ebi: Annotate struct atmel_ebi_dev with __counted_by
      https://git.kernel.org/krzk/linux-mem-ctrl/c/c1f2c81631df7654c249a457b7a54bbc36042248

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

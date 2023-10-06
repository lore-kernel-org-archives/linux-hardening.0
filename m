Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563D4446E
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKyhi+TD"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B23C2
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:31:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2255737b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624306; x=1697229106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX47GVueSgt+x88lXgjrOuEvVhXaBMxhauYyZI06tqQ=;
        b=mKyhi+TDoCaD4LcnhoWxxHl1Jiw7/0pvkXAJ2TOSxuev9IUPxKVkBm7ShuaSFXj9+q
         1TV95Hp26kG/i5Cz2WkSz4K4G+xpKva61PAWh2gSZZZnGG7HqBWL4qc1nXBV88eTrr+2
         H4YJZI8tPsFGC9um9hJBvj6CjMaJs3bhvvpzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624306; x=1697229106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX47GVueSgt+x88lXgjrOuEvVhXaBMxhauYyZI06tqQ=;
        b=VpqGBq7RAk/XpRyloOfq8/NmMGEaLM3d++lp7A6qFdUH/QmTUFN91CJzUJcIA8UCeU
         5PUxLDEZW4A0yIDujxastAc3Csl/OwLQ24w/L697w1it/OkNQRHP+dQj6uHHktH156wt
         KPjF64aFsb+7PaLwFwiq/36HRWNjzoINeUgkFsAHDtwPK24miytCTArrZ8MR2RqXNbmF
         pseWSPoMeDxPmNvqxxKSSCZwbewwMFT37bJkPcOb26Qk4SmQtj0pmB99TFVm+p1N5Rtr
         nuAFlU5IQ/zJD/xyWvOGWa6hIrB7ClPMGBAqS3yt+UQ5gm+Ec142yFK1Dls4TL4B9pMV
         LjEA==
X-Gm-Message-State: AOJu0YzCz4XArL19ox8BZWheSlqGzrs70Du9aDc/3EM1OStyeX3B17ut
	AvZOQ0QYKUOCQJWl/6/qmtxHzudtFM34p3Nqv7E=
X-Google-Smtp-Source: AGHT+IEDB4JiE6QwcjTIlFZlq6WWddYaDMaPi1FSwSZbG+KVJWywvAicRGeUH+/1a8vmGHDJmVIHMA==
X-Received: by 2002:a05:6a20:394d:b0:153:5366:dec1 with SMTP id r13-20020a056a20394d00b001535366dec1mr10718663pzg.15.1696624306130;
        Fri, 06 Oct 2023 13:31:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78112000000b006933e71956dsm1903839pfi.9.2023.10.06.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:31:45 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tim Harvey <tharvey@gateworks.com>,
	Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
Date: Fri,  6 Oct 2023 13:31:32 -0700
Message-Id: <169662429066.2155323.3293633131737633450.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175053.work.564-kees@kernel.org>
References: <20230922175053.work.564-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sep 2023 10:50:53 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct gsc_hwmon_platform_data.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
      https://git.kernel.org/kees/c/e909028ba701

Take care,

-- 
Kees Cook


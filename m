Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44F38FA6
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5aHyoiF"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA6D8
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:41:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c60f1a2652so20577755ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624882; x=1697229682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZOYPkPA5oLY2q95iWRFQ2sCIQPxY7UDWuU5p2gRkM4=;
        b=J5aHyoiFeopY2mIT8gKrHYsUrWY0GepMvy70TAds0ELpAGVBoRQMNwYYbea7SHyvnh
         bZ7bzmZFG1Oble4+NbjEK29zF7fd6CdQEMU3Dn+cBEHswSfPDxFtv5iIveG/YaBn0tlx
         AXFO9kPGvDV3/Jdmcg38VNFcQZd9Lfx9+kUTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624882; x=1697229682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZOYPkPA5oLY2q95iWRFQ2sCIQPxY7UDWuU5p2gRkM4=;
        b=LiNhWocUlwIsuaoErSAA1zdghyIfsQ8eU0+aadypitHbFBC5oTFVl2vmA8p3J5uePR
         DQ6TKhHAZ4VOpifnevhBkN1AvHzMnulwctyxSBOeRt7ZklIoFKRZ0c1yBhSTxikhXnF2
         /V5nv3SzpbbcRj3IlOZ1pxjgJTQe3d6oeaQfVc5Fw+7EJrkId7DKllbDR62JYCXIpVZc
         Fsn+K7+9zbHvFT9o2Egaq7EerRGnxVjVo25T/tvqhmr5H2QwlPJjfGEH3+wseZB4/Np7
         PwKsXcLaz//+c/tnAqtSl3hPngYH7v/AHOWM+ujM/BqCzB1YmmD8h48Sp39poKCGZ3+/
         DZSQ==
X-Gm-Message-State: AOJu0YxyIOLjvcWFUNtiKviM7uNTPSrHeq1BdFTL4RTL/j41yaOg9Pki
	K+oZSY1sI8KQyMjHj7qgc/EHrQ==
X-Google-Smtp-Source: AGHT+IEWqt2kL6vpwyP4uo7HmC8l8zOT4kXDp6UjWXjtm8QKJU+xVORM9uyR9196a9oaKsrfAArylQ==
X-Received: by 2002:a17:902:e884:b0:1c7:36ff:1feb with SMTP id w4-20020a170902e88400b001c736ff1febmr8572849plg.17.1696624881958;
        Fri, 06 Oct 2023 13:41:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001b9d7c8f44dsm4371587plb.182.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] irqchip/imx-intmux: Annotate struct intmux_data with __counted_by
Date: Fri,  6 Oct 2023 13:41:10 -0700
Message-Id: <169662486912.2156024.14062339724876062907.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175131.work.718-kees@kernel.org>
References: <20230922175131.work.718-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:51:32 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct intmux_data.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] irqchip/imx-intmux: Annotate struct intmux_data with __counted_by
      https://git.kernel.org/kees/c/839c5ee04f30

Take care,

-- 
Kees Cook


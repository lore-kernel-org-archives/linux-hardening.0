Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFD66666
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:20 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6461B9
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c723f1c80fso43512735ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015278; x=1696620078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilE7Vn1v/6L1xjJiSnZJWIX4iPYebLM1xUgfMUUBIXI=;
        b=l1xKYYCO0814xfitFFg3tTO2AT9+9UZgRImRulirJNri6/R8G48vt7MVrsxzwN/yb9
         yZcK5RIeg2Dnra8ZA5VYQ6jsSEfwkHjIdSx/M3JiS3KW6skKsLi+OoDS799kphCDvFul
         f55bYSu/I95TCgrsNLDFkV1d4tO7/oQKR06NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015278; x=1696620078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilE7Vn1v/6L1xjJiSnZJWIX4iPYebLM1xUgfMUUBIXI=;
        b=jwqR3IRUxKv/jM402ur+u88Gv/ghyDTmL+r9sCxqKFM9PDLVlAXevvELTvEcq/3Qxb
         WEzMmu7aSr0oawgjujkGHM9vmBy4G7xr4TagvpmPktfXoar6hLg+sB/jIlbhPQeET5ZD
         GFF4d7kv57PaaVmg1G2M/IwSISq/qLdgPcxaBuiQIefJNweRybdis5GoIpFNzl8m2U5j
         GDpMFCa4881sRRgTIqPPRRiGlzXnGxHqcyakP01IFQtqQhi4HmFeqrilL9ome0fs2RWO
         vvZrGh9QNPBzL5wRR6FQIUrERX9Q09RQ07eHYQIi9iM2U9VYpPu+oyDFaVYpyLxVs0Mt
         511A==
X-Gm-Message-State: AOJu0YyfRlFxeOL3+VwPwT0RAST/dHlPKsPeR4QHMVzynWfd5q67iloL
	ifE6eGc5n+2wT/dRLNNGGb0h7w==
X-Google-Smtp-Source: AGHT+IF0tQMM6MXJc6XxNKRi0sTdKpt1DN5cZbXrTlB5Mp1e+iC1EFDxKCNZm0dE3mY+fujU5z55eQ==
X-Received: by 2002:a17:902:e549:b0:1c3:d07f:39f7 with SMTP id n9-20020a170902e54900b001c3d07f39f7mr5943508plf.62.1696015278370;
        Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c5f62a639asm13455348plg.196.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: John Keeping <john@keeping.me.uk>,
	Peter Chen <peter.chen@nxp.com>,
	Hulk Robot <hulkci@huawei.com>,
	Allen Pais <allen.lkml@gmail.com>,
	Will McVicker <willmcvicker@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	linux-usb@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Annotate struct f_midi with __counted_by
Date: Fri, 29 Sep 2023 12:21:12 -0700
Message-Id: <169601526970.3013632.470911371867487341.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195938.never.611-kees@kernel.org>
References: <20230915195938.never.611-kees@kernel.org>
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

On Fri, 15 Sep 2023 12:59:39 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct f_midi.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: gadget: f_midi: Annotate struct f_midi with __counted_by
      https://git.kernel.org/kees/c/cfe2af2d553f

Take care,

-- 
Kees Cook


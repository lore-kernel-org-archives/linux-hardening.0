Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94738F87
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dpj0eQxX"
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50DCF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:41:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690ba63891dso2167953b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624881; x=1697229681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtVwJz3VmrSTmUGmidLH6zVmajGrZnWdZ9J4CH5SXmA=;
        b=Dpj0eQxXcfywc4+TM4p5SvmgEPNJqjKLk9gCraFCx+Hx/U//Q3PvFF7eaLigNL8Gpi
         lMR1LdLGafh28bLCI+TOPG4R9JYJDLNcBCnqcEiXVqzqvSqsb6Bps5iy089Q+5agtsKV
         gYcyvEp1asaxDTobeEYrGesnzBE9HioUEaItE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624881; x=1697229681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtVwJz3VmrSTmUGmidLH6zVmajGrZnWdZ9J4CH5SXmA=;
        b=L54zEuNdu1kQngORVPubK/JIeXLTIM+Q1jyHLTs6EImOZ4V9PcoomG5L3rEtc6/eAl
         EvuA1MhA/Bx6GFjgRd2O2KhPsFlO5oLlVGtWtcTarK9aginQCK24UQp5YqgfoLyW5DBM
         XWSEWbS+iBn25BCNtIY0bj8MFa8EMwExBcMSmJPN4SQI/ynScNYCgeIrQhvut5Mj6puV
         TGU9buzdrl3a6SbpX5e/eIlLam0WkraSL8XSE/I98rsOdgHBs+jdBpF+vZFo1nCIK5Kk
         xm50hu+zNTPE0wsFyqcc+A1ECNGHT13PmpuDSXlC6DTvO0oN3Ls10SQPWDEUOHt/kHsu
         MKBg==
X-Gm-Message-State: AOJu0YycfdMamH7lovfZ18UJz3B7Soq03kMMkimd0TFrLubLzeTqVySE
	j4EKLJkg4s0PQm7l08oQpDKlMg==
X-Google-Smtp-Source: AGHT+IG2dW/zusfUQ2rC4ErBYYeHN5DHDo9LKlcGpi35mNLb8jz1YPoleHgLhOqVUS1wHJDIJupwlQ==
X-Received: by 2002:a05:6a21:3397:b0:15d:c86d:27a6 with SMTP id yy23-20020a056a21339700b0015dc86d27a6mr10172087pzb.55.1696624881579;
        Fri, 06 Oct 2023 13:41:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0068a0b5df6b2sm1920327pfu.196.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Fei Li <fei1.li@intel.com>,
	Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
Date: Fri,  6 Oct 2023 13:41:13 -0700
Message-Id: <169662486907.2156024.1367197877614723586.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175102.work.020-kees@kernel.org>
References: <20230922175102.work.020-kees@kernel.org>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sep 2023 10:51:02 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct vm_memory_region_batch.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
      https://git.kernel.org/kees/c/1a38cf8d8ae7

Take care,

-- 
Kees Cook


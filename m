Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA141D692
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIwa1Q7X"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BFF10D5
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so4075507b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182345; x=1698787145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z44BPeMtE2kACzCzizrt3sSV/gaHEispvl8DNfLTFYw=;
        b=TIwa1Q7X3jjYVUJNeubx/TLG21qBuyU/zU+FucIySGmdWBABnr2q3jmvATXm6Rb+XN
         kK40MgjdpuwcNx4ZEKuz5OtQklHK2GOydJfpef+F7f9b/C6PGlZLAIzYa17Ye4j7pLF/
         qpefgOmGI71QvMciI2kOOCOJN+IcChKulKSGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182345; x=1698787145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z44BPeMtE2kACzCzizrt3sSV/gaHEispvl8DNfLTFYw=;
        b=dkj3MV4hUgmjk21eXZrchjLwCw0OL0A9PCT7YBl9+GyCWks5IFstLz8HSMrrE5Knwh
         ESEKqoUajuRjwaKzBwFWxocFKNqnnf02ksfdF8yEmfg46tO6jlKZCMmc0LTtnAQX1FQN
         8pszoJCw5S1rRywCc9D3/Dbrye6fX2qtEEcmDakpg2DArxUHyhJDUtmL8HJVJRM0ct2c
         E2gGQ9313AqTy6ANslhJeiSUuSw7I7t+YB8nUrUsxVG71qD2r5DYcH1/W26nBKMfXXZ9
         EWS1DAtOFnQWKpUbARmPyoc69kTSvxLmumNNThZCWJRxKXOB6PGJ6mavCG2uq7mEgz7P
         Y50Q==
X-Gm-Message-State: AOJu0Yzf6v5tPTwYiZCorV1KkhzXlkWphNGMeIdBzDBeAbzFPfZx3Yqs
	OJGBcS/0USwuc765btDIB89tyg==
X-Google-Smtp-Source: AGHT+IExcAVhyp7VZm2kE7JqtYW/LVhoC5XB1bnP/53gqyGSRDMgUiZJp81JNdO0o7sPap5EOURDnA==
X-Received: by 2002:a05:6a00:1595:b0:6be:22db:7a13 with SMTP id u21-20020a056a00159500b006be22db7a13mr11429436pfk.25.1698182345417;
        Tue, 24 Oct 2023 14:19:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79a4c000000b006bf536bcd23sm6081290pfj.161.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
Date: Tue, 24 Oct 2023 14:18:52 -0700
Message-Id: <169818232969.2100071.1483595444634836042.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
References: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2023 07:06:03 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `lc` is already zero-allocated:
> |       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
> ... as such, any future NUL-padding is superfluous.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm log userspace: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f8cff5441800

Take care,

-- 
Kees Cook


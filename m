Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C2849C
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:34:38 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066B1AE
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso12572006b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012476; x=1696617276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB0rJAp0zg9JOPur8i8NsK/kuHM5BlZt26jybAyks+8=;
        b=R4Bm1s2YMDNb8i6t9eeaPRJ8BU9BL2z2660ZgaUZiopxwwI0MT9l3WjfOptgGYvo3v
         3Q44/h6kKhWuA2IR/y3BGr9qnItKzdWQVJqN0PrzT11nATFlhA1IIvCY2jbMoBB5Xr2K
         a5V3YSY5fAH0gimUYPyhggy5XLF2VB7hhxGmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012476; x=1696617276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB0rJAp0zg9JOPur8i8NsK/kuHM5BlZt26jybAyks+8=;
        b=pl7AlJwUEWEthibuh6lPvCl2j/J1uptOf7GY1q0pl2q+spetbvH3U5dNbeRpKWYjWM
         8wcNw9uiDIJrDaEvDuAt3VqV9Eg9v9dWLDUgsywc9H89jP6qw2RlNhDaXSMyjlc+UjRq
         u4tmfEbJcLVc5nJPhkyNB104TIZLScTWyyHjm3H8c8aZMQKjj4udwlZTmnJNaAiQzvlF
         FgDWJJVSaxyYLj4xWdHgUm87OWBYZgzPSOFiURndHkprS8bvUK5AEaD00EJ67Otm1+Li
         kys/gNDRBuqZWBirGYB3Yo7PdnMY5Cyj9u+QfSKzPnV1RbfoUt3ANj4tyOrT44IR/1GA
         bsoQ==
X-Gm-Message-State: AOJu0YwTTgMiLbCnivaGQalddFU8g+Z7XEMD0H06YXlvcnoIMKIaXIwN
	Nd520R7IQGECYjkbHb8rr63s2Q==
X-Google-Smtp-Source: AGHT+IF2Huj+7CtO7jU1UHaoN/b3RP+BS7arEzCw35sdCLa1Kq6KkDAUvYLxeedGWg9tisSKDFxpYQ==
X-Received: by 2002:a05:6a21:3d88:b0:15d:f3ae:665b with SMTP id bj8-20020a056a213d8800b0015df3ae665bmr4493650pzc.28.1696012476128;
        Fri, 29 Sep 2023 11:34:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm4082161pfm.26.2023.09.29.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:34:35 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:33:46 -0700
Message-Id: <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
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

On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and we should prefer more robust string apis.
> 
> In this case, `message.str` is not expected to be NUL-terminated as it
> is simply a buffer of characters residing in a union which allows for
> named fields representing 8 bytes each. There is only one caller of
> `tdx_panic()` and they use a 59-length string for `msg`:
> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> 
> [...]

This appears to be trivially correct, so I can take it via my tree.

Applied to for-next/hardening, thanks!

[1/1] x86/tdx: refactor deprecated strncpy
      https://git.kernel.org/kees/c/e32c46753312

Take care,

-- 
Kees Cook


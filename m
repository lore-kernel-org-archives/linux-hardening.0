Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F476667A
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:18 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89041B4
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-69335ddbe16so4031925b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015276; x=1696620076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dtIBcP4y5aTwl3+nqmFPHxKsnqtE7UwX9ZEYMXGnyg=;
        b=iCnj6Vw7WL71EUzMEItrpm/Hyk7iWtcjY1skHdG8cuNAIFsfRNO/jzmOn1DPokRn/s
         GZPELQnLkJOXwEgA+o+m6d7aVDkxULEs0L2SsThLnndtIsECz3yeD+AcIlzh8M5mQLdw
         MAaKOze8xVMIvBJzyVzHKKfMTO/m36bo+0W/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015276; x=1696620076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dtIBcP4y5aTwl3+nqmFPHxKsnqtE7UwX9ZEYMXGnyg=;
        b=vTYJsAhlfgCsPuGCXOA3od5XqJCwITb6S+wxRiNFCtoxfEx0GhVdtOhqwRIiDxBATG
         28sgjJefbYu2EecnXvvJuJfDRW+REmTdim0f13Mo4fnAa2xiD3Y1XrEucU17kT5Khb3J
         2KsKhwB+CsQcnNGjrtUtIQ7YQhdLqz3dGVHP/+tv5lz9dDbyTAcGvFyT/pelJoQ2Bal7
         /ncFEfJwqzf6dOEEmqs8jcxUPIxFSzkXQF415QqZge3krRcD0dM6vZvLf7AR7AlgAel3
         KITFi1PP8nzckhizvnAe83CfwVQJuqC6ZPTlWf58sNjAUb+iYHeZ9nsUYCHmdlE8TTH8
         bYKw==
X-Gm-Message-State: AOJu0YzjNJf4ArvKNhsW7lpP9+0TXHIEYDFleYT1kFQ28sqBHOoVy7bo
	pEP1nM7Hl1f87Ve6hjBE4SiLeQ==
X-Google-Smtp-Source: AGHT+IGUGV/4POMYK1/va54VqFpcD4baV6lyhqjawMMWWCnzsphh24Cw/Lf7ot61TO/bBKwMRN8+vg==
X-Received: by 2002:a05:6a20:3247:b0:154:c959:f157 with SMTP id hm7-20020a056a20324700b00154c959f157mr4646963pzc.30.1696015276309;
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b006862b2a6b0dsm15959308pfo.15.2023.09.29.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:13 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alasdair Kergon <agk@redhat.com>,
	Kees Cook <keescook@chromium.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm crypt: Annotate struct crypt_config with __counted_by
Date: Fri, 29 Sep 2023 12:21:06 -0700
Message-Id: <169601526974.3013632.10898812764774808611.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200344.never.272-kees@kernel.org>
References: <20230915200344.never.272-kees@kernel.org>
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

On Fri, 15 Sep 2023 13:03:45 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crypt_config.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm crypt: Annotate struct crypt_config with __counted_by
      https://git.kernel.org/kees/c/6797f1750c3c

Take care,

-- 
Kees Cook


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591566666
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:18 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD91B7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690ba63891dso11500303b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015276; x=1696620076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+JwqsH6QF4VOv5yHrt+J+oPhRZNhTjhOsyT6TXu7Bw=;
        b=WaAoonNxsrI2yVuXxCezdMWu3ADhaCQk5vmUC3A4VizJKmgpI//ZzPfEn2lnpwAael
         XxDXjO2XxcWu5ZmOUfdomJpvpcAR/3GdfTbyQMYDXcZcWiud/4lgxOTgm/S3EuKLNjQw
         JLVw3cWfhao6ve1GDSV2TrmXOi6JHeB7Zn6Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015276; x=1696620076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+JwqsH6QF4VOv5yHrt+J+oPhRZNhTjhOsyT6TXu7Bw=;
        b=iYSsUjlndwvJ67NDZNpZyhpqQl6b3MLymFreEilGHLAZsKErymvSt4OewP43tTW45r
         qvWFYskgK6qBdL8TKdlmd9kvEz2UxJSkJFvwBcrRCtxYE+SB9xAUWkePgn03Xw3YVWD3
         k2CJ/TdQW6P1JaPerrR2EQEHF4Dqd+G5szZ5ZsswB3VZmgIzDaT2se9schI7B8hB5PgM
         kq/+LUD9SZefZrILxq8oiPgLwzKAFF1KaRpRXx5WAylNhRN7+6QjB4K7qPdsW+3aN64C
         JHqNnbgLERcVWeTeLANJzd/TXbCBqkVqDyR66ggpXew68mqMjZ4Grx8kOJ3HgUbtnK7P
         DweA==
X-Gm-Message-State: AOJu0YxinLZ/RKj3QZ8RoLRbRDW5TlebdqaOdhOEGMySLxCzi4ZMWhcw
	mhu9FVjzIRHKTB6fFXZP/UtJ8w==
X-Google-Smtp-Source: AGHT+IEgcLkzDCaWGmIBtqvOf11K/aas1RfwhznJoxkvK95mk2Nx5WuE98B3wrHbauF8RteAbPkdwA==
X-Received: by 2002:a05:6a20:8f02:b0:140:730b:4b3f with SMTP id b2-20020a056a208f0200b00140730b4b3fmr6546747pzk.1.1696015276710;
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm15729140pfe.170.2023.09.29.12.21.13
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
Subject: Re: [PATCH] dm: Annotate struct dm_stat with __counted_by
Date: Fri, 29 Sep 2023 12:21:04 -0700
Message-Id: <169601526975.3013632.10720424703998827212.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200400.never.585-kees@kernel.org>
References: <20230915200400.never.585-kees@kernel.org>
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

On Fri, 15 Sep 2023 13:04:01 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dm_stat.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm: Annotate struct dm_stat with __counted_by
      https://git.kernel.org/kees/c/e9d842d479ac

Take care,

-- 
Kees Cook


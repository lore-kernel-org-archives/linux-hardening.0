Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3F6669B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:17 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B71B1
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c752caeaa6so1062475ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015274; x=1696620074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW49HjAeDdFUYVHrqpmiXGwUFKL5qDwVnlMaVHIvZgA=;
        b=PQ/JEMGu7yBKYPcG9YMhg9ngoSZA041koKkrFDm1XLQJ6P2s+caMnFE7X3oSyaZVBc
         1Le8y3pnkwGsQ7j31+6CHl9nlAR1gb1oG51BBZdyqNKSmBA5AxiOhtHy2k25Ccj1MID+
         QQMYlv6hKXSJfWzaH8h6IE2RXVDpFBAHJenuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015274; x=1696620074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW49HjAeDdFUYVHrqpmiXGwUFKL5qDwVnlMaVHIvZgA=;
        b=hsJD3eXg6ZQJZY1dWgRVCr1NbH/fJGF0jYsPDJknaqqQcoK3rtI17kmVWzEFzvM8Py
         zqFwtd7atS6WLTLbYxutXozchIEuD/kkdpjmUfHePnZ4L6x5NlgmgXyo1qcjjSdtq9DG
         jokEtWNSkpMRQnPGxXB0mbe2/rbJVAQWBApcDQjgDzLTfL6fvRLkQ3qpBVCZJqGwGstb
         nkdgQY0r1wtlCZbTkmFnIbKjmYUFELIcP58ONqYR1fqBr6oHUmbe7Iv8F7Hp0+mF2++D
         BKvbs2sIVaoJW8PZIGbwreNVSCylArdSNKku5AZpbYWnbuHOMK9DrkMlR8FBZm0gyqpl
         Lv2w==
X-Gm-Message-State: AOJu0Yy3fNEN/aMaaeaGOyP2mw+ei4rUv/b87AXdox/lz5st9dJk7R1i
	YPVPh8Q+ZnsmSGlpcaTBhBHGig==
X-Google-Smtp-Source: AGHT+IFqgSzjVU11V7YtNG7pPQTxvIcXDaDxaRn0PMHt1RkZSRJN+29nXd8ze3Jn9LTDaBVCzPc1CQ==
X-Received: by 2002:a17:903:22c7:b0:1c4:5e9e:7865 with SMTP id y7-20020a17090322c700b001c45e9e7865mr5825424plg.0.1696015274656;
        Fri, 29 Sep 2023 12:21:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001c61acd5bd2sm10606776plr.112.2023.09.29.12.21.13
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
Subject: Re: [PATCH] dm: Annotate struct stripe_c with __counted_by
Date: Fri, 29 Sep 2023 12:21:05 -0700
Message-Id: <169601526975.3013632.9191876969851693974.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200352.never.118-kees@kernel.org>
References: <20230915200352.never.118-kees@kernel.org>
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

On Fri, 15 Sep 2023 13:03:53 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct stripe_c.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm: Annotate struct stripe_c with __counted_by
      https://git.kernel.org/kees/c/052b7cba53b4

Take care,

-- 
Kees Cook


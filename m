Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A491D692
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGvj21ZX"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615910CF
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca816f868fso32611565ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182350; x=1698787150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnI8XGGBa5Ged2dlOjjAPxHj4mUm8WGd6bk+tJs2a3o=;
        b=hGvj21ZX5i24BDdFA6wdJ+Sf552YeLV5EGHpryoOLIBxt8rAGWQGd60subTVaCtUiJ
         RnT98PQPbfhxkFudULTtEugqlSzZuXt9qqa3DyWSz0j50s4YX73PE4NfmAeg8uO+SC88
         JqkUwSaPuYMhF5aPc2a5SJohc+Lnwgo7O7CfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182350; x=1698787150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnI8XGGBa5Ged2dlOjjAPxHj4mUm8WGd6bk+tJs2a3o=;
        b=bU9IPe0Ay5TUMBe4gKm5DmO3dSMjIDjBUhutfYh5DiU/sWN0rIqpyv4eVPQIX/hn7B
         bkZL4R080A6A5PxQNsFtdyqccUd0ZiNEbnoQRBS28xGtxxsNNe/w+q1WMCeDa4YhfT4E
         PbZqT4tsMej4nYcqTUHUYuS1MJmTXepOgSd6GWlBOA/fWmlrTLBE2Q7c5A1H39CloBkj
         DB+DVu8NP8yC/voi9Ij4ctZ2qcoocAHUzDXJjw45vA3xyH69XAd35Nzzbyet6wnmVjQu
         K7kVhKVolgkAFi+Ggn/cBtp+JZm5nn3QXJzFEA1Hl4n83PKzEtNwSrNQ10XikADYRl6o
         PIoA==
X-Gm-Message-State: AOJu0YwLK7OA+7Y7aCw1cpkZGNNXWgzaeUwJkUVyXSazRkPoLHahaQfG
	RB4PGBR2uAt1eNUenOD3thT+Bw==
X-Google-Smtp-Source: AGHT+IFLiNPphz9TGJutCgbcHvP4j//UbtA+4B8E1BmP+ZRyb2spD6/OWsEDhqeuX4bWNmF8o1WI2A==
X-Received: by 2002:a17:902:e747:b0:1c9:bca1:d70b with SMTP id p7-20020a170902e74700b001c9bca1d70bmr14578120plf.39.1698182349784;
        Tue, 24 Oct 2023 14:19:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bdb85291casm7807107plg.208.2023.10.24.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] reset: Annotate struct reset_control_array with __counted_by
Date: Tue, 24 Oct 2023 14:18:55 -0700
Message-Id: <169818232966.2100071.9153679108451026314.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175229.work.838-kees@kernel.org>
References: <20230922175229.work.838-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Sep 2023 10:52:29 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct reset_control_array.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] reset: Annotate struct reset_control_array with __counted_by
      https://git.kernel.org/kees/c/fed2ef7abaeb

Take care,

-- 
Kees Cook


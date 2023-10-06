Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707F44460
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gD3kK/oS"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E133BE
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:26:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bd8f89baso2107640b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624017; x=1697228817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=gD3kK/oSz9HpK1bX6ilsgqMakimaq8cgsY52n1LikFP8Titet9S97kTAwIIa6d7y4F
         1RJWF9rdgeOWQCoB/ft170/3JQTKpCxY8FKvdmNzTXAbASZPDsG2tjd7EtEk2XqpVNZH
         Wix9Eo44RUWCVF5p0lzNn79tIabC7ZQGPe5uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624017; x=1697228817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ik+8xyOrxrDENzMU2+XdXOoH+BEnHgLDW/RYA7oHq4=;
        b=uVrXQb21lV7/BDfRltS3P0mbnXnpG7y1Zz/u7M3HMfdIArexk8J3inR0w3+iYxqGzz
         VA5Zdi7kZtmKwD8e5gN964jIumKHd14JuNBJxz7q7au/Vx5D89fCuQt9fi4kd3NdxILJ
         tbEjS7YLKnPyJ88zPC363Bpo9MlI6ZXih51xwah9QtHcfM9KRlil1AoHCfGBH/2bJUPA
         7wwzDVz/BoJeN+/wJ/LbWCM48wuTo7IF2//5cgIalwCu4Ja7HThrZHrSEoyiNj45HmEa
         gzJua9izYwwQunDU/zocqrOygTAy3r+JCx+FzDjuf9VLGM8bl7S3PWf5teX7V1/McGPE
         XAPg==
X-Gm-Message-State: AOJu0YzBpdyXP80rcFCUru0fuNj/nybaNjsRG0mYbCg2VU0JlLP98W4m
	TupRBm926Oy7HZ0pY+lsC5jSeQ==
X-Google-Smtp-Source: AGHT+IG2uZ4oQ6pqs/gPUxE9hmNLIVY3TcFTdzCBj+5FryP0YVUJaPRylWXG7huLOl6hdWH/tBpVog==
X-Received: by 2002:a05:6a20:3942:b0:14b:8023:33c8 with SMTP id r2-20020a056a20394200b0014b802333c8mr10453505pzg.2.1696624016776;
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78c08000000b0069102ae6d93sm1952733pfd.14.2023.10.06.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:26:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>
Cc: sparclinux@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: Annotate struct cpuinfo_tree with __counted_by
Date: Fri,  6 Oct 2023 13:25:46 -0700
Message-Id: <169662394357.2154428.12028362294967452741.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175159.work.357-kees@kernel.org>
References: <20230922175159.work.357-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:52:00 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cpuinfo_tree.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] sparc: Annotate struct cpuinfo_tree with __counted_by
      https://git.kernel.org/kees/c/cfa36f889f23

Take care,

-- 
Kees Cook


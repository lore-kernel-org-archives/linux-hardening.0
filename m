Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C582AB54
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsWsXFp7"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA1F5
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 12:49:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c7ce16ddfaso3433546a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697485768; x=1698090568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDEvoDDFlhaScQdoPW2tJhTzTU/5dfUG14nxqzDs2yA=;
        b=JsWsXFp7B+tTYU2ItV0yg6gp2M0FieKyfLU1u65a9OD1zULLXTI9IUZjcTP7nPF7Cn
         YSCdjyak05QNzkxjgILMkBBeuFuaEDcGmtspaaZ0UkOdFWCCO9Y+CEAiN6jstBqMGYAA
         5fy3L2H023WgcLg5FJNBOoKl/Kgvhf3HtIiXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485768; x=1698090568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDEvoDDFlhaScQdoPW2tJhTzTU/5dfUG14nxqzDs2yA=;
        b=ralxQ58nJrGqHQkBq26uZNOat1dgcXgzHAi0F7fdvZekn59XJ+Wb58P8LBKaDufG6l
         q82CD2HbY7tg6jV4tdVXP7Qzz+NgEfNWu/6eJCPidxxl6nPN4mY5GTIeXUEba5tkQJWl
         IvXEV1NCWp470d77Ga45w40CEkG4Y561mgVvZRi5gdG0xwJNmKWl3P5XDe41Q+ewkOgX
         ZKkPk4/d7UxGUbfOZ3JMW1chGFrEbe0zM7pqmon9tvEWFy/XyXRMdQmotKZWPFXwTCed
         1f3wNSr0J70yYzr1HT0EeFeaBioRO/vHQG+eSNjgquwX7/YefghhGpQ1GfMb3Ig5ayW2
         e8+A==
X-Gm-Message-State: AOJu0YwubFSM6YVkRFi4XPfwpbVUfbZW80anyW4cq9Pc1qI01GLh83RJ
	bk8iMkUH7iRIviIeIRGYjgORZA==
X-Google-Smtp-Source: AGHT+IGzztkRAoioNbwxGtaNyJL8FtTv0uRRmTERYsx7mf9E05Z0DIj6n8vDcTI8S1PZr6xfpA678g==
X-Received: by 2002:a9d:6d9a:0:b0:6b8:807b:b50 with SMTP id x26-20020a9d6d9a000000b006b8807b0b50mr221886otp.22.1697485768484;
        Mon, 16 Oct 2023 12:49:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v67-20020a626146000000b00690d1269691sm309260pfb.22.2023.10.16.12.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:49:27 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:49:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Kartik <kkartik@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, andy@kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, pshete@nvidia.com, petlozup@nvidia.com,
	frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
	pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 1/8] mm/util: Introduce kmemdup_array()
Message-ID: <202310161249.A59D2AE2@keescook>
References: <20231016053411.3380-1-kkartik@nvidia.com>
 <20231016053411.3380-2-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016053411.3380-2-kkartik@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:04:04AM +0530, Kartik wrote:
> Introduce kmemdup_array() API to duplicate `n` number of elements
> from a given array. This internally uses kmemdup to allocate and duplicate
> the `src` array.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

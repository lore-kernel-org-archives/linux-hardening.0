Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C1C6AF
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfXaPkm7"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BAA9
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:41:05 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57bab4e9e1aso181932eaf.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060465; x=1697665265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9utCBiCdOTyVV2yijJlin/2F56vToEAaXQDWZUK9xk=;
        b=KfXaPkm7m+oRIwlMiiIHcsazYgkO86v1Sj8k3lCn9TH50FLrc2yiYBBJ5R5cjl0DPG
         L1Xo7xDo9UrUr/nnsmadHroZ+fPaC8ZadTSjcIMxr5eqah8BKMR6KZUwRCoeXhkmtnxf
         BPhnkM6Q4Vj5NR0J9d61kFaJAjFyllD+i6ums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060465; x=1697665265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9utCBiCdOTyVV2yijJlin/2F56vToEAaXQDWZUK9xk=;
        b=mVChfPkZyzxqi8NtVGD290Tr6kEShUwWGTXHNK8lEgHY5Cu3sjhs9dof85f5vEgRqH
         YRNn+51NSvGfxu/OLkI0RyIs6gLfrVzjt0IdbaovVYFOD2UoX5mB1ZqJCpvosoN47QPt
         agbWBhjH4+crImQ3A9NSW2RcjfUL4yxKfGgSHJNL6hKk76BnGHczvdkVqQFv7WhhwdYV
         f2vEtzDLwW2wdxvxfkliRrmPZFpqYNZ3Gp0lZx5ZLleKo2UpsZglHS3XOz6FuutoJxeU
         b42w053oMncVJrr1zkxI9HReLa84KRmzsplfynXBPaRSjNNN7b2Q7VazTIe83eycYSwJ
         MITA==
X-Gm-Message-State: AOJu0Yxv2Vmzmvt02ubZZOvGcHE6/Qwb6+jSnQrYCh8ehm65UwEIjL+E
	5yTAWCgj2ylmaM8D9kLJUZNZQlhOVB2ZjlcmTQg=
X-Google-Smtp-Source: AGHT+IHI060ARBfAOQ+6J3AvSpXVQH9lS2coXsGbCtUx/R3qXp2HCId6KikW4ulIVwWsbBAQB9J9FA==
X-Received: by 2002:a05:6358:2496:b0:13a:cb52:4837 with SMTP id m22-20020a056358249600b0013acb524837mr20580632rwc.31.1697060464890;
        Wed, 11 Oct 2023 14:41:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0068be3489b0dsm10864161pfn.172.2023.10.11.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:41:04 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:41:03 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] clk: socfpga: agilex: Add bounds-checking
 coverage for struct stratix10_clock_data
Message-ID: <202310111439.35CB04432F@keescook>
References: <cover.1697059539.git.gustavoars@kernel.org>
 <fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:35:26PM -0600, Gustavo A. R. Silva wrote:
> In order to gain the bounds-checking coverage that __counted_by provides
> to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
> we must make sure that the counter member, in this case `num`, is updated
> before the first access to the flex-array member, in this case array `hws`.
> 
> commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
> together with changes to relocate some of assignments of counter `num`
> before `hws` is accessed:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> However, this structure is used as a member in other structs, in this
> case in `struct sstratix10_clock_data`:
> 
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         void __iomem            *base;
>  11 
>  12         /* Must be last */
>  13         struct clk_hw_onecell_data      clk_data;
>  14 };
> 
> Hence, we need to move the assignments to `clk_data->clk_data.num` after
> allocations for `struct stratix10_clock_data` and before accessing the
> flexible array `clk_data->clk_data.hws`. And, as assignments for both
> `clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
> each other, relocate both assignments together.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yeah, ew. That's super tricky. Nice find.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

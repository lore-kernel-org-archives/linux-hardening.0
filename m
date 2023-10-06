Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0831A9B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aVVs8RPr"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE9CA
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:40:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c87e55a6baso19716305ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624811; x=1697229611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYltLeYvbo/1mtF+cJGeNFCBhuyzY8y0TMwn8mJuDlU=;
        b=aVVs8RPrQTqCTjnXOY9nAwr2OCb8YXiOco08CShS92ljT8lrczAb7/Bvecss2ocb4E
         b4mlzDnaTPBAj8FMY2bLfu962Yhs8wEoHZNKD6oj9FHN0UTlp7PBO8e/21TlSI5sXeTC
         suJmtsaKQds6w+Z5C4JdwqH9eMc3yw9HMlNW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624811; x=1697229611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYltLeYvbo/1mtF+cJGeNFCBhuyzY8y0TMwn8mJuDlU=;
        b=ptKSswid7Ask7RfDqYbKtMNfrvE7C0RC7DKzHm0SGuurG5YI3uXytO2L28SzUyJDXS
         EUY5ZukgSTYfT00u9yDZad/KBg6XX/VeOocL7SLqefY95oZLxYr1bhRnzs0FfnJdA5ow
         TEES/1NzKJg+qxyrARhumYzpX/1wwusCNE/yohbTbN8qKImIa83SFq6vMYjTr9GrnCGE
         /Mv55AGaDpsRbfAoNVgzd12KpOWBkLIL8mZlGr/gzwz04BiOiWO88RMCYH6Dwfz64SFd
         MusQJGSWVJMGii5hFZyVB4bXGzIfH6pk334rc/3fD1tqTDNh8jExsbOqOC49OZpMusYp
         hSDw==
X-Gm-Message-State: AOJu0YzQhDZoJ/NyonPjZsYjyeIL0Uyq3CDZCeRrAAR8PdL11ZFxyAda
	0V6fSiz7QkSn8vmeM/qOEwBDKg==
X-Google-Smtp-Source: AGHT+IGoeOCB9BQIIYsDUHmHt0dNs5E/IqnYM+4JDPUgBzU2U7hQ3/G8hmfV02fZLGW6TulWR0YmQg==
X-Received: by 2002:a17:902:9b8e:b0:1c6:2780:3adc with SMTP id y14-20020a1709029b8e00b001c627803adcmr8091459plp.24.1696624810733;
        Fri, 06 Oct 2023 13:40:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001c55e13bf2asm4349404plb.283.2023.10.06.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:40:10 -0700 (PDT)
Date: Fri, 6 Oct 2023 13:40:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] regulator: da9063: Annotate struct da9063_regulators
 with __counted_by
Message-ID: <202310061339.56F7680B5E@keescook>
References: <20230922175207.work.576-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175207.work.576-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:52:07AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct da9063_regulators.

Friendly ping. Mark can you pick this up?

Thanks!

-Kees

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/regulator/da9063-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index a0621665a6d2..82bf321ae06f 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -158,7 +158,7 @@ struct da9063_regulator {
>  struct da9063_regulators {
>  	unsigned int				n_regulators;
>  	/* Array size to be defined during init. Keep at end. */
> -	struct da9063_regulator			regulator[];
> +	struct da9063_regulator			regulator[] __counted_by(n_regulators);
>  };
>  
>  /* BUCK modes for DA9063 */
> -- 
> 2.34.1
> 

-- 
Kees Cook

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960F43ABB
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SQAOm7mx"
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC168BF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:22:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af609b9264so1667206b6e.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623777; x=1697228577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=SQAOm7mxJwp8A70M7SmHvhOVbjNCbVpWxfmgyc8x8MGl2URWXQYazZH/vDNR3cBh0Y
         jB9zlJi4doGVus4mdCPj/vA4YyEsrhC4fzLf7ylNa/e0HXTRhyd2DfqkZ8jnwEsqwXHJ
         QlEhlu4jObvUqBwnIkAaguUJRH3jRx3UmaQL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623777; x=1697228577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8kAE0L3XYT2zduhiLheo6/OoQQtkbHtadi2JLu6gYg=;
        b=R1QJOWOn6f2VqiuqtLvI6AKN/AobGFi0qlHdYW2UsaKbsr3v+B+Z5Tc3hRc8ojZZiq
         2OrNVJx8Ny2F4cCpqELWKH4efpUzmFT7U+Ja5s2jSjz41exszz8khxwamWET7uvWpnYP
         Mo9xCxbJfgMVafLXhqfxwuzEwbJNbIXy0PUh0W6uFEhcrztZ1zUv8bRpw72FAUqobMtO
         fS/R0QMaI7vor1hxe+LpXjjrTmz1LMasGkVVTo8Sj5pX4EuVWE5cFwZIn1XNR4veHLG1
         Od2Ewr2Pa7raYkpVTMdc6+SpVRUX64NBIN6njnbbd04zsjzkVNheJPdjObStGMYPDEdX
         Bx9Q==
X-Gm-Message-State: AOJu0Yyiqh9ttYi9wH8oPcZL6odMIoFCcBttkekluOhaO6amG+hx0mvP
	dHspjel8qYA9eVdES4sNNlpSBg==
X-Google-Smtp-Source: AGHT+IFJgYFdXQLoiEQmx+lFHyuC0qUrDFQKLIKGfw/wrLmvAN6GJdpM5ZD/9ihDG8TtTiEFnZjYhg==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id o17-20020a056358969100b0016487420525mr1346056rwa.17.1696623777190;
        Fri, 06 Oct 2023 13:22:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b00273744e6eccsm4271576pjk.12.2023.10.06.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:22:56 -0700 (PDT)
Date: Fri, 6 Oct 2023 13:22:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
	alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <202310061321.E7247C52B@keescook>
References: <20230922175050.work.819-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.

Friendly ping. Mark, can you pick this up please?

Thanks!

-Kees

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Martin Povišer" <povik+lin@cutebit.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: asahi@lists.linux.dev
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  sound/soc/apple/mca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
> index ce77934f3eef..99e547ef95e6 100644
> --- a/sound/soc/apple/mca.c
> +++ b/sound/soc/apple/mca.c
> @@ -161,7 +161,7 @@ struct mca_data {
>  	struct mutex port_mutex;
>  
>  	int nclusters;
> -	struct mca_cluster clusters[];
> +	struct mca_cluster clusters[] __counted_by(nclusters);
>  };
>  
>  static void mca_modify(struct mca_cluster *cl, int regoffset, u32 mask, u32 val)
> -- 
> 2.34.1
> 

-- 
Kees Cook

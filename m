Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D928DD5
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 15:04:38 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA1E76
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 08:04:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d77ad095f13so10182791276.2
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740663; x=1696345463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi8I/a7o7wwNWCt1t7ekaKgHNV+vsdHqCcY2PQYg2QI=;
        b=zkXj+jWgCXTz8EVcqT4K+5J9FTmhy1AsGvuhiNbT9vvQiDkcI3FPAbt4cZAawG8rs9
         5D+mhHmhlKrnfMafXDymPIALL4dxUoEdQuO7rE4Avjpn/o156+PJEygwEQUKPMqkGgcn
         mSOVtlhzNODEU0wMJLZzGesogWeqngupnEgAlGLaE1yKskTv34Jc32fI3IrXqy6Naw+L
         n43c9h5yeXBsXaEqmpfu/JAcm4llYv9giN6H0tgCLAiEC3OwSDqYNv26XDeSO2gEKLGN
         aOH6ufFWeXvyy85tFU+amTHC8nboW0SkHXHjAVeis2y/L35Mlc8W11ctEGKAhbvXWexy
         EQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740663; x=1696345463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi8I/a7o7wwNWCt1t7ekaKgHNV+vsdHqCcY2PQYg2QI=;
        b=EQKRti7hCva7vd+gMAGntWe66bxY8sOljbXPMfXM4n6vernknOLcXEBlYxHaNRUAE5
         7wcUp4jXVSG3kIJaLuUp2tDhc2UVkYOmshndyov+JNuNeqO7orrWh/a2BkyH3nHeUOf/
         3KWwGdPiVXGQkM2j9ImIKLDimXWljAFGHGeWK0VjMEoIwuwgxUXq3qFIDhZq5jenSO8Y
         Dx+AfyZgUAXJnmwzjxMPd3w/5CwS+Eq+OShuybAyKsrrFq3vviIBw1424jPV1SlnumpP
         pN7lUHNIe0Us09mAI2RLrtpvAMXNsDVtx7poJ6oiYjPoFb1WjY6DUtv7b9qbMS+VALeN
         wVJA==
X-Gm-Message-State: AOJu0YyLRweyMDTzQ2MDox7JnQ7SvToTPuNQhwH5S6L8x41tyHrGZ57e
	0vH53/+9chOzmKhxumUrGno6BWzlhQkLOv/JUyKJrpcXoMqrCFQC
X-Google-Smtp-Source: AGHT+IGQ+cDmUBy1mScBjOKjo++Q7IVdwaEUb7YBFTbK5U0lEpvDf6oS2L6LJvgIzbDQlTFsBZNTNRnN7t9lk62BZKU=
X-Received: by 2002:a5b:54b:0:b0:d84:90c5:4e1f with SMTP id
 r11-20020a5b054b000000b00d8490c54e1fmr7705526ybp.63.1695740663508; Tue, 26
 Sep 2023 08:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175249.work.593-kees@kernel.org>
In-Reply-To: <20230922175249.work.593-kees@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Sep 2023 17:03:47 +0200
Message-ID: <CAPDyKFo2CeV2Gw-MCbYvA=SRMrb+BptK3hW7f3sz2m1ChmgMAw@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: Annotate struct jmb38x_ms with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Tom Rix <trix@redhat.com>, 
	Len Baker <len.baker@gmx.com>, Dan Carpenter <error27@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-mmc@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sept 2023 at 19:52, Kees Cook <keescook@chromium.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct jmb38x_ms.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Len Baker <len.baker@gmx.com>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index 21cb2a786058..e77eb8b0eb12 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -66,7 +66,7 @@ struct jmb38x_ms_host {
>  struct jmb38x_ms {
>         struct pci_dev        *pdev;
>         int                   host_cnt;
> -       struct memstick_host  *hosts[];
> +       struct memstick_host  *hosts[] __counted_by(host_cnt);
>  };
>
>  #define BLOCK_COUNT_MASK       0xffff0000
> --
> 2.34.1
>

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36679FB
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 04:42:53 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F31A2
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 21:42:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad810be221so1607395166b.2
        for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 21:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695876170; x=1696480970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtW2DaDex4/qq5KYNshzbiXk1ZKdWPIH7i0eyiB1QPA=;
        b=i6y1Vu0sfJHLPXfDGY7n6wdXFNbO7UmkAyHcECjLix6U9u/lEnkbRJsaDQqVDc9da2
         1JlcNfxTwVnct1seNlZ2w1MSd+ZpvW7VT4pXGlnUZ+7bDWQmcPZTfC3+5+syXO3lnXeC
         wzaa5BLaAkBuozg+9J5eWe3RIv9Q16nr933238SEFy++aJ2Ga/FgMabys9HN3vnU3E/j
         aal5HLei0ANKgQxpaQqM6BXC8i4qyFIZ3Bl7EfR4HR6C9iX+r6E4lyb266zTYkiNsEVy
         IcsGyNcv9lGKIxhaIXGV/p+KyOyISTFLZgZRlDirJ1lpWnF0meK8JoFXF9wRdB/tjYSg
         0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876170; x=1696480970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtW2DaDex4/qq5KYNshzbiXk1ZKdWPIH7i0eyiB1QPA=;
        b=s8onk7eSM9Reh6Xxuu8xnDfO7BV9UngBRhgZlTqjxU63MJBGcGd80kTakvgs5XveiR
         9RSN6nbY5F9e1ryTs0uA+bXqxIjG7ZX0FgDwriqZbsDjnyIXPdf//HEJiWaU/gI8Iq9v
         GbOjUsi3Y9b0DwbxaTlZ+7XFtMEBtyyn1jrUcNj2LzeAwrZcmARfxetCqRPhU8BQczSb
         SBAIoIMR1+Z6txlThb2SUBKsJGW/kg38Wq9vlr/ZU1fIl631OC0hYnNGn3RXmk6iixap
         x6GzJjggKrikTem+fov2LgHk2ihI3Q2z1L92JOh48JLP/KZLnb1QKXDK6Nr/+e0HKEGG
         q3TQ==
X-Gm-Message-State: AOJu0YwhhjE30HWbMOqIDAQSNgPtY8Bmhbnv1SktiJDHAagSjDUFXqel
	vLEhYdMCBl3VCH7m5Fq6I5pc0kaTjKqF2Bx6E/t6jhaATfEZR1Yfc75RAw==
X-Google-Smtp-Source: AGHT+IHPBAmhx+er6QkuJRIUAhKqf0BCJK7e+59Jegd3S5xW+6aqnkbAfNHzBG5wu6mzEd52bNAKmrbIN7pJkCOCyI0=
X-Received: by 2002:a17:907:78d4:b0:9ae:588e:cdde with SMTP id
 kv20-20020a17090778d400b009ae588ecddemr163330ejc.11.1695876169938; Wed, 27
 Sep 2023 21:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175344.work.987-kees@kernel.org>
In-Reply-To: <20230922175344.work.987-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Sep 2023 13:42:39 +0900
Message-ID: <CAFhGd8oz9zTVacJMEWv4-hpNeXbPLYQ6fnb2z_2Y++rWyVSUow@mail.gmail.com>
Subject: Re: [PATCH] hte: Annotate struct hte_device with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Dipen Patel <dipenp@nvidia.com>, timestamp@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 2:54=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct hte_device.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: timestamp@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yep, this flexible array member is counted by @nlines which
is evident throughout hte.c:

        gdev =3D kzalloc(struct_size(gdev, ei, chip->nlines), GFP_KERNEL);
        ...
        gdev->nlines =3D chip->nlines;
        ...
        for (i =3D 0; i < chip->nlines; i++) {
          gdev->ei[i].gdev =3D gdev;
        ...


Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 598a716b7364..1fd8d2d4528b 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -88,7 +88,7 @@ struct hte_device {
>         struct list_head list;
>         struct hte_chip *chip;
>         struct module *owner;
> -       struct hte_ts_info ei[];
> +       struct hte_ts_info ei[] __counted_by(nlines);
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.34.1
>
>

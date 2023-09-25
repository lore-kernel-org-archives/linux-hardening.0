Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69510A00
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 07:41:10 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5228E3
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:41:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4529d1238a9so2439261137.3
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695627667; x=1696232467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiYZdX9DU54hlyCL6A/xG5cg0RmJhcg6NNDUibAVUyM=;
        b=T+SWuozF8p5UNcF4T8GwMGauc784jE2iIkm53erAQQ30lNHY8u3xAUjX6P2uPLyWee
         rbXYSdDrsy3uHF1ClYhkxlw7wEhRX4ckShYHTrKfegTvOtLHoVtis8DHD6geh/XsrW5x
         vJVwN9uFuZYZx3YSReBnawR8jg0OyugWDMPuKUuK0pmU//MSffcj0+xOH2MMrJzgoxYA
         JOZCGtqf57WdeJ+XEH33FP/PKAnUNzYnv3WtJ00JjgUi/bGBdVr7hGe3d0hoh3rbwOqq
         HPZMp24PtdeYQTGZ3nV3T7ZyL0ekt1GMjP5RMQi7lFqXtyK1kG3w75m5LFUWoZ99SnwH
         O24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627667; x=1696232467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiYZdX9DU54hlyCL6A/xG5cg0RmJhcg6NNDUibAVUyM=;
        b=sSMzLQmnVC5CA8sgtiHdQeVDg1V7srbVXAYTgcGB/xqveLcap8z1uQkmuzji9Y0yDS
         Ks9qq4l9zEcqo2dl2T05I7tE/vYwclgDWXgLIUKoZdnBrh8XfLAcefmR5fIF3GnR8RmK
         a/IehrBfzoSKqxrKpdBzFed8rpgSGK5ziB7Q1GlmSFBrsQJoKWPDPUOAJ2IG3LGpsZl/
         M0JnGLCYTa8aJ3xf6MrPnQ5US//h1lmUg2WEtRU+f1n08TqXR71jqYPeXHXTITbpBWBi
         ifHNUPuGm1vGgiS0H4UCt2WT5pAtmwz7uzWm0ZtKJeS4BFA5iECdW/DslxoYRhGi4Vgp
         p1/w==
X-Gm-Message-State: AOJu0YxKeSFgPWG736+a1Yu5u9PpeDGy0A5HIHl3wf2ZYsOmi8sHLqO0
	rR6AFuKU8UZjaQCeQOTy/72JW6YaFdwp7inDI7kL7g==
X-Google-Smtp-Source: AGHT+IFx82zmsxjoLuNTPGGd8GrhippPyNF9FQn3hKIpX7aWK+Ny/ek0o4jNsCfrxS8J3MiCNYA4klx50t41kyL94KQ=
X-Received: by 2002:a67:fb89:0:b0:44e:e7d7:6847 with SMTP id
 n9-20020a67fb89000000b0044ee7d76847mr2800971vsr.7.1695627667358; Mon, 25 Sep
 2023 00:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175155.work.872-kees@kernel.org>
In-Reply-To: <20230922175155.work.872-kees@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Sep 2023 09:40:56 +0200
Message-ID: <CAMRc=Md+BM0fGoO9SrnmKOKAmXmMBNJ9aBvuOCfKpT94rhv+zQ@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: Annotate struct at24_data with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 7:51=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
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
> As found with Coccinelle[1], add __counted_by for struct at24_data.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/eeprom/at24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index af83aca452b7..7dfd7fdb423e 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -92,7 +92,7 @@ struct at24_data {
>          * them for us.
>          */
>         u8 bank_addr_shift;
> -       struct regmap *client_regmaps[];
> +       struct regmap *client_regmaps[] __counted_by(num_addresses);
>  };
>
>  /*
> --
> 2.34.1
>

Applied, thanks!

Bart

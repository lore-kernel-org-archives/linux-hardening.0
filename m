Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630F3E497
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 22:57:13 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6BB4
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 15:57:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so2603119a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696373829; x=1696978629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNJ4V21M91PAJnutJlU6BdqwkvAfNI28YR+w3lb7qz0=;
        b=FlzORDkkg7tyvRYrDZ31U0Z2lEs+wu93DA5sSpR2UV3YqRfU5BRcG3bUoaydaox5ki
         lTp9WJrTlPrzX1OuW2vzeqqnIKtowcXcVGKipKR6nwNR2prDZbD3n4ENwL+VJb6F/jih
         YkExgjBcMYKpnNkrpqbXLfR+jEthWcX+BoMtLNoQWzRz9Srptk8gSH3x9ptCz5p/WB8b
         s8hKuw6eI91+WkUxEZ8QuhptZEVOmhV7Bu0ai428Ia0oupD7fCF+XqBGDX2RW+qza25R
         MNG9VmV4vM5W9m0FekxDmhxd75maou7o+7TgfI8Wv935k+O4i3eRFNIg6G05HRrBY4sG
         P3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373829; x=1696978629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNJ4V21M91PAJnutJlU6BdqwkvAfNI28YR+w3lb7qz0=;
        b=Hb4IK4krwM7FU/PB2pCeBiDTXvf6pYWLdlwOOsSCNHN/FJIyhIsHFeUc37skc4MLKh
         g23SLd6sVTb/6fNYZfjQwvNid1xBuoN4WVJYFOc2tn6Gy0s9rERR18watDWge81Rb2vm
         UMCFhZxeQkfWCkAUObUEVyOuRYM02T8Q+3SLkQ91SUGBIP1/Llf560MoDF35U/m1jsBm
         d0HbGa0X/2ZbmKmBMbr/ftKW80a4rstUIlv6hjiN5Nz6NFUwX8p7xft1WQuLTu0qLTiq
         ksFD7ApRbmun26w/6vMkDdevQUdmQEPRzG+U/BahUBaW/b4Nj0LSgNdd3jcpfCro10Hp
         W6Hw==
X-Gm-Message-State: AOJu0YxfYzszbaFU4LjlHjxCMsSVr9ARqF4dkMXwP8PDRtmo5lgxmVPP
	QFRCx8cFjeYmjDVaw/idD7AFXKl7/fEOGnYfJFmE7A==
X-Google-Smtp-Source: AGHT+IGU3gyaT977jvt9iRD1Ew9XlWTiuArkryKIRq2HRhld6gv/M4qSWfTxLUS5n5K9yVhjHJogubJlzCAW0Ey3Gyk=
X-Received: by 2002:a17:906:210a:b0:9ae:56da:6068 with SMTP id
 10-20020a170906210a00b009ae56da6068mr563304ejt.57.1696373829597; Tue, 03 Oct
 2023 15:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175351.work.018-kees@kernel.org>
In-Reply-To: <20230922175351.work.018-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 3 Oct 2023 15:56:57 -0700
Message-ID: <CAFhGd8pHzbdcSaxjJHVHTAVrsxVPptn+OfwNjQ0RMEsOS3xRiw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	linux-arm-kernel@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:54=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct zynqmp_ipi_pdata=
.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Great patch! Crucially, the count is _correctly_ assigned
to before the flexible array member is accessed.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqm=
p-ipi-mailbox.c
> index e4fcac97dbfa..7fa533e80dd9 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -108,7 +108,7 @@ struct zynqmp_ipi_pdata {
>         unsigned int method;
>         u32 local_id;
>         int num_mboxes;
> -       struct zynqmp_ipi_mbox ipi_mboxes[];
> +       struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
>  };
>
>  static struct device_driver zynqmp_ipi_mbox_driver =3D {
> --
> 2.34.1
>
>
Thanks
Justin

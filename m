Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AD225BB
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbGiertw"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDC94
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 10:59:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso187974a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696960742; x=1697565542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1TIuimi/4iNqWfZhkdgCqCgPh9EXGV/EamH/mMM+fY=;
        b=mbGiertwvWYamM+aNKPr2cCQA+HiLPCFu40udrV9vYWhwv3NktaY6xCWjCJbPt3FFt
         PG/bnwlEUTI6g35HV/KDl1pDr2KM4r4++5gqZk4vCZ+JuRuOpThNwnroi/VEsY9Tgct2
         AnCGhYH5J7H6jCV42naZpHfThBTvqqM/y6Ng2Z5fJllf+CXS1q14frxP1JIWNZrsLQ1L
         rNaXXPo4OfGDiaZSdhe495proUVXyG7UoztYpeYGUHXLOyrKYNBr8lCPsMsTumLLzQ03
         Z43UYvkY5Pqj1Bgq+/rzxtDvL5iMyW+pA0jHX/nzIhQu4C56k7DcRFM3Jehlr5KJjYsK
         5mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960742; x=1697565542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1TIuimi/4iNqWfZhkdgCqCgPh9EXGV/EamH/mMM+fY=;
        b=GlLpt3KhjJVW6jg+j4Lu9lqLSJnzuKCnrpy71Mzz20HquzwA/No6XkA9ovQaVHGZzF
         XrMBGLWuUMqkJSoi/u9Rhs4P1Yccg3vPufjK0MMp+O9BJwSWcTcuUocEm30RjiXC2z4A
         ikDWpxrm3YciVOMKFg+NNdQ+GUXeL+S7Ml7lJC/au8GN820/oN+35smmvKYrnxUEg7fi
         Hur/caKlz1MPntzZr/8sS42FM7kW53V7tBGCQm9WUhUCWlA5M9+wxadelQYdmJjDjF6A
         EMDBgUrWSXz9ikc7wSV4oB2gTaS1Gvsf8/wICldIR2Amn0q1GeGWkiQq3zsZp7YaEasM
         ++Pw==
X-Gm-Message-State: AOJu0YzMdAdOoAdaxaKLerLnDKv03aYkwI0pdPmID7t19PrNOlTQx9MN
	8jQmBbnH3ZCQuTWQT+p+luzBHQgXZi0hg+WESaKKUA==
X-Google-Smtp-Source: AGHT+IFBjf4+jhA5R1S4LfIZl/PoHi7DBMB4Y++BcAbRlrtJ1OribXCLcIPF3cLZbNsEXcD2yDyVPecj3Kps21xbSc0=
X-Received: by 2002:aa7:d1d9:0:b0:531:157d:ba2d with SMTP id
 g25-20020aa7d1d9000000b00531157dba2dmr14928139edp.4.1696960742207; Tue, 10
 Oct 2023 10:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSVHurzo/4aFQcT3@work>
In-Reply-To: <ZSVHurzo/4aFQcT3@work>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 10:58:50 -0700
Message-ID: <CAFhGd8rwzaa5hFtJa6hf0i8OrgAx2tgvtXrHvKFzgYijd2KKAg@mail.gmail.com>
Subject: Re: [PATCH][next] atags_proc: Add __counted_by for struct buffer and
 use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 5:47=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
>
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/arm/kernel/atags_proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
> index 3ec2afe78423..cd09f8ab93e3 100644
> --- a/arch/arm/kernel/atags_proc.c
> +++ b/arch/arm/kernel/atags_proc.c
> @@ -7,7 +7,7 @@
>
>  struct buffer {
>         size_t size;
> -       char data[];
> +       char data[] __counted_by(size);
>  };
>
>  static ssize_t atags_read(struct file *file, char __user *buf,
> @@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
>
>         WARN_ON(tag->hdr.tag !=3D ATAG_NONE);
>
> -       b =3D kmalloc(sizeof(*b) + size, GFP_KERNEL);
> +       b =3D kmalloc(struct_size(b, data, size), GFP_KERNEL);
>         if (!b)
>                 goto nomem;
>
> --
> 2.34.1
>
>
Thanks
Justin

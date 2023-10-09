Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23847363
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/YgA6HK"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B26A4
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:49:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so8763380a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696895348; x=1697500148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=w/YgA6HKdYQNbSrx1ojyA+nJKg/1GMbtiR4Vgotnn+0Mu+dxPJl2n2ul93LczpPlYg
         8B4fcM+0q2G4mzwawiqrxMh3SG9J4KRFwnYk1xsdH2WoBJDaLGuVnPmr1ueggx2B2ug4
         oBTmxG0hv3A7O+lSD9d4z2wFX6cNi3QTIl5lHVhPq8wuMJvg/ZHwEb0AhvXT+VqQvASV
         Vhbg2CHL8IYkF9mznN1JAY+SBWrp5S1/Nnhk0oruOada0d8qyPsCcZpTkoncZj3nk4is
         ZvEL5yNua0KD3OOyUxBBjcipmxr6wO+fz5xEL3taj/bmVba3Zg97acApY8+jlUrxXQ8O
         5KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696895348; x=1697500148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=eS3c92Gp6uRsxQcAYSv99uLmj9tzXlL7Pq4hxqRbl1CYa2Wfjm/jBQDhrzrX68IDzv
         3EoG8KFdN0PCbIHyE2KEy8g3IgHax4DsVe1Eqo/yt4g8b6oijU0NvxcWzwWnZe72ejwD
         UuIYILdafcC1uj5mjaVfVGdj94ofh9iyXO50wFsiYATMENrvStzHaKcA10H6idwNrIjH
         yCdLOyPVNgCPo83O1YEv9cKYP48Ln4GZK1u3mCZbAIZdP5TwwUjrXMajbz/EH540LoYH
         O2LwMhM4osbjU8uad1fX8EStZyOiqF8fWF61OBG5knrn3Tana/YbaF7bEkrl8nqEK15J
         kLCQ==
X-Gm-Message-State: AOJu0YxrBrPdAblGLjzXO1j1fa7rmdHTWn9W8c4foDn6OM7dWhvfxI2F
	FpLMUt0fWQL7f7D366sc/equoMQHWpbgOGXCSsruLQ==
X-Google-Smtp-Source: AGHT+IEZU4Sz3NJ/tlAQJLXA8SAjvhWPvXTbQLHBmKyfF8fk76AwoUyvKdaafL4oQUOV3CPkS9uDRtezaI9Fz4xlEyI=
X-Received: by 2002:aa7:df86:0:b0:52a:1d9c:83ff with SMTP id
 b6-20020aa7df86000000b0052a1d9c83ffmr15150271edy.1.1696895347954; Mon, 09 Oct
 2023 16:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSRFW0yDlDo8+at3@work>
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 9 Oct 2023 16:48:55 -0700
Message-ID: <CAFhGd8obPWF5469BwFAXmZ7czOB6f68gdOGqCPFL+dbs5KzDyw@mail.gmail.com>
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev, 
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

On Mon, Oct 9, 2023 at 11:24=E2=80=AFAM Gustavo A. R. Silva
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
> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>         void                            *writeback;
>         unsigned int                    write_offset;
>         unsigned int                    len;
> -       char                            buf[];
> +       char                            buf[] __counted_by(len);
>  };
>
>  #define VIOMMU_FAULT_RESV_MASK         0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu=
, void *buf, size_t len,
>         if (write_offset <=3D 0)
>                 return -EINVAL;
>
> -       req =3D kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +       req =3D kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>         if (!req)
>                 return -ENOMEM;
>
> --
> 2.34.1
>
>

The __counted_by annotation and the usage of struct_size look right!

Reviewed-by: Justin Stitt <justinstitt@google.com>

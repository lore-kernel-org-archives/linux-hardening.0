Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8630FA0
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhLgjgLZ"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E60A7
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 11:14:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so8211629a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697480081; x=1698084881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRL/6VX7HAEyDPGl2HTyivOlN20wjAMOil4U+8Zf2+k=;
        b=AhLgjgLZl67P4j/YjKLQIhP8byxtkC3GAroqeIuYOLU+9dshhBBbkZl8/eo9bwt4/D
         7LJatgprrWqA5mH8Vwwnv1AbWv/hCau2SiSIuhlOQVhvzGEBbJLH4l8UHA/xd0SvkSR1
         OAEx6jFJMi5ZrPkjksqbk8xykprcoqxDSCGqBIsmxowFQsiWlzCkCfjeeAb04C6+9Xp6
         84fGRXnGmdQCFLNU3Myp6QmQpg47lWwzvQEAp31tlL+Qbh90Ia95HZ9dAbOT6yMTSqYy
         WhVn5GQV3A8y9Hi451da10evusKZ2BY3HHSP3Dn4mgdEJ28kJCllEIHN6xcAuRxu3D+A
         +Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480081; x=1698084881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRL/6VX7HAEyDPGl2HTyivOlN20wjAMOil4U+8Zf2+k=;
        b=ecLP4NjNvoBLqQaWp6h77a/259de9wma1xy50aA4Ps5V5S7x0s+5bxEGtsIxEh6A/s
         10i2P+jpNa4RxaTtH/GqdxRjKBfu0ldxJ8rK0ZffSLQoryESWv4eYZv3f+T8pJofS+Hk
         AX8cXrUOBE4x6I5s/xOjWqJLtcoJYcL4mTOi8/xYCOwHMRvfs56yc1UXRsBxHd3dwWRA
         sp7EIWudcxtPC4YXpPuF4iuANoHGbpFKerOORFgdCCi0P5glSgUQMP6UYDgKBQ2nMA5y
         KcjmXRahM9Hzmnx0tlErZAxcJ9/mNkp9RxXs7cp3ZGVv4JbGBlVOt6UIwgynyE2CQi00
         Dsuw==
X-Gm-Message-State: AOJu0YyLC2jTsxzPZ8d7jZrVerkCWa/KZKjT7RAjRlLYzU+fwy3xIZ0S
	rs1OwAVh4o0tpS//AZPeN/xUTCY2aSnn0AKyU/MCvA==
X-Google-Smtp-Source: AGHT+IHWE+5Rhq2pCOMoR8bDSaQb/FjDy2AMJAB/4FZZkaJ3R2ZA5dlO1ZAXGzdrzGkzocSaigLv2m8YWy8QwPOXlIA=
X-Received: by 2002:aa7:d1c7:0:b0:53e:1815:ed0f with SMTP id
 g7-20020aa7d1c7000000b0053e1815ed0fmr8825edp.31.1697480081468; Mon, 16 Oct
 2023 11:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
 <202310141944.08A1FF6D9@keescook>
In-Reply-To: <202310141944.08A1FF6D9@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 16 Oct 2023 11:14:29 -0700
Message-ID: <CAFhGd8qqVAfSL6__Z0tC4r29FE31a4uHzhUAakKs8DURFnM_8A@mail.gmail.com>
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
To: Kees Cook <keescook@chromium.org>
Cc: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Sat, Oct 14, 2023 at 7:47=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Oct 12, 2023 at 07:44:29PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > We expect fw_info->fw_file_name to be NUL-terminated based on its use
> > within _request_firmware_prepare() wherein `name` refers to it:
> > |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> > |               dev_dbg(device, "using built-in %s\n", name);
> > |               return 0; /* assigned */
> > |       }
> > ... and with firmware_request_builtin() also via `name`:
> > |       if (strcmp(name, b_fw->name) =3D=3D 0) {
> >
> > There is no evidence that NUL-padding is required.
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
>
> When doing the hard-coded value to sizeof(), can you include in the
> commit log the rationale for it? For example:
>
>   Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
>   sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
>   size to the destination buffer:
>
>   struct qlc_83xx_fw_info {
>           ...
>           char    fw_file_name[QLC_FW_FILE_NAME_LEN];
>   };
>

Sure, I'll be doing this from now on to make the change more clear!

>
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 ++++++-----=
-
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/dr=
ivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > index c95d56e56c59..b733374b4dc5 100644
> > --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > @@ -2092,8 +2092,8 @@ static int qlcnic_83xx_run_post(struct qlcnic_ada=
pter *adapter)
> >               return -EINVAL;
> >       }
> >
> > -     strncpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> > -             QLC_FW_FILE_NAME_LEN);
> > +     strscpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> > +             sizeof(fw_info->fw_file_name));
> >
> >       ret =3D request_firmware(&fw_info->fw, fw_info->fw_file_name, dev=
);
> >       if (ret) {
> > @@ -2396,12 +2396,12 @@ static int qlcnic_83xx_get_fw_info(struct qlcni=
c_adapter *adapter)
> >               switch (pdev->device) {
> >               case PCI_DEVICE_ID_QLOGIC_QLE834X:
> >               case PCI_DEVICE_ID_QLOGIC_QLE8830:
> > -                     strncpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_N=
AME,
> > -                             QLC_FW_FILE_NAME_LEN);
> > +                     strscpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_N=
AME,
> > +                             sizeof(fw_info->fw_file_name));
> >                       break;
> >               case PCI_DEVICE_ID_QLOGIC_QLE844X:
> > -                     strncpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_N=
AME,
> > -                             QLC_FW_FILE_NAME_LEN);
> > +                     strscpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_N=
AME,
> > +                             sizeof(fw_info->fw_file_name));
> >                       break;
> >               default:
> >                       dev_err(&pdev->dev, "%s: Invalid device id\n",
>
> But yes, this all looks right to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Thanks
Justin

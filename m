Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70C28E6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2MFTdg4"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A93A4
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:46:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso3875645a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696895209; x=1697500009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXbLKS+MxtD32e7DqErJ9Y3Mh+T6J/t2QZRdubLMtiQ=;
        b=p2MFTdg4Ku/ED/0Lw9LyVc8RZ6mH6QdHG18FcltKEMRFZUp6mvDe+bDHa0khBH0f52
         lyVpSrMTmqA8zRsmYmhQ8S6hGilZn9MAlHR35bIXNoxrntxtUAFYcYxg9M2Bd4nu6j3C
         0vavPkpRs6vDfye8asGPZA2STFmW3WyI8JBojpwz6ZeHOSP6Hv7twlawnZDpmWPQ3YnF
         WRNWWSCFO+QNM/yBR1PxiHRthqcslsnTHOJ2RaTsxAKAkJ6unqJchN0ZOWgjxoZet6xC
         ztm9MBVq5yFHB7WM45lJBK+FMVf0d+cyh1wS2nbdhYi2GBW+ZTnN2M9ElG5wnqWt6AcT
         iD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696895209; x=1697500009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXbLKS+MxtD32e7DqErJ9Y3Mh+T6J/t2QZRdubLMtiQ=;
        b=rWXf/ebU7BoR7PyVfBY/I3XX9kLHjNN+tEvdI6Nwre5D1Ehp2aB3jeYuWDgKSN+42z
         a4uXyvvKF2ETz+lHJwK6vDd3XOvW21VrXFolshVutxdhvqAFAO8B87Z+1JFLP9saU505
         jEYxXjBJ3e1TI3rYRxOP6fNpYqDRC8q/CIP9fEIDT6OQw1v3eJIo7Me94gRdcxh7E61U
         2/WoYgeOHeljMSvbOuexCVWdATRPt4xecjf++8tGo2Gv02lAg82P2JY1whgU1CDw0hMJ
         +EJkOGxUgY8WjmtgJmzzl6SjwbNnExtj5ceElMdmJRrqvduH7Rfkwb3A8eJOUSvm8n8O
         uWOQ==
X-Gm-Message-State: AOJu0Yy8nJvjKwvwW0z14tqRQFwVCNsscp08eYyQfpXWMtXH2mkQkSJI
	vbQeIpi1SHwj5C+QNViH8nJPBZBddwevUTwEetYfQg==
X-Google-Smtp-Source: AGHT+IHxLOxVJsCnD34Qu13Ga8MaOle2QYFCYyhM8gdiqM+aR02mWA0J6BETSOKihrN6QR5kLYk1mEbinX+qyX2zgEo=
X-Received: by 2002:aa7:c541:0:b0:534:2fd8:a9e1 with SMTP id
 s1-20020aa7c541000000b005342fd8a9e1mr14401271edr.22.1696895209185; Mon, 09
 Oct 2023 16:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSRw6RNi3Crhd32H@work>
In-Reply-To: <ZSRw6RNi3Crhd32H@work>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 9 Oct 2023 16:46:36 -0700
Message-ID: <CAFhGd8o=UB5C_RDUHvNLEkW6OJEDn-uB2tCz3ZMnD4KRq3DcCQ@mail.gmail.com>
Subject: Re: [PATCH][next] soc: qcom: apr: Add __counted_by for struct
 apr_rx_buf and use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:30=E2=80=AFPM Gustavo A. R. Silva
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

Excited for __counted_by to land! This looks right.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/soc/qcom/apr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 30f81d6d9d9d..1f8b315576a4 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -41,7 +41,7 @@ struct packet_router {
>  struct apr_rx_buf {
>         struct list_head node;
>         int len;
> -       uint8_t buf[];
> +       uint8_t buf[] __counted_by(len);
>  };
>
>  /**
> @@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, v=
oid *buf,
>                 return -EINVAL;
>         }
>
> -       abuf =3D kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
> +       abuf =3D kzalloc(struct_size(abuf, buf, len), GFP_ATOMIC);
>         if (!abuf)
>                 return -ENOMEM;
>
> --
> 2.34.1
>
>

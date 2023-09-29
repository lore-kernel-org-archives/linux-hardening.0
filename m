Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83582521C3
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 16:20:52 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD84199
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 09:20:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60128d3f6so223015ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696004447; x=1696609247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJsy3U5P7JRkSbDtJdUi/rB+ipyk8l35yY9j6rGapyY=;
        b=ezF09jR72kxsakofzaaNDV/CJjc09Lt2SF4C0WWEkH9xetWEIKN23/oC5BwPU/OUtJ
         WnvpnLBfTj5mgDcQ5vFiCRF6O2cPkKm0icLAC3Jz0mx8CSCy9q5fnczPj3MRQnINKFbK
         5UBN+OPXcslymWgy0SISaK0ki84hQRGZsDKWD8CxNBOMgmCGo0YUyc0Xu4BXubAb0uJF
         rRLYW3Lbka3tZf3R7sukzsx3hIoORdfLuHToW8w7OMlCu4vvFHvcMDnP3ZsG2QWg3avO
         4PER5tIbFSi/jiQvHLPWnTeT57Z+rPwLC3RKyTt5p9nkjbXS5yk03/vMnaPO5CC8mtH0
         qhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004447; x=1696609247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJsy3U5P7JRkSbDtJdUi/rB+ipyk8l35yY9j6rGapyY=;
        b=rfak0lsnkWdAZ4tyz0a9gHCADZy44/pXwsbg5spON3/J/8TajlY/VZqz91aXMmAq6D
         KUdbd4YN04A4Q9XpgW65Y4HFdiDuvniPqR4zfwB8rfIvLFJ7YmHvixCCZLuaJY0Ujhwf
         Yq/gJ5b0cijAUCO1JKu4co34A+6m4/Nngurb8RJEW6Y4l8GhS2LsScA/xX4mJZRG62tX
         +sAzFvuUmy/Ia+5//h959NrO5m96+x77TABteJXIT3w1oyfvoKCOowMWWZ57H6sOanSD
         5Z+XGZPj1dfrCgT4P2/uF/nKNOy3MM16b6qMfk2Jx4HYiBpRxiH812F5+O40ZeumBgny
         a4VQ==
X-Gm-Message-State: AOJu0YxpiIFX8SEC6O3OxwQA0NNoIkKF+NWwQs4/T/KGpwKANRACDWGH
	27CP1LVk2RyXLU9f01NN+Oe0RN7B86DWOQGatlOFnw==
X-Google-Smtp-Source: AGHT+IG7bJVACXPaJHWfeTFPOQqYslgg2MMLtTumeATk1ELGuLUrmmid3NcQWN+cuFswlozqETVEAyH8vagOlxW7bdE=
X-Received: by 2002:a17:902:f54f:b0:1c7:1fbc:b9e8 with SMTP id
 h15-20020a170902f54f00b001c71fbcb9e8mr820240plf.10.1696004446368; Fri, 29 Sep
 2023 09:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZRbwU8Qnx28gpbuO@work>
In-Reply-To: <ZRbwU8Qnx28gpbuO@work>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Sep 2023 18:20:10 +0200
Message-ID: <CAG48ez2SJMJSYrJQ9RVC44hbj3uNYBZeN0yfxWa7pqX9Fp2L7g@mail.gmail.com>
Subject: Re: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	USB list <linux-usb@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 5:42=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the object `wq` at run-time with the contents of `urb`.
>
> Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.

Does this really change the situation? "struct smsusb_device_t"
contains an array of "struct smsusb_urb_t", so it seems to be like
you're just shifting the "VLA inside a non-final member of a struct"
thing around so that there is one more layer of abstraction in
between.

Comments on "struct urb" say:

 * Isochronous URBs have a different data transfer model, in part because
 * the quality of service is only "best effort".  Callers provide specially
 * allocated URBs, with number_of_packets worth of iso_frame_desc structure=
s
 * at the end.

and:

/* (in) ISO ONLY */

And it looks like smsusb only uses that URB as a bulk URB, so the flex
array is unused and we can't have an overflow here?

If this is intended to make it possible to enable some kinda compiler
warning, it might be worth talking to the USB folks to figure out the
right approach here.

> Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/media/usb/siano/smsusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/s=
msusb.c
> index 9d9e14c858e6..2c048f8e8371 100644
> --- a/drivers/media/usb/siano/smsusb.c
> +++ b/drivers/media/usb/siano/smsusb.c
> @@ -40,10 +40,10 @@ struct smsusb_urb_t {
>         struct smscore_buffer_t *cb;
>         struct smsusb_device_t *dev;
>
> -       struct urb urb;
> -
>         /* For the bottom half */
>         struct work_struct wq;
> +
> +       struct urb urb;
>  };
>
>  struct smsusb_device_t {
> --
> 2.34.1
>
>

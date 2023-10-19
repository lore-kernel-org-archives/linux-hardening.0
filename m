Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722D17FD
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQuPntFt"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B1912D
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:35:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c87a85332bso65801985ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697693728; x=1698298528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfobpSr7vKEGPH54g86JM2Np+bjWhjxTMm3BnchjKQ0=;
        b=fQuPntFtrXBrqOA5X1FYTkpOT/zHpG9OLlVqSGDGS8Zudy7WmI5zDxOrqmQjO8kMBJ
         /niDxix/PjtbdpJMHtFgTG8VGqY7VTQZJUUWoPqiw7hUMZbWki2yh6HwXTlZYLLlGOPU
         Ou8sgYBgOZyRUdEP/5IlqkprlDahC6At1/5E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693728; x=1698298528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfobpSr7vKEGPH54g86JM2Np+bjWhjxTMm3BnchjKQ0=;
        b=QrPZz5r4qSFToXfbRZbeXZjkNW1WopplVkK9NTXG6w5Za6c+JKr0LEgA5CfWge1+4Q
         GgMK/ISuQ57Kqk8UHLwC2zdjd5XKx0B9ZndslRYctf1P5fufpv6ULKbpdH9N68Kx0WjM
         bSIWoUjc19GLL+MgpjGQF6JERTPrfFAjilUwHmGzw8eQyWX6J/AkbkXLycycfzyX6rYx
         o75qAmJny3fc4FbQP//mieQYEy63mE0BC95HXMSk6d1KN+sm/YZHubxAR1Z1LOuUNgKp
         snfRFI2njqtwrlrJL1/dwLoOTgALxKPvH6ZpBXqFIA2OS4CGvyBnSLiy/hkSm33qt6N5
         9NiA==
X-Gm-Message-State: AOJu0Yye5vnMPNpfV59HKL0XW0V4hJxaPWCCCqLJk39P4Zg81I3vLe0H
	iy8og0mMrspe6hLWb24YHuaXqw==
X-Google-Smtp-Source: AGHT+IHWgfmf8zIXxwIjD4ZleHld0EiD88e4q1WNeVI5olT0uObTayiLltt3PVMa2zo4Kom7Jk92AA==
X-Received: by 2002:a17:903:1cb:b0:1c6:a0b:7b9a with SMTP id e11-20020a17090301cb00b001c60a0b7b9amr1450654plh.3.1697693728114;
        Wed, 18 Oct 2023 22:35:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001c74df14e6esm903825ple.51.2023.10.18.22.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:35:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:35:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
Message-ID: <202310182232.A569D262@keescook>
References: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>

On Wed, Oct 18, 2023 at 10:14:55PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chinfo.name to be NUL-terminated based on its use with format
> strings and sprintf:
> rpmsg/rpmsg_char.c
> 165:            dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
> 368:    return sprintf(buf, "%s\n", eptdev->chinfo.name);
> 
> ... and with strcmp():
> |  static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
> |  						    rpmsg_rx_cb_t cb,
> |  						    void *priv,
> |  						    struct rpmsg_channel_info
> |  									chinfo)
> |  ...
> |  const char *name = chinfo.name;
> |  ...
> |  		if (!strcmp(channel->name, name))
> 
> Moreover, as chinfo is not kzalloc'd, let's opt to NUL-pad the
> destination buffer
> 
> Similar change to:
> Commit 766279a8f85d ("rpmsg: qcom: glink: replace strncpy() with strscpy_pad()")
> and
> Commit 08de420a8014 ("rpmsg: glink: Replace strncpy() with strscpy_pad()")
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wwan/rpmsg_wwan_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> index 86b60aadfa11..39f5e780c478 100644
> --- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
> +++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> @@ -37,7 +37,7 @@ static int rpmsg_wwan_ctrl_start(struct wwan_port *port)
>  		.dst = RPMSG_ADDR_ANY,
>  	};

"chinfo" is initialized immediately above here, which means that it is
actually already zero filled for all the members that aren't explicitly
initialized, so the _pad variant isn't needed. I suspect Dead Store
Elimination will optimize it all away anyway, so this is probably fine.

>  
> -	strncpy(chinfo.name, rpwwan->rpdev->id.name, RPMSG_NAME_SIZE);
> +	strscpy_pad(chinfo.name, rpwwan->rpdev->id.name, sizeof(chinfo.name));

Yup, sizeof() replacement looks correct:

struct rpmsg_channel_info {
        char name[RPMSG_NAME_SIZE];

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

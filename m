Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C043688
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cs+gUPJ4"
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B72132
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 16:14:38 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bc2c2f13dso819140eaf.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Oct 2023 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547677; x=1697152477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irJXSE0omX7Ex5LSZzNgKfqZeUDyCk8wvHecGIiPTPc=;
        b=Cs+gUPJ4qQLS5V+jWRjdw5/Dtz7zVJChF5shjDXymHNzsPAd4o6Ql5FRfGr7i2DBAv
         JkIyIeLQnuOUKUiESy0v+Vz7gTVnxYM6RoEEtuWSf98RrWxVK1eQhA5TPWOnrBieTDDj
         zZhPEoVHMgkVS3QEnGLRTBCHsGR/aExiLAMLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547677; x=1697152477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irJXSE0omX7Ex5LSZzNgKfqZeUDyCk8wvHecGIiPTPc=;
        b=t3LQEDEYi94YEDiDFmFlACwt5dizOekZx7ASalf0RVxtcpbuv6fu0Q6Xr9/gMrmGxK
         zzlTVldtKCKa1Tm4IrR125ygpLYr7Fx1uXMgII4epdJBSY0flwHg1V8TZr+daYbTnjkM
         SXQT7OBvzcDksMa1X90pi47tzwbzRitPWOO9Wh4nRTLX/HAJMpaQefq5GThVmRnhRpxQ
         adlakmjmlqNxQMwlhglsNKe1ImaR8GIKs1i4jYmpyC6LP411IJDesNs3RIBmOAIfJAML
         l00IMWi3oh03nvH3zwz8T+IbBuhxYbOqf0fhPTq820Vm3h2tVP6Xu3j5mBm9tH2+yvZ0
         bwjg==
X-Gm-Message-State: AOJu0Yx5JCov52WRoooKqOWvya8ML2v/LqAcUjr0zu8IRYlTctXkRaqA
	d4sQFqy1GIjd/C+HGHBq57+HbA==
X-Google-Smtp-Source: AGHT+IHBOijir4biZsLjBKOWnhShZC2IeLyv1yORJ7HB6ckpE5kbk4Cbl0nN0LtKeofidT5uyC7Sqg==
X-Received: by 2002:a05:6358:8824:b0:143:7d04:36bb with SMTP id hv36-20020a056358882400b001437d0436bbmr6454599rwb.6.1696547677527;
        Thu, 05 Oct 2023 16:14:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090abc8500b0026f4bb8b2casm4138869pjr.6.2023.10.05.16.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:14:36 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:14:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Derek Chickles <dchickles@marvell.com>,
	Satanand Burla <sburla@marvell.com>,
	Felix Manlunas <fmanlunas@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] liquidio: replace deprecated strncpy/strcpy with strscpy
Message-ID: <202310051610.01453F60F@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-v1-1-ab565ab4d197@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 09:33:19PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as drvinfo is memset to 0:
> |	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> index 9d56181a301f..d3e07b6ed5e1 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
> @@ -442,10 +442,11 @@ lio_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>  	oct = lio->oct_dev;
>  
>  	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));

struct ethtool_drvinfo {
        char    driver[32];
	...
        char    fw_version[ETHTOOL_FWVERS_LEN];
        char    bus_info[ETHTOOL_BUSINFO_LEN];

> -	strcpy(drvinfo->driver, "liquidio");
> +	strscpy(drvinfo->driver, "liquidio", sizeof(drvinfo->driver));

Yup, this is basically what FORTIFY_SOURCE will do automatically to
strcpy().

> -	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> -		ETHTOOL_FWVERS_LEN);
> +	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> +		sizeof(drvinfo->fw_version));

Yup, ETHTOOL_FWVERS_LEN == sizeof(drvinfo->fw_version)

> -	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
> +	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
> +		sizeof(drvinfo->bus_info));

Yup, ETHTOOL_BUSINFO_LEN == sizeof(drvinfo->bus_info)

>  }
>  
>  static void
> @@ -458,10 +459,11 @@ lio_get_vf_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>  	oct = lio->oct_dev;
>  
>  	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
> -	strcpy(drvinfo->driver, "liquidio_vf");
> -	strncpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> -		ETHTOOL_FWVERS_LEN);
> -	strncpy(drvinfo->bus_info, pci_name(oct->pci_dev), 32);
> +	strscpy(drvinfo->driver, "liquidio_vf", sizeof(drvinfo->driver));
> +	strscpy(drvinfo->fw_version, oct->fw_info.liquidio_firmware_version,
> +		sizeof(drvinfo->fw_version));
> +	strscpy(drvinfo->bus_info, pci_name(oct->pci_dev),
> +		sizeof(drvinfo->bus_info));
>  }

Yup, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

>  
>  static int
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_ethtool-c-b6932c0f80f1
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

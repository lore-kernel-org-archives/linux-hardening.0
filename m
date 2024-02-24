Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03293383
	for <linux-hardening@vger.kernel.org>; Sat, 24 Feb 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733371; cv=none; b=kIxT3qXBO2Oew3+NlwVTcoF2Jr1HRXADHdmxiw1ZQohO6k7UfOANBog2RXHiScOGAEsB10Zq0AkotUH+hQuJ964qQavcMG0gpk/SLTF3RCosK41ZmOYEZocggv48cwSiHmy/K6nOuI9b2ZtiBoEjc9chg6Q2SAd//UUwrK1Un5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733371; c=relaxed/simple;
	bh=B7Dv5dmeACyRpOSQW8ispbxs2jmSkERBItx9SEjQyHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMHFwzGOOcen3y+JWn7V5iJVxYSNOxzCrZcNVmJhnQdN4GdTyQJ1dw7s9jDac+ltSERW/RUt6cB9EZXvtBdNBY3/tGd2FNlc1sUDzngOOS66Lf5d72xxypIjBfkb+ITEuTtgZQxz8mDC5tMB0zXM1j+pX8IZUUIj0NYE9/DpIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQnOAltR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQnOAltR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1214523a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708733369; x=1709338169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnDYUmc3jpobh2TN46WwlCu2ElQF5tI8PklWkNI35oQ=;
        b=XQnOAltRmIQNFvE9xCVEJIxnaWSDoxQn4i8h14y8l6K8PKJnPKR9cVYzWYg+Zy5ZQP
         axSy5kWaZPd3MWGEdk9+zFajJFGGhIYkOg3JQMc17uykhMZlm/nCSIDXtdIc5mC18EK1
         kUAKzGgmMeSb3Q25XV167g3BgfhV7UyG9CX2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733369; x=1709338169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnDYUmc3jpobh2TN46WwlCu2ElQF5tI8PklWkNI35oQ=;
        b=nYSqf0NtGgXypemwCrzQoKzm2BrH7JvnN9RemZXvJk0H249pQNxdxu/AghnR79Ah16
         E0iEfrKHgcNJ2/SejMOL+5vHWW7YExcwvapQ3mm+HP+0kTqqBybjvYVkElwXe03RUtVF
         1yfUlHDtJP+p8IsT2jCpbv8Ixniw2pzTnNhkZX0rTkV4FvYTXR8Xh2126HdTO2fOCuR0
         m13FSVYdjqzvY/iHchP1pzTuAtXVObJKcr6unAYQHp0b/0Bw8ipu8krgwxLdDcDqCEHE
         4rl4ZiMJaxYlenZeXqCG2NF5L7CMhtt1X/d0VpeQ00Y+l3mU7a1yLMUhJGGmQFKMEVKm
         pRSg==
X-Forwarded-Encrypted: i=1; AJvYcCUiA7sXcYPaAvwtIcefzPrdL5krf2Dqs4Bz6WAacl7nzasYiw6WJrvOlCpkrz/r/3fD4D+waZiJJvJUt24EArb+kND5djCnR9LIEuInZZn6
X-Gm-Message-State: AOJu0Ywhz1Pqh+7hddugfQIiEH2HJnzAJFcP4deuqtKD8cHfJK3tDzNr
	GeEWn4suCRHOpOR2HNad5phkLAJQCuVyIlAQg/oXO0nBtCOx1p7eWlGeKzGf3A==
X-Google-Smtp-Source: AGHT+IFKfPECqsVhmrrNx/vGtyxZh4W0YZoCA9sgWVucX2CWOw6y+KPjncpxsZNQm/QJeAE5gD/R0Q==
X-Received: by 2002:a05:6a21:789d:b0:19e:3a94:6272 with SMTP id bf29-20020a056a21789d00b0019e3a946272mr1623552pzc.44.1708733369463;
        Fri, 23 Feb 2024 16:09:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a63fe17000000b005dca5caed40sm59589pgh.81.2024.02.23.16.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:09:29 -0800 (PST)
Date: Fri, 23 Feb 2024 16:09:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 3/7] scsi: qedf: replace deprecated strncpy with strscpy
Message-ID: <202402231608.37D9DCCA29@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-3-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-3-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:08PM +0000, Justin Stitt wrote:
> We expect slowpath_params.name to be NUL-terminated based on its future
> usage with other string APIs:
> 
> |	static int qed_slowpath_start(struct qed_dev *cdev,
> |				      struct qed_slowpath_params *params)
> ...
> |	strscpy(drv_version.name, params->name,
> |		MCP_DRV_VER_STR_SIZE - 4);
> 
> Moreover, NUL-padding is not necessary as the only use for this slowpath
> name parameter is to copy into the drv_version.name field.
> 
> Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
> instances (one of which is outside of the scsi system but it is trivial
> and related to this patch).
> 
> We can see the drv_version.name size here:
> |	struct qed_mcp_drv_version {
> |		u32	version;
> |		u8	name[MCP_DRV_VER_STR_SIZE - 4];
> |	};

What a weird length. :P

> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
>  drivers/scsi/qedf/qedf_main.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> index c278f8893042..d39e198fe8db 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> @@ -1351,7 +1351,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
>  				      (params->drv_rev << 8) |
>  				      (params->drv_eng);
>  		strscpy(drv_version.name, params->name,
> -			MCP_DRV_VER_STR_SIZE - 4);
> +			sizeof(drv_version.name));
>  		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
>  					      &drv_version);
>  		if (rc) {
> diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
> index a58353b7b4e8..fd12439cbaab 100644
> --- a/drivers/scsi/qedf/qedf_main.c
> +++ b/drivers/scsi/qedf/qedf_main.c
> @@ -3468,7 +3468,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
>  	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
>  	slowpath_params.drv_rev = QEDF_DRIVER_REV_VER;
>  	slowpath_params.drv_eng = QEDF_DRIVER_ENG_VER;
> -	strncpy(slowpath_params.name, "qedf", QED_DRV_VER_STR_SIZE);
> +	strscpy(slowpath_params.name, "qedf", sizeof(slowpath_params.name));
>  	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
>  	if (rc) {
>  		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");

Yeah, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

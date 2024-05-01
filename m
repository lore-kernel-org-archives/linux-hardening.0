Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171A1474B9
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590934; cv=none; b=Or45qq2uV+STaiR9Ixou4XnYuJI0jjiBHV1C+W0LxKAQeBSOqI/pQRDG7VAcgfFameJiPNrMpzsn7oLnnOBQLv9yzbPlrjyPs1eYNsacfKZVL7jrFc3vo7n5tRRuc4xcthvl4yseu6lJU+mSh73YP9+5gK8OsqfAOMO3FtSPUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590934; c=relaxed/simple;
	bh=FjDFufbsvnrKVpq/d3f57SbbkDccuVf6Mo7zLPWNI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXAatIXNGwFEJ7rQKS2EPmB8BuJ4kKjsr2lAYE58VY1cUu9jxRy6e1+wsaMsCLsHwdaKxSlItRhVVgPIbV5O0PC/muAiWEbp0zYPTtoINPcKaR1MZcMv6Dl8nG+09JpDI87AcSGau7gVi5lcHqSVhvkKdXSZxXNJxo9z8YvwaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmhrKOGP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmhrKOGP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecec796323so6814826b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590932; x=1715195732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=JmhrKOGPNOqzHr8k2ATuVWV9FcWJ5q0nf6hFu8OGHjzWNdlwoQZs60KS6TQCNuqRw3
         iNooqKTSGhjXNpn+4/uw5iJgXQe6vOLFZXXxa9eZHKE/FB6B2PCYJ/tlvS+mnB0mGtV2
         ca2z7FQT16EvzATAzO0PKBAfY6PFOlohuX2D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590932; x=1715195732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=cQpaPdgh7JcsvmJXDaEGzqxCWwZ/RI7vHDFly/EEL42GvHCGdlEoeEtoIkNJuiaw3/
         qSJYhC41lgUM5fZVEA6fB1AqG4AL2u36zaS9tD+6TAShknGnjlA85Ee8NPpMpQaVhl3Q
         aJdqN/z/wmjLWM2Xykk8agHLAcc4FNcRo5aVf01lu3GN0uBGSlbdl1deHYVHIxwpMOiV
         zms4Br9ngwWfdNGksVs14lyEd3sB5ivu3HFGnL2ODmE7URrZpBAbslYveTQvhgN3GPKM
         rEMlWjh2NbH/cO4N1bKxLZtWHcAPmaQh0GNlJ3QnwX/wtdLH2NLf8/S7Gs1FO831BI1k
         o3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLhvr1o3Az5p9owiZjOy34ccz82PmrJI5LL/XqXJxIv6S5foEkiQp+vTdl7jij4psMc+/aY4TKW9RNXaeZRbP9UgOnopYjNWMKvRpoDm3
X-Gm-Message-State: AOJu0YzQRtn29d9vP2Z4aXHQmnZP3DgDw+9PyOvrYKFwbq99ba4BPx0t
	548fsDNU4hZQNmZIYD+TVJxm/XFhUMH2X2wqEHLwxVQktNFMaRIqadovWNuSBQ==
X-Google-Smtp-Source: AGHT+IEha+gO+FpGkm9o8MQRL+GDzeOY8CJgsWHInozyoylrwPFagTvr8PCPZBBqlxdqKOVB+3C9lA==
X-Received: by 2002:a05:6a21:606:b0:1a9:c80a:bdcf with SMTP id ll6-20020a056a21060600b001a9c80abdcfmr3454424pzb.2.1714590932324;
        Wed, 01 May 2024 12:15:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b006eac2a25631sm22896185pfm.129.2024.05.01.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:15:31 -0700 (PDT)
Date: Wed, 1 May 2024 12:15:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_sync: Use cmd->num_cis instead of
 magic number
Message-ID: <202405011214.EB46DAB416@keescook>
References: <ZjKAyg2bZNyTcT+C@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKAyg2bZNyTcT+C@neat>

On Wed, May 01, 2024 at 11:50:02AM -0600, Gustavo A. R. Silva wrote:
> At the moment of the check, `cmd->num_cis` holds the value of 0x1f,
> which is the max number of elements in the `cmd->cis[]` array at
> declaration, which is 0x1f.
> 
> So, avoid using 0x1f directly, and instead use `cmd->num_cis`. Similarly
> to this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZivaHUQyDDK9fXEk@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 6e15594d3565..af9513f3c451 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6559,7 +6559,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
>  		cis->cis_handle = cpu_to_le16(conn->handle);
>  		aux_num_cis++;
>  
> -		if (aux_num_cis >= 0x1f)
> +		if (aux_num_cis >= cmd->num_cis)
>  			break;
>  	}
>  	cmd->num_cis = aux_num_cis;

Yeah, good idea. No need to repeat a hard-coded value.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F538D
	for <linux-hardening@vger.kernel.org>; Sat, 24 Feb 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733142; cv=none; b=Jp3J913dmNWOf/5eTNx5QOchj8mrVFugb6X6NcBBb/HGtD/Ibtj+mXdKApNxviIbVKp74PcFhDBjdYleMaDOW/nwOGGRQOQjS1FYX+9QmIsRQDIptqSnTreoGA2PvpDHIaS1RKkAp4DtdtQkkHMKazMfLfCQK3hMGdYAleQBJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733142; c=relaxed/simple;
	bh=BtNLLDRfUzf0j5Xx0MzJGDSaQOP9BLR490iANSNKg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Raab9Q9X8WfhC2Y65UElfJxOJ8dkxVS/s1mbuHSw8wja3YLVXhJtQkFWM8mvz+ExshBCGKtT0swZ5L0UrBcu5yun9XCuED+VE73XVEokMPTpgB3zI0Em3nr7XOs7YtGlj1O9krzJfjnErgEaoxujBgnXQMKcmyxwN6pY/Xhtjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h5dT+U2j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5dT+U2j"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4d869b019so831606b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708733140; x=1709337940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISFcMVB4Pi1paX6ZB9XWvqasqvLqqrENosxnYhDGUTM=;
        b=h5dT+U2jOHgOh3n6I9Ce0rEW+mNzvHrbQUjqc+yCvqNMMG8bvW2as2dZb4mNmAQAPc
         MAh8dE8aRop4mHXczQP83Y10OjSlouO8niFtdvwjZEfbML0vHWv+H1KWam1RyWscDCjk
         hMsooris10osvVDd7CqTdxeqtu+IYeQhLtwT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733140; x=1709337940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISFcMVB4Pi1paX6ZB9XWvqasqvLqqrENosxnYhDGUTM=;
        b=kq88pis3QgNshkPP3s3rejXGmEpOjaCwSyBDwR43ZfW+esVrDwm9qkT5uPLbG2+JZw
         47yFef2pp6mZ6/u3V12RUkVUmviPiExNY+FhiiipG9yxWojFzFdqoUIai3AcAmY7a3pr
         mAY0EL3pYLDSON0F73opkFoVY9m9NpVhcJkbjEn733jmuIwwe0soGVnXM16t3ZJwhgZl
         M3MLWGG6zm4a/q5XtIqeFvSUjVOsgJfucq9Su76l35GJ8OBovQGs15fvmGGCKt5X05CP
         vS4WcLxHNmFiYdp76yzcJ+uyaFULp36AXSlfulXkGRtZjmiTUYolNfLWSMOYm8h9j7Gm
         LRjw==
X-Forwarded-Encrypted: i=1; AJvYcCWBAAv4MH39ugBmkA4LWUSUqNchDTTCD0LcVN/b4xwgLX/SpExXUXwBZr74n1BXeYet3KtHlpHSy1DvKBkTkfwNYje6Vx3XY1ZA2ByRWBCs
X-Gm-Message-State: AOJu0YxhLWkgmqsrY9p2/OZsI0Holbq/1TptwMLqjA81fj8rHP8UdebJ
	7ahwiE2hfiiauphJ6jyGSFwW0QP5X4o0bj3d/n53CSvnWYthljrhe0lqsIH/VA==
X-Google-Smtp-Source: AGHT+IEYGoG8kuObm+K6CkUKu1PoKg+VjgXJU4uccu5PNgmBbCgBxkplrCyKKdgTzkD1guBLILMifA==
X-Received: by 2002:a05:6a00:9396:b0:6e3:b7cb:b105 with SMTP id ka22-20020a056a00939600b006e3b7cbb105mr1558704pfb.18.1708733139964;
        Fri, 23 Feb 2024 16:05:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w67-20020a626246000000b006e25d43630asm46314pfb.108.2024.02.23.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:05:39 -0800 (PST)
Date: Fri, 23 Feb 2024 16:05:39 -0800
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
Subject: Re: [PATCH 2/7] scsi: mpt3sas: replace deprecated strncpy with
 strscpy
Message-ID: <202402231605.3DABED3@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-2-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-2-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:07PM +0000, Justin Stitt wrote:
> The replacement in mpt3sas_base.c is a trivial one because desc is
> already zero-initialized meaning there is no functional change here.
> 
> For mpt3sas_transport.c, we know edev is zero-initialized as well while
> manufacture_reply comes from dma_alloc_coherent(). No functional change
> here either.
> 
> For all cases, use the more idiomatic strscpy() usage of:
> strscpy(dest, src, sizeof(dest))
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDE339A8;
	Sun,  2 Mar 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932983; cv=none; b=U6X1+aXW8l1Ua5Zh9p/G5MJFlfF9B0xcykeGXK3rIvMfuxv2dFb/uNJdtSje5S0yo97kYRKkkvYp9q74qz1CqEQMadtWNPlvDdQoGcxnymMlTNlr730pciPIHJwOK7YoTigOYAKc7sVgYNmutK+m44UYey5KKfTCxTDIlbz/TnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932983; c=relaxed/simple;
	bh=PKwQKCnzQxLCormRajg+fE/7G6f26nk0otMh6ZrCHZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ8YREbCIzxtSymkleB510r/LtQuFjiWa5B9TUKufMcyV/pkwMtxexiuE2qgIXyc8pKnP379I6Z7hUs1eTegQc6n86LIn51cle8a0AGR7Q0dAwZ/joKVt2UdAvZMvkzZdYdrQkQVX2u4EMu0h/nUm9ZEl4if8/8XNmIRgja+K0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3pHjfQG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3pHjfQG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22349bb8605so70224395ad.0;
        Sun, 02 Mar 2025 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740932981; x=1741537781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dijfl36fdLRwpTIccWWKkVNKprn4Lw0LAYubF3gjRP0=;
        b=d3pHjfQGP2YWe8/Pzb79Nq2iIkhpOj8YxxfejXN3ZqEuj7TbpqNCU4Ztdd9touAeWV
         7F6H3FdLuMsx8lhnx3nk2hCfQ6cnmMxB3L6DSZSCTrJvvQfxaLWETEApjFzP4Vj59Q7r
         /QS3t+YKo6JnlyZMitt4iZkl5GVtnz1qTzvyuK/kBTOXbzUVFK6n43jCFla3MzxG4OLI
         ohHsOx/urLmKFVw0e1aY67zDYs6BLj5vPN/xAH4uvNSJ9z1jSdlqlSWr9W1K/P+hCPqc
         WNO1Iw7Z3IZCN0v8jV8O/b/8R5xurhTW7v7DBandihNiA8gMQszO1RfaJTrrBakY7+bI
         frcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932981; x=1741537781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dijfl36fdLRwpTIccWWKkVNKprn4Lw0LAYubF3gjRP0=;
        b=JnwBGkZdMMFZh87gXNl9OjKehLLbXMpM1wlY/nfhCfR0uHQlKQ1VNJb/hDm4RS4xj8
         NO9UbCXTdnxgQ4/zqysOiSgklK18yFUYiioNGHwxBGqP9oRaEZvuyeocWV2zQBE+0s/F
         mOr/PF54Zdu07MCCME312JW1obKJMX0OLoU4KMPHqnJEEQHC0lHD+soOgC3xUnLUffY6
         ChqTX6zdmhbj5HrP3l8m9UHtEGgRCVdWpxidunnLk4bNn+MZs1cCn8jRfvDErhxzP9c0
         rfT+MX73P8PeTqilURjLd+ik9yX6eO7zY8F37Q8P10rA4wk0h0ENrWeDBc08/GmEe33I
         JM6w==
X-Forwarded-Encrypted: i=1; AJvYcCU/3IZzIJgIyMaE78eyeDPzLoTMAsqjnnJ/ducHBZYhM/dT375qSAZ/AffAtg4MHey5cvI1/Z03XiyCdS4s@vger.kernel.org, AJvYcCX5bKoy4pCs+5on8j6p1q0MpHrTAXpJ4NaSvERtnnp4xKXSecr5nou2TWf262bdheTwNfC2qHmidtFuAAyNbao=@vger.kernel.org, AJvYcCXiC2ir7rr7u1gvq0xwFH0WbU/wi/5nH/1t3VDOmh/QdI/xHqU2sH/Ti+SBBsJmRVbr0VM6LuYYi2u801k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDDLJKAjST3LmjlJ1ev0xQtbitHyf94jLu708oqVCUSImYHoz
	/vLluN4oBXKj5LQZJ8M20Iyx4C9cibrIcDgmY/jEu45gT7fgWJda
X-Gm-Gg: ASbGncvJs1Xsn1DSOzEjW2k8heYXOM+Seg37cCwHY39qSuHKoP3+JeKKmrD36vA85NL
	hy2T70yB6n5Dcnzvna0PNElF8AnQ2APHoUL4rzlEQGMoDNslDTer+9L8X1Ot9hLnpoqjGr4ACB5
	tIlUbwEECJiz77qFsrOSUlX6FXrHmRDoDOGgyb0vUywyATkNbd0DhiswAX26r3qSjUrZWj6PkZu
	4Rxq0Blq+jIWWt6p9ynUNFzAGrjaaLyryOKnCxhAeanMClFo8ICE0w1Jen8f3tmcm4S9hVAES81
	FWtIdOrpqYJaeCFS7diWqvYYzAHFMFveBBiHBi3qPf1ENT12g4b5/0CsVA==
X-Google-Smtp-Source: AGHT+IF6hF9DfgJ6mhdNwGPBvt/piqg2Vn2ngBFN07q2c805TexmxJLP9SkGMhbT5HAO5Hpm+YqGPg==
X-Received: by 2002:a17:903:32cf:b0:223:66bc:f1e6 with SMTP id d9443c01a7336-22368f61b58mr189470385ad.5.1740932981456;
        Sun, 02 Mar 2025 08:29:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d33ecsm62676175ad.37.2025.03.02.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:29:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:29:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Patryk Biel <pbiel7@gmail.com>, Ninad Palsule <ninad@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/core) Replace deprecated strncpy() with
 strscpy()
Message-ID: <f5b67a83-205c-42a5-a59f-cb5df877df99@roeck-us.net>
References: <20250227173936.7746-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227173936.7746-2-thorsten.blum@linux.dev>

On Thu, Feb 27, 2025 at 06:39:33PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy() instead.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied.

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 787683e83db6..cdde8b03a6e9 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1470,8 +1470,7 @@ static int pmbus_add_label(struct pmbus_data *data,
>  	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
>  	if (!index) {
>  		if (phase == 0xff)
> -			strncpy(label->label, lstring,
> -				sizeof(label->label) - 1);
> +			strscpy(label->label, lstring);

I added a note explaining that strscpy() uses sizeof(label->label) if the
length of the destination buffer is not provided.

Guenter

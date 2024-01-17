Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66A2556B
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jan 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524673; cv=none; b=oW2zo7F2OfM3rDHlklWlwWV8VeDImxQP+Hi5CZjeZb1qBEhJ1uXbJgolpDCrDDCaT5f/9dRfTn+XjvClmt1gpqzPjijtZmsrUbNmgC575F8iKC5MPYMO0CKsIg/2VwSTvK5yg4HxAZGcxXOzSFEO//WCVYdVlcbQOFCxmQQjPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524673; c=relaxed/simple;
	bh=KEO+rHwBc2shj6H6ATYkN4mc8w4293/sNHJG3mL1qhA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=nLEezECdNyPj59g6IZNvwSSeRAog687eaavm1LjaWdaHo4P5dXJk+xFB1Z2ke7MWvvKdCgG92W5IfzJ2Tu0H7+34ck+8LVj+waG+UhkVSyeMzT0CKzqsooayeAxFkPLaQ3yZCyriseSfVqIxJbiMP/pwZQPomnBO5WOG/ZjUj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UXnHuZU1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXnHuZU1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d40eec5e12so97335545ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jan 2024 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705524671; x=1706129471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kx/TANifPOtY4pPL6VukQfe4dLtrXERVJTf79pfe/6Q=;
        b=UXnHuZU1FeBYinM64Q/OMb5UBevLFcUxkhPsMjKqsByNfezM6FioGUaCGtUV/7YNIw
         6kAspVzNbrz6aM/w+ExFTe3FK8FpF1HDYbPzYfmGThkU4QmyDITK2kh/2yRzcVPqbKwU
         Iibv2xBxxgBfM8bGgrs2ivA1DKc9vPHSXUong=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524671; x=1706129471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx/TANifPOtY4pPL6VukQfe4dLtrXERVJTf79pfe/6Q=;
        b=kCVhpCYUtCQAZR+WIGdwwng743/UyhdbsbfNdbWeFgy2cUmKqATtW1z6J4Li7Ip2GQ
         vatQxdgildVYtGc7YgxS7NUkGffVGO0p0rfXHNCxqr9HaS7ev8vlOxa/tXMTBJMmV3uV
         1sO4S8fha6Ewm5/0oEDFIOzDowWo/8uzPR9/IUCWoADpxlDrZ3P8f55C1/wKWHXPv4iI
         dWFMRdEF5LSZhEsOq3Ki/SszjhGidK6k7ciKO3cTdwPnHRLkLmBN80tk36S4tHvlf80V
         M20RW5qIZF3XQX7M3AlNCKcVFrwRwYxTQXMhanngQXXhj8Zqrzu6STJpVFDgYJyvaMnL
         vixw==
X-Gm-Message-State: AOJu0Yx3a+OiqiECqomteISIxjQlibq8FFyGqC+y/6PzR55SyI0EcieU
	h2jInwwnHUCUqfU8ZqapUx8elVX3BaPo
X-Google-Smtp-Source: AGHT+IFBazjvV2lR/bEVLRw5mnikVJ9ZApUSi3AOIFGvEer5uS7MyrKkE1kyrimbiHD2zhHX4671mA==
X-Received: by 2002:a17:902:dacc:b0:1d4:69a5:edbb with SMTP id q12-20020a170902dacc00b001d469a5edbbmr11788701plx.48.1705524671293;
        Wed, 17 Jan 2024 12:51:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le4-20020a170902fb0400b001d6f2775570sm76695plb.209.2024.01.17.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:51:10 -0800 (PST)
Date: Wed, 17 Jan 2024 12:51:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Lu Yao <yaolu@kylinos.cn>, linux-hardening@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: Resolve compiling 'security.c' error
Message-ID: <202401171236.5175FA9FA9@keescook>
References: <20240117014541.8887-1-yaolu@kylinos.cn>
 <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>

On Wed, Jan 17, 2024 at 09:32:33AM -0500, Paul Moore wrote:
> On Tue, Jan 16, 2024 at 8:46 PM Lu Yao <yaolu@kylinos.cn> wrote:
> >
> > The following error log is displayed during the current compilation
> >   > 'security/security.c:810:2: error: ‘memcpy’ offset 32 is
> >   > out of the bounds [0, 0] [-Werror=array-bounds]'
> >
> > GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'

As an aside, Ubuntu 18.04 went out of support back in June 2023, and
never officially supported gcc 10:
https://launchpad.net/ubuntu/+source/gcc-10

That said, I still see this error with gcc 10.5 on supported Ubuntu
releases. I'm surprised this is the first time I've seen this error!

> >
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'm adding the linux-hardening folks to the to To: line as this has
> now come up multiple times and my best guess is that this is an issue
> with the struct_size() macro, compiler annotations, or something
> similar and I suspect they are the experts in that area.  My
> understanding is that using the struct_size() macro is preferable to
> open coding the math, as this patch does, but if we have to do
> something like this to silence the warnings, that's okay with me.
> 
> So linux-hardening folks, what do you say?

This is a GCC bug -- it thinks nctx_len could be 0, so it gets mad about
the array bounds.

> 
> > diff --git a/security/security.c b/security/security.c
> > index 0144a98d3712..37168f6bee25 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
> >         size_t nctx_len;
> >         int rc = 0;
> >
> > -       nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
> > +       nctx_len = ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(void *));
> >         if (nctx_len > *uctx_len) {
> >                 rc = -E2BIG;
> >                 goto out;

Please don't do this -- it regresses the efforts to make sure we can
never wrap the math on here. We need to pick one of these two diffs
instead. The first disables -Warray-bounds for GCC 10.* also (since we
keep having false positives). The latter silences this 1 particular
case by explicitly checking nctx_len for 0:

diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..af4833430aca 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -874,7 +874,7 @@ config GCC11_NO_ARRAY_BOUNDS
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC11_NO_ARRAY_BOUNDS
 
 # Currently, disable -Wstringop-overflow for GCC 11, globally.
 config GCC11_NO_STRINGOP_OVERFLOW



diff --git a/security/security.c b/security/security.c
index 0144a98d3712..ab403136958f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -793,7 +793,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	int rc = 0;
 
 	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
-	if (nctx_len > *uctx_len) {
+	if (nctx_len == 0 || nctx_len > *uctx_len) {
 		rc = -E2BIG;
 		goto out;
 	}

-- 
Kees Cook

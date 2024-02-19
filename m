Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E0524D9
	for <linux-hardening@vger.kernel.org>; Mon, 19 Feb 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378261; cv=none; b=nTgSCYMAypPFGY8HEngQKpP1Yo8by3ywdCEYCBbyaQ9kAhVKGfP0n1GyNBtnDdnW1PxPZaxJi2DVArhy97dTv1+XR3R1jxWIDoI+Fgi+Io5iSbSOEqzYfS/cvcUyZh4qSaTHgsZGZGqFncecH/BFtFcuT53bDgzWveG9El90jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378261; c=relaxed/simple;
	bh=aoPIAPeIcMZ3O8NtO4F6czhuBJaXTuwiOia7AEB4YqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbBi2VwEftehf16j5IaYOY4jPOBnRjMwuY8qBNp3iMz/xSfdh5kWGV28esRLr6UgCAppeQYi6XMhpEyPHeosCtuGTjWYYQYupevn/bkP3/1WnU0cKPsV8u1d5CGI5SxXVU5KTICh7umXP4cl5nitoIFr7dX/EAcVxcvJUII+I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VO3/rqEa; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VO3/rqEa"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595aa5b1fe0so3154164eaf.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 Feb 2024 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708378258; x=1708983058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvvJpjFswKgVoEBvb+c2q57/k2FJfy6sWagye6yyVc=;
        b=VO3/rqEaNssd4CqzfdZFhtXWUQgM9bor7ZFWJMTNgyAJqmENKo2EYHF8SQYasnFe0w
         ohnxB1gP4qXNkSpGUHemAybnaspPN8pRBy9uipqUQ6rxDbe8kovbMSTtbfCH3EQQbx2L
         g+MDB2YOR8jBmediDxnH8UFZyGzFNuzK72XbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378258; x=1708983058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLvvJpjFswKgVoEBvb+c2q57/k2FJfy6sWagye6yyVc=;
        b=xL3FR4IF3wuDvWQiUq8YbprGnAoO3bIoNeouUXEI0sczwZi8c9lFPIKntz9AJvil5O
         UUWiHSaUSDK03cE8AvDWZZydPTTeXZ/FDx9vT9Bj6VZMq8DXX0h+HieP3DpYK81wPYFs
         QqMguTmp5kCmthU50nLlGOBr52E3Gqmk7CwbrSdT3Tp2AIMp2DuxIi2p+pU6Z+5GuIsi
         C/aHOQyXGHS9iM00gM/M3pGB7gtJDh/x8HtvFsxcGluQXUg5YobogpalCbVS+wbDnp9k
         xyNlAGdyUQcZ4lU1AZAmOqlJMGhDMMEToEOKrqcBXx3RAnU78veoZRBBtDqhHFtD1tez
         0OJg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2c1mfqlvPEnBoZLT/3uQqqOjVlGmC+0M/tc4wdQglOuifcogDrWVZ420GHBlF1yGyb7lbka20K7JZAtrIcnMWcOfPGGCXRmA5BsTlKC+
X-Gm-Message-State: AOJu0YxkKPOt8rdjKnPBD+MKKcjihjDt1wE651T/smooeLzZS1MVzquZ
	nfl1tw4GSL4BVMn3uVxVCaQ4+afClOshMKxulP2AGHn6lhcH0SkQk18JcQdgRw==
X-Google-Smtp-Source: AGHT+IENMyYwE8lEUHnaBTUNox2l0l51uXNOHgYriL2vmu8euJMWrvHPGQ3xwxdL1Kwl7EWjX6cntQ==
X-Received: by 2002:a05:6358:d26:b0:17a:c976:c143 with SMTP id v38-20020a0563580d2600b0017ac976c143mr15279982rwj.12.1708378258679;
        Mon, 19 Feb 2024 13:30:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm2065885pfv.132.2024.02.19.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:30:58 -0800 (PST)
Date: Mon, 19 Feb 2024 13:30:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: James Bottomley <jejb@linux.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <202402191328.8E1A325@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
 <20240208102939.GF689448@google.com>
 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
 <20240219152312.GD10170@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219152312.GD10170@google.com>

On Mon, Feb 19, 2024 at 03:23:12PM +0000, Lee Jones wrote:
> Adding this to checkpatch is a good idea.

Yeah, please do. You can look at the "strncpy -> strscpy" check that is
already in there for an example.

> 
> What if we also take Kees's suggestion and hit all of these found in
> SCSI in one patch to keep the churn down to a minimum?

We don't have to focus on SCSI even. At the end of the next -rc1, I can
send a tree-wide patch (from Coccinelle) that'll convert all snprintf()
uses that don't check a return value into scnprintf(). For example,
this seems to do the trick:

@scnprintf depends on !(file in "tools") && !(file in "samples")@
@@

-snprintf
+scnprintf
 (...);


Results in:

 2252 files changed, 4795 insertions(+), 4795 deletions(-)

-Kees

-- 
Kees Cook

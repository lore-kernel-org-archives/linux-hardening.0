Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981D168BA
	for <linux-hardening@vger.kernel.org>; Sat, 24 Feb 2024 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732883; cv=none; b=bGd5x8ynPWtBhmw+KaWkeY9DltWoXkk0ioilc7zl5812dr7uRU/2XFxHBj7NCVsStw6ZffK05Q+g7xQul/QoQwhl8eQ2CS7ztD++jeYeCqL/fBJ2ji/hNrYuUJgEI9gZzOWm9GZ7Xo8C9HM2T8gcROe1cGzYoDkSsfCL7LlFFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732883; c=relaxed/simple;
	bh=UJWe2ubR9EeG9OLfsfg8jP7GUJZQt+mG036oE86qbt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l14+Ww2iplkB6wZC5w3EK7Hs08prpB4VET7ipxRsSsbfn6ENzAxe2o1n0gV04mH/DBdnT4t9JYxOYQJAS5TD3qLNghmunHIlqrqh+C0n0K6Rb1S3VwlFhdej7K7rf0ZmAinA+Ym27XjoH79AjeYykkLQZO0YUa2A1dlQkx7TWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qj2fsIX8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qj2fsIX8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so1098280a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708732880; x=1709337680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZWnhZfLrYBNGaitWH9PS92YgltdabR+chQohhbMUEQ=;
        b=Qj2fsIX8sW1e/StkitcjAJJx0MgWNLBIfmJjIsKgNU2QEIXFzADkawgHgi46h6iBPc
         B0JxbeYtc/H4pxrtWl7Jyh7yNZEbiAjoG+QlJpRY4ONZ+xj8XvP5y3H+6k72mZuijCnt
         1Y4Wjv5ZoJrQyJcAHfs+7pzcG9AZql6ArTCDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732880; x=1709337680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZWnhZfLrYBNGaitWH9PS92YgltdabR+chQohhbMUEQ=;
        b=bjAK8lpJhNDaUql29bCKYjI6wMRpuKME4EOpVYqotLhVOjk/dCWS/YZ06QZY7SvynD
         3CSBaFQxvJXS8mvhbe4LANMCl18VvpAL+07me66kVUYNdVjevypadNc+o93D0IoG2zLE
         b4/LtNVizDjrfrHW0Gl/npnFqdqOuxIStLkANcLO+9u/IwLWVUQwGCt+NZPUssiZh2tC
         X7qgGm0oLsF1xMaLU5wwyf+Y2nPCHvQKyZlNnFc5eavVcB4P7ulMLmaOYJzB+X5v5bup
         e6fgn3PfTmG8JXfRqoLouNSUcN32mM0RrHkcuaCkGlwGAn4QJ559AuIoTwbL0qcK8K1U
         P+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnILxESBJgc2wBkAkzZlxgywtq4hoec9wj/Fv0GzZ7Hgv3LjNe1EdBV+nyLhfPynWmVhlt8IHlvcGKMYYgLqIqtHTn35sQtsXYbAX2QCK+
X-Gm-Message-State: AOJu0YzXcRIYt+mG9XjsXrRXkj2HVcwkYM9+p/59DFgW64UTWKWtNOF5
	veq8st2BSPtWkSUp/XxTWoUeNgyosRkkqc5mUB7sGLRqOmBRRicn2NhPqk87RogcWfMgnI/z13k
	=
X-Google-Smtp-Source: AGHT+IETYvJa4jCu7s6VQ1h/zjgBKc/QzjFKDXibxNeQ000X1/v877/hoosAzF63YVPEIj4E046yYw==
X-Received: by 2002:a17:90a:4413:b0:29a:56d5:230 with SMTP id s19-20020a17090a441300b0029a56d50230mr1211745pjg.25.1708732879965;
        Fri, 23 Feb 2024 16:01:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090ad70100b0029a71e7ef55sm97566pju.10.2024.02.23.16.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:01:19 -0800 (PST)
Date: Fri, 23 Feb 2024 16:01:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
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
Subject: Re: [PATCH 7/7] scsi: wd33c93: replace deprecated strncpy with
 strscpy
Message-ID: <202402231556.7DBA6E1@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-7-9cd3882f0700@google.com>
 <4a52a2ae-8abf-30e2-5c2a-d57280cb6028@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a52a2ae-8abf-30e2-5c2a-d57280cb6028@linux-m68k.org>

On Sat, Feb 24, 2024 at 10:44:12AM +1100, Finn Thain wrote:
> 
> On Fri, 23 Feb 2024, Justin Stitt wrote:
> 
> > @p1 is assigned to @setup_buffer and then we manually assign a NUL-byte
> > at the first index. This renders the following strlen() call useless.
> > Moreover, we don't need to reassign p1 to setup_buffer for any reason --
> > neither do we need to manually set a NUL-byte at the end. strscpy()
> > resolves all this code making it easier to read.
> > 
> > Even considering the path where @str is falsey, the manual NUL-byte
> > assignment is useless 
> 
> And yet your patch would only remove one of those assignments...

The first is needed in case it is called again.

> 
> > as setup_buffer is declared with static storage
> > duration in the top-level scope which should NUL-initialize the whole
> > buffer.
> > 
> 
> So, in order to review this patch, to try to avoid regressions, I would 
> have to check your assumption that setup_buffer cannot change after being 
> statically initialized. (The author of this code apparently was not 
> willing to make that assumption.) It seems that patch review would require 
> exhaustively searching for functions using the buffer, and examining the 
> call graphs involving those functions. Is it really worth the effort?

It seems to be run for each device? Regardless, I think leaving the
initial "*p1 = '\0';" solves this. (Though I fear for parallel
initializations, but that was already buggy: this code is from pre-git
history...)

> 
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  drivers/scsi/wd33c93.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
> > index e4fafc77bd20..a44b60c9004a 100644
> > --- a/drivers/scsi/wd33c93.c
> > +++ b/drivers/scsi/wd33c93.c
> > @@ -1721,9 +1721,7 @@ wd33c93_setup(char *str)
> >  	p1 = setup_buffer;
> >  	*p1 = '\0';
> >  	if (str)
> > -		strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
> > -	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
> > -	p1 = setup_buffer;
> > +		strscpy(p1, str, SETUP_BUFFER_SIZE);
> >  	i = 0;
> >  	while (*p1 && (i < MAX_SETUP_ARGS)) {
> >  		p2 = strchr(p1, ',');
> > 
> > 

I think this conversion looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

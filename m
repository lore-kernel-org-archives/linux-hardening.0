Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A180BFF
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084953; cv=none; b=TDUC2FVN9P6XwUSQmcrB/m5ftYgBd3pTPHmxuDq/pcDUaYPyod8xVkhVKw7UfbecpOLWChRrh6Xl9RcK42MPHGy2sTa3Z/Us1bEqZP+UI2MD+f+eCs6obaowVW0ShWfKMXVTx6TSQPSaRgsLcRxfjgDjy+hRN5qzvS5mWYlSjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084953; c=relaxed/simple;
	bh=9T//zdrVT2iC9sOT7glYkzNaiJH5cSL6j4l+XgJxSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnxl6xvh0++5TwbFSNy5hfHJyL2aWwnB4MZWDhUeoAHMDtkNdgZkUtSA4vExz4aZaIzC0W2IEEDoSzueJnraRjhVdx34Q+GriwaFXIZvEZiHWiSJSFomi6vYGlMVrl9vJsTNnx7LUx8F1yJ/WF5fMwqz18bX7xoU+gOllATHkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgnOyFgs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgnOyFgs"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2af800ff18dso1321991a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714084952; x=1714689752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQMgEUshXi0n6VyMw97AYUenmOeWDaHW3E9fbmg8+bo=;
        b=jgnOyFgsUPn5I+rh5olPuIruOLXL4kHp0WHC96sW0KkJ9IFARKk0ABaNPBjprHBUOj
         b9gCOFUYD3Soelx6j3i3jijw3xzNkDIz/NLXtQkC0T3D6mEfGdtv9KLZ3DajaAZX01Xe
         14WssIXvPDQNZIiR5NhHTay3r5DmSnMokWjA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084952; x=1714689752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQMgEUshXi0n6VyMw97AYUenmOeWDaHW3E9fbmg8+bo=;
        b=aeCpBlnXlSNYIgCnoNEg6nMFr/rwQJPUGJqQKxTDQtli4Mc9hA/O73qUiN7E9V71YL
         +ubMU7XkQXrCnr6dmgVl59oalbXgVZYUZb/vQ62DjQ/gsGZ5dTIiLq7admyfiyT8Sj8k
         t41uSkXZkZsgeyk2koI5YfFaxTyLwWBA4J696I3OOtglR0IMLFI5hBPFde3Rb4HN584m
         07Z1SjcG8a/N/nCGz2rctnjlGkK0/lo8+TsoLmX4CePLsIMQdW3izPiRiLYW0WtMwkSk
         6iKhO4aRQfPTDf7v4FzyHH+bB3kHzQHE41A966vmxY7Cv4ZibvBPa2pDGFLkZ+wH835R
         0Tug==
X-Forwarded-Encrypted: i=1; AJvYcCUi2+SYi0ROhu9zomBQoCZsCBuXnaPYNCG41rfO2sRHDPzQE2B/dJHEtIPXf/PtKcrjjrmG5wNYgUzMugGHDa8fezIkL8v2iVjtFp8g045R
X-Gm-Message-State: AOJu0Yx6cqYTgvv+AEQ80tzzpmfk9DjvHSYyw62sxtbE9T1yVhF0esVc
	Uu4Kuyf7UD5tjD3vp7nYxnu2Y3YLyZB7RfGdScX7ru+oJ54dwY/j4v1sxUuyFA==
X-Google-Smtp-Source: AGHT+IGiOwEiR2ZvU3hCBIL/uaLOVZwKzUQaJqt9cMHM0i4zfElGPrIWI4AiHuO056FHOxcHNtXevQ==
X-Received: by 2002:a17:90b:4f8f:b0:2ae:b8df:89e7 with SMTP id qe15-20020a17090b4f8f00b002aeb8df89e7mr1054767pjb.38.1714084951948;
        Thu, 25 Apr 2024 15:42:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a531000b002a537abb536sm15111032pjh.57.2024.04.25.15.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:42:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:42:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251532.F8860056AE@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>

On Thu, Apr 25, 2024 at 05:04:47PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > > The /proc/allocinfo file exposes a tremendous about of information about
> > > > kernel build details, memory allocations (obviously), and potentially
> > > > even image layout (due to ordering). As this is intended to be consumed
> > > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > > there: 0400.
> > > 
> > > Err...
> > > 
> > > The side effect of locking down more and more reporting interfaces is
> > > that programs that consume those interfaces now have to run as root.
> > 
> > sudo cat /proc/allocinfo | analyse-that-fie
> 
> Even that is still an annoyance, but I'm thinking more about a future
> daemon to collect this every n seconds - that really shouldn't need to
> be root.

Open it once and rewind? But regardless, see the end about changing
ownership/perms/etc.

> And the "lock everything down" approach really feels like paranoia gone
> too far - what's next, /proc/cpuinfo? Do we really want to go the
> Windows approach of UAC pop ups for everything? I'd rather be going the
> opposite direction, of making it as easy as possible for users to see
> what's going on with their machine.

Not unless there's something in /proc/cpuinfo that can't be extracted
in other methods. :) Anyway, you're offering a slippery-slope argument,
I just want to avoid new interfaces from having needlessly permissive
default access permissions.

I expect this to be enabled by default in distros, etc, so I'd like
to make sure it's not giving attackers more information than they
had before. Even reporting how much has been allocated at a specific
location means an attacker ends up with extremely accurate information
when attempting heap grooming, etc. Even the low granularity of slabinfo
is sufficient to improve attacks. (Which is why it's 0400 by default too.)

> Instead, why not a sysctl, like we already have for perf?

perf is a whole other beast, including syscalls, etc.

> The concern about leaking image layout could be addressed by sorting the
> output before returning to userspace.

It's trivial to change permissions from the default 0400 at boot time.
It can even have groups and ownership changed, etc. This is why we have
per-mount-namespace /proc instances:

# chgrp sysmonitor /proc/allocinfo
# chmod 0440 /proc/allocinfo

Poof, instant role-based access control. :)

I'm just trying to make the _default_ safe.

-- 
Kees Cook

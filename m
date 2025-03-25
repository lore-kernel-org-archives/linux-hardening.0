Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4C1DDC3B
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897724; cv=none; b=nFCPbLD8E/gOFOHB9LxZtPhf4qYVY0OHMn5FJtEF23n77vHQ1zxd+hsrwivMh3ZtqKTm9u9QVMq1NjX6jUnP3unEBAbSPpgFlL6+bCQMA8VDlo8TVlp3X7ReRfJYRRUSRJI3DUNm0RD0js52KUxIAC0+1gapQqL81FhWArc5wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897724; c=relaxed/simple;
	bh=gBxlLT5ivpGDh72oKPJ3CBVf2yMPWUqCIsclGPiI0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/ojOKdut1mE3Hk4OZL3goe3WwnviWuAUN3X5SJrFsfKrCRBCbSFBn77WrwWUupivSS8G7bma7c8AtCVOBN4btZSMoTSLk6wJqQUWa2pLkJjPzcogh+ryKN+JSoj7E/bGE5LYcJQmp2GnbwFBXzQ6+aaWCIiIJY8kbVxpXIdf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fc6lIOAK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fc6lIOAK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so51551355e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742897721; x=1743502521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=Fc6lIOAKpCOraZEvR/fbMV5DPHBT9DVzUJxny4j4iSVPija1FrydvR31VLyl9m0P+3
         st+zmzGmXGZ73QIc3dXalcaw91I5w3P7vT426vY5pUqgLyziJcfoqOdbgodK+8P9vKh6
         2poKQl7dd/2hNfG2GG3wenA7LXBMeIIyOACwJ+eEviS/HHsqvObC7FX5QZ7PwDsX+Wpj
         xH2NV4KxrEtTLzbDlFjxSAs+SxBRrlgSfl3ccvgU+0qneT8Vu/5toPBGhYI2TQvWUr5X
         UiwNQkLTv+lMQGSVrABaVF55REQI17nfgtaAtzXZoZM225/5YsKBN92o01tcCHg2RT0S
         9/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897721; x=1743502521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=Nll8CLJMgdA1DY6F8BmTQD2pS4fcEXMUBaddPqoLwMpHk0Ti54P8DIKqDhYzfk/k0i
         EgMAaUHrLIVKtqviI8/S/dgcHCNjh8BpeBoLewgVdcSPkWOENrPC58DVeP1c/PhI/dI1
         /WKCsqC3h/cch4Q3Td8QPdvGO8qBr1CRhoFNDClmgOuy4Abx4mSpDiZydugi42Nt2Rbl
         XUpDlHjEU9FBldUiwwHqeH+z9mtw/vKxVg9sb2DYUD/pic4Uh4VFY+9NDoTZ7Vg3yCeF
         sNFe3PCzyD9ZEeDL5ysjw8rPTiw2PKFmHMGU9KAb9i6yo73GxVat+LFTthHC5GDb0QEu
         mkbg==
X-Forwarded-Encrypted: i=1; AJvYcCVjBxUvzJjh5j+AChS0TjKu2Y+dYhyPqFLHO4RuqFoWtoEShSeLGCvxeYzrH7t4ezWn4kZhbG6KXE+eqwPquTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0IpWdlyRAN7xRjQMd9a4iDFwuNW59RDv2ecxQCOYcNIk9qzj
	uGdEq53PkSUngoSEkKl/lqfXIhq8HGygmWC1H41mLsXyqNN0xnR4oxjGZ2GkOY4=
X-Gm-Gg: ASbGnctXRF51cIQMGMqnvyhYNhUVRzqqMmBvVegmgDurY+s2YbWLklLEPz1nGItQMMG
	odzs1hKYUo25njDi3RsgwWWCtkTfv02zjYnJJdi7sWlD2Te4jrBDsH7tON+/MF70Mb2L26Q+GX0
	w9TN/hDubXa6AVAJMwBbfDYXsg0K8FvXOg3V/Aaf1guMQtf6n6402g7iwTBMkRVrZokOX7Yz5+H
	kcVrwmg8CwX34XzkTq3u9ivbtzRgBdyov0Fen8FvO/x+fywAbverQuFh0KDR7aPi5KiAtOOg3aT
	nc6EBKZrOu5Ty8z3qbBTD5n3Jur0MBYraspBRMaUhD76
X-Google-Smtp-Source: AGHT+IEHsfS3jwIQd3DXLtKs6BlMXePkgOPcd8GrAW7V3JTw8OOWk8DEnFNJlXsh14KOgVQNsnrCHg==
X-Received: by 2002:a05:600c:4584:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d509f58b4mr147592855e9.14.1742897721087;
        Tue, 25 Mar 2025 03:15:21 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm149735745e9.4.2025.03.25.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:20 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:15:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's
 required
Message-ID: <Z-KCNy7Qu2vFdwVx@pathway.suse.cz>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>

On Fri 2025-03-21 16:40:46, Andy Shevchenko wrote:
> This whole series started from a simple fix (see the last patch)
> to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> (note, that CONFIG_WERROR=y and all warnings break the build!)
> down to a rabbit hole.
> 
> However starting from v2 the last patch doesn't require the first
> part, I prefer still to have them since the functions, while being
> _binary_ printf()-like, are still printf()-like. It also puts in align
> the tracing stuff with the rest and fixes the wrong parameter value.
> 
> These first 4 patches are organised in a strict order and can't be
> reshuffled, otherwise it will produce a warnings in between.
> 
> I believe the best route for the series is printk tree with immutable
> tag or branch for the others.
> 
> Alternatively the first 4 patches can be applied first as they
> are pretty much straightforward. They also can be squashed to one
> (as the same topic behind), but it all is up to the respective
> maintainers.

The whole series looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to push it via the printk tree. I think about doing
so as a second pull request by the end of this merge window.

Anyway, I am going to wait few more days for eventual feedback
or push back.

Best Regards,
Petr

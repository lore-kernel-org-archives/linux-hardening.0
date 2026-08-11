Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25C40BCAD
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484352; cv=none; b=lmNS3uSCl7ccbFmhghUQmkMT90mLal0BrDath5T1yF9ofw1vjzlyTtNkth2q3+ehXZSg/fqNwoPiS2/e6nGh/lfWxRtpvs7BGv1d0mexxhsk3jayc16wobqjp7Xkhv8iY0cyPmZ3k+5fTmTzFIAyRIz9l7lZITyeGMpGyb9LceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484352; c=relaxed/simple;
	bh=pfwDYX8VFy478Sr2JoJKNhy3KslAV2qaL0+IxyNz0Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCAqmX+SQKGhgzmht+1LWpWTV3pK2jS2sxfVRnwZevNpz1hCt4bd9InoMlnKWSj+AzM3yb6Gq5X4fJocncXqvkRagb741NcosaLPm532vGOHGDc0mKBRVAcB5qh8P0YLBgmRzqLqE04BtWfOzrRBVxbaRo3KikugYRf09AM/EeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KL3plXLM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KL3plXLM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso458334a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786484350; x=1787089150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PrgfFfaTrFq8c1E5Q2gDfQwMd1L8fsWns2o2BnEFJGU=;
        b=KL3plXLMnkjU7HJdsCFzvY5PAnkx9nv/iI6sjzt/O/ppvgmtezGm+S7JGO8gnqQOqZ
         bhce6JR73FYC/vXhf5d+hjbGBehn+QyvUQ8yC/hV9HQoGDLjTJXgE4qujh4/9f3JzNTW
         ILF+jQTz2nEVRBPwJCKroTSsiepk8iGADOc/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484350; x=1787089150;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrgfFfaTrFq8c1E5Q2gDfQwMd1L8fsWns2o2BnEFJGU=;
        b=R48FaOEOESnhSU7YKi+U7QMF1JLlgX3o7apAaGilczmZgNTFBboGnaQPDFujWRQ+OA
         iJnZy67/+8ZrGFbuhW4ldksRUCjEtjhP9FARKa51OUyPMNq7tr30bLUuh9c7Sjf4cdvx
         VBft9ckXHQpdSMs4wSaMFEqPqLdYjMPMVQGy+1S4khp676pwN0MegjI04PBy6el7Nx54
         i5ma5AiRW0OxbBA8ExEQ5GOHqusKZLv4vv1R4l+PHCanQXIXJMbzyUE4J7lU66Xs5+kT
         z6EBqKF5C4vrGPMJotusW3VuVP4d2WmpTCJiaj+Jnl3PBru9YeCuHp+ZwUgw66LK9wmM
         iIPA==
X-Forwarded-Encrypted: i=1; AHgh+Rq58nfJjO44Ak38iPdDeluWFYKngy20ue5BTov0lnvq+F2/hnkwwspnPIGByqPEiYxXr9GpXTXJZuNhhDUe4kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRyRr8a3IPwIzrM2sfP/2b1cNQLlcStGhUjULS7TpibJFfVdi
	Gq6aC2+T9/yR1PZDZw9akGa4n+BcqSDXH8w0Hhn5iUT4VmKrCuYX+p9R4rsYd73ZXw==
X-Gm-Gg: AR+sD100X7T2qS0MQYg9OubycLA+KCufeMx+jLUnQDVo+uv6mMIQHqHQToqYjG1am1V
	shfG1Wy1aesREyQla9cPJBwOQIJH98Z8tCZ+HXIin/it0kPPXC2vJ5axBRU/GackYxc68wKi+nM
	lJ+qo2y2cb1yihVWBHQBEk40Slh6iMGBTF27MkTmUnRTZjAICO7VtEMuOnV9v8UOujOgv7URu+F
	swC2WiU6+fjW8m/OIIi7AmSQqszxaRngR+Hx6Oi62ysLgLfS4QUcw5q2hapK26ng4hmlxYrC9OD
	iKkLNCLxHxL1EwLk4Mspd0qxm+y00TDEe2Tz3kuCD9e1CDCGfZ27XFdfpreNKm8uDn/ZPaczpZQ
	nTGZ15v6RfWr52stNHdyUefJvD99Xh9k/x8mVHSayVIyyWn9nIfRtIa0zT9MioBS3pP7CgXaL6V
	G6YvkQsjsAGJrsMfJQd/MJ7ddQ409mhgzeDos+SakjBnkdMDLZRM/MF3vkqX0k2MNrcA6a7KZYc
	LfVOt1pt7X49/DmFozwAX8P6G+lb6kc7VDdCA==
X-Received: by 2002:a05:6402:320e:b0:6a1:28d8:2306 with SMTP id 4fb4d7f45d1cf-6a36446fc31mr3285128a12.1.1786484349756;
        Tue, 11 Aug 2026 14:39:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6a362e3adc2sm1042864a12.13.2026.08.11.14.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 14:39:08 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:39:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH net-next] drivers/net/wireless/marvell/mwifiex/sdio: Use
 strscpy() to copy strings into arrays
Message-ID: <anuWeccD8vRRbX8k@google.com>
References: <20260608095523.2606-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095523.2606-3-david.laight.linux@gmail.com>

This isn't how driver patch subjects should be formed. It should be:

  wifi: mwifiex: ...

On Mon, Jun 08, 2026 at 10:54:47AM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Acked-by: Brian Norris <briannorris@chromium.org>

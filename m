Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92B8F5A
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548169; cv=none; b=VsYfkoF7xxeZBuUR068WwZaUEfsEZL0ZkSWzroQwmyoNaRIcN6yBDuXVdmDUOyizZAzuDUbnwxWJt3tNa/yE9vaO8ekZ0NLPusJrPPXh+rYgx305cquUqtLC8jn9kma1rSsTLFNtHUKED1oUmwPpmUbWZ2hKELO54q6LH1nE3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548169; c=relaxed/simple;
	bh=NVSOZpQjmNZbvBbytVbKbYZTTj5KexVg9+EBMGPo8iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4amY7Cx7KOz6qgwkvuGO+tNxl8K2KaD/LPIfgW4h8UTuRnh9E0Fw0exxZdCJ2p4dZwCW7n4s0ae+GXBn5y5/j4dP8XFjr6KAuS+PkaBgZIl/hYKmURAauqcvIBQf5Rt14oBNdYX4oV8++EFB3sk9EDp3dFK+l99fN8kEaHrAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d6LUHLFC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6LUHLFC"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso1247687a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 22:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548167; x=1708152967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lqdmVzIJwt0NdDv6XcYQYzL0U+gQtOwIYPw83OVL8g=;
        b=d6LUHLFC9vd9PmKcO4dhOkt3K3zU5yRuw1C2EGhxy8e34ZJvfR3DP45U8XxFFeBLBZ
         aPYbZ7p6Qs/h0PaMi4d1K0k/1hSrXIXnzMtnp6yT5LIfl6E82K4hb53oMaFjCnj6BmNs
         vF5D7w7352R6gQK4GsaHgyDD14Aqn9iKzPOpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548167; x=1708152967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lqdmVzIJwt0NdDv6XcYQYzL0U+gQtOwIYPw83OVL8g=;
        b=GPPIyhWP2iGfwuNcNvo/fXwwJ5byDrBMe+Sl73or959PkGKnZWMQNMJskpWj+uSD82
         oR4QOFrPncZ5EETyhxKArYLD5D0elHcMY9GnSpPvA0NGRLlz9fLi/BQwX+YiKZ5QZ131
         Ee3HaoZv03hgb0ElYGNV7MoiZlYR6JYYJF6FqzWbA3cQ2jbikr2mKGmeVGw2yKj5NSEn
         IKUL/pxgMlIvSmAEFMMRtNIA4OTTzqJjbsoNfbG31Sm58GbyYfabebH6BJczXJhedDpj
         GnkSWA8+K4hU0u/rFkoNA7wqQKUrbZZDM0IrDnfIJ2LVy9sv64FejvnRccOwJ8/qLSI/
         BPJQ==
X-Gm-Message-State: AOJu0YwINe1AvDMJfJ3DNt+shKIjCWWzxuwOw3D9yjSOVDYONAXUzDYw
	p7JOdJlt4QjT0bSYsmApQNmh2KszsVjCK7iL4YXQUZRRaJgmZF0Is6RgoGzbMw==
X-Google-Smtp-Source: AGHT+IG8Uvto3IXh7IM+fA+MZ+Inj6FlHN977ejGAfyv7OajcSC0CUdI70yPsphZgCB7gunDHexmGA==
X-Received: by 2002:a17:902:f809:b0:1d9:7729:2a6f with SMTP id ix9-20020a170902f80900b001d977292a6fmr1497467plb.61.1707548167643;
        Fri, 09 Feb 2024 22:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHNFwtwo2sj5Hgq9iT4SeharaFb3De5jNs2sKKLiRzhEOcJt9l0HQWoxTSJBuBbvBTHHP+w5FoKVroZZDidVlFmiko3Q3RPTYxPY8x9vc974PFN7dkbXledwzEmaGTCFNB1mAzMCu+0ZatG2sAA/J08eE57foSNwEJSd716ibUiYWvTqrzGTU9I8XM+zcpoHD/fw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001d9a40f50c4sm2491642plb.301.2024.02.09.22.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:56:06 -0800 (PST)
Date: Fri, 9 Feb 2024 22:56:06 -0800
From: Kees Cook <keescook@chromium.org>
To: tools@kernel.org, Joe Perches <joe@perches.com>
Cc: Lee Jones <lee@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: .mailmap support for removals (was Re: [PATCH 00/10] scsi: Replace
 {v}snprintf() variants with safer alternatives)
Message-ID: <202402092252.0A0A59A@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>
 <20240208174912.GZ689448@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208174912.GZ689448@google.com>

On Thu, Feb 08, 2024 at 05:49:12PM +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Bart Van Assche wrote:
> 
> > On 2/8/24 00:44, Lee Jones wrote:
> > > Cc: Andre Hedrick <andre@suse.com>
> > 
> > Please take a look at https://lwn.net/Articles/508222/.
> 
> get_maintainer.pl pulled it from here:
> 
> https://github.com/torvalds/linux/blob/master/drivers/scsi/3w-xxxx.c#L11

Oh. Hm. It seems "git check-mailmap" (and get_maintainers.pl) don't
support a way to remove an email address -- only redirect it.

It seems we may want to support "don't use this email address" for more
than just the currently observed rationale. I don't have any good
suggestions for what the format should look like? Perhaps:

"" <address-to-remove@example.com>

?

-- 
Kees Cook

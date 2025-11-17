Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A01E9B1A
	for <linux-hardening@vger.kernel.org>; Mon, 17 Nov 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763357530; cv=none; b=lMtYovGYt12EuFeHY5YHLYrPLjFp3BN16bwbU5hG89JjiXYOMFyWJg4S/JMM1sC6LznRNnxY4rzCf/neT7UhB6v5AMFZb2hmFxv85Ulgaokad51rYDhcbehcyZg42+gQT5YnRij7Zxd5aqoqDgAl+ebybmgMjHEnSam99AZ3C5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763357530; c=relaxed/simple;
	bh=qDNvS4gs4rZScxDqi64CNWzwpI9eznGM3AO2h1Xcvo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5k2WR7K3kOUzKf740mjO9//II18lTHEfYmDJOCtDj68DKI5soA1ueIev5q2EZSvLfcX8m3nacYUrNBGM+odd+vAN15NFu3t7ebzKV6U4e+89PIY8T0a1rUNrAaOFQd1lwfl93SXC3FQ3Xoz2soauIm6Y4CQ/PHhqGfGqeZVjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mk8zU9xr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mk8zU9xr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47798f4059fso1159965e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 16 Nov 2025 21:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763357524; x=1763962324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOTfYi+tVsV8XnFMmLsNAmw9POVor+4niM6A1Xzk09o=;
        b=Mk8zU9xrSTAt+juLJnBTPPiEmZhhYufy86IFUbbBPeC7zhrjKlMys38IT1nxPwpSbk
         +ZXuwwNmx2+xcPj0pODXWFnbdiKjE1OQBJS8j9IwcP8XOMyL9DsjkH3r6MwqeLrFthLc
         wwg3gsiQG2m+wU7vtj9NEcrPBjjXMENp39AsXJ2iFekdSsjRByP6xcvVdaYK5QcI6slG
         Yj4eIRI7IQUgvjzsnIR9AO9ScIMjOp1KZ89zW8zlZy0CqhevhU+N3JI0/FrLAx7zT0BB
         Fb4k6x0G5HokQt99ZChv47QXPlmQXVIWnsB4Uz6tARxTLDkS2j0piy76ssaG5nu49WDh
         sHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763357524; x=1763962324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOTfYi+tVsV8XnFMmLsNAmw9POVor+4niM6A1Xzk09o=;
        b=WecjzTFF8T1yKg5jcMCwOgP4tF56Pio4+lwJnKWAeQhdhRtaA1UJcuUnZv99aasYnF
         VbjKEM7+zUSdFliPLnUbZJ7qBZdq9At/JWiX/tG2CNstDJw9ZpnPEiyCHfuTcNewlnJG
         wlLSy17979UOaYtwl/sSOc7XWdVTRZnEzOVEDQ7ukJBWZ+uwEzX83s45xy/R+AVGt5SR
         FFcmkxNRwIizr/StkHJq2k5kbsfYPKiT1k1lHeSrygGxMQuyJNTEBRRg/l8C90wjPNAq
         5pUgoqm71lzloX0OV3gptvwxRmYrurwNzK6e8D6fxaanJM+pQvSoDAL/AR4twN/3dfct
         G7mw==
X-Forwarded-Encrypted: i=1; AJvYcCXx77sox08EajaeIS/QjgooH0Ljh5P26Pb1uCi1fDTVCwNWS10gBksA7XzPNVkOPG/75sHorrG27TuNPIlSfys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxsrZIj4LsK9NT92rL2l5zjCYqQ29FqYfNN+OogUy+hk+oRIm
	6xQEi7WHSkUgzTg3xBwXjdjzgXmOUUEmEhqj9qms13iL65PN15Ad9JDhMMDVioyo8iE=
X-Gm-Gg: ASbGnctjDpsFeoFOoTLEKrr5A9FeSQezZc3effKBa73UbHD4W395jS3t7hwFiFaNwq/
	d4dohFxBeeP0J2oInOsQ4m6e8dPh/0pHHCjqsWT7BEfRKaMqhLKp3LN1KzEErOaduLKC4RpeqQ4
	TFostGw5eK2bHXY7yB2//62Q0B8ydKMvyJNd5tOxaeWrulIn80cBhkcsX434hAy7IQhmNrmQQq/
	7xnZ2l8GBXXw59iGLRty7rK03jLKwZ+zD7TFUp41P/5mFjA7T2AFMpzHftr51P+zgg/naBFvXaQ
	WbM6gQnRbtLzcDt4Kxt8ZzbN1UrK7wgeKRLY5bHgu2NgoZZpmIpIusw5/umAKi4NBpOBeIVX4rW
	vkQkO0AQZnb85rj8yz3BtvfPrrYYA3/jTFSl2x6Pg+LSr9XxgHQOPfbFVGGBbsAptJHksN6QC2t
	SXNICbpzEK9Q==
X-Google-Smtp-Source: AGHT+IE/Sn+NHjmFPkX+qDLBz/tmkuljOojgxRyZSKcbpO5UM4orDk6yBzdR3NijuuYD+wAGs5CY7Q==
X-Received: by 2002:a05:600c:4e93:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-4779fa8bd59mr16387885e9.4.1763357524134;
        Sun, 16 Nov 2025 21:32:04 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0bf0sm126604445ad.71.2025.11.16.21.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 21:32:03 -0800 (PST)
Date: Mon, 17 Nov 2025 13:32:01 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ocfs2: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <7vsq3tvjuv3ppiot3lgithyp76r4jbbssoiiuni6zvj5pajsov@nketwax66jss>
References: <aRKm_7aN7Smc3J5L@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRKm_7aN7Smc3J5L@kspp>

On Tue, Nov 11, 2025 at 12:01:19PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> fs/ocfs2/xattr.c:52:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM) and a
> set of MEMBERS that would otherwise follow it.
> 
> This overlays the trailing MEMBER struct ocfs2_extent_rec er; onto the
> FAM struct ocfs2_xattr_value_root::xr_list.l_recs[], while keeping the
> FAM and the start of MEMBER aligned.
> 
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after the related structure --no
> blank line in between.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

LGTM.
Reviewed-by: Heming Zhao <heming.zhao@suse.com>

> ---
>  fs/ocfs2/xattr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index d70a20d29e3e..09069defd7e1 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -49,9 +49,13 @@
>  #include "ocfs2_trace.h"
>  
>  struct ocfs2_xattr_def_value_root {
> -	struct ocfs2_xattr_value_root	xv;
> -	struct ocfs2_extent_rec		er;
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct ocfs2_xattr_value_root, xv, xr_list.l_recs,
> +		struct ocfs2_extent_rec		er;
> +	);
>  };
> +static_assert(offsetof(struct ocfs2_xattr_def_value_root, xv.xr_list.l_recs) ==
> +	      offsetof(struct ocfs2_xattr_def_value_root, er));
>  
>  struct ocfs2_xattr_bucket {
>  	/* The inode these xattrs are associated with */
> -- 
> 2.43.0
> 
> 

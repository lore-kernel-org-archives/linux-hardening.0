Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D0389112
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798666; cv=none; b=jNdiuXsD5M3AlAFZ5vYl8Hi2e2yMu9OpaWisKBvd8rwmb6yHrT/vgoOflxts/0JuZhSP+xmKrczGhSn0E0kar6z+ImCacc7bV/A/XdoM4EOjAIbL+VbbRGXvV9aSejREQXmPT1s84pVn9CcR6Zlxxpzn7p66y0LZaYEaur1D+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798666; c=relaxed/simple;
	bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmJ5pTwsuo6/WQ6dt9BFFIsd2YDXbJHB4E0FOmHeQGZbLeSEAOH6SRuVJI956cfVbGsCi6wkMP3PKizBM/K2EfiCFZvN8fpnTQLEs4Pe1JG3dzOS99mAsn0wszSI9fzFho7ZYh4i6AOuRiF1iwUXiv8ifL6dXCR+9/jH2k8WEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ed0+SS4y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ed0+SS4y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3494965f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772798661; x=1773403461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
        b=ed0+SS4yZkwyoqttqz2qhbV/2mXNHH4wCtpAcaaCajm0MKG1iFTOd5yOmdpRIncx/m
         R/MzrkIZ2LQ60MJ69EPr89d1dMLHMdPYwiPpQkZ6e43aLUCFard78WjMci2mFPqHk3zE
         K9PmPYHKPVjwu1BQ+vsQlaoLywKOQyU6kPYN0eES7hoglcneNTsGh6Su+rltrQGPrAgX
         AVUDDRvqec7UY9kIxT+7ljR35MXzDQjYVSlNrKTOXtfEpZ/aSloyWQL81KEtXnaA2n5c
         P6TAQo0u4IcKG9/orcbzxAtwZSXskYGtfVyQBE+m2gVJ/Rytx2ezl3DSD95+4ntGlPab
         Sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798661; x=1773403461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
        b=Uu7C7hxlGHHJx7r+Nq1vHaIEcRsYjgJvilvqzkRvynZNz4w5X2pJ3BCbGbQdeZpUtL
         Ql2DHwoREnOmP9aUzjwW6InmctV5AHaUA0a1ova34WJfVpRtW9iCYYMVROcW5YGWddgh
         R0AtivRIAjUqCbdp4HwbnoDsFtCw2DjOFwydenL2qofR5QGHUoOn5lUXA8jZjMDq0+MV
         ncJKNeztFOHPzYclr/I5xTtvKNqDV9sZfEjY/UWpaMQWoUE3L9CISGpK/5Ow7Vrpg58d
         rqp4KmAc67ge1BuAc+Bb7YyIThpAj7LuJXoX2dXcE3HNQmT5ABx6xZLwFxihf7EhyO+h
         AQqg==
X-Forwarded-Encrypted: i=1; AJvYcCWh3nE+D0WgOCOMP+9kSlTCt7xZwiWDNuItyE5xpI+Zwyo9ZNEgaj1CXfD34fh8vyoeX5VGqLkGaL3D3rdwnNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgckQSyoIk/QIVcWnCI3q3Kgs4tTeqbdwTz4hvJe9iO11IHC7
	cS/0Eu55db2Nc4m3r9nmmoyS/JRGegsyZpZrGUWjTVJC1uPlx65ThUMF8C3FrtP1jpc=
X-Gm-Gg: ATEYQzy1TshKjUnTMNUGn6YkElV1HuctKH7s9MVXz0numnwMeetH2EAkVShCzYVMHJe
	/Iej+pnLPIPPFiY4lSmc5SKZnzey458T8kfiblFSnNCMQnO1bny1xiAJ5rkb51tCOqtpg6yyxeN
	HC4xAtBeu0KHVW8agGbo7lQh1HO85yZxbHfGh/1fMeD9ZiWkKb0d0ExoZQiBCKDZGJBg7Lw1Ty9
	dOZZj4c9lfytf423Z8i+dXEotMMIKpikSbpCcvC6EH8knOHAWf2qZV6sZ7ysQHIXzVfb/S64tz0
	xRbfdF3wpc0Ll0e/QPwFS0hKmvI1dSQk5N5UD6GM/4Jj/J3XlPtSb3pIn+9Wgmd403Ff82R/Dmb
	fBrQ9gnEsFVQTFRmEyvMNw0Xsu1iT3hTLRZSWXw9qn57jtFFKCZqX0NSGFLFmkxKasaOvI/YTAl
	XMF3nsLFfnZctfqJ5WSDI0zHyURTQMD44=
X-Received: by 2002:a05:600c:45d1:b0:483:7b99:131d with SMTP id 5b1f17b1804b1-4852675e55cmr30233535e9.16.1772798660534;
        Fri, 06 Mar 2026 04:04:20 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm207763565e9.9.2026.03.06.04.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:04:19 -0800 (PST)
Date: Fri, 6 Mar 2026 13:04:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
Message-ID: <x6bh5b7btkboaso726etps5t5hlka256nxeobbr46n7s7sj6kl@ddcxvax7xsc2>
References: <20260306025449.12333-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306025449.12333-1-rosenp@gmail.com>

Fri, Mar 06, 2026 at 03:54:49AM +0100, rosenp@gmail.com wrote:
>Combining the allocations simplifies things, especially the free path.
>
>Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.
>
>Add __counted_by for extra runtime analysis.
>
>Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

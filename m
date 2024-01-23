Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56F39848
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045558; cv=none; b=QinayXhBDt/1soQvcMsceZ74zcclE53aN+1MQOeorfjvkpmJKIRhqb1bklERg1ETx1mLCoKkKe7v1s9ShihtYwHlrBIpEg/jze0nfU3xhkpxEGeBZ9wISXBt+APXrp+FovGswKRgfg+0hNKob/cT74lwnbR0nqcYPFVfzLFk5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045558; c=relaxed/simple;
	bh=N2eMKxGKC9fb0PjB8BggX+mn9jsS+yaW0VK2ox0w8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKeWjfqy2JQ0FuY+PSc6HyM/s+qSTjz7NiUwgQHC3ohLOAQg8jv+vkdXBlCI9JTQufqV8kGppKQyX2Jw8ivHA3YvggZ9Sp5iE3qVID7j37sf+u/q71KVbfX4Zmh589G2gY4ejmejyjUq3fqDLy2q9smG9aTgD4lGP1h2P7xsDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RZWZDETR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZWZDETR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d6ff29293dso31946015ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045556; x=1706650356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=RZWZDETRJ3tdK1x5X6K5KNtiJ9OFq2PbD0OBYuOj5ncE/kICqyYGWyiipWArPUcV+R
         I+VcKv+e80Px86gl3C4eF6UjVc0z6kUBEQ/9X4Yswd3eUeustu+K4+ttSrKMPRUpJqOF
         Sj0lAePTvUusLq9GYw+KSHDTQyNdvGhRNvpBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045556; x=1706650356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=NAYABWmoDM9MbGvieVBWw0Ij59ubuUn/SP3TlDkEMmcjhgUD6zI8JbV8NFmGNxsJF/
         5rQLvlhJYJDcMTCbK+P6iMCdPuoQnR6mpnaWS1U2HYDBdad6y9FVH+dDs2Lx7vmx9P3R
         MWyR6IAMSzfQbdSEyiUq5t34E/nyoT4uqzjS8AMKUiG5gaxm0Gfc/zJmmqiGad9YblZ6
         hk6lGA7LFfc/2ZGxs/GmvicnvcpGkgwuvPm+671AMTWrsVV6jKUlCZoxuyGvhkCEnUoE
         0wLMgd4dprFpMnw6Df7ufW0qDXjJ5K6ahCJ9erdzggjpu4f+ftJoOXvunOesNxHFZ+x5
         GLkA==
X-Gm-Message-State: AOJu0YwcOUOAEQAT7MdETlNtc5Bxm2Cz/YTrb2FBofjmlPxite85XH92
	L0bl6MgnIF5yB5e1mzyDARObLZRzRX+uKfXpphnvczPEBA0XXcGbuyRymRf8tQ==
X-Google-Smtp-Source: AGHT+IEQgobK3CRi+ljenTCG6shvI0FXYyD3FQGn2ZQQGUseg7yif9UwvyOavRLNcvr02zSwCtZc7A==
X-Received: by 2002:a17:903:120d:b0:1d5:7316:c9fb with SMTP id l13-20020a170903120d00b001d57316c9fbmr3866864plh.37.1706045556284;
        Tue, 23 Jan 2024 13:32:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902740800b001d714ccf7b3sm8100220pll.180.2024.01.23.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:32:35 -0800 (PST)
Date: Tue, 23 Jan 2024 13:32:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Message-ID: <202401231331.0BD2925D4E@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-80-keescook@chromium.org>
 <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>

On Tue, Jan 23, 2024 at 08:55:44AM +0100, Jan Beulich wrote:
> On 23.01.2024 01:27, Kees Cook wrote:
> > --- a/drivers/net/xen-netback/hash.c
> > +++ b/drivers/net/xen-netback/hash.c
> > @@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
> >  		.flags = GNTCOPY_source_gref
> >  	}};
> >  
> > -	if ((off + len < off) || (off + len > vif->hash.size) ||
> > +	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||
> 
> I'm not maintainer of this code, but if I was I would ask that the
> excess parentheses be removed, to improve readability.

Good call. I will adjust that. Thanks!

-Kees

-- 
Kees Cook

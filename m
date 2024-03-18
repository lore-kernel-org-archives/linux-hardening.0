Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B855C16
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784169; cv=none; b=svZkX7n+yiJi+OXUvlM+PjTrgsXpDCQxTcOgnqJ4gTnQW7np/qvwQY9QQ4Q1asiP/WMjsI/EYDyQ3+3A9p82o/v1X2w6vuFss0XYxnkwd+diDoB5H+EvajU0nMJRcumHvmYuBf9Htr2Oc4ChLpQbyaV1aY3ZihrZxSV5S3ey/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784169; c=relaxed/simple;
	bh=AYMfYRY6klCQYJM0bVnZCDDZuEIucFRaAGMVi5tuFig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyCjKaayu8Q6K7e6jbLbjOdZ1XeXlZy8MsWLqNCysfw6RbzQkQEaq0FuwIJAMJ/xR08x1xtIvwvcr6CNV6B2I5v0gZWFbIcCjhtitvsp80ZUSIyoz+S9J30JRWDgYCM+xStoxmj3YNaoFONQhNU7dnqmMbmIpj3yjEu7u48vBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bjRLZC5A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjRLZC5A"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dee27acf7aso29409445ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710784168; x=1711388968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hzHXHAYAO5IILy822dDVSoGujLH1eorSOetYUN+2mo=;
        b=bjRLZC5A/VZvwMZxMp6m++hqN3+TDHrVFJOL8i9Y4qYNXCFVHT/w5eFPJ3MlhWgwC2
         AxObZ2dTh+6MTahoIj8Q++Z7GMoNnS5VDOJtEsriJGwuU3qhDaTnw9iBCX7+heF84yMO
         A7rJK6NzInsVUiegfehtPIsvpPSfzL/zy80Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784168; x=1711388968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hzHXHAYAO5IILy822dDVSoGujLH1eorSOetYUN+2mo=;
        b=rNucXZgh7Xo13NrhFH6V48Uw8r886nEclBJcJI7LVAQ7fTEfs1jXAzdiRFOZP2JNZw
         5cpuh3ZmrNvcQPfBp+XAenOzgWkLwZV9q+2lQnq4fFJIl2Iq0bFxmleS1M9SFJq+ozrJ
         HXaMlwXwKZZp7GN7EEIhDoaYU1W5cgogKCVGoN8sjivymMTt82OykeQnU/LpO+Pr4lEN
         ogv/UoEFQz2ScbvrAqCKugtxI71ygz7TedGQbST4amuTouQvpnk+4ttHpUKuYJo2V0if
         1fc2UqGr3hQQHAF/1dTeQXaHUewHoAm6RCh8gBnmb5/qYmJPIxPM5FD+6brjWjQfUAxB
         b1IA==
X-Gm-Message-State: AOJu0Yx+cdiZOuXDOWNjsdN4U8pVuQ/SVFcSKgNsjq6iZ9GP1IeqR4TW
	/Dq/vpPeT0ixIQoHAlU8RsLR9XojH6YwLRY0MgOwiV+Yr+NlLnbcj9VC0E/xl8jaUoG3X0m3/Is
	=
X-Google-Smtp-Source: AGHT+IHwULWpwHgXCxheCai0yUoIM9O7hU0pUI6uaypY1BpY+L2E5BH3oRPzmgUhLmFFsNz/L9wHkw==
X-Received: by 2002:a17:902:da8c:b0:1df:f9fc:e572 with SMTP id j12-20020a170902da8c00b001dff9fce572mr9150174plx.22.1710784167690;
        Mon, 18 Mar 2024 10:49:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b001dcc8ea6247sm9547206plg.15.2024.03.18.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:49:26 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:49:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Message-ID: <202403181038.EC9DF8CE3C@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>

On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
>  include/linux/compiler_types.h              | 11 ++++++++++
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)

Oh, I see the Subject says "kspp-next" -- normally I'd expect things
touch net to go through netdev. I'm fine with this going through either
tree. Perhaps better through netdev since that subsystem has the most
users and may gain more using the new macros?

-Kees

-- 
Kees Cook

Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCD4D9E1
	for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764400; cv=none; b=gkJ2QeJOfGOnWCrT8QWFwuc8/ZNWFQGT/kuUYso1906eIAHfK5R5Wbud0yaa33FUrqscAEn5wbscXFZGvrqR5SMJCzxdeoGy3bHmmacPy4/UYzvcNrazOwTzxJpJdgbHpeshBo7LbAmV1QaosLTWSky13Jzgo4I8jCKH8x38wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764400; c=relaxed/simple;
	bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0oPCResF8Ds2mAN+QZzC9v8QizZzpQM87rkpawCSUnqC4Jr+r5/T1JGWPdknOydM9riEbqKsfiBAAl/+xp3sWcwiHDPyAmJEtsfQr/LxraeJhGC2R3yEl6whlivrTy3gAUfCbr4Zdroj6bC/jFOMRzB/tlHq6l8ulHw89XcTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lLDikqb7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lLDikqb7"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2ed77e94dso361168a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707764397; x=1708369197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
        b=lLDikqb72XIUGYz8SWG1QhVietJSjvsR776R3/MhrMoAXfxyxUD4dW17GppSzFyMGE
         ysDeDpVMMmH8LY08LPAD6uj5t5/Xh2wS6Rg/oOjOvRsdYZ0cFiliJvGUIE5rGuw2O/im
         CeBzdilEpDjIH0WMl6YFOOXvyxV+mJtIy3xsIdzTWc/2NSH8yx+35Gq2scOiQbqsZXy5
         2ggF1Emtos9yYlYtB5uhCQ+WAQCagQLf8vo6sLOiiCzLx4fA8meZAKKmiBauuD68F2bY
         nwxvq2sv385+i7Mdn+vTpvgdKxbepDJYzL7KCMVm59J/ynP6pS+LezbfTumOVeHnGor7
         PbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764397; x=1708369197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
        b=FFcEnrldDXFL+wxv6vtLq67EJxhwFkH/vLDyUhGmx5lwrjOODVzTgyCCkyO/zzge1o
         Y/u+24EtYVaXMTsvYrmWX/WjKrWNyafobxfoxFZZqdjlyogRN0la5OuobjHKk7VUk9M3
         Jd9PsQwYsMDCgGKq5BAttk7afGpbquds8dkwdTaGFxHSe4r0Qck5t0nEaLjzOda6o6OE
         NF+0veGPmie8yrgQNb61ywJEPMOB8wLW+kFkc+8bJcGsso27LIHgBuNlnEChd8wNKy9K
         SDSjmJZNuJNskYQKjZxNlhMOm9//+sdCQelpdIWOIKxVZOAZ8/V7RvlJdBABjwu0n/GH
         LIeA==
X-Gm-Message-State: AOJu0YyBw241+UPFp33/Ay+uS7NrN675gV6pnTwsef61NtCDo89Zl0Cj
	plWI8tl33GBuxk93Cd+Vbca5HoF6XDEw4jYBCB7DmtkXb4LWoGfsZRsdpEXngtE=
X-Google-Smtp-Source: AGHT+IGLv5eFYNCU4+HomPY1o0vKj1PlmGaiQycPq0Q1ss6ZrPJnmX6ZnjQQphQqx/jfdKCsd3BQ/w==
X-Received: by 2002:a9d:64cf:0:b0:6e1:14dd:78e6 with SMTP id n15-20020a9d64cf000000b006e114dd78e6mr6802246otl.33.1707764397591;
        Mon, 12 Feb 2024 10:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTi+7tX5r64ygyx5TKwbl71bUWtl+XXnoD12XhAm2ZTKI+tKjP9/Q+kSfXRykeBt1y1/qJDFKjW41BWdvMRWadJQsGA+H+OvzcLrrJS0oMZWcNuoVY6hqPr5LoBm1qTNkd+RGX+Xefs2CMbVUoC8DZIF/Bb75R7wyzPUr1FiT8SJ2FaU1pLazOtUaRZI5vAlLL/nf5KwssfpgLmISjJsqfFo0CalOoRraAQ8qQzkdEDqjAsAFZNRY6UymT+lUFLYEEu1rGkzuphk0+M95yacyHsHfyMf874fiO
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o10-20020a9d6d0a000000b006e2e3fcc23dsm173805otp.58.2024.02.12.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:59:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZbX2-000Sw4-0l;
	Mon, 12 Feb 2024 14:59:56 -0400
Date: Mon, 12 Feb 2024 14:59:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>, Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Remove flexible arrays from struct *_filter
Message-ID: <20240212185956.GH765010@ziepe.ca>
References: <20240211115856.9788-1-erick.archer@gmx.com>
 <202402121026.0AF90DBA@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402121026.0AF90DBA@keescook>

On Mon, Feb 12, 2024 at 10:30:17AM -0800, Kees Cook wrote:
> I might suggest doing a binary difference comparison[1], as it's possible
> that "real_sz" is being used to try to avoid trailing padding on
> structs. I wasn't able to trivially construct an example, so maybe I'm
> not understanding its purpose correctly.

Hmm.. No need for binary comparison:

+static_assert(offsetof(struct ib_flow_eth_filter, real_sz) == sizeof(struct ib_flow_eth_filter));
+static_assert(offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter));
+static_assert(offsetof(struct ib_flow_tunnel_filter, real_sz) == sizeof(struct ib_flow_tunnel_filter));
+static_assert(offsetof(struct ib_flow_esp_filter, real_sz) == sizeof(struct ib_flow_esp_filter));
+static_assert(offsetof(struct ib_flow_gre_filter, real_sz) == sizeof(struct ib_flow_gre_filter));
+static_assert(offsetof(struct ib_flow_mpls_filter, real_sz) == sizeof(struct ib_flow_mpls_filter));

But yep, it is doing something:

In file included from ../include/linux/mlx5/device.h:37:
../include/rdma/ib_verbs.h:1931:15: error: static assertion failed due to requirement '__builtin_offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter)': offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter)
 1931 | static_assert(offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter));

__packed on that struct would probably be be OK.

Jason

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC46131182
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943220; cv=none; b=I8zl0o2/eCxe1icnC6SBvMwbJRussoM64qGlmgrDOWu5NwQ5bQWv2Q96kuIdrLje9kOTs7htyPy600etkK3Qj8W9hKI+DSttyAOYBo75m0IdSO5UyNojol37lY58ZKyNOIy3rW43T5/Ros1/9jl7z4KKwaFj3zEF3mFxnZCNr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943220; c=relaxed/simple;
	bh=AMJIZehGUySGAZL6wkzXO7bVQ+DTaxpnpI2Ky1q5D9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0t8Xj5RxGJ8rhdCVmP2zcLRgnF2NWK3vclGL9fpQFmA3U88W485hka/zr9+jmJey45TagxI2PZDgJa48ph+LOFASxYcX374XK1JYthRvhWNjITtBP2fRtmUXTEOghTRkKMOoQQW+Awp+g9CimtD+HkIjAbOCbGIPjHeVleyXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eZNyIL9G; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eZNyIL9G"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a910860e4dcso102211866b.3
        for <linux-hardening@vger.kernel.org>; Thu, 03 Oct 2024 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727943216; x=1728548016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nv/jEsjvCfr0g7lE4sP3JOAUBPrhIjuzgUZn50DDyM=;
        b=eZNyIL9GWkhXQ4NPWK344f+9xCEKFGYTx5ot6IkknLxwsEg/1qkAvhRDVCA8d99Gm1
         i69Kz9wfIFeQVFljagPTCUmPvoM5eJusvdf0xLNXP6qYxLGHqje111jfEU0pzFaxbHvS
         DNggyUQA22EjGnMURivc8k/fh5ffHHq+HQQBYACzkqL3aODxXvrodEY7Amphm0qiOiaC
         KMJ7xymFowMLV6DBP/D9cmoQfF0qPpuqdyQ5X3xQomgkw761aeB7+qrFmCwWhlJOpgQ4
         sraqU+UjN7hoAySdrO1W8S2aL+0jxz2rVRdlOYShQUP3mWpKolhCny7dJas6ZP95sJOH
         UPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943216; x=1728548016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nv/jEsjvCfr0g7lE4sP3JOAUBPrhIjuzgUZn50DDyM=;
        b=fsG7w+96G+OiqvvVSyh3ZY+/1Gmd4lRFuMbmAz+rihTsr8LdNU/ZyQKBpfmK5DHxms
         VLVsbudAQxiy7qhS6uFpGFslVCUE3MZW9u3WnKTmOMH13Ds91j+UqInyyBEz78NF2KMq
         dpPojhk1sbtSVw5r+gkPl53tN18sH4dGywohMa0bg9cv8iqvBH//0YIgjQD3iLJ/Nmor
         h6joreal49yHKfJHtt+C7+MHClc77o7vBVvHmfwhBDL61Lv441wqB8honHnuME8Zgz1M
         ZHqOf/LYqn9dozPTmnzbCCXvKvqXlhRZbomidzp1p4djIA3VJ09IuFRFTZoZHQmqANRf
         PppA==
X-Forwarded-Encrypted: i=1; AJvYcCWxUwUX3RAqYLm7+xV/Bd3a3wPEZ8NKGYw7RwxQTUiDbioOViFjbU75QhcynImEdGFyUVm8DwwxVxDRNNRUm7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPE5FJvi8B8sHOwElwC4etT2f2/wTCi3cgYAXjOtGBZe1B+B0
	OlaBrxwgyAhbqLHS30mIxUkWAFvKdvDObbmaKovE1zTaPfhrC2GYfIEEq6xzAWo=
X-Google-Smtp-Source: AGHT+IGLKAKVrT2HuZlfFESje/bCc3xN6+9Y/hwXPymFi/5gJ/tzC/OwSCJfsh/jRlQLzKuRNAdetA==
X-Received: by 2002:a17:907:9304:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a98f821de96mr671954566b.18.1727943216445;
        Thu, 03 Oct 2024 01:13:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103bbc0dsm49188066b.118.2024.10.03.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:13:36 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:13:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: linux@treblig.org
Cc: kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
	rostedt@goodmis.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <Zv5SLrKeQIpWnhsS@pathway.suse.cz>
References: <20241002173147.210107-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002173147.210107-1-linux@treblig.org>

On Wed 2024-10-02 18:31:47, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
> ("vsprintf: add binary printf") but as far as I can see was never used,
> unlike the other two functions in that patch.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Looks good to me:

Acked-by: Petr Mladek <pmladek@suse.com>

I assume that Sven is going to take it via the ftrace tree as he
suggested at https://lore.kernel.org/r/20241002104807.42b4b64e@gandalf.local.home

Best Regards,
Petr

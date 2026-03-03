Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F84301C1;
	Tue,  3 Mar 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559291; cv=none; b=cpJUuO1hyfOaS31eo6TLsiYqjUTkguiICgAdQ1xWzG+xtirPmqRdNENKojRNsLRmpNMJJPTjI+hcmcTS1Y0FPuCUjaaHDEYLyWhBc4NhvE3O+5dWXRiFgbci609zLoA20rCNn25V72Ng93cnZ23Ym2lHWIVEaPHavFUPTU1PPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559291; c=relaxed/simple;
	bh=70uyYe7s2E6X7AnJBGkkkxOS7v1d2Km08tJCTIMGiYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vz42CqrFqyKwXllhYK7qEjJd1ZsOHuREoxcB1Vrcz+AheCaFxFpkgETzjNPv67zpDoYwBZM88mYlK68RFF1QvAgZAKwJcSg0WDkbBwirRWfXioQpw/Sqrwy4HiTnqHJTDj/nkJ6QhCKR3DYUWm+A0DfCAPibhUiiWnDrG/zcOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W7/5EYBP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W7/5EYBP"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7679F40429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772559289; bh=p1Z/TBWG1G2IxEOxUKWAwXVAY46Ni5SU7OEprjK7kAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W7/5EYBPQPftHPWTuXHVc0QQg65BR+1Srd8l5IKh6defNW83NQ4RdewlXd8BNnAHI
	 gon9byPQr3GIjqcm7OEzIHAlSaQdDJEG5QZ78whALJ6UznBSeEKajdz4+AyOJJ7x80
	 6K4JPBFX/7NPoBcjn5FYQnMiHHv6RZZy8mjYHfRHgA6hBn2mYIqw+9kkHENK+e/HgQ
	 webzLTXGNRJqzPNAskAhLXtF+HCn63D9G4K2AQlg7r/D5LFrKxzLwMy3TrAiUsLTqC
	 qKfe/z0AuhyewZ54TYO/TmFB6xQZ5tkeJxV/xsl94s98jF4CnZlJDjjr1Qe+fEZocI
	 /EDGqYiZKBDXA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7679F40429;
	Tue,  3 Mar 2026 17:34:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH 08/18] docs: kdoc_parser: fix parser to support
 multi-word types
In-Reply-To: <544c73a9e670b6fef1828bf4f2ba0de7d29d8675.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
 <544c73a9e670b6fef1828bf4f2ba0de7d29d8675.1772469446.git.mchehab+huawei@kernel.org>
Date: Tue, 03 Mar 2026 10:34:48 -0700
Message-ID: <87jyvsbyvb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The regular expression currently expects a single word for the
> type, but it may be something like  "struct foo".
>
> Add support for it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
> index 39ff27d421eb..22a820d33dc8 100644
> --- a/tools/lib/python/kdoc/kdoc_parser.py
> +++ b/tools/lib/python/kdoc/kdoc_parser.py
> @@ -1018,14 +1018,14 @@ class KernelDoc:
>  
>          default_val = None
>  
> -        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
> +        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")

Just for future reference...I *really* think that the code is improved
by breaking up and commenting gnarly regexes like this.  They are really
unreadable in this form.  (And yes, I know the code has been full of
these forever, but we can always try to make it better :)

Anyway, just grumbling.

Thanks,

jon

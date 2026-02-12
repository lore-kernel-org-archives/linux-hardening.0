Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136B2629D
	for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906764; cv=none; b=jp1SMxI5CP2SgTOj7zS4upPu8e8/CMi9RhgR48KrFSYTd+3UZfJIe4RSsuNyd2xqAY1O8y0n3A28SuGo9tYf10iXXdJrH5SnnlzqzW89MuccONlNd4tRvQE+5Dnrps0imC20qL5dlU3uM/rYxK7iLZ2Itp55oMRPkmfTJWdtB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906764; c=relaxed/simple;
	bh=vJa0YV8/AAhwkj+6zcGnh5TTocmKgjfC4eD4Jdywfng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9cHVi4JyfnyhsR6tLU0CaZYgtkyp/Atuc7EJiYZTPdbiD1aqIeFjUMCNfnBPUo+dXB2LcLlrLgDKvnOyBf+mdVxsHKPwSpkCmJbAxnPRB/kJhopeJbwuCAXThcDxL9cPdhnwWipa6BTwqQIIAO6qXMySRUkVQi9JCpMxX+WpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsv5qWPl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsv5qWPl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so47832745e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770906761; x=1771511561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQGR+zG+LtJxLmW2ico4/GTCmLnqArT7S1nttOCxytU=;
        b=Xsv5qWPlD55KNXoXLdVuFVET8ylLxtfXItwDU+XPPNbdFmX1SPGr5F0ZcvshX7cPeX
         pcTEYEY9+oVh8DCA68lV8R+rOEregSsADA2aaBuZQJTRq83nrbsCwq9DimTDxxzVUOOF
         3gIPktmIoBlWGqEc4g71SlWI64t8KDX4z+Dse5wUaNikcdjGF0pZlFcF6VhIeb9Cp7TV
         tD8kEZYdGdR3zgSAHg+6ZMogxIOp83Rx5m0HttKXtCeiQmbcY8RQh1N/fC1wanL1ZNb9
         FL2ACLmUasoj7bS870CGYS4n5RnQ7Fb0f8bHBfnOvof7gdv+7Z11a62A4EpSFhcrY0Wo
         DrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770906761; x=1771511561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQGR+zG+LtJxLmW2ico4/GTCmLnqArT7S1nttOCxytU=;
        b=g8/gygsmgKiC8cNMxRILEqEdKPdomDWIsLpP/fRnXTdc7I4kO1xAOzidFCtJPPBSqE
         0OlgppSQWvORSriFisTsopRyzNQx8AE8C0RMjYL0Bt2TORblz5Zzp45Q9Xo3V5zAnpjd
         tauE7JGTIO8K+jfAZsGYfeLIs2e2MkFBCLzqQzhYOKGWkYKzIa1Ova3xCiD5/QSIHYtM
         O0+yK7RqbZ6JJLuZUhTe6Da9sxCRhA2VyWALduhgSpc9YxF96adzkIhRD9cUzd8VFEWz
         kEnYkaTlxO3OYpANxtJ2mGAdVcfmJJo8Ej/On8ECP7AFhvW7poJ8SehbvcH38qYA7UR2
         0v1A==
X-Forwarded-Encrypted: i=1; AJvYcCW8WOzsQDNopHFHTrmp/weazoEFWuLj8MKocP0SqbN34RWJexXsVP3dI4OEz8wuCAqJ0XzQnG+bHdv53Bwskwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwGRrWyYbi4anGXQ/Q/hT1+n3hiKI1+NmcJNqEqjZmsBKHyR7
	CYSLOXlOL1B3L0XcSirSouzSHKlfbui7K/Q6V017KstmSMZvPfMgwOPc
X-Gm-Gg: AZuq6aIC8jaLlyM5PkzU8ps7vjyGFbRZ1edkiOF7yw3JERU31d0Aj6YTjdDCZ9panmF
	LbMx1LxTTn3MzM+SYnZJbfM0vZmWo8VIVn0sFG8JMEP9tiKZWg+djsBJbwD5EeQGyoSjWDxSnB/
	yfVV+I2cLEuVp4IW4cD4u9apoBVP1mO8sdfkucDHrZ/gDkpGskszCpJyERirDXYZUw4ozs4pG4L
	VUfckZM19G4tqXrS65C9wvlg6ejJLsNFSPdprVUMWrfPx0bNaf8rbehCmqd+qWwBolHiiNDpPRq
	whw/rF7dJ6NWxGNTe5Y8EgLQcEYO2p+UJ2UX+0UPkwv4vesloIwowR3pq3AsRJiV2FpqCRerLIl
	mhtGP4l+PP7HzD2V0laSyLc8vCMiUuCdotDtxHZMtl7AZeFOtK5/58aGrHe3ES1+JBgLjxZCrv1
	KUQlH6zhv+yIaZgPFvnYSlEXacIRVaDXScnMsryY8/JOANIY8ay2JZrJ54pjTn4mgj
X-Received: by 2002:a05:6000:2912:b0:436:3563:499b with SMTP id ffacd0b85a97d-4378f128ce4mr3735577f8f.2.1770906761029;
        Thu, 12 Feb 2026 06:32:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm14478377f8f.5.2026.02.12.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:32:40 -0800 (PST)
Date: Thu, 12 Feb 2026 14:32:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Darrick J .
 Wong" <djwong@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] lib: fix _parse_integer_limit() to handle
 overflow
Message-ID: <20260212143239.7039596a@pumpkin>
In-Reply-To: <aY3Yp89R1cl-sacD@smile.fi.intel.com>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
	<20260212125628.739276-2-dmantipov@yandex.ru>
	<aY3Yp89R1cl-sacD@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 15:41:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 12, 2026 at 03:56:24PM +0300, Dmitry Antipov wrote:
> > In '_parse_integer_limit()', adjust native integer arithmetic
> > with near-to-overflow branch where 'check_mul_overflow()' and
> > 'check_add_overflow()' are used to check whether an intermediate
> > result goes out of range, and denote such a case with ULLONG_MAX,
> > thus making the function more similar to standard C library's
> > 'strtoull()'. Adjust comment to kernel-doc style as well.  
> 
> ...
> 
> > +	for (rv = 0; max_chars--; rv++, s++) {  
> 
> Hmm... is max_chars being used inside for-loop body? I would rather use regular
> pattern here:
> 
> 	for (rv = 0; rv < max_chars; rv++, s++) {
> 
> (just check that any integer / sign promotion doesn't change the logic).
> 

The 'problem' is that the loop sets 'OVERFLOW' in rv.
But that is easily solved.

The smallest code is probably from the slightly horrid:
	rv = max_chars;
	lim = s + max_chars;
	while (s < lim) {
		ch = *s++;
		..
	}
	return rv - (lim - s);
although that relies on max_chars being sane.

	David

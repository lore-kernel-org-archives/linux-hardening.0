Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963A225791
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936338; cv=none; b=WMom2oj44xGmYB4hfg3H0MxkCLjfE7ASxmhKYrlNzHUAYiSD1QyQ94xtbLR1N55IO4IfigMaPtSwJ77XZ3lbZWZmD4lo9BR/d7XJsckvz38SCXLy2aFzDOweZ+O7yA1hipOKf7hya8UxStru81YxNY2xDMpZEIaoU2ByvvJCkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936338; c=relaxed/simple;
	bh=e4r6QSzCXgkLd00SfnwI1rSarp7HvrZXjtfgoPQVYxg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX4CQW83n0VBSUcyPOSDjVHnQ/ksTVVW4vSJspanuTjPzRsid+joE0WLjkdtouyIyfx4rtEO4QzTmIlzmf/oEhdtcC7s29DKQlOWnhXFnTaTynSLsivVYeguG+cPh1sJF63PyhRizmdfOuH+J7GuRNzpIl4pXSbzpCcFAobcclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1fjrOzK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1fjrOzK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48069a48629so56033605e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771936336; x=1772541136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZJXURF8+qZPmvOXTS8TBbzIn7PDpr9uM92PUJEhPaE=;
        b=L1fjrOzKwWwfVlOe4doH9/ccyD/tZvD5NwdJaXSDMe1N4tiIIca9tkH2xd4A2k039B
         2sHLyOn6iLx8NjNoyGRLkFgmD8p3zRky3soEPMLw3azUssFHYo5Dj4tiHwSVCIj0pHdm
         0M+uM88WmoDJeelUnm3aJJ7HVZ3bGrWEV8vPA29le4vCWW+e8ZoSZNesAwM/zjx6P91r
         9Pe9sJ6V8K23kzM9yVifc3hCrRj5lpYWGJQF/ukZJ2S9yQYV5G5Rzfm8oEUuhuSxqbBr
         7bBk2pMpQynyZo8gHF0LWMsNPsYTYQPyRT2VpM6bWeuAPxbXCHgA2ds478N0Elo3prIM
         xhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936336; x=1772541136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZJXURF8+qZPmvOXTS8TBbzIn7PDpr9uM92PUJEhPaE=;
        b=ETvHWtPgHGRwcr7hmZhKPULvPKvct10oKIVpWXt8EavbyoRso9HU4rsuD9Hc5PUA/1
         DqWuEMKYcqcelvxiMJKSZPRhRMLuTqr485XntZEu1AvVsKgF7CmKyXD2ONaapGEGiNXt
         oTIS/G/N7nMmyKqq1sZWbusqla1yA1anJi8wOmHi8gWgNlL/5jNPQRAnsY+e4VjkdKB9
         yMD+DaLVeaSMN5kXulds0ijyxYu8spNelC9e4uxdYAV1kJVN99xMdpXwDQS+cZzdXFms
         7CzvWUmioZmQvh7Ks6Yd55jDWHzF4UmV9LC2auAKK8DeVe7lC1xcpRxQbC66nnbx2Se1
         xqHA==
X-Forwarded-Encrypted: i=1; AJvYcCWs4GtLUdkQASgfkKDYys+UzKYonk57Hrf4ejB52+b0h7pGSxTUrowfmVdQMXTo1JU7B6ESH8G/22ZCDxdA8Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYwib5S2BXgEqgCNqCpdmnCp9O3IIKoCIGWWAt4tf921UQgI6
	kypUyImrred+iJJnkEvC9nNKKlsEQ7LCowNaLQOT/CUVBv3XM4WQQ6NY
X-Gm-Gg: AZuq6aIsLOd3TgMhbogbtY7Z+FsZdPEmFOxfclerpYhc29jpfIBAWgy9f8lie/O1VUZ
	DWROWj68h7QKZ63+gmLbPmwKd56qWZlXQgASkSpr+oAM1QPIYfNO3h07mq98PlQPfpYoXQMonDB
	qgKGJqt5cn8Vi0FMDeC7IPagQ5/LiR87B7IyMV+nhyQvVs+/ajX2HYYVyx70eELwOrS4eLgBgVh
	dZvAnlQDThXRNGgxRQwgWcg+eGoQUw1dwX0wNtdv+QxEXVdTEDpPl84FJD5TnZF2qovK+iVN3SX
	NWqAXz31VpVbSP3aBoBWdtAbn5SgCSb68Be448ep6OkcDZnATM3PjoCRwulUBrq4q83Wq8TeoQN
	xWhRlLFZ3upZqgfk5bMKQYB/U5t2Ir/VFsaUu5+E8Bc0wi6J4TZiMQCegzciVh4aslwtCX4qpJQ
	TgAN/EJEhf2BCSQF6up991Hwl7Hyp/INAlwT0zocA8pR2GSJctKJWWvpfPC3V0ZDLNCrWpJNphl
	V/xV2RWpeTZujWCR166JObp+GPs10tHscNrwaCUXGgW6/Vm6bSY4HQJFOQEmQ==
X-Received: by 2002:a05:600c:4e48:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-483a95f71b9mr197091855e9.29.1771936335417;
        Tue, 24 Feb 2026 04:32:15 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b81f94a6sm23664195e9.3.2026.02.24.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:32:14 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 24 Feb 2026 12:32:07 +0000
To: Dmitry Antipov <dmantipov@yandex.ru>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] lib: fix memparse() to handle overflow
Message-ID: <umfxjjw2iukw5knj5xn5lxtkr2keorq3sws2mnegmw3zr64bmg@77v4cqwi2fay>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
 <20260212164413.889625-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212164413.889625-3-dmantipov@yandex.ru>

On 26/02/12 07:44PM, Dmitry Antipov wrote:
> Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> capable to handle overflow, adjust 'memparse()' to handle overflow
> (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> use 'check_shl_overflow()' to catch an overflow possibly caused
> by processing size suffix and denote it with ULLONG_MAX as well.

is returning ULLONG_MAX the proper way to indicate overflow with
simple_strtoull()?

...

>  unsigned long long memparse(const char *ptr, char **retptr)
>  {
>  	char *endptr;	/* local pointer to end of parsed string */
> -
>  	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);

... or a new wrapper for _parse_integer_limit() is needed?

I am interested on having _parse_integer_limit() overflow check
exposed to kernel modules.
...

-- 
Kind regards,

Rodrigo Alencar

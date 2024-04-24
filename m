Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B516D9A7
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974377; cv=none; b=teXDLKbh7qctXaqPFQblcZIlUvWnoG4XT319lXPqym0bgyEhul91nGaiPl/fLXEOtEJKU1E95B+JU1m8e/woKediLr09qGu5rueHIqorjXwxX9wv0Cd9N9/ium9jf4CmKj+xVfQRmlgs2wOmrDoLQh9M4R4tOkrvirggnjm0mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974377; c=relaxed/simple;
	bh=0GiSfYTnN6d165IOBQzb694rnUh8tyUWWbTI6T31ybQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo1oOBuQnTF9LgGHr5dKUgI14Vu5CuiAdZexwqsHbK0q6Qkp4bfG4sLcZAcp0FWakE4f1cF9SLeCBQRA0gm5JSGnbroCxfsVy7yaykLM6OwddS23VAJGfASlgAKw58TBQLztkLpWtxs0DvyqsBf/K787aTzulqyz4ZwEozcQQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JbZOhrpT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbZOhrpT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4f341330fso59724155ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713974375; x=1714579175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WnnPsbn6LQ0620dM71ztuHhda8zUa4oNBqxG0zPojc=;
        b=JbZOhrpTlsJnQLzZ365dtjwupe70dJDCEXDimOBMkR3Bg7+zZd3iVL9+c/fblvuOJR
         x0/p7JzcKbF5JES4niDrqp9telHI2uMJwCUzDwhUzTuXKR6QJJzAvzo4uhChsQDsbZmc
         tiA0z6vwEp4T0MncXqV7aYzXI91gWY/TuKhuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974375; x=1714579175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WnnPsbn6LQ0620dM71ztuHhda8zUa4oNBqxG0zPojc=;
        b=cBtUr7OsPlneJeWo/dl9IpNp3fiIcFMGkjUmr8HsVd/gBz1xI0oRFCsH5vsuRBinKW
         vkJlk+wADWcD2+L0hXskcvyqoBjieFnMqfm3Y/vNJf4DqlSNm7UEOSkTm1q3PjSvq+jD
         wg1cRXE5OAdaq+XZAdamVs85wrNdzk3DqMRkQuaFFsRg9CU81Yk6YO6POXqHguL+7goh
         S7PH2KZummFl7Z8y8SniBV7CpiSeH5howyO/RzOeEQRw7l9Nl+sZoM17Bn6i0gwLvc+W
         iTZP+OTsknRuDAL6eacz7dl4BRv6auWvfTQkh6BpFxO27h3q2mQmd1PIFYxr6TaemwI9
         k5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUU+f347tb7GT2qKmN2lfVON+LiLNCZadAHpf6ksN3HMwVoFOVsnb+KYzxSAGetKSvLME07nJvk86qtEmMeOJB6BzfnhJZncz8vcmvZueeK
X-Gm-Message-State: AOJu0Yy6cyZrF+tcHUd/eA5BY1kwy58udfRk6MdiVCSs18EtdH2gVUmb
	wXKkQvgDGaxyN0NbPgXDiDZBrSVhobPdxeBj9rNEEFGi8yxSLsNI4AgaDhRc0w==
X-Google-Smtp-Source: AGHT+IFH25XoxrsKcb6phfTBuhyybN5yfvn80JCnlXdGkC8eys5A64GweFI7pjlxIx0ItdNyWbfEnQ==
X-Received: by 2002:a17:903:11c3:b0:1e9:9c6e:9732 with SMTP id q3-20020a17090311c300b001e99c6e9732mr3467740plh.19.1713974374923;
        Wed, 24 Apr 2024 08:59:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902bd0900b001e4565a2596sm12100439pls.92.2024.04.24.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:59:34 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:59:33 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Charles Bertsch <cbertsch@cox.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/5] string.h: Introduce memtostr() and memtostr_pad()
Message-ID: <202404240858.0FDD390@keescook>
References: <20240410021833.work.750-kees@kernel.org>
 <20240410023155.2100422-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410023155.2100422-1-keescook@chromium.org>

On Tue, Apr 09, 2024 at 07:31:50PM -0700, Kees Cook wrote:
> Another ambiguous use of strncpy() is to copy from strings that may not
> be NUL-terminated. These cases depend on having the destination buffer
> be explicitly larger than the source buffer's maximum size, having
> the size of the copy exactly match the source buffer's maximum size,
> and for the destination buffer to get explicitly NUL terminated.
> 
> This usually happens when parsing protocols or hardware character arrays
> that are not guaranteed to be NUL-terminated. The code pattern is
> effectively this:
> 
> 	char dest[sizeof(src) + 1];
> 
> 	strncpy(dest, src, sizeof(src));
> 	dest[sizeof(dest) - 1] = '\0';
> 
> In practice it usually looks like:
> 
> struct from_hardware {
> 	...
> 	char name[HW_NAME_SIZE] __nonstring;
> 	...
> };
> 
> 	struct from_hardware *p = ...;
> 	char name[HW_NAME_SIZE + 1];
> 
> 	strncpy(name, p->name, HW_NAME_SIZE);
> 	name[NW_NAME_SIZE] = '\0';
> 
> This cannot be replaced with:
> 
> 	strscpy(name, p->name, sizeof(name));
> 
> because p->name is smaller and not NUL-terminated, so FORTIFY will
> trigger when strnlen(p->name, sizeof(name)) is used. And it cannot be
> replaced with:
> 
> 	strscpy(name, p->name, sizeof(p->name));
> 
> because then "name" may contain a 1 character early truncation of
> p->name.
> 
> Provide an unambiguous interface for converting a maybe not-NUL-terminated
> string to a NUL-terminated string, with compile-time buffer size checking
> so that it can never fail at runtime: memtostr() and memtostr_pad(). Also
> add KUnit tests for both.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

FYI,

As the string KUnit tests have seen some refactoring, I'm taking this
patch and refactoring it onto my tree. Once the SCSI fixes are reviewed, if
we want to land them in -next, it's probably easiest for them to go via
my tree.

-Kees

-- 
Kees Cook

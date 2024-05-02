Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071A155323
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662434; cv=none; b=EHGCEvhFYBQwZh+nIVmhYZvHsHIqLc0CZynSrNgO3uQlGoJ14bNtaHn1rWJYOl7Ys0PGieU4WiwOvUbDCdRlydPS4Q4xPlpwi/uJ5C+/xSq4IlIXuU8ICnKhDFwlUM14oi/tRLjlpcC24IW7Y/w6yRxm0Tn2n53wqR6f/Flh1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662434; c=relaxed/simple;
	bh=CdgIWW0lb+8R+RRrQzFoh/AUVg59OjsWVT/VyiQepxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPkOnhDuqNmbwrNcR8ZtyD+FcGqRbkXPehsDROhlIbg5z5FLknDUdqA3mBtgcayCt88180vpBBcensq0DM2eWJZT5bPy6bANK7zWfJZX1+TXD0g+6n5jmvZaus41wnR3eUQ8xkhovMCeia5licHUmbGrjKJOsDevENqGZ6jWdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eb5nz5j5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eb5nz5j5"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d7d04808bso1772537f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714662430; x=1715267230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Warmf7d/nexbr8HYWpxXY0Pz6mIh14PX1TjUWaJ3M6c=;
        b=eb5nz5j5XY4N9D8e3gvdHEDDfa02sXHXSPgGR84AT/hfdX2Al/9D5ZivNQRDTgDtTp
         MLWUChR1mUFPEpBLzA7+Thd7Y7TYe39KFKjtHDNPLSMYZ/qB/mQwqdox9wyqXWd9E2ri
         1qsxr9NJ23PCNGwmiYDYX5OdkDSn6owtzbW2i17tCx17ynu16f7VQ5146Xyrcb/7gJd3
         GG8PgZXGujhPo/5P2HGuOgLb5rBGrNrLSJjIdinSma4h75ACR6sqFMDuutJmi88ZOsrC
         CxX5xxkLWil0S7M/+D9/pCCIxxgX1PJLkNo6n5iwtz8aeLbTVLmFtz9JYIAAV8IuM2q1
         FNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662430; x=1715267230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Warmf7d/nexbr8HYWpxXY0Pz6mIh14PX1TjUWaJ3M6c=;
        b=gqnyYLTzj3VaSUs9sJVNVQCMv6flP1hfDYXSMZU+u4XRkMXl/70Nj0UzcItoTSgI9X
         QjLOmpY7zOD3vxRojq7Rumz9Rw1JI1aEg8Yscd1IDGQuGS10MtkkmAFrnJeoQAQ3Vfc7
         687lhgnglPpZR/td59UshVFNm7kyFaw9cO77CmAx0umxOjjEp+PZx/xQVDXepYIjq6F6
         rEAkN4mUQ+RGpRptv2nKC1Al4DK9qmeNCGmjCoE9U30RDzbbVrbjlz2TLKNois99hdrK
         CAPEPGrRoS7pJtJaJRv/g5OG/HJgi1xxqmIgJxXyPHHuEJmYMknUhXJifMhPULiWJK3J
         2G/g==
X-Forwarded-Encrypted: i=1; AJvYcCXX4gi0cDDu1GEQ5lv7JjmBz44Nx409a2qnBQ9d8veAOSBQg4+xosN3YxgY2+8oSLJ2bAm38WndLNpnB6fpQ4mye98O+pvOdIfl9W5+lNTo
X-Gm-Message-State: AOJu0Yxb//CA7iUxvi/hYpuhO7w1zeEn1AL3Mt6MdV/FosaKSUsH8blv
	pEM4lAve4WZ1mo8WfwKMfi5UzrLCI9te9009pYM4eow5OJO+Mei9trsQ6VVCAPQ=
X-Google-Smtp-Source: AGHT+IFvhvgA4+JHhAkagq7K9+Mr6f8dl2vhC/5zX0tFQMYpWpYAuAoPeQmv9cRCQAmR64cIXSJFWg==
X-Received: by 2002:a5d:43c5:0:b0:34c:a9e:97ed with SMTP id v5-20020a5d43c5000000b0034c0a9e97edmr83749wrr.35.1714662430017;
        Thu, 02 May 2024 08:07:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id dn15-20020a0560000c0f00b0034d9012e74bsm1488989wrb.72.2024.05.02.08.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:07:09 -0700 (PDT)
Date: Thu, 2 May 2024 17:07:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <ZjOsHCOWXEC7JNOC@pathway.suse.cz>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>

On Mon 2024-04-29 23:06:54, Justin Stitt wrote:
> Cleanup some deprecated uses of strncpy() and strcpy() [1].
> 
> There doesn't seem to be any bugs with the current code but the
> readability of this code could benefit from a quick makeover while
> removing some deprecated stuff as a benefit.
> 
> The most interesting replacement made in this patch involves
> concatenating "ttyS" with a digit-led user-supplied string. Instead of
> doing two distinct string copies with carefully managed offsets and
> lengths, let's use the more robust and self-explanatory scnprintf().
> scnprintf will 1) respect the bounds of @buf, 2) null-terminate @buf, 3)
> do the concatenation. This allows us to drop the manual NUL-byte assignment.
> 
> Also, since isdigit() is used about a dozen lines after the open-coded
> version we'll replace it for uniformity's sake.
> 
> All the strcpy() --> strscpy() replacements are trivial as the source
> strings are literals and much smaller than the destination size. No
> behavioral change here.
> 
> Use the new 2-argument version of strscpy() introduced in Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). However, to make
> this work fully (since the size must be known at compile time), also
> update the extern-qualified declaration to have the proper size
> information.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Nice improvements. Looks fine.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

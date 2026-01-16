Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418D3587A2
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557208; cv=none; b=ZSPkmCbNiv8qp6oljUV205pVO/xGCKci8/CFxuAWE8MM43vbtNFfO6+T/reX8xx8L9r0Ev0gqo8fwZyiwurMDjnQFN0V0+ZamZprIHqschIc5nHeh2A08+0vWeahMTyMzG6DdOyMn95IbCnKGczR9TEuJMaPU1Yg4OXwmsd4Qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557208; c=relaxed/simple;
	bh=UTgpQh0ZLgnzkFSvhFTTbcTXvNmo/rsBWjbi2EKkncY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8tmEG6s/iLXSqubiYQzIhfotuooJF5NbV6MognWb25VhfEFmX8Bl/CIFgfVlSq/7BAQ6tawGHjAEMMNqoV/bcgs335UQ00tkTn6qvjnSMBmolF/Qm2hXoqzBn4KPcxz31HsACBkUMevqEUjg5yXkbjS8ytIn66hSwVG96M3I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZk1W/KT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZk1W/KT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee0291921so12855955e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557204; x=1769162004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc9Ty9XgpUdwxFhTnyIgiWP6bdhC4HIf+rr8u+NJ+Go=;
        b=BZk1W/KTAm1xH+5VKcuPMSh2uu/pebl3HoUOauxWdOOJM5QVP69whoozeB/Pt42+Cy
         2SQ1qbf5EYaXXEwknSVHkP9zNwL0cBdFakLz9lDVBI7vgweyRwtI4Xk+juBEiHDhYH7J
         9/9sNafc+3mVEf18cNd2AaI5YQBgkY0LAanTEHalIOt8NUEO6+fZmCKCxnvmATovxv4p
         5eST7qwoCvougdi5q3NQze4req0uMCrdN58mcgRZenQS4VSbDUx1zYU77AikTxQ22YtK
         ZT056if92mc/gOG0aVnHYmWC2IKes/lzW3X9BkctCNn3W3+ej8crnWUa753hOIsbFV4g
         yboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557204; x=1769162004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kc9Ty9XgpUdwxFhTnyIgiWP6bdhC4HIf+rr8u+NJ+Go=;
        b=Al5Yo4iDR/z9z8PvMXIiWPhBsPp53jK8KGXziA9thNVYe3Hg3oG5FPgL8PbApE10ws
         +JCJ9BjVOlYTPe4C9gT9ff8i5zzWKh9mUDmMVG9YMHPgMG9mlXuoGvI87Iu8pM/pPf1C
         Cmdyl3bQD8ngNAdORQWpLEp+nTGhZnz4aqn0g+jn0xLHXZF9IelhtGisF0ELXUT7pr/s
         0shq7z8Jqp0RMNG2VeMl7+bz9BhRs/tzlY8bVdCu2QQTWAVZRYOLX3yOjMdCGPgqf4Qh
         d2tAh4f3sq1TfjeakgcuEYvuCxu6JumF+wL15MWOsv4JsY4mgGHcanrgaHm5SmahMBzj
         UKlw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Bpi9dU5zJNxRcoo6KelNbwph4809q0EF/ci9pKNEVA7K1iEtecv6+iM9SSLJHn6SNzANOrPUpeYlqaVGtQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYtcRJ+v5cF5fBhYwfa2yOU+6bHJS1Sd/FO2K8mLbB8NF7Tt/
	l3y+qYJoorA++45aQIM3WtcAkL+SySf4PGg1UaZcTTB+8FocnvfjDvkJ
X-Gm-Gg: AY/fxX6+9nXkNy+EbzBqLzvnu/uKK8MOaBgXTF0bHCzCVepGkaLq0enW2DtR+JFZcKV
	VxfK81hM5vl2mypkVA4c9/8kAzPK8DJKKmU88Q8hCKYuwEkserS4mxkrFmRDMk9fLkhqGsV7nJq
	fkfBstBguvIbW5z/POZZn9Q5/pNXyFF+4z1j2F1LQHEwbeWGODGx643iPodgXA2HrfwqFDgieOO
	gEAdN5U4PLkuspVoT6YG0b8J7tq+LB4EqgMH7ZgjcllAc3QschhYvPfxs39llVwzLQF7J+fbf4f
	fw1Ff/y78wHP09BLz9PzqHqI/e1VJ1auwZxcNJ1b/mrKOq/yLFFCs38hIBZ40cTlS/OE+qIm7id
	mqGLCr8VHYmRBn6zC987Voxo4/S5L9EU6KDzJHPiPXR2jPNuCsI8Nsn+MOHkl9zeihR/4DzQcHu
	an7BHwQobI8XJNu8vxoJfLeDeFcYwjP8W6/L4n9g9wfXeUNS37zHBB
X-Received: by 2002:a05:600c:8b64:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-4801eac0f22mr21648235e9.14.1768557203887;
        Fri, 16 Jan 2026 01:53:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm90683575e9.5.2026.01.16.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:53:23 -0800 (PST)
Date: Fri, 16 Jan 2026 09:53:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt
 <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko
 Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>,
 Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, "Michal =?UTF-8?B?S291dG7DvQ==?="
 <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, "Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?=" <thomas.weissschuh@linutronix.de>, John
 Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, Masahiro
 Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, Nicolas Schier
 <nsc@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Naman Jain <namjain@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Compiler Attributes: Add __counted_by_ptr macro
Message-ID: <20260116095318.46a149fb@pumpkin>
In-Reply-To: <20260116005838.2419118-1-morbo@google.com>
References: <20260114193716.1740684-1-morbo@google.com>
	<20260116005838.2419118-1-morbo@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 00:57:57 +0000
Bill Wendling <morbo@google.com> wrote:

> Introduce __counted_by_ptr(), which works like __counted_by(), but for
> pointer struct members.
> 
> struct foo {
> 	int a, b, c;
> 	char *buffer __counted_by_ptr(bytes);
> 	short nr_bars;
> 	struct bar *bars __counted_by_ptr(nr_bars);
> 	size_t bytes;
> };
> 
> Because "counted_by" can only be applied to pointer members in very
> recent compiler versions, its application ends up needing to be distinct
> from flexibe array "counted_by" annotations, hence a separate macro.
...
> diff --git a/Makefile b/Makefile
> index 9d38125263fb..6b029f694bc2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -952,6 +952,12 @@ KBUILD_CFLAGS	+= $(CC_AUTO_VAR_INIT_ZERO_ENABLER)
>  endif
>  endif
>  
> +ifdef CONFIG_CC_IS_CLANG
> +ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +KBUILD_CFLAGS	+= -fexperimental-late-parse-attributes
> +endif
> +endif

Will that still be needed for clang 22?
Looks a bit like a temporary flag to avoid regressions.
Probably ought to at least have a comment that it won't be needed
by some future clang version so that it gets tidied up.

	David

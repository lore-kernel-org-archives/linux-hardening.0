Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFB1DA4D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Mar 2024 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685342; cv=none; b=iMIwBzxuo+aPV0tsNM7JGm4dLG1aCDLOUHFB2Dke7PMedJ4Af6mWQCp/LaFkH2Vg3gsMjFiVz9wdWkAFdvFkxxTaVdkjw55eDqsPd7n38DlFMw5LfIZGkNLmSkQ9yBc8PXXNOYGO8eaPEibEHmkIoATtfOyHv6jIVIvEoOs+R5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685342; c=relaxed/simple;
	bh=AIXz6hFwPMo/63AZqDwu1il7uoR6aFXlxyvNoJ9wDyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWtbPXEgoIe3crcY3UXca/t5zu11c00SZJVnOUVW87ZC5Jn+hQzhIVjSGnd1P1NUIbOFm7NLfQoPa03vPG9KfEFlN1fljRM+GioPppQ6xUhQNqGyuh+QXF+LhLWan/Ojwi4Sycu4LU8JqRpbPvyBjShMlK8FXJTXMKFAi4TeKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBzFRUOc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBzFRUOc"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6c0098328so1399804b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685340; x=1712290140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GSIx6Wus4ZS9m3axSqWoJpxC8q7r1Pna+YZvaf3a1g=;
        b=aBzFRUOc9XA1X8SoUnr+RreRFORyhYpIxnJyOAkGVi4acPKUgigblZlQTB+bKaL3zU
         ir/Qqaf5GdrzALbB+cQ8GOFTmyP636z/jLTGdrAPa7asCIXU1CmI/V/1U2fwfqK6nS5s
         WfhWet3OoHiyMbd0mCLdeZKSqkjNLhkISwsdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685340; x=1712290140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GSIx6Wus4ZS9m3axSqWoJpxC8q7r1Pna+YZvaf3a1g=;
        b=u4MwnsIfpbJgg70CXef1K8szLdv8A/3kXoVsUnow8ywjE9rVzLwJdv8eTBT582OIY8
         CrAk8eEib9gH6zTb59Sh1zSQaiX/pLCz4ShtZ6huDzB9HQeIBNUKyhB0dDOeXROUuQ6e
         wELA2i4DwqW5FS10tI1mDUbF+eQHJdGZaoUkGo35oiVd1oJjl4SbklElyvM57qzs3hen
         EVnqjCmuxc+kl5AEcgH8lqACFoXOtzZBTYfUarjCC9ABONbENTK5xw7cO8qB3801Lq+d
         46Kdq13ILTvWvFAOLbVN367DRMjzlYALpVCuh82vsz930RGq6j2nS28EJFG77wWdVBbn
         QBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6cLSu2iOjYG87jeluRWwRm2M1FqEhClasCnDx1ZrjJbzpOThzTvZKTnxMy0+JFI6mcsJh/g8MedWS/0yC/ZhAwfUbNP3rXayOatGIqOey
X-Gm-Message-State: AOJu0YyE4uetf3h0qH51dwHp6xZ/O+2BFJWe42Asi/qumj8/sMYMuH0r
	beSH5gZ2y+ThN0Hqh4f5vCAG2A3J2hHVqZG1Vz8LJfmlM33lZl/xJyu5s0aOOw==
X-Google-Smtp-Source: AGHT+IGtrlqVd6FuifQbwlZNv3KdJx69MDDJ9nmnLRznOiLaCbnCwVY+yNnQYSAVDdPJK8/Q04vNkQ==
X-Received: by 2002:a05:6a21:a59a:b0:1a3:ac89:d478 with SMTP id gd26-20020a056a21a59a00b001a3ac89d478mr1468090pzc.1.1711685339835;
        Thu, 28 Mar 2024 21:08:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001da15580ca8sm2516369plb.52.2024.03.28.21.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:08:59 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:08:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: ecryptfs: replace deprecated strncpy with strscpy
Message-ID: <202403282108.7FF7CE596C@keescook>
References: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>

On Thu, Mar 21, 2024 at 12:38:54AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. A good alternative is strscpy() as it guarantees
> NUL-termination on the destination buffer.
> 
> In crypto.c:
> We expect cipher_name to be NUL-terminated based on its use with
> the C-string format specifier %s and with other string apis like
> strlen():
> |	printk(KERN_ERR "Error attempting to initialize key TFM "
> |		"cipher with name = [%s]; rc = [%d]\n",
> |		tmp_tfm->cipher_name, rc);
> and
> |	int cipher_name_len = strlen(cipher_name);
> 
> In main.c:
> We can remove the manual NUL-byte assignments as well as the pointers to
> destinations (which I assume only existed to trim down on line length?)
> in favor of directly using the destination buffer which allows the
> compiler to get size information -- enabling the usage of the new
> 2-argument strscpy().
> 
> Note that this patch relies on the _new_ 2-argument versions of
> strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
> Allow 2-argument strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct. I don't see any need for padding.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

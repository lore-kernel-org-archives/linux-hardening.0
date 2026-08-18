Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE543CEE1
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043354; cv=none; b=qaOVbL/eyTuCN3U+VJ2R4m4uxZC3zZ9GFKjhc4ht56K6Zhvzp6ctoEoIiZIgiMe+hk2oT3PA+JFUtrzvPqdlJycIZyPOwUkA1up/MiRwRJPe/vJNEdRvjOQ0+GZdMOix6MTIRlYazqorjbbbEWIsRGLnPF3zjMusS3XBXDPmmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043354; c=relaxed/simple;
	bh=C286L6tbBFmVSHmpGBeJxiKWhduKtxRV8w7hZXwOZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fs4/hy5nT9MYxPEAPs9wzOua02WRlI3EWDuVe6l63gY9oN+nEUx8HBPl44UOb0yBi8lhAaWx2HF4axqepF5cTLiB+34s2etG+aJqHsPFZMG20wjrSsVLLrw0Y/B/sTUN1li27AbNWICY1qS2L+I210+6KMyPFeJS7wU2RfUu3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBKsoiWJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBKsoiWJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2723688f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787043351; x=1787648151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCXFaMST6pWHnhL+UrBGfVhFKZlV8sK4DX8oPKUD0UU=;
        b=aBKsoiWJei+kPrAJO7gPNLwQbC8Ikcy8S3fibWbAU5HEibQR/an3/MbqC7zvZRrtL+
         sKif8SDTV8gptA3pLtb5KQ/19a71DWtK4SuV2lAdle5Oqui47K21ErM/fSkxfi7wQc2g
         qGe9rFqeKCR0eVDAGuVP/iPpjoLaS4CyRYKCRJ1gVaJlzU5tc7h7mMmHA8OU827Cajut
         sDM7gTnE88zEVNQVTkITcevY2dyxcHxzMGzk+kV49E6IYG97sUbFnY4/jeRVa0mRVxEy
         YK2v1Qg6LLNazZk5e+JBdyiRokveyeJfjqtzJstJSo5IQtg+Z8FJElEEeDzkNz2LDm1b
         xT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043351; x=1787648151;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCXFaMST6pWHnhL+UrBGfVhFKZlV8sK4DX8oPKUD0UU=;
        b=C+Rh2Y+9RYn6cLrvVrOHb2k74d2DFFqwlxDXX6JcOEvF3OodSgbB2tN5eqhzyHKjEa
         jiUlen0O4hCLZnOOMjA98V2Nsmx/Ytskpmi0AV2eCdgmz46PtFAM8mSdUmV243ZGem/5
         pCHplVAdVeWBSwpdcfjAYzDTKbVxdBjR9DhQKaA6CLJAe+fc/m++z0D8G5vDZSKL61RJ
         qlMGq2oqtFiN5VRcytTPx4p4JkKVPhv+t0qwTyM4RE+ndHWO+O97kfuPW2qlmN46VjBL
         037+VW5lQOa5HJwYQAyb3Y85jE0L6tC4SdYtrq7TYYYwLXRZ4rWlxFHO218tArF02RfR
         40ww==
X-Forwarded-Encrypted: i=1; AHgh+RpSJ/Y9x975wkFM2N1UNTRPiVhxXIvrkkp7HGR9tq3FAmFvwmiwZBc5iQnICgcgV6wK9KgH2a0WRZdcJuAERCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFU5LduKIsmO3vEzkBsMom527vuGWbt4HBMWbPtrkRbwLyiIiI
	jNhuvHNI7yB6U5KXiTbcxNjvs60HIv4vPxnIAmJJbCQ4NpVmPdqNPI9t
X-Gm-Gg: AR+sD13QbeuDUoOt6VahsVY+W8vxjBUwNn5Z9tn655kRwwsaWHTTurNbZyDvgOJkfco
	cdEZ5xtWoUcHlikdkaojboEk3yrS955BUzpfRUX2TQ0zhAAKvuUef4opuiaEOK12Nu3fHAREmpF
	Cb0KrePN9ZVZVxHNmZE8t1kmM15sfDpM2iqIjiLkCtYV/q+5Aw/ZRoJC8RAlwxBMP1SUxA7RKgc
	SJiAYyZ6vr/RDWnvpkgOkMvM4XIYIX+bBpXUHY1O1M3MSejTKl5fvC3LFCVbmAi7JnpdeH56wCr
	s64ohqdtiYlJnY/8P3ekm683O9OU9a/6tQs40uiQvpElYAB8IdeRhAO1kKAnh3hCpQ1J/A2KA9/
	vZvKNsD4f+O/d8uF4y/sgAJPHpSNkE0Rsen4Jaal4apYUJrYCCeVNvHPab+1EAGPAPolHkAcogI
	y1TDFOGX8QYZDWem5wzQ9+LEpmeWgpv97f85Sp5WWsb748V1sVqWJSvKWiYyNvIH74R/hAZ3vjP
	bhtMqejMjEsWWZrOlA6UYLb8nU=
X-Received: by 2002:adf:f84f:0:b0:47f:eb22:4d9a with SMTP id ffacd0b85a97d-482a90e80aamr8822990f8f.22.1787043350536;
        Tue, 18 Aug 2026 01:55:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81748sm10409553f8f.37.2026.08.18.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:55:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:55:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <mariianikitash@google.com>
Cc: trondmy@kernel.org, anna@kernel.org, keescook@google.com,
 justinstitt@google.com, linux-hardening@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 nikitash.mariiaw@gmail.com
Subject: Re: [PATCH] NFS: nfsroot: replace strlcat() with snprintf()
Message-ID: <20260818095548.27e0edb2@pumpkin>
In-Reply-To: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
References: <27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 00:28:45 -0700
Mariia Nikitash <mariianikitash@google.com> wrote:

> In preparation for removing the deprecated strlcat() API[1], replace its
> uses in root_nfs_cat() with snprintf().
> 
> Build the separator and source string in a single call using the
> remaining space in the destination buffer. snprintf() returns the length
> it would have written excluding the terminating NUL, so comparing the
> return value against the remaining buffer space preserves the existing
> truncation check.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <mariianikitash@google.com>
> ---
>  fs/nfs/nfsroot.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
> index 432612d22437..e951fe731679 100644
> --- a/fs/nfs/nfsroot.c
> +++ b/fs/nfs/nfsroot.c
> @@ -173,12 +173,12 @@ static int __init root_nfs_cat(char *dest, const char *src,
>  			       const size_t destlen)
>  {
>  	size_t len = strlen(dest);
> +	size_t remaining = destlen - len;
> +	const char *sep = "";
>  
>  	if (len && dest[len - 1] != ',')
> -		if (strlcat(dest, ",", destlen) >= destlen)
> -			return -1;
> -
> -	if (strlcat(dest, src, destlen) >= destlen)
> +		sep = ",";
> +	if (snprintf(dest + len, remaining, "%s%s", sep, src) >= remaining)
>  		return -1;

I think I'd have gone for:
	size_t len = strlen(dest);
	if (len && dest[len - 1] != ',' && ++len < destlen)
		dest[len - 1] = ',';
	if (strscpy(dest + len, src, destlen - len) < 0)
		return -1;

Although it would be better as an 'add_option()' function.
I suspect the it used to be just strcat().
(similarly for root_nfs_copy() which is a pointless wrapper on strscpy()).

Much more worth while would be fixing the sprintf() for NFS_ROOT.

David

>  	return 0;
>  }


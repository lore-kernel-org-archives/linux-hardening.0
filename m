Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92773303A03
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112892; cv=none; b=YliGnuy+nRV2rqo9vdw/HwABtKuWUcL8Qep51pO+6yunoZYQCIRqXUqAehPhT6NVbrC+odrjzNlT+zd6yMggDhSOd3BeSLn5DAu33vwNG44GFdPXFKDPfPCzmF9Ooxu+p14hAo3h1qop3w1Q0PiZ40uPALvUbhU6zee/3djb4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112892; c=relaxed/simple;
	bh=C8PM7WxuPGZdfL2k/hswcOqc/x9TppYivbKp35Py/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgimC8hf9B+Hvs/xBS20/hqBExArxS16I+3qQJAJdKMroRMhMZ/9x4UfKxYBekz3IHayTP3nwkXSlitF9xclglUHZnEBqvcbyXTWFfhpXI7c9xKqK8l0zUKzr1WiIpBIftgFhhHRzUSZ/w1TpX0iFj0qOW218TTZ6pBas6wtW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRVIg1Ih; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRVIg1Ih"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so8633035e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112888; x=1763717688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=lRVIg1IhGsjmG62zRqIW0jDcktXfh9q/PpJATyuviAZzYLc8UHQmXvO2YSvaQhWTRl
         noPEUDml0I4cmFggHx4LH9Ygb9LYsmse3lAv2yNe7BHCptZXffV5q54tPu/h4eLqKQ/G
         BBjMRZ377eMLzVyQEPHwOU1a9MkX+qCedmGee7ga2pxB15UCs1SGHcxBiP7aSGdUqcE7
         CIaB1+MzZJtC/XsoPcf6JQcE2E5L/OMX9SAQRR8AgxVjjyyDBOYzwHP5t9ZZ5lPFM5c9
         O3D4oN3c2jsY+XLEQIA2AWaUqwCpWcWJUWr01hLtFFqX7EHi+aNWgpXSkXTLmFh1vFzY
         lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112888; x=1763717688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=mD+SeBMWP2LDcJjxNaZejDmiEnNlHD5JvHH1maB4P17NPGYBdQo51lmVg7ToVbccW9
         x13N+l/LDGgIo2VinhxqK8Nf2Rl58UCg1oVElgSLcAu3pc6WOTp9t5MXyfKnffIf+Q4v
         KTyNXaTs9XRk3VheiSpWcwBuFD8Fb7l+2aBhfJRvGPOw61K9FvPr4sSmuokYVRWS39S3
         E39iJD0Z5vgoDFGxHANU3tuJYh6F8wRjMUlVfzck+e0ozm6VVmnpuqR7qMQ6qqRx7WBN
         BJO6EczCLzvI+dLClXb2wDAcQ8Me1FINcsrwQJ85CRzWlgPSVomXA6z6oZeJrIJlIQtZ
         hwig==
X-Forwarded-Encrypted: i=1; AJvYcCVzrtd54b9GfLWvfAQXirVeES0xnE2FCRPPNETE1H453TssPLLztkcsJPjc1g/6Syl5o+ed8LWKABovM7/tv/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkaXKhJ8DlYwbOjxcZtbUYKTO+c0M4I19qI6EQ3hOBbtE3wyZ
	vHqWcT6TCVgDnliR55+5hVA68GfmkPsAt9ElD7cC3yWHvMW6bVOciJ6oyLg1UQ==
X-Gm-Gg: ASbGncvUSE4KxBKbx3X92O1jW0+an8zaMnO3ckY29AogEjvK4Kh0N0QQHdlkCJ7t8AZ
	wf245X4vGu23QaARd0Husb71baLBg41rlj8jDWGvRa0ic4XsRYOqg17ncEJGAJrXB2iJ/DmGBXE
	bbLZrnbW3P+QJ9fCPqFyqQh6/tzrmjAxPEBTbohQC5S9o/9YEGbhqwCkjBshuUf9ANwzzVenvCr
	qKK8stpIig+q4OMTktdA1Gu28VB/pEvC+bOBUNoBcblV9fyM04znlTSbxUSjUWTjgYC8/IHPCl5
	Ss+FtpMBPI9rmILJGAAjJKIJVzZaciOBiPnENp0t623+HYoCB939dQ4CUAH2bp0agEvZl7iwFqu
	i8zSYbPM6J/KJUDHaLR0H/IigO3fb+OxL8TzewwoeYX5L838f+vQKApr4XdIMy4B0dba+8x3QGS
	9AGvYJApjiDjHbxyJF3MVCxxoWYIdiySQI4fYamnuieX4GYWhcB4xT
X-Google-Smtp-Source: AGHT+IHMhMM/WcqOC+40/CZXzxi+sVHMlKI3vfKumXj5CG2qbmIl/AdQzRU5H/oZ2Xbc89Ibz5CWGw==
X-Received: by 2002:a05:600c:a44:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-4778fe69cb3mr22853755e9.10.1763112887580;
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm131781785e9.11.2025.11.14.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Date: Fri, 14 Nov 2025 09:34:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: encrypted: Replace deprecated strcpy and
 improve get_derived_key
Message-ID: <20251114093445.0ec74428@pumpkin>
In-Reply-To: <20251113215546.136145-1-thorsten.blum@linux.dev>
References: <20251113215546.136145-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 22:55:45 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated; use the safer strscpy() and use its return
> value, the number of bytes copied, instead of calling strlen() on the
> destination buffer again. String truncation can be ignored since
> 'derived_buf' is guaranteed to be large enough.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Revert some changes to include the trailing '\0' even if key_type == 0
>   since this would change the bytes passed to sha256() (Eric Biggers)
> - Use strscpy() and its return value instead
> - Link to v1: https://lore.kernel.org/lkml/20251113135831.98587-1-thorsten.blum@linux.dev/
> ---
>  security/keys/encrypted-keys/encrypted.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 15841466b5d4..94408909f1dd 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -330,23 +331,17 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
>  			   const u8 *master_key, size_t master_keylen)
>  {
>  	u8 *derived_buf;
> -	unsigned int derived_buf_len;
> -
> -	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
> -	if (derived_buf_len < HASH_SIZE)
> -		derived_buf_len = HASH_SIZE;
> +	size_t derived_buf_len;
> +	const char *key_name;
> +	ssize_t len;
>  
> +	derived_buf_len = max(strlen("AUTH_KEY") + 1 + master_keylen, HASH_SIZE);
>  	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
>  	if (!derived_buf)
>  		return -ENOMEM;
> -
> -	if (key_type)
> -		strcpy(derived_buf, "AUTH_KEY");
> -	else
> -		strcpy(derived_buf, "ENC_KEY");
> -
> -	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
> -	       master_keylen);
> +	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
> +	len = strscpy(derived_buf, key_name, derived_buf_len);
> +	memcpy(derived_buf + len + 1, master_key, master_keylen);
>  	sha256(derived_buf, derived_buf_len, derived_key);

I'm not sure this is an improvement, but has this code ever been correct?
The buffer passed to sha256 is either:
	"AUTH_KEY"'\0'master_key
or
	"ENC_KEY"'\0'master_key
For short master_key the buffer is HASH_SIZE bytes and padded with zeros (ok).
However for long master_key the length is calculated using "AUTH_KEY" so
there is an additional trailing '\0' in the "ENC_KEY" case.

	David



>  	kfree_sensitive(derived_buf);
>  	return 0;


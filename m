Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25804302CB2
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700335; cv=none; b=SWwDJbGOA1SE9KhdqcvcUuCH1ehLytWRLmPr3uUunRAIOjbzMZV1f+CLRk1rytFCL/vMhHihW/gi/wt51UVkyWNnTSY72vvUdOgWo7JMJj4FmzGQrMI0Fywar9+zRHVu97rcjrMjYtNC46Rp2b9XzkDA3tkdfiYzxQJ5WmNIr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700335; c=relaxed/simple;
	bh=N/wqAgrO/zhmnFI1nBfWgzHwsyg/LF9jTsJtR4dZsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoVIa6rW/DD07A7lG4oZ45TSIfixCezGH4wr8kZOJAEwMy/iaUtt2rAXaO4F1UqW+ub43xdQsNzYCwPeAQ9VQcvUHB+sSPe+1FjEqD9/CmJ2Q5sqLyJUbC3eah/nVPbZsM1SIjDvWIKaqP4LgzbYsrnr7VdKUCBMk9ZYlNxifRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xw+CDHx9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xw+CDHx9"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-410c884decfso23079405ab.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757700333; x=1758305133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=xw+CDHx9lfX/c9sPgkJ8vT2/2jJBIOgxTKLQzE4uLHCr2+MUa91gFgUY5x+8z/KrwI
         596uQ9w0zBj48zHff6+o0dLqpYaIZzj6B08w7sToYgGWWRCHnA6ZmB/7FLeZcq0TsXMN
         Wkl4M2XQeJFmf4SGF08o3blV0AxBWTn+kYK8MhSziCwJLXfWg7rqC/PcTERSWh5OVneB
         C+8MjbbMUPjJpwX7uQHIhTnWxWaaJZeIvHcXLOl3CYSQqMuu0XjIhnx3FbmYQM3slDw0
         oQ4IKm6f+aa3c8lWSO6YdmjK43pIOxbo9W38as7kK4Dw5Y3Xc3AIYDRnDvuOBHlwSwLc
         VzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700333; x=1758305133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=GURsDq3IXeytC9E4ZESKGJJX7zLfSu89egcW7OS1Inwg5dHV1Hn3MZPffCs4QxRvmY
         IfKXQStREjpE/WE4bB51LUCotDXN7fDaN6bzm49A+RgUArKDdW5vgobtJXhVQ4sZl3BX
         mk/1mUhUmDq7bXmDu3BQEx2IQbckGPlB5CZXTC2kklp86VOJgLOorhe6TsR0fgwe3+rd
         Gb8Mkfu8YEXM6olD8sYGT07Okt76uyEUw0dfFq2OWUavFJtP8FLsrTeubnCmrq3R0HIE
         YFw+L1mEihx4y+xqOCe4L8rKPosf8LkXQLbbyMNIU3WChBrh4bE8iEBc6glqxdV/LkPj
         o+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgdG8IhhomZANr4sDd4duJzCJJOCI4HcVaaUh/HANpnEaMflMN8AKjAX2Z6gRe22bUzVX1BGXo5ouDhGLaZZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntVbUxs0y+tSzMX9Odi0YK1pS8id8ik4znkhq1icV8cGxNOIY
	dR5iogAzlEFPtiHcARuCxHoTQUAm0ZWnLo0qDxAJowExdUXOPyctDouvgA3hnSDNdQ==
X-Gm-Gg: ASbGnctyxpDSbdi2udDSBUu4wdpMBAFl0XBTj/DIaUHdwUWufwbM9ZVNE4lr4CNs0xB
	k1eZNoSwRTiz2GuPUmd7H94sLnIcZ3PE8sxL068kHIPj9Hs316JwX09jeDp44MCcKuZFfUMVBUo
	w8bIdWOZp2z1C8i1YPE3soy0py8raJFm1syAjYvzG6keSwby9W3+zIxVlNDjqEY2NG9tFxk+YX1
	GwEAPBsfGbi7h/xlsxiW57hu3mH1fN3PS6BG+RDLOId5Cb/O5jtb8yn9KeVi2ko1IH15+MxNb4U
	M0Oi9CJ6FW6GntoI0i+eU8Rt/wneVJxPrI+D/J/fIBHglLoeryyUGNM7rpwjoz6yM9BhU1DULT8
	dbjK+kFbpzlTmCpZYpWVEQt+lVesp0SI5bnL38oTEwTUq+ymCchgTHUmyspbSJ+PsN8keOGwj/w
	==
X-Google-Smtp-Source: AGHT+IGJCURFvMxoZWZd20cUZQaAwt7BOfCiB9UePZcFNpGBu6mZoPeVrn4XW3nB4SQJl2xpLBtXNA==
X-Received: by 2002:a05:6e02:e11:b0:421:bb6:fc6a with SMTP id e9e14a558f8ab-4210bc6491cmr47318185ab.2.1757700333029;
        Fri, 12 Sep 2025 11:05:33 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067bb9sm1854661173.39.2025.09.12.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:05:32 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:05:28 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Message-ID: <mv6ck735oa4ix7emkjtgt3cwrbhyizina4tady26nzx6otbvi2@ngewjjf6ahdf>
References: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912064724.1485947-1-thorsten.blum@linux.dev>

Hi,

On Fri, Sep 12, 2025 at 08:47:24AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 097673b97784..6745e3fbc7ab 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -108,7 +108,7 @@ static char __init *find_link(int major, int minor, int ino,
>  	q->minor = minor;
>  	q->ino = ino;
>  	q->mode = mode;
> -	strcpy(q->name, name);
> +	strscpy(q->name, name);
>  	q->next = NULL;
>  	*p = q;
>  	hardlink_seen = true;
> -- 
> 2.51.0
> 
>

Thanks
Justin

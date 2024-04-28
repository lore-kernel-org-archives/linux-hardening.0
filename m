Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8056B67
	for <linux-hardening@vger.kernel.org>; Sun, 28 Apr 2024 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309934; cv=none; b=LCEVrIaBHYNprhZbtUB383wl7QlyljWBQVAZKsCHcdMNCyeVnqn8z+77Tm0rR7OAFPB1qbHAt8wqpWjMu4cNScxHHimXMNa9v/9APmJ5ze4LdeQbajxeBY4gBFiWl1T0HyVfIJALbSX1E4Zvpb5WmRB70n0OV4jrlGM5n38snrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309934; c=relaxed/simple;
	bh=KLxM9YkdCvUGN0XvVsZ2GkkSmsruBVL2Lgf+5mm+kSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U+7R15PwuLktRHmG/nUtLaTqKcZ1sWvlQiSGQUY6WjKFDTTevP8j/DljAFId2FaBjYl2T/M5LRQHQVdmqsn4jwb8v+B0VkNBy8f/2P+2dU3R3Ya4q+lEgrgarC0GbzaPWBESa9VTRjfcIWnsQQ/4CxddfTW/XuPeS8NIDDUal0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xas8rZSs; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xas8rZSs"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso43229591fa.1
        for <linux-hardening@vger.kernel.org>; Sun, 28 Apr 2024 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714309931; x=1714914731; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ek36Ely/+scMwi7ZAeRLEtew44ioNM5oYhC6FNlT0xI=;
        b=xas8rZSsSj/HhmtpeurAT3P01Nkosba76wVlawilikfATBjLV9nGGFSx0rN5rXFVSK
         rdCN/tq+Tu7Ln+vQFWFZw7z/wkAmDw0BpxiXwmCLKSce6BDCzXDjWCorRmTef97gN/H7
         eMbwHmEmrTcUqGjlnUUZ6NBvim7KBGNn1PJhj2eAaL8gadVkZK1pjyaB5KX4Jyo0gcNn
         9cvElR3CX1gm4NUNcVGTbv30iHbC1msZ/a4s695H3udPDQs9D79Npj3PUUa9k0w2mVwU
         L77H9qj6yjh1ebC6lhEggvf4nk4cjZSt10saBX7nbgk75P+ccZBxZhuPYe7Do0/Ell34
         di7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309931; x=1714914731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ek36Ely/+scMwi7ZAeRLEtew44ioNM5oYhC6FNlT0xI=;
        b=sJfTxMK0oaibiykm9SmbuL+n6dpqu/9WO3qw+SVmMEHjZAPCmdwZFY05efmVecSh4m
         9uNGGtZZGBRrX3q8hlLWRkubT4W5KCPGCFj6ff9D0EgJ1HQwqKzTO9slnyGkzOupL5wO
         8Kvjb+9M8KMOjKka4VFnJ282IEGOlCeBQCSEYyURDuYwrNgkUnVfS/gaIHgdrP1RHHPY
         BfNdIA2P69HB+k1sSiMveKOW5HpG9ycMYvl3Y/GD6CuvaUt3q/hNK7LqtRkkEgftDiQ0
         6cSnanr1mZMIJnelH4Nflq7zQodVi4RVUCZHLmK00ZQyUO71gVd2oSRKu7lpjH2+l9vh
         sS7Q==
X-Gm-Message-State: AOJu0YxQnwc/v0fUwtBaH9la/uu7zF3g1AA2x9NxcfRF69kuy6BFogwW
	RSSdy8egUfVj1y3tOa61Du2vIX6FwzylZYe5WWjq4zkZxaNnUZhgFbL7NlfCEjc=
X-Google-Smtp-Source: AGHT+IF/TZNLcxN+Q75lqk7glUXfuSVex5fY5hbQREJfj2J4DwYtYJ0ssqTgpuPBH5gZNETuxfo20Q==
X-Received: by 2002:a05:6512:2001:b0:51d:910b:4acb with SMTP id a1-20020a056512200100b0051d910b4acbmr642083lfb.59.1714309930836;
        Sun, 28 Apr 2024 06:12:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q13-20020a5085cd000000b005726b83071esm1735966edh.4.2024.04.28.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:12:10 -0700 (PDT)
Date: Sun, 28 Apr 2024 16:12:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: dm-devel@lists.linux.dev
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [bug report] dm ioctl: harden copy_params()'s copy_from_user() from
 malicious users
Message-ID: <f84a96d7-2df4-4f79-8c27-83a1d9574412@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi DM Maintainers and kernel hardenning people,

drivers/md/dm-ioctl.c
    1931 static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kernel,
    1932                        int ioctl_flags, struct dm_ioctl **param, int *param_flags)
    1933 {
    1934         struct dm_ioctl *dmi;
    1935         int secure_data;
    1936         const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
    1937 
    1938         /* check_version() already copied version from userspace, avoid TOCTOU */
    1939         if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
    1940                            (char __user *)user + sizeof(param_kernel->version),
    1941                            minimum_data_size - sizeof(param_kernel->version)))
    1942                 return -EFAULT;
    1943 
    1944         if (unlikely(param_kernel->data_size < minimum_data_size) ||
    1945             unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS)) {

So what's happening here is that struct dm_ioctl->data[] is declared as
a 7 byte array, but it's actually a variable size array which could be
more or less than 7 bytes.

    1946                 DMERR("Invalid data size in the ioctl structure: %u",
    1947                       param_kernel->data_size);
    1948                 return -EINVAL;
    1949         }
    1950 
    1951         secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
    1952 
    1953         *param_flags = secure_data ? DM_WIPE_BUFFER : 0;
    1954 
    1955         if (ioctl_flags & IOCTL_FLAGS_NO_PARAMS) {
    1956                 dmi = param_kernel;
    1957                 dmi->data_size = minimum_data_size;
    1958                 goto data_copied;
    1959         }
    1960 
    1961         /*
    1962          * Use __GFP_HIGH to avoid low memory issues when a device is
    1963          * suspended and the ioctl is needed to resume it.
    1964          * Use kmalloc() rather than vmalloc() when we can.
    1965          */
    1966         dmi = NULL;
    1967         dmi = kvmalloc(param_kernel->data_size, GFP_NOIO | __GFP_HIGH);

We allocate the correct size of the variable element array.

    1968 
    1969         if (!dmi) {
    1970                 if (secure_data && clear_user(user, param_kernel->data_size))
    1971                         return -EFAULT;
    1972                 return -ENOMEM;
    1973         }
    1974 
    1975         *param_flags |= DM_PARAMS_MALLOC;
    1976 
    1977         /* Copy from param_kernel (which was already copied from user) */
    1978         memcpy(dmi, param_kernel, minimum_data_size);
    1979 
--> 1980         if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
    1981                            param_kernel->data_size - minimum_data_size))

Doesn't the kernel hardenning stuff have run time checks for if we
write beyond the end of a 7 byte array?  Why not just declare it as a
zero element array?

    1982                 goto bad;
    1983 data_copied:
    1984         /* Wipe the user buffer so we do not return it to userspace */
    1985         if (secure_data && clear_user(user, param_kernel->data_size))
    1986                 goto bad;
    1987 
    1988         *param = dmi;
    1989         return 0;
    1990 
    1991 bad:
    1992         free_params(dmi, param_kernel->data_size, *param_flags);
    1993 
    1994         return -EFAULT;
    1995 }

regards,
dan carpenter

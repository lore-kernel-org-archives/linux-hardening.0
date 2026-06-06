Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C945BE3
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790114; cv=none; b=oxhcSoiRO0CFDJ2no/RGI6KfsBxb2NLguKvmKVuwaTKfRPomyrQKX4zLWx4N32a7vaCnOkQWlGYyyD0yKNsyuNIRIUJYLIUSXvW9MOvtULJMFziPj6PRIUBJUI2OdIoKV93mqJbzGSIdI921Aa2IwqVzO2f0DS7FSzuXAfkpBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790114; c=relaxed/simple;
	bh=K8OYtNJC3IIZRMBqEi51lk43u3HkOmDMFO6SNuAuxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8BWyvngjHbockD7OmnLUpN7FE6ixPl0pqYUp5uHBnub6d5+TKphE3TnWhJB41Gv4rZ+qOWrYIUeiYnvJlhOrgNyXF2Y54ywDqC9TSwkZsYtO3v2YDkU1bhzYW5wg/9vOKuVUnqNmYiH9rBJdatnkZ81GBGHRFj5FrjfQDW80dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=CjTBQgqW; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="CjTBQgqW"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4865e953031so3687373b6e.0
        for <linux-hardening@vger.kernel.org>; Sat, 06 Jun 2026 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780790111; x=1781394911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=CjTBQgqWJ1AoG9moWTWz/rQBt2XUZTccRHRslxYYs8rDeuZpPFCHGbg9VlYWySgi/M
         v+skadR8BA+TmVHyxiH8MN2S9tpcYgaodi+e8NJUN4oT/9dw24a69wRaPWJqVTzFs5El
         /EI3L5s9ZNmjOQ3JMpDrqny+DSq7+oQcGwt20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780790111; x=1781394911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=ggFuUkKWUwH0C6gbs7LoWCYE5hKPyimGz65FM1mkX3tOGsyWOGNHb6MQ0tT7kius2l
         gTxJ6wpvQtEdrE4mnvWefQUP8yCmaX66SCSZeygZ22meCoQAH5tJNiOk6a3d+lVl1cF/
         q8Poq5iC/5DxELAmFgz7/yOhOq6SYsoLu0MJHtDyzvBKmETcXGZhuHE1j1cKUVdbE64k
         /IMM0fMiQ4czG2193AbRebBZfVb3H+6lfdQlNSS6vDqMfWrE+mBbNI+x5sq7CAhJj0NX
         zD6Auf/Mk9Mrnp3UuhIe9h1XXgKJJoFD+65K7Yz6tONnOkw6pwxMZlruolIh5PJLZzcP
         kiog==
X-Forwarded-Encrypted: i=1; AFNElJ8qPHiWldmOA1tKwTw5cyGEd6J2/IqxV/l+ppqMQo3GkWzGEjaDH2yKaTNu3bqdoFCceD9Z6p68r23hv4z7oUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLsfmyRthgGron6cDPQSflX/LKtfLwnGsZoSfVk4JCwOZ+NrD
	pEMShOusMb1O8VNMpRFFq2ZHl6OqMaBVEqQDfCUqEZfoSGPtsVxQ8OSNsZhjNvk7gw==
X-Gm-Gg: Acq92OFhzzjKTAKz9Xww+RZWU1LHWXyncdrR64N0yse2hEGS6mJgrvccLhS6yv1BbDy
	dxSzS7pNcUSkJFZsalSGRp+ivnoxl+a6kMnUH+lWUTIiAVJZYT6EWoXJrm2lFlH3tszBJvHyNxK
	kYA58xfeUDZWIS1jytOfKoe3OZIlG5W4lFnG+EoqZVilGcga4DIJF2RUx09uNhnWZ+UHsSIJz4D
	OW2hoN9MidF6nQqt8OMcbL2D5RcWZBc34l4FVjO6hz4sA4DNd0+0MWQEE4/hx6UXW6jW2eUsHdp
	2WK9bKcTGQsoBVoLd2hFLWU76SIMmb0IlwoWmB2pshkONbEH4zxVWCq1UTR7d1jdCS5YRwUzDl6
	5wGEsFmoBtkbB8b1T/DkI0VY8DiCIXXI0qbZw6xKYcN5cLrjJlHf0Ct6JXvFl+OlZo0fq4VTAIv
	jAJ28TmM33pU83w2eOiUxf1xrWKiflRUUVK195eT+WO2Y6vfeSV2dt
X-Received: by 2002:a05:6808:15a5:b0:479:d674:dcca with SMTP id 5614622812f47-48692c881fbmr3789772b6e.4.1780790111555;
        Sat, 06 Jun 2026 16:55:11 -0700 (PDT)
Received: from [10.211.55.5] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4865b5a53bcsm10302924b6e.3.2026.06.06.16.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 16:55:10 -0700 (PDT)
Message-ID: <dcb49836-cebf-40b0-81b7-c06cf84b81a0@ieee.org>
Date: Sat, 6 Jun 2026 18:55:09 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/26 3:27 PM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4065336ebd1f..632fa2d56ea0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3672,7 +3672,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
>   	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
>   
>   	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
> -	strcpy(rbd_dev->lock_cookie, cookie);
> +	strscpy(rbd_dev->lock_cookie, cookie);

This looks good.  The rbd_device->lock_cookie is a 32 byte
array.

Cookies passed in are always a 32 byte array (despite the
function only requiring a string pointer).

Reviewed-by: Alex Elder <elder@riscstar.com>

>   	rbd_set_owner_cid(rbd_dev, &cid);
>   	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
>   }


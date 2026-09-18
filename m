Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6C4FB9C0
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743909; cv=none; b=V75Q/28y3O3Bw4megAg3L4FE6iy2TEzvw95zTzya5CBK1Xz53LzUUbUmXK6mq4Hv4PFIYTmzuVvewTuImkNAzLECF9zGBlXtP6fmsTTCfR6xVNTABaxVr8icgzB9wZx1xOSvDLwAxhvB6lBP1V/OWJlvq++nT1wW8eE+VCiaK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743909; c=relaxed/simple;
	bh=f8mvvksl1SUaVUErzE+wRXUolyqXSD1KXdzSFkjjDE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwbr0wi2EkFKEKaRkJo6GsaPW0KJk2poFGjdtw7FdNN8M0QUowjHS1EIOl02xm4eW8Cwx4z9dUTHxfLQFedT5KShF3IvmquZlk4NeQJp/xaJy5fD+ihoBrstqJt7yl/UwdKYkGZ7tvMoAeyJSlowey5K/iHHr4EdIY4v0fg/Uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTT7/XGJ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTT7/XGJ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e2254dso112425b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789743907; x=1790348707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e7y/CcPBO636TJGAw7k8rF+8LZq12IShhUAQly8K8oU=;
        b=LTT7/XGJdCSSeGDn6WqL0si5ZPiQRGsWXA9G24uNBrdbQkiyE4jaP7vCPjT4a0ZGk0
         X7nCTS5FOGS6wKbuCSOxXeLJ+b0I1x/xc7ICeiu4mGKd8dYYORqqEV67JXhBiNnzUbsd
         hf/iv63j8k3zVTEvirym4XgqwoHrSICiCwKLJWavSKwGgqrFzPJjs2EE3OzfJnfgT8E8
         oW9asAi+JlkvLLKHaBW2zig18FLEuBdMsUm63R7twIuvt0JhcIySv7qC5i1/9IPHcfO8
         YEdCV7pK4krnGuthPnhHqRoWnpcO4uow2SywN8pm06aKE1PQrNyUdsi0eKo9E93Z7tne
         n0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743907; x=1790348707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7y/CcPBO636TJGAw7k8rF+8LZq12IShhUAQly8K8oU=;
        b=E0y+FeQX+ce32y1BRGY37NrXPk7tho3bMXZCuP5YLZWdQ4Mi/jBqQUe6c4EcnAcAUU
         Wq5Qhbx0rIDaZ78dU8h8LSXiqmBATmGCdLgiIGNcUUqLNCmCpaOqyv5epLtAaD5F1gR1
         kX/u3aW+BpOsd/A4DJNFnQpR359ymqGgcC4OAeb6jEU9N3kRw3pNJZCRO/dsVpmS/5BW
         Th9XuUrQAUXXg2xRBU5FRM7C5ALzxUGjo9QlrYKGkBQaqv6leaBbC6q74lrUJQ7UOYSd
         Gcuiv7+qEHd9dMq43Nv9Uc82efBa1T3TZ3a3ucHZqy5xz52oRRbc/ppUWD8NCxVtjOTU
         DRYg==
X-Forwarded-Encrypted: i=1; AKwUvBzAEv1vZpaerFecdn0vOlx6BpeVTnKPufNQCK4JGvAqobF9Wo8hw8EKj8ldKneAt0zF9aq9ls8tQmm7P7HQL/0=@vger.kernel.org
X-Gm-Message-State: AFuF++l2/GWfCM+4J/7yqgT+GNbN05Lj1P4lzVXahj3nyCZtJBQ1ZRn0
	ija5U9+zmjcPTMl2E0Bgo+dXeBuv0FjttCg5G+zSVQaC28cSdd31ckIY
X-Gm-Gg: AYBFou2z/2cbs5NiI3lXVZpp853wM6eHQgdSQN2ZULmiVvn9v7gOZ+z7h6N51qZCZrT
	0E02KjacGImguRYonivGp0xnjpU9gbRsiPi25lCL+ZTFqN6sR1GVv7N0/HLEad+asoXWx30QTFN
	viwn14WONzxdD2bvHZnixx0tWJZO4tD8vn0PJUfTQtyp5FcIS1jgnRncopxHiwYOqWzFNbFihs/
	YV23fuiV8pT1C8TnagUv4tFHWi+lPJV3uQgOJ7oEBLvi1LLCxxQ9hYizkzfK5R/QKVsZZDufzJH
	RxKR36/WOdXZ5sqLxK/NwJn8/pSnG8SnZFvTFLafPkwUXqjC/QbGAqJrLkMkqe1kPDta+KrwfG4
	3t3JoyPuef6EfxOzUsRyFmKIRhxH6giSFSQYY6ilwPcvbgeJzcGKVZjR/x/f7n4nfMFNnuzuWpV
	k5Gyj14Z1xSrnJ/jZuXPaNbagU3IuidQMp75EdGGcZqNE+32+UqDCVY9k/l5GjGV8/p/yxd/tza
	Ikb/69TDCVCGujo/LLDs9s=
X-Received: by 2002:a05:6a00:6c93:b0:851:8bde:7861 with SMTP id d2e1a72fcca58-874d259ea4bmr4306819b3a.1.1789743907066;
        Fri, 18 Sep 2026 08:05:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dc8fd8c3sm1042506b3a.16.2026.09.18.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:05:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Sep 2026 08:05:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: pwm-fan: Add const to channels allocation type
Message-ID: <4db2b003-f66e-4c15-a9ae-a8b4483f1168@roeck-us.net>
References: <20260917211417.i.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211417.i.173-kees@kernel.org>

On Thu, Sep 17, 2026 at 02:14:18PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "const struct hwmon_channel_info **", but the
> converted allocation type would be "struct hwmon_channel_info **", which
> is the same type without the const qualifier. As there is no general way
> to safely add const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/hwmon/pwm-fan.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Applied.

Thanks,
Guenter

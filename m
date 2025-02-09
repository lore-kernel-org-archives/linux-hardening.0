Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2E39FCE
	for <linux-hardening@vger.kernel.org>; Sun,  9 Feb 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739082250; cv=none; b=LfcLMJ4KitOvJxLBnmVONWpPWbRUUlRK/U2Z8W+WaHzYxQ4Se0WwhUTpdByRXyZFWOtbsBW3y2azUMSw8MzpneoicpxYX4qrNtuMX/YsZTbEC9hvcTuN0h5kpyaN8fTQeUwpaBc7o2y/DYS2UN/O8ztln0L2FsWw1PZseqUOwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739082250; c=relaxed/simple;
	bh=aE8Pr7FMgBpzGLwqUQPLB4QILiBDleWz4ZaabRMSO3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCdMkvst1s1XlHBLlCljwAOzwqPHXFEq314ivkOQY7U0ctYklspQxaNjiPLHnqf0WqPzSTgWNSJky6wr5zogT1B+0bXca9ra/7FnPei0O/ZHiEzLFtLWqvDdYvvb5OZ1hujSpn1L0SBCpWkObhHjBanLxovqDu/gxfD2lg/MU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FtUcMwlB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtUcMwlB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso1837520a12.0
        for <linux-hardening@vger.kernel.org>; Sat, 08 Feb 2025 22:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739082247; x=1739687047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTto9Kr8hhs4LG0n8TSGyp+f3yaAmq1VIFKY3P9KHF0=;
        b=FtUcMwlBjGcQm5TpBrrrZSc1mtPEy+KFHo/653m82noS/CzyuNG9SPjdjcJyxelUUe
         h1N+NiIxjF3WH0zlm+nAE50y8HvWYYJDaFAjs4gZqpm5tD1fxktpGT6UOjt2DUZv9w4i
         mQlkmsBGdIG0GqbgJUZQ+hshLkCwikJw9RntesMheXGA9Gw+ACZPxlYG5+JakwOZmvt6
         jRwwPHJQEVDUUPXBs3AQL990P5/0wE3d1s96w8Gy+RWJaDjLZHgB8sVSD6eobH4liCPv
         02hEgh7oDTbArzfU+4PdOSu8wzsa7wPKTKKgpqK+JD7w0WizCeFa35YXaNXJccNzZTFK
         QcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739082247; x=1739687047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTto9Kr8hhs4LG0n8TSGyp+f3yaAmq1VIFKY3P9KHF0=;
        b=F4wAQWPVxkDr7eUMjOyeMM1No6PvaiLOTigqS1V8+5aNYuNBh4bnfU9uNqok5tjBd9
         FplOzLxByTqjPahNgTl/SqWLbTkyOUP4h1+c2/BeRWNeGWVyGyoM03+5plg5+cq+3lxK
         6GQgSVLKAXcl6S4sIlW1bIFHXMXgX58P11DUvB7+y16bpWb59PPc7oiOvRSIwdgnGeTY
         VHQkjDNs8E5JQeOBJtJ7OG/N9UUUe2NGSFf5CCBHkpKe8JsgvM5JwZkfAH6qWgFtNFAi
         xjGBv4pPrFoqY8uuaIASwH4XlWpvFPGwTh8IbbtcYIbV41GBLRsDX9LGWg2CRN/LuMMJ
         eRyw==
X-Forwarded-Encrypted: i=1; AJvYcCXomRAseciUhTwwTj5qJwPe4P3ZGnFt/hIpjGyzJglEzFiWR/IXp0JK+LL9Ny6na6YtnuMjBuqWzijp79I7fok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3bSFVcWgiJ9BED/IRvp8eOtFc3Dnr6QMdzXz26Qvakf5pCex
	GZAl9z7bxeoKp+cU+Eqne6y8BpP/Xa2veu2eME26Xvz69etPD8+wiN8n8qqfA32x3VzjoHpGXk3
	n
X-Gm-Gg: ASbGncskLOiGmC/habsFbnc6+oj2xIyvrJHB3T9hVl+7nkflHWpzYn8oyXVA4BQeEQU
	gjHYwfqFXf0loo+56mcahOgaPuY1lHbYw/MQnN0LWIq16R5ELL1ksuFzPk3HIRAVEkTk/bPm4iV
	hBF5SgEk7eaq8lMs0gOn33PVYR8hAL7xPk+aLvH8qHT0MG9drKhIu10bY20XUq/THarroZfjZ/b
	eeHxBXsjGk+OeaixG5KyhYNwFrojULjk9nWLWcUhXhxOOyFBqsXZbXLb2vPJc07ATbsaEXQQeKA
	HLa+b71/RxB021W5ZGN2
X-Google-Smtp-Source: AGHT+IES82N8C+fmH6KFZPQ2PcILhvhCYo68TATrCctmduAL8AzzSocttcg6O+pNFOFLcG4GQSgsDw==
X-Received: by 2002:a05:6402:4588:b0:5db:731d:4456 with SMTP id 4fb4d7f45d1cf-5de45085cc7mr10374231a12.28.1739082247149;
        Sat, 08 Feb 2025 22:24:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de63a89b6asm1714510a12.46.2025.02.08.22.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 22:24:06 -0800 (PST)
Date: Sun, 9 Feb 2025 09:24:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com,
	linux-hardening@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] hamradio: baycom: replace strcpy() with strscpy()
Message-ID: <90cb9ac2-2af9-4fc7-b93d-0f36514a76f6@stanley.mountain>
References: <3qo3fbrak7undfgocsi2s74v4uyjbylpdqhie4dohfoh4welfn@joq7up65ug6v>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qo3fbrak7undfgocsi2s74v4uyjbylpdqhie4dohfoh4welfn@joq7up65ug6v>

On Sat, Feb 08, 2025 at 11:06:21PM -0500, Ethan Carter Edwards wrote:
> The strcpy() function has been deprecated and replaced with strscpy().
> There is an effort to make this change treewide:
> https://github.com/KSPP/linux/issues/88.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  v3: resend after merge window ends
>  Link to v2: https://lore.kernel.org/lkml/62yrwnnvqtwv4etjeaatms5xwiixirkbm6f7urmijwp7kk7bio@r2ric7eqhsvf/T/#u
>  v2: reduce verbosity
>  Link to v1: https://lore.kernel.org/lkml/bqKL4XKDGLWNih2jsEzZYpBSHG6Ux5mLZfDBIgHckEUxDq4l4pPgQPEXEqKRE7pUwMrXZBVeko9aYr1w_E5h5r_R_YFA46G8dGhV1id7zy4=@ethancedwards.com/

Ah great.  Thanks for remembering.

regards,
dan carpenter


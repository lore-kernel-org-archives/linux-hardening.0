Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AAF4F9
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906518; cv=none; b=pAWlbTVRQOE4obScSh7kVl8nxQDOpscl2Xw6cfRMkK+zHBoZ69rWWM85x2rNUhf7ST3Q2xpKUe8RfmAnUw7OuYVNurdUkA3l0X9uRZ82UxkvcrkUw7xAiRfNTQzjl/IQus5t/agHy6NCy/xTLBSj98h6xG1lMFJcH+QFd48O0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906518; c=relaxed/simple;
	bh=kurIw7V3rZKMF/Ht1fnXn8epEvVoc15GU/v6IoSqneU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/lQrX9C2QQ7qz+EbajVDuGovl1dMbZVOH9y9g2WJth5v42HkTOrcUbJBfDBIsz+ddG/0QSSGdmSja/QfkIYcgi8x7+eoGyPbeVS2kwgwE3L0hfwODlfJI01Va10pv++M/d53UIxfkbmVraSR0R3qgvJbekM5nmfdWwl+JBes+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xbzs7y+9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbzs7y+9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e8801221cso28388785e9.1
        for <linux-hardening@vger.kernel.org>; Sun, 21 Jan 2024 22:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705906515; x=1706511315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aUJC8rG/vO3bD1rTOQLhtvB4t4NcN5TufneLFrEaCo=;
        b=xbzs7y+9pWSdOgRktONzsIqxbYnumGP7nzwQGoMk1ZJiR73IDv8pbkwRVYIUZDzsy1
         VPefcV9epAkqtlBqVlmHLchqUhLec4Fc5LShEBIHusHPgxpOhHaVNNV4EU7pOoOrw+0h
         BLAvUo42jjgn152CzvRxIT2ZFwgWxU+IDW5RVKq7nplk6IIt+S8+63PySMplHn+njNhN
         Qzf9xbfMozsEUVfGYdhbWn38HCfbhkKGPZxiUVqQRcr8kpSFYJYPCyARzWFMdfFB26Qi
         9cVr2LdOdtdJ9Twxhlz4Zs84j0dQWx8avQxVqk2TMaByGgaPsRw8MLgyyPpzUL0/WEn2
         gnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906515; x=1706511315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUJC8rG/vO3bD1rTOQLhtvB4t4NcN5TufneLFrEaCo=;
        b=HbtjrCwt0fP3/op906cmVfkG4nPcKCdARvYuaCJ+setoxVIqlgBOyxR1cX31BS5rlU
         dXyCNdlACo6QKtv/98VXaDHDRDoW640Y9W3UOElBJAOFU+u6kiulRLxbAub6DKmA3Mc1
         xCJZmGjT01nL7CtuJRL2UNjjPpkJFW/yEvbns2j80Hv28g/r61OS5s4RanF+dz9DHLat
         zya8vIjmI2gi3Yt9d2y57cspLVSwoecIbWDByM/dyE7k/8mOZBnGDgt9FJBi1oOF7Z5p
         JueRJbp5atgIQP9ZsIysjKGthyexwocZ6+Cstqjk23z6dJMrOOk2YiZp33SLQ+W/Jdqq
         6DQA==
X-Gm-Message-State: AOJu0YyFtwEdV8qN8fnGKye1FSOiYKJzxkgIqawoUm7EDPNc/Ph2m/Uj
	P4j0ob6J4JjlIgErEPmtmwMfsrSZnlHPnC3kYiL0NDc2t3XDYEiNS3ST6gT1RbA=
X-Google-Smtp-Source: AGHT+IGfn4IAtpvCRksZdJ+qY0f4oJppo8bUr5RyWi7AbO/2NfJDVKSiGSy1jFwXSGGedSZzJIOsgA==
X-Received: by 2002:a05:600c:6002:b0:40e:ae0b:62ee with SMTP id az2-20020a05600c600200b0040eae0b62eemr387119wmb.56.1705906514724;
        Sun, 21 Jan 2024 22:55:14 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm38018916wmf.43.2024.01.21.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:55:14 -0800 (PST)
Date: Mon, 22 Jan 2024 09:55:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use kcalloc() instead of kzalloc()
Message-ID: <a5d8a5f1-432d-46f0-84fe-7b5b22ff5f32@moroto.mountain>
References: <20240119173900.11035-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119173900.11035-1-erick.archer@gmx.com>

On Fri, Jan 19, 2024 at 06:39:00PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
> 
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

I quite often write responses to patches and then never send them.  I
wrote this response and debated sending it but in the end I decided to
send it because you have sent multiple patches.  If you had only sent
one patch then I wouldn't have bothered.

Generally, commit messages should say what the user visible effects of
a patch are.  Sometimes with these sorts of commits, it's hard to
determine the effect.  For example, Kees went through and changed dozens
or hundreds of these allocations to use safer constructs and we don't
necessarily expect him to audit all the code.  They should already have
been fine, but it's better to be safe.

However in this case obviously the patch is small and just by glancing
at it we can see that it has no effect on rutime.

But if someone is reviewing patches with "git log" instead of
"git log -p" they aren't going to see the patch. I can almost always
figure out what a commit does without looking at the commit message,
that doesn't mean that the commit messages are unnecessary.

So I really prefer if commit message say, "This commit is just to make
static checkers happy and to make the code more readable.  It has no
effect on runtime."  The commit message you wrote is way more scary than
is warranted.  Here is my proposed commit message:

"We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows.  Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability.  This patch has no effect on runtime behavior."

regards,
dan carpenter


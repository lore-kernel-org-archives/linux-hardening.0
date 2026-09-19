Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22E3C1D62
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808875; cv=none; b=eFw7cduz7tvwY3QRd1lY1DIFmdV3SPDTrTKflOKVFBEFUmiZSWG09kx/x9Ub3DIbqNsgVXuridJhwJWs3Zntmli23BcIp1g2KxNzxKVLjfubtusYOXlhphbvQbZAGBMN0LWKMDVdWKyK8gdLdfuOibju0qa+2Zfbdjk3loOyIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808875; c=relaxed/simple;
	bh=EWOHrvtfAdH8SUMdIJx2yEBFvBc3QNtqqxzu2fF0hD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVhAVd3MPy/mOc4+qN5nGiDJgazTjY+zd5J8KY+eUnTTaPYzHWaCF0YscueXe0R6xH5ErqLJrIn6NabG/zFn3FelQ7+83q25xuVzHcnvGbe0B05l9GpORPki+prhHHBUdfcCmRk/REHJYY6Sqz47mn3Akk2zrnRqLcqYXXv+mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fprrbYwr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fprrbYwr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso10610325e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789808872; x=1790413672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NbapgDXr+FyoTKQ50JUeVgfa7Tqe0pMogS4ct7fFvKE=;
        b=fprrbYwrbQZylNVye0yOD5gMuMSrQVHMsLOgDD+V00Xhz/3FDJdu58hyzbT/seM/Iq
         phj/3vAj/rkJwSnUzCqrs0jCi0eN272M4vvV3DsknxFbv9GPr3KvkGPWTmWAnvonbFaJ
         NZi+vdGeukRjh3iwAdq7UHJ8pELZqY2ta0HAybuUROz0NlMAYfE5sxhW+L7C5uWiNR0K
         39McqlE0dqc+mYYMnYvp1AQcLkjtbFqzp6HPEzIDjY4BiH7/7QP2Slq2GC0pQL3oMAqB
         nXw7FDMMLFMi9wHJFUkhDLHusVYNEdC6kTBGSjC+50hS0LbAFUXKPa7zbyHa8AFFvPOs
         0Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789808872; x=1790413672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbapgDXr+FyoTKQ50JUeVgfa7Tqe0pMogS4ct7fFvKE=;
        b=J+uvYuliRtOV4AztUWNngd1KN+3bV/bUcoJYtRZJ1fd1HbDRlkXXm5JqgiwXwBIrnY
         9EAQ4fyYw4YB2eVNGO3bz2VzWxBMO8LwOQEGrzwkOJ48z3lBwbEk2zQ01vBXw6iHVfPO
         1VBh7x+kpXALmFklaL27xmVEqrxe5xUKodBv4PkJJNLx6HoqPSiQzmTMFgXR8bS0+ZUE
         y1mIcVH3DAqBvoG0jhtfB7NHRVgQXzN02LZUSe9ti3Zf5ORwi5EcC9VwFCSJsPejpP+N
         rCgTmbfpcrZJRi2DoxBzUxghdJf3bSlc9d1LMcmbVr7VskCql41se/EmVDz0CN4djwCE
         5ASg==
X-Forwarded-Encrypted: i=1; AKwUvBxHuq9+nk3HC9XrjAkhxoJvJYO7tNm/fYFQQAXlQ1JXJzsnK4fD42rTT+QI231HfWV77s46PVjtH2dPV3ysH3M=@vger.kernel.org
X-Gm-Message-State: AFuF++lH0Ic33xLmnByrO0RYokGywjXBCzB7jVHtbYcBbn2IJ7NPJZn9
	I46eJOsw8Y5POhtEdahcmc7JtXFgrTqg3JAIprAeXf0g9cwUQzkFafzd
X-Gm-Gg: AYBFou2sjKSbB+ndkxX3wphjntpum/juaW092I3hS8OIIlZVvK4EbuMQAt7A4YEhG6F
	+XksOBK385fZjWGZoiRP6QHGPj5/wNAOln8HStkwm9WV5CeCieYwlNGcwt+SP6oRVYoqDxtuMHT
	hj2z3dzwo/XvaybUscZm+DqXpdmFqd2bleOz83pqqljkqP3JGI+Yvv02hW+/XKaRWa99eRzos/H
	/TSqEW4pb+uMbcMcKeX4Ec6BmCagmd9EOR3J2uyNThElz8g2yLyUCt8Tw9MZGCQnMwL9qTmteFh
	BA95Ywjrsyvpju6jSbnletk3o6VHcwJqETv8hMo+q2S+M/AAA/ZRXVRc43tG1kuCrVepkHwbQfg
	zdmf3Voa6/lNMhV3RabrPk1eyE5SU12fDing3uUSMzqNVUi1XFThV+qygWTwllVA3GdphYh9cY9
	BK2hHTDDk+i/ZIVgMDZAe/mA2Od2eQ8WmGAtlEeyUlqhmA56wR1ejGmY+oSlQkfaQoAW+sEeJfw
	fzlrigbUuvvkfaNSzFleH+828RuGtXf/8WyI4jWYSbrA3V5gci0g3lSeH+wa0PrUc5SVqBnlW4d
	SPpc2uDVhMZz7vGYXg5Rz7sqGostvylrPSsNY/vl8DiwbywBkniZ4a6L6Qp2Lh544WvyOofMdEX
	qNCU=
X-Received: by 2002:a05:600c:a085:b0:49d:25b0:cc60 with SMTP id 5b1f17b1804b1-49fc5747f7bmr70121265e9.29.1789808871519;
        Sat, 19 Sep 2026 02:07:51 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cba562sm86917495e9.2.2026.09.19.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:07:50 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:07:48 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] slab: ZERO_SIZE_PTR alignment and ERR_PTR
 hardening
Message-ID: <aq5QkQQkyaljq0R9@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
 <apqmVDiyGJWnEnp8@nixos>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apqmVDiyGJWnEnp8@nixos>

On Fri, Sep 04, 2026 at 12:25:59PM +0100, Harry Yoo wrote:
> I don't understand why v3 of this patchset suddenly implements
> hardening for kfree() and usercopy to handle ERR_PTR().
> 
> The address range for 'zero or NULL PTR' range and ERR_PTR() do not
> overlap. The bugfixes and hardening patches are irrelevant.
> It should be a separate series?
> 
> Also usercopy.c changes go through the hardening tree, slub.c and
> slub_kunit.c changes go through the slab tree, and LKDTM has its own
> tree. Patch 3 and 5 touch files across multiple trees, which can be
> avoided.
> 

I added the ERR_PTR changes after Kees raised handling that range in the
v2 review [1]. The two topics also came up together in the 2014 [2] and
2019 [3] discussions; in the latter, Jann suggested a separate
warning-and-return check [4]. I wanted to broaden the discussion and see
whether considering both together might suggest a better approach.

I agree that the resulting implementations are independent. I'll send
v4 with the ZERO_SIZE_PTR alignment, exact-match and zero-size KUnit
patches only, and pursue the ERR_PTR work separately. I'll split that
work along the SLUB, usercopy and LKDTM boundaries you pointed out.

[1] https://lore.kernel.org/r/202608111716.0FA9DB17@keescook/
[2] https://lore.kernel.org/r/87oaumdz1f.fsf@rasmusvillemoes.dk/
[3] https://lore.kernel.org/r/20191010103151.7708-1-mayhs11saini@gmail.com/
[4] https://lore.kernel.org/r/CAG48ez05QVn6_gQ2TBrRa1a_DWQoaSSYubUsu5YMWxx-gqMijQ@mail.gmail.com/

Thanks,
Karl


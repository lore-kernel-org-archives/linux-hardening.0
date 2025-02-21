Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE042049;
	Fri, 21 Feb 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153642; cv=none; b=Hy4XrUwekhfMAZsb7vJZ5b+jiMU4hWddvPxqtUBkVR2/aRW7XbyRLFm0Z+SZfFE7SIYBpdnVTtTViV+lmMzg/Pl7/1NOzRyiGr002cHy9pHI7M8dF+HIuhhosB1TJ/Ckz9NutJSRaMkHU8o2Umftx3cyJFMRY5M2jI/8NbTkaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153642; c=relaxed/simple;
	bh=8JwxSrAkb49WD2mDErfKLvyH0/6S3kZaUGqW2G14m5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZxrsaSKHHFlyYJJg2JeqCvZ5Ki2FNNGFjFRivmuVvTF5WFd0E7xSXQyyWMnRRYNeic/Si3tzWV8G3v8MqEOIVVILKqeQhRILS3SujL52kwwA17Jcru2rQo3QYvP5mKADRqk0Vqc/M4eA7aG6kwDVET68AcJ6AvAP6kcjcpLhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Wd3VgrGl; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Wd3VgrGl"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yzvx01MRfzhfX;
	Fri, 21 Feb 2025 17:00:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740153636;
	bh=bzQREuWWWsR2CIYsAKZ/AYGR6t2UePv92kGxLbABb24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd3VgrGl6XF5Mb3O9V4H28Jc/XuZkOXkVlwUk6gWUIiGjwc5DMUVu/Viwn21aOl6p
	 7YGIL6b7a8D84nOQO/r2Rh0K6IoQ0TY+kB3OskTqKEVoyANhXyDRf82jrZKfoh25Q+
	 lAgYf5VQLnbtELW6PXW2op7t6A4vdKp1L2QVYRl8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yzvwz4GQHzgjK;
	Fri, 21 Feb 2025 17:00:35 +0100 (CET)
Date: Fri, 21 Feb 2025 17:00:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>, Guo Ren <guoren@kernel.org>
Cc: linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Morris <jamorris@linux.microsoft.com>, Jann Horn <jannh@google.com>, linux-csky@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing
 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset
 -2147483648
Message-ID: <20250221.ga2OSh6ieZei@digikod.net>
References: <202501040747.S3LYfvYq-lkp@intel.com>
 <20250106.uu8as0Ha6pof@digikod.net>
 <202501061623.7A617B09@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501061623.7A617B09@keescook>
X-Infomaniak-Routing: alpha

Cc csky developers.

See https://lore.kernel.org/r/202501040747.S3LYfvYq-lkp@intel.com

On Mon, Jan 06, 2025 at 04:27:26PM -0800, Kees Cook wrote:
> On Mon, Jan 06, 2025 at 06:04:56PM +0100, Mickaël Salaün wrote:
> > On Sat, Jan 04, 2025 at 07:26:27AM +0800, kernel test robot wrote:
> > >    security/landlock/ruleset.c: In function 'create_rule':
> > > >> security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> > >       96 |         memcpy(new_rule->layers, layers,
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       97 |                         flex_array_size(new_rule, layers, num_layers));
> > >          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This warning seems to only show with the csky architecture.

> >
> > I guess the GCC warning is a false positive?
> > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116494
> 
> Does the warning go away if flex_array_size() is open-coded or if the
> create_rule prototype uses "*" instead of "[]" syntax for the "layers"
> argument?

But that would not be correct right?

> 
> The warning is about the "read" part ("accessing"). Using tip-of-tree
> gcc with -fdiagnostics-details might show more details on the calling
> path.
> 
> -Kees
> 
> -- 
> Kees Cook
> 

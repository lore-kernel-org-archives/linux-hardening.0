Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757573;
	b=ZInyIPGAn4uKBahwR85U2xFpYClvVqNpoFFh/8DvYiPv6p/iJAZAwQ5Aa6L+mTpDXhvF
	 EKx+eJrwmm8K2931eQfxNbuyA/lzObuwmUZkT/Mdt6BsmAoV4rVH/QUDcSwoX3JJcfbu8
	 gk5YcWXeK5kvrsDANrfJthLjpQ4qqa+tViuYIa/qiPkvEa5ms7izcQhvPlN4q/iqE1UDb
	 vlfzXnFnj4+7eX7D6Cgu9fuKGjnUutoeEiLWqzL4DuRH04dOUKxN9vX7ObAhwVezR7Qb9
	 dA2qhaYlJCr8r2VC3TfaWuLyUSSW+Y0dvXc/XNdvt5uRp05DiInzshpQNZ9IeSKdxvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757573;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=5Tb+/CVAcY5SOeTTU6JB0JtDtCzoK11pcXkmRemeQxQ=;
	b=E9PA+kiq+N0y4ZcvaUOQBmmLOP3a2A6kgN1l+02vnm6ktoxuLovEZBl7JuVzvrtiuRPn
	 inNAjthstETs0FuAq+fGahDOz9aaTu7SBaeG01ohOkzDdOsaSewro/8leI1JBxilwVv1n
	 UjsE8exZbuXMDS5zZtzYVYYE9Y+eumb2ngEfrYR2P1aHorCzBhcXK5n1TFa4mD8e+j2Rr
	 faAZXsBpPgiyyRs8gAvtTqph0LeO/VVAFGpW+PjLID99vyxajcG4KLJnYKiaDw95iDs6s
	 JenFdKfWHUUr3ZsWvFellYcK0swG1V+3hn2gD71PFecOI9hO0dSZL+z/FJhtcmFSh5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=uh5f1b+Z;
	arc=none smtp.remote-ip=45.157.188.14
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0C606A31F
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 12:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD0C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=uh5f1b+Z
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jB22t2K5bzJVD;
	Fri, 23 Oct 2026 14:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792757557;
	bh=5Tb+/CVAcY5SOeTTU6JB0JtDtCzoK11pcXkmRemeQxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uh5f1b+ZbD5b6QU7YiELqZMVlC8XKhjucGaizjaffPKtmGAD9fxrhC8Ya1/UAfycG
	 dO+hZi83WI3mju3r+VPSYWqVI4m06cyXiKQD4KMYkGLccQsk5X5ZEET76oOcWN+lId
	 X2Fc2/o78BSY9T6pcsT/NGwPS0MmUPOm+FAlg1V4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jB22r3TQnzKqR;
	Fri, 23 Oct 2026 14:12:36 +0200 (CEST)
Date: Fri, 23 Oct 2026 14:12:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Haofeng Li <lihaofeng@kylinos.cn>, Paul Moore <paul@paul-moore.com>, Tingmao Wang <m@maowtm.org>, 
	Wang Yan <wangyan01@kylinos.cn>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [GIT PULL] Landlock update for v7.4-rc1
Message-ID: <20261023.oHeec1uh0ael@digikod.net>
References: <20261021162538.1852602-1-mic@digikod.net>
 <CAG48ez3Rptvjvt=t_YEcBHHwYGD4zmPtc6tk+gPLtorZY7WEFg@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3Rptvjvt=t_YEcBHHwYGD4zmPtc6tk+gPLtorZY7WEFg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 22, 2026 at 06:45:59PM +0200, Jann Horn wrote:
> On Wed, Oct 21, 2026 at 6:28 PM Mickaël Salaün <mic@digikod.net> wrote:
> > Jann Horn (1):
> >       cred: clarify that task_struct::cred is only for the current task
> 
> FYI, that already is in mainline as
> https://git.kernel.org/linus/b030ffaedc1d638f232f6992406cdcdcc82d5602,
> it went through the LSM tree.

Yes, that's the same commit, but I needed to include it with a merge
commit to get a consistent PR.

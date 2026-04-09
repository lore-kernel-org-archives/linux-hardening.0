Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE45315D40;
	Thu,  9 Apr 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746075; cv=none; b=IQq+9eoY+2gWdC5PzIDXR8wesCGZEIav5IeU41aNZwNCqAk9peH/OI3epAPwv5x1DjFgSvzQ8aYFiszbQ61xahvfHhpIZPJnORdmL9MkNGyziVKHrPBZs7/xOvS5s4LP+nUqomi8l++bKmCRYu44+VvGHWoe5ZlddkAeKTjtQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746075; c=relaxed/simple;
	bh=4qnlhWkrVAC2M+j7AtAL9W6fLDOd3C2x6KpG3K+AnaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJt49DHoFkk3oSg2Vea6lh9GZa0Ov0tricHM5f5OlznPc5gSIrff4cNPBtl9rpu2eNbrf7s6/DbvNDXEOgKi8BuVfePUmxTpEEtPUyuNe8ECuk9gBT8OqFLDIbaw0BwtSTh3Eig1A7FgPOVDfKtQFfdZcyszarurX27tp3NNzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JUcDj1so; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JUcDj1so"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vtWvECdJsOce5KQBkQ6BB16WnHR2lmUFEE8FNue2MfA=;
	t=1775746064; x=1776955664; b=JUcDj1so+5PMg8X/Ilo2vk9KWS1t9Snio50ZnblPUR+nmGX
	i6UY3K0mCsnoJmk7ZV5ZA61txcAa2LYLCXcJUfUAZjeQT9wiEP9xQaUF759a96X5JUIg//B/mNrdx
	/BIQqz/zng/os+ydUbK3I/C4HYo1XRGX2EJWHphf0Y5C8opROcL4gOv+eXvADA8WCB0/u7uTE67YU
	otT1CYg8Lz2eoL/shg+jU/CUJ1n2PTAptU7ICAnXIJWDJJXq2BIc/F2mb3BGX9CzdoZpnCCd2l5RU
	yJbOC2aFice2zXKmACNCA8bPj5TrETuR78ijaQCHVTHJBKtwgURN895JYIH6iONg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAqfN-0000000G2eD-3CNn;
	Thu, 09 Apr 2026 16:47:33 +0200
Message-ID: <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>
Subject: Re: [PATCH v3] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: kernel test robot <lkp@intel.com>, Nathan Chancellor
 <nathan@kernel.org>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt	 <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-um@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Date: Thu, 09 Apr 2026 16:47:32 +0200
In-Reply-To: <20260409052038.make.995-kees@kernel.org>
References: <20260409052038.make.995-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Maybe the subject should say "um:" instead of "gcov:" now?

(I'm assuming you want us to apply it to uml tree.)

> Prevent the bad combination by disabling UML's ARCH_HAS_GCOV_PROFILE_ALL
> on 32-bit when using Clang 20.x or 21.x.

You say 20.x or 21.x,

> +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> +	# on 32-bit, causing spurious compile-time errors in check_copy_size().
> +	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >=3D 2000=
00 && CLANG_VERSION < 220100)

and I see that 22.0 doesn't even exist, and maybe that's a general
pattern, but it still looks confusing? Wouldn't it be better simpler to
say < 220000? At least to me that more obviously is "up to 21.x". After
all, 20.0 also didn't exist, and you did >=3D200000, not >200000 or
>=3D200100?

johannes

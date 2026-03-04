Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECF384243;
	Wed,  4 Mar 2026 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663652; cv=none; b=ln5HDeLuzr4qdzmj33QYrWPDrp0WeK6lEYfo0o+ACEU3i2nAg36kO2jhXVP45ONf6xkzPd90qewd/6IX9cCDkhuhLp0jVye8TUEkpAlCVyPzWS7DUVhOozx1pJKcsxZo28XRHnaMOFJwjwogAJkgzMCVSNJa2/fTo3i2aYFKkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663652; c=relaxed/simple;
	bh=TkcuoO5tsFwY/l5ERE7A1b0z+I2NDXDqlLISsvfDeCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A52rYDaQFhQtle+GMeKIRbfNzHiGkhHsg/tSKs0ugvdMbMUz86A/zJYNDx0QYjEhVRAdbjemwkLdnkisVWMHHLfJ7Zm2k5+Mm57EHslTn2o+8GelFMlZKj5qCrvxjvNSq9S4ziWlNDxGbqFwAhGfmfGo06XKL9mwYIEG8oZdoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FFoWFdvK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FFoWFdvK"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A78E940B4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772663644; bh=QFep6DoXCTa6MHlsiX+CObDNlX2M5BuqRR2s8vPNjQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FFoWFdvKTGVVYBua1siObF/ey46mYxmOLcZGV2bmR2fbaG6NwxZ3th2uh5jbu5utG
	 0qB8XWF6PqZ14mHP/DYJKy+g3i5IAfL/vXb+tYHDuPZFawpGT3ysTRYqldztWkiTwj
	 kjojNazoDd05ZY5le9rksrrzwAm3IzxuauTFzhxnzwEH3+zHvFxTiLkKc9qq/Ma8xA
	 ptUz7PtIv/b2FJZ8P3JuSzpkI/8l7U3T96cGfvEDJ/5PwBuZMX513Qs+F56zRvqBLz
	 KSiGjd8eTlzi41qo48+AR3nRw7WV1cwHxr2IOUjfd2XbsvwNy1wv7aeMWN7I7sCGIS
	 KDeyNFJQM2Gyw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A78E940B4E;
	Wed,  4 Mar 2026 22:34:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <878qcj8pvw.fsf@trenco.lwn.net>
 <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
Date: Wed, 04 Mar 2026 15:34:03 -0700
Message-ID: <87seaf442s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> So yeah, there are definitely tradeoffs there. But it's not like this
> constant patching of kernel-doc is exactly burden free either. I don't
> know, is it just me, but I'd like to think as a profession we'd be past
> writing ad hoc C parsers by now.

I don't think that having a "real" parser is going to free us from the
need to patch kernel-doc.  The kernel uses a weird form of C, and
kernel-doc is expected to evolve as our dialect of the language does.
It *might* make that patching job easier -- that is to be seen -- but it
won't make it go away.

Thanks,

jon

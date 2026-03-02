Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A6387372;
	Mon,  2 Mar 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468049; cv=none; b=A2CHjJgARZDxY9NdotAS0So5jaTy61OO6VNdWv3fViUufQFOsWi5qmJQ1kktONrhDKOE/YwhX/OLHz22mwEeDIwYKp8KivQZ1gpkKnAFshvX/ajRTb5KUEiXYMihu8YaC2cLG/iQyXHvJIMuAtYrMlEVA2MmT5kz87SnRM070AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468049; c=relaxed/simple;
	bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8/8FJXbtPcyYCvRx1OjvnFxC70LLBIx57cfUCBPzTr1LJeI7/WffZi0LJ7dyddFqaax3f/H76XkRoineRQCTvUntb6kbTe2FjIGOP/6Fyuj70KF0fFAoRbqTlttiXXG+KJsMrL7RASBrvXCSByBAgW9DLlGn6e2dPRcGUzp3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f8pn8U6F; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f8pn8U6F"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5854040C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772468041; bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f8pn8U6FA7kUP/r8iFJZ4rWUypHnzoaqHWxdAGjfHjokYaiGJKCr7IU0F2JeN/8Fw
	 azpeD8ldqGCxtqmHWLxHS49TZl0QI+PrcVa1ESn/HNUJLsJpACllhhxKlZ7WWhWA0G
	 4aJvqrqR8VuLoM4+Eg+rb1g/Si03GSmPlar/FE1+ppa4Qndh/WT11KisZJg8mqwbVh
	 /WzQmizJRbq2GmBEJHki9LsLvF6IsnP61jEwvwgciTs1BsM2J6ZOLVi4QFAAp0/ZhL
	 xDEN8yE0rRR0o2SHCha4a+omT/xNujvFQOxlgrR+kzRwwpwg0ORD4R3MLY+vZKFmpC
	 3fI6jawrtR2kg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5854040C69;
	Mon,  2 Mar 2026 16:14:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
In-Reply-To: <20260302165433.27f11148@localhost>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <87sear2kbm.fsf@trenco.lwn.net> <20260302165433.27f11148@localhost>
Date: Mon, 02 Mar 2026 09:14:00 -0700
Message-ID: <87y0kaw6nr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> So, instead of merging this patchset, I'll be sending you
> a smaller series with the basic stuff, in a way that it would
> be easier to review. My plan is to send patches along this week
> on smaller chunks, and after checking the differences before/after,
> in terms of man/rst/error output.

OK... *whew* ... that sounds like a better way to proceed :)

Thanks,

jon

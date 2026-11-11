Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.61.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380261;
	b=SIT61Vuch4hMTnBOZ8XkHWX0vRVw1wS9Zr4jMJUK+2L3LIryXQ9xI/qZAtMI3Js6/A/Z
	 Tyu/BmdYiqVAcARbJ1Pz4ps9u7th3DYeGdazbxmAFkbIW367nFrjPeY5z51Q2W4bXpukY
	 fBLD+CwQoihZCWHsU3/cWkVean3l5xH27ZM4DEI2Kyj/kjHhib1twKwPCHVUs4hS3qO5w
	 ZIJsKcTuUihKpBg2i3WtwhFul7BcZRPaokNz9uIDSx1bW0FYRx1/L8gg1pz2NH2Q0Xvsz
	 CvAVsKovRr3jupSi9BZM2okqznrJJvEMfxEXq1X4k+gtLxLpV10FIDpMilfrMBTCERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380261;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=Ii/JANG12rhgUYH14odhnT3AUGJ7mzTHmXQwKDpHhrY=;
	b=NLK1rtENaXL3BFhbKAXgr5IxwuVVjmEcN56vOcweNkND5QmhRf9lNw9TxQasVuN4/pn0
	 J2UdG+KrfrBXg4vcQdfUt9obeYHUZffDD08CpYWtxGx8RsxPAWPHFAyafJfosMfQIwJ1d
	 nUHxazFksxK53J5atBpFj0sflueEiK7Z1E1ZszUQFjJKWyxjATghXuHB9yITEni5ux64h
	 gp+NMo0eyXte9uhGPeLCfVO+aiMFP+PYppuy9wMIWaPqoaPBZI1ONo1I6XUVKFsyUWEAo
	 yKz8A22p22sE5obV4yVkBDO30yE62qZoYAFIfyLuTbE2RPHksV46TEv/7ngyaXs4fLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=j+HyK+IE;
	arc=none smtp.remote-ip=188.68.61.107
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D6606A32D;
	Wed, 11 Nov 2026 06:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 029D6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=j+HyK+IE
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4jPZ8V5KMrz7DQV;
	Wed, 11 Nov 2026 07:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794380250;
	bh=0kRS6HcThTRfwBZuoYJysD3XRboaoxYenf5JUqHSq7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j+HyK+IEv74c50BE5JDPsIHxzP6sjEoSgjMzPXIPQHHM25FPjzoWGu3CN1WglQxtj
	 UvEhbq4zdziX1ThVpN+yGGe2iQmRSHjdV/NYxGObk5qd4D5RJ4OfAfRHwLP4mvZ690
	 m4eAKQCryTlvlle1j3EraSUbOLUPMr/un7COw7EduVFnWk3Iiku3pMVkyRCShUxzRs
	 dtQSm+yR1DNxqI+9vxapJLuO5X+iY5pvm1uWeQiGIPR5j03DOByvhP6y8HDKpZgR3X
	 kFJGU9r2s/luNxf8zaaRU2GA4CZhKNr9xQHSNi/WyKTDl1lTOy7me55xbDRQTzB7dS
	 tqzg9oEkbSUuQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4jPZ8V4bLSz7DNj;
	Wed, 11 Nov 2026 07:57:30 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jPZ8T45gtz8svf;
	Wed, 11 Nov 2026 07:57:29 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1AA845F957;
	Wed, 11 Nov 2026 07:57:20 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=thorsten@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5fa96a09-9004-4de5-894b-06a9e801e363@leemhuis.info>
Date: Wed, 11 Nov 2026 07:57:18 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: cve: Describe how security fixes reach users
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: CVE Assignment Team <cve@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261111014419.i.586-kees@kernel.org>
From: Thorsten Leemhuis <thorsten@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=thorsten@leemhuis.info; keydata=
 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
 uTaBMEK4
In-Reply-To: <20261111014419.i.586-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179438024055.383810.15326130967008139699@mxe9fb.netcup.net>
X-NC-CID: o6Q3L7U+z0f8iPWa8mrti+ud5yjvwquEdPtCcCX9RbqK++8xbLA=

On 11/11/26 02:44, Kees Cook wrote:
> Recent threads on kernel-hardening proposed new mechanisms for
> mitigating kernel CVEs while waiting for distributions to ship their
> fixes. The CVE documentation does not say how fixes reach users, or
> whose job it is to get them into a vendor's kernel. Add a section that
> does, summarizing the answers given in those threads.
> 
> Link: https://lore.kernel.org/all/2026110719-zipping-silliness-2443@gregkh/
> Link: https://lore.kernel.org/all/2026111052-spectator-legwarmer-4c1e@gregkh/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  Documentation/process/cve.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> index 5e2753eff729..d16b5c2bf7ba 100644
> --- a/Documentation/process/cve.rst
> +++ b/Documentation/process/cve.rst
> @@ -119,3 +119,33 @@ assigned to all fixes for all issues, but sometimes we will fail to
>  notice fixes, therefore assume that some changes without a CVE assigned
>  might be relevant to take.
>  
> +Getting security fixes
> +======================
> +
> +Fixes for security issues reach users the same way as every other
> +fix: through the stable and longterm kernel releases listed at
> [...]
I found a few things expressed slightly too complicated. I first wanted
to point that out, but then decided to just suggest something better.
Not sure myself if I like the result. If you do and want to take it, let
me know, then I will polish it a bit more.

"""
Getting security fixes

======================

All fixes for vulnerabilities are first resolved in Linux' main
development branch and then reach users like any other fix: through
backports to one of the currently supported stable and longterm kernel
series, which https://kernel.org/ lists.  New versions of those series
are released frequently, each one tested as a whole by many community
members.  Only once a fix is in a stable/longterm kernel release, the
CVE assignment team announces the CVE on the linux-cve-announce mailing
list.  No vendor thus learns of those before anyone else -- except for
the very rare case of :ref:`embargoed flaws
<process/security-bugs:Disclosure and embargoed information>`, which do
not include :ref:`AI-discovered flaws <process/security-bugs:What
qualifies as a security bug>`.

All of this is available to everyone at no cost.  The best response to a
CVE and the quickest way to receive its fix is to always quickly switch
to the latest release from one of those stable/longterm kernel series,
as then you will frequently receive security fixes even before CVEs are
published.

Some Linux distributions or hardware vendors regularly distribute those
new stable/longterm releases as updates within days of their release at
no cost -- and thereby distribute fixes to their users.  But if your
vendor does not regularly ship those releases or even bases its kernel
on a series that is not supported anymore, it is that vendor's
responsibility to integrate the fixes -- if those reach you later than
you need them, raise it with your vendor, particularly if you pay them
for support, since keeping your kernel up to date and secure is part of
what that support provides.
"""

Wondering if we should mention what "EOL" on kernel.org means -- and
that some CVE fixes are not backported to older series and suggest
something like Greg did here:
http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/



Ciao, Thorsten

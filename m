Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C703EDABA;
	Tue,  3 Mar 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560576; cv=none; b=mxI/JHHoKWaHpGgN6Mjzls3Ulp/7lpUX/FLxxvYzSTo/DyiL7Rhd9D9d1mihuyY9twUEnjJkysTvHNzsXsRZr/LmG4/Zww+WVwNTZR+uWVx/oZGZJogQdUgW4ICVVDTT0Rg4zgIEg1J2uTZU/odIQ6WyAG9rjinwOVsDB1sdtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560576; c=relaxed/simple;
	bh=tB7Qhf51t7COgx6AMwEAKQA7Sfjn1Zl7lq7S+y5Xq5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SESjgCmRSVA5FYHhowEu6wD/y9+PSjufsl1Gi02V8dUlD3jrDH7icloXoQrmcODT8IOKbxPiA2a+JVJwQvB2E7x6KnoyUI/9eQyx+al1mhi5oC7IctFMfVw29ZCE4B5kOdLCEch7JZhIVvzQT54cczusFWepvB7Jy6ksGHjYagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ECcOlPtO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ECcOlPtO"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 94D5F40429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1772560573; bh=Ob/61kfjwkWKR8Gl5mNIk6TMub+KtclDWQimZackFME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ECcOlPtOmP1m2c6qpzyRlEc5KAxrOjxF2Xhmr/bTT/lt/nCQ4ZS7jlbOZnn5oZlN1
	 j3r6Jt6sZEJuKuazx/woFmFwYh7y7hBLLJZ1cbStpSsE6DyOudYmel/mBYUS7WSusP
	 KDd1S3+QYiLvAAeRrJq6N2CbMUD9OdJDmGhmAvnc/gesHwWpguTO2eLszxZyPOLvhL
	 KdS/Ki3vyX0CMP1aOG5nWOQmPWQxbwvI7JFfkcnlZh/LNNnH7neB2Uu1OXvk2hhJ5o
	 DP37OvPr0ka6vBlb9WcRgkZLh9xWFx2DYA6oY59K7Y76qge+daKhsLpPsdeMZ0ckbP
	 Tmy7I4NQgeN4A==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 94D5F40429;
	Tue,  3 Mar 2026 17:56:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Kees Cook
 <kees@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/18] Several kdoc fixes
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
Date: Tue, 03 Mar 2026 10:56:12 -0700
Message-ID: <87fr6gbxvn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This series contains patches from:
> 	https://lore.kernel.org/linux-doc/87sear2kbm.fsf@trenco.lwn.net/T/#t
>
> I rebased them to make the changes cleaner, fixing mostly on fixes.
>
> I dropped stuff related to NestedMatch arguments parsing.
> I'll be sending you on a new patch series, likely tomorrow.
>
> The changes here basically addresses several issues discoverd by
> Randy and by me and makes NestedMatch more similar to KernRe.
>
> It also moves the transforms ruleset to a separate file, to make
> easier to maintain kernel-doc code.

OK, I have applied this set - it all seems to work as advertised as far
as I can tell.

Thanks,

jon

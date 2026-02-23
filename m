Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59223793C7;
	Mon, 23 Feb 2026 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883935; cv=none; b=aJNUlYa/po390VGmYVMUW0HDGEu6y8nO+rVvbYNJDyUXC7sZrhp5OplvbVFK3Le6kdozJ/+E0rMWezRy6gm3KITiLoJV4rI3zcLthnDlZ6kG9DaPuoqD5wawbr4OSZbh5xqv6xCmkOrixclv+/S9iIknjA2L95eaOemNsuHH/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883935; c=relaxed/simple;
	bh=wfPv1Dn+5ayb8lV9aVLjZI48FWCKzwmw+b5CEoCWtfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+Vyo7Q31FwYfTylonFKzfAOrlk+LQzUt2+kcgaIhz7assa/IYy0892oUFYcqxQElGmfLPvPKR14+0u7OXIpgVaFeVaAltnAmf1B59Q7ZQ6pvfad/UUslGtKECmXPNTiNL+4TaUDOceBKJ5Kb8As0kMeQcvg7KeXqP5qw1W05jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qV+GVt7p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qV+GVt7p"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAB1C40423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771883934; bh=rVO0cWY5YQPss4mxRPqlFNx3v8FT5KAjLgK+RHGEKFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qV+GVt7p2nYnN1+NX2I9tzAiI/gfQQzdkQ5MNfOJF29j/ytt6j6GfVJyQcDGu1V9F
	 YzM+E746lUijkUKpKBr/KYbV1rzWjfVocyBhqMP3djNh9+BT6yc51cpcDy+26+iFjy
	 ytNBD5vsgO4PJMlVr/fP3rzSWkp5g0tcqX7zfyzuS2j84CXLoENSSFFDfAUlQFpgbS
	 Q16b5X9YhSeh57ro64FMLtPeMpYXQwX960eUJ9tbOr5UG3jP/phyYJXfSG9qMUjMVK
	 v2l9/1oNHjVcEx7Gi/XiGY2JJ45V06G7bwVdYIGfeMKQ8WygYhYF7R14R+pULAyLSL
	 m0Cm5wLPQCcMA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EAB1C40423;
	Mon, 23 Feb 2026 21:58:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Date: Mon, 23 Feb 2026 14:58:53 -0700
Message-ID: <87sear2kbm.fsf@trenco.lwn.net>
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
> This series contain several improvements for kernel-doc.
>
> Most of the patches came from v4 of this series:
> 	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/

So I will freely confess to having lost the plot with this stuff; I'm
now trying to get back up to speed.  But, before I dig into this big
series, can you say whether you think it's ready, or whether there's
another one on the horizon that I should wait for?

Thanks,

jon

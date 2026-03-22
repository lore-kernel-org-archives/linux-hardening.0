Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218E37E319;
	Sun, 22 Mar 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774213695; cv=none; b=gzf97bk14vy5qzPstLvML3qvCrDDk7krjggK/XIbGBv3kf/pyA3iLEjMoXpxL+PVNpoIQWAlzbtk3yO1Ob2EqxorCE+71JN+U7s/m9+4PuenUwxvRTzPo0nJRbZFtNMrrM7G061wQuSAszE1TAllaMUNio9LgEyJzBFVTaO38yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774213695; c=relaxed/simple;
	bh=1dIm+IRJ8YNviqNMy1x1h605kgMvdgBb1SG2sRlgD/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUhrEc0ZnPsESB/YD91j1UxROqYjo3EigFCfuMIQc6XuDtpm7298j+Fd9n4S79yhPrbYrsTbARzrXj1LE98TRTO3ZFzn6SiwH44TGkm1JzBOyvN/bR5GOt+99HAqGAFCRm4ljabOesE7Mvezrg0I2mFW+1wN4QtSTWmCaRmEcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XjesLpLP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XjesLpLP"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7DB4F411EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1774213693; bh=c7Mkncglh+ov7MC8kT/zXkMfiXtW+S9B7hikGVB2yP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XjesLpLPc5lvC+qLnMB24elpRtpfZfwHwCfm2W9F6je6yaz37b8vGZ6LwZ7Ajtm0J
	 l/YBMLv7mXobmWRw2h+dqAA7iRyPm49xo02TxXAGWAWJ/EF/E0hr0KyQ4wG/MqoXOy
	 OfYJuLc1pXZW/0MtXrvh8nonvXBhNCp8jscBqUDzXR0lM91nznRJ5Xelh372C5brE/
	 xiZDTlMubegdzNEdIRHYPFWCOH1FImGDOPWikhq3lnUkmDtzyDSNB3WwhMyc+eipQ4
	 d+qNUFV3QSNlH+4BtYv1/wI8Z/EcodfrbDitO/z3N6go43Oc7dXqa++UWEkmbcDt9E
	 ty6hHNW5KSdhQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7DB4F411EA;
	Sun, 22 Mar 2026 21:08:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Vincent Mailhol
 <mailhol@kernel.org>
Subject: Re: [PATCH v3 00/22] kernel-doc: use a C lexical tokenizer for
 transforms
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
Date: Sun, 22 Mar 2026 15:08:12 -0600
Message-ID: <871phbd137.fsf@trenco.lwn.net>
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
> It follows v3 of the series. I basically addressed there the
> points you mentioned. Besides that, I did a fix at CMatch
> group(0) logic, and opted to create a special token for ";",
> as it simplifies the code a little bit and will likely help to
> simplify future changes.

OK, I have gone ahead and applied this series...it doesn't seem to
explode for me, anyway :)  Let's hope for the best...

Thanks,

jon

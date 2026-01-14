Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB733BBB5
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416968; cv=none; b=QnlcGRTDoC692xrnETMdRQkZTAZKicsuszflk4bV/SoWDLVo9mxg246BNNKj1Ob9pA41swBm/kEROl0RQ1cbwooC8uw/Nmp2SDSH8iu7AdVSRwvnkWZt94JsInUVBrKMDB14kuZsBiMqZY1jbReVDOapL2JHjSNPGEDaUGAQYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416968; c=relaxed/simple;
	bh=YdCUg8NzWbyzZSxbCz+GK9qULo67LffCaq2JFxkWO10=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tJIs9FJJgEYW6PcTr9o2DYi+K8n0CCvayOlbMCig0Ty7BDrZ+YcIHWxA5R7M9WCKb2gRsmONLctUOnQepBcvL4ZrAC9BiO802cSbqXTKafvdfklzzLP0BYepQXKdSYSgGkE7qPS8+TxNmS2LtUMAi5Zy/0djQ/9Tom7e1f9NlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5wx4bEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5wx4bEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FEEC19421
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768416968;
	bh=YdCUg8NzWbyzZSxbCz+GK9qULo67LffCaq2JFxkWO10=;
	h=Date:From:To:Subject:From;
	b=I5wx4bElbO2boNcSYIv1pYN/rGviNe+SmV81DfbNL5yXjEAINLtBCY3hD0j6wVfbc
	 PL3DFEHqwafmRr5Qu3AleHpkxFgb5mepOaysmRJ/EA21EQIQSqo7YTjf4p0XfNPJvW
	 GtSpJP91wtmGYV/oEgsI231kQ4vXTjPiR4XlWgzqOyVHHQ1lWlZGm8C8hzW9U+WXT+
	 g/ZjBMjIUYLrkRgR3Gzis5J6mRKNli7daN6n/wxT0SrzRz+I4iUjGrs//fVYxaw92F
	 UPkLilwXBocJ74VVHNCZ9GbuDMWe/gpLPbdyEHIWq9eiPQd9cLYUkUYR7SQmHzF8wm
	 mBqG20Vy2wxpg==
Date: Wed, 14 Jan 2026 10:56:07 -0800
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org
Subject: Coverity scanning offline
Message-ID: <202601141054.4A30A22@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I mentioned this on Fedi[1], but I should repeat it here: Coverity
scanning is offline until it supports[2] -fms-extensions for transparent
structs, which were enabled globally in Linux after v6.18.

-Kees

[1] https://hachyderm.io/@kees/115894901529239937
[2] https://community.blackduck.com/s/question/0D5Ul00000cztsCKAQ/linux-scanning-is-broken-coverity-needs-to-support-fmsextensions-option

-- 
Kees Cook

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D3125A2
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNLrjbY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1EEC433C8;
	Tue, 14 Nov 2023 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699949021;
	bh=en3QOVgsWe7HU+LBcOQv05X+cpfd58h4zxSJZwEEZqM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RNLrjbY7hsz6H1MAKpEq1aYBxYWTS2sp4lE8aqXE0aqNjqocX2M8gCeyNnzNXe4I6
	 5Cv4qDunlExXySHepa6L1+ItxDqN/W2XT1GNoEmTdHDVSs43uLYJtvusIakBHFnfB5
	 +hDuXFrd0Qbvu60PGgdcUPZFHvc+g6od//sJdMQhtkeZ0BPfnq0OXL+E/cuawWAl+X
	 mj9BTo/MSPlDKcfOS/xKaGZuOFg6Z1D6N8kUnqp66azpDeHTfuHxKj4B0DzLTofUkk
	 vER7GkbUtwnnx2IkpDkkgV8bxeHqBLUBzKqc+Rt5+mxHpz9I/aVoy67XYCZ6ztOmve
	 a/lxqtbMuJaKw==
From: Kalle Valo <kvalo@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow
 warnings in _append_tdma()
References: <ZVJ6lRCRaywGktxJ@work>
	<fd0d79048efa47868173c5fd8950b956@realtek.com>
	<192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com>
Date: Tue, 14 Nov 2023 10:03:37 +0200
In-Reply-To: <192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com> (Gustavo A.
	R. Silva's message of "Mon, 13 Nov 2023 19:23:49 -0600")
Message-ID: <871qcsahie.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

>> wireless-next has taken my patch [1] that is identical to yours.
>
> Great!
>
> I had mine ready on Oct 31, but I was waiting for the merge window to close
> before sending it.

BTW we keep wireless-next open also during merge windows. So no need to
hold up wireless patches because of the merge window. I know it's
confusing that we do differently than how net-next works but this is
easier for us, less patch build up.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

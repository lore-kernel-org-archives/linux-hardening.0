Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67218FDDE;
	Thu, 27 Nov 2025 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206361; cv=none; b=fi9o/Tv8FnNmw0hMukcToplRnRktU4m6kHZNtneWxlXR4ku6S0NrkHuXActNQfXQ62ClXizffcSUPfIbfpaktIqcLMAPkcWGYTn6ZPQj+32Kum2zYsMAwVxt6kw+Oz0XW20mCgGJI12z8O6TUxno8eL0YJKAgVbt1l7hM6DW7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206361; c=relaxed/simple;
	bh=NtskDgL3o4fK36RmcEPOl9si5HKfR3Y3Gm0QNNLs7p4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOHITlqqWdhdqaxKEmlOCtqqhsPIQNEe3LlUrKjAqcpRTo7bbJIBSMBKX8+S2HREd6tq63EudO8CWItcdjb43Y/6swlvjGm8khMwcLazW1wt4Hdcc4yjMhJ55yFIqNYq+lFgUiCZIj3v5RwfUJThSOWLgF3JUMy7BwfCgMBja8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anE6CaJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anE6CaJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF9FC4CEF7;
	Thu, 27 Nov 2025 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206360;
	bh=NtskDgL3o4fK36RmcEPOl9si5HKfR3Y3Gm0QNNLs7p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=anE6CaJHz0T9sDt0vxxIX+if89MZsCo+NpM32P6Kw6Gj95hKJ78cHMchtHgut2nQ/
	 qapUhoLo/WxupapdhvQphiTfQSxBIEw/PQG/IzCNEXvzD4BV25EvruDn/RBKWLI0aI
	 S+gwCOiWLCMCwK4SI6FMb/xcK7DvH0Smi5bxn/ZW+OW+3njpzdE/R0CT7bj4A505J5
	 xOf/xl7YIAhYDU2valVcH4UFsQoBiwreQMIN32imNfWMzzwWLryUN8vB62lP0ZNO81
	 1etyVjjI7AifVT/FP9EVuRvZf1iVcV5gi4F3+wQxuINtSxqt0Ivc6iLefbryKmcwL9
	 5+eYc2v3/cccA==
Date: Wed, 26 Nov 2025 17:19:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20251126171919.15dbc430@kernel.org>
In-Reply-To: <aSUwOtiDMYA8aSC3@kspp>
References: <aSUwOtiDMYA8aSC3@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 13:27:38 +0900 Gustavo A. R. Silva wrote:
> -	ndev->needed_headroom = sizeof(struct mbim_tx_hdr);
> +	ndev->needed_headroom = struct_size_t(struct mbim_tx_hdr, ndp16.dpe16, 2);

wrap at 80 chars under drivers/net/ please
-- 
pw-bot: cr

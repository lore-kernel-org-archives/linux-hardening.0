Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFA367291;
	Wed, 12 Aug 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541554; cv=none; b=WvZMV2uD2TIwmjEwMMATVCptkqOScmIql0GPjNZca+5f3pSkIF85eFv5lqAI9XklXCLhT2puvxTfIqau84qrb9q/6ofvHv9hzDI8mV07Y6E2xzwyyWwwMP2OqAnDGyKL7/V/1aNAxl1lBfR+5m7iL6DxPIS2wGxWrL062JvkBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541554; c=relaxed/simple;
	bh=37eRYdjaxomv2eRGiOLZ22/lq5u86pHVdLmmzJiyeE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIzrXRgZO8KNsjMmPt+m+nrearqWW0I4bnGMmfjEI2wcWXDXwwIoh2sBo/aRuk1uodKfbrHEqC/a1L+257YCLn5y//Sd0XsrPwRBuB86HeswDLysc56wgfRPwOkbJFwdTcEAEN4IWEB+vgvj+8J1wgwGJcubqNmmrIx6aAVLayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpavJL8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpavJL8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E11F000E9;
	Wed, 12 Aug 2026 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541552;
	bh=FHP2adXMKime99fuV2vPCh1LzH4rU7kufd/f7lfaEnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NpavJL8RPxuNJNu1SBs6w918KEO6ukKSW8Yr9b/sBXY1tKAiORrsy8wHkCioJ9mG0
	 AI1YnPz1VkTha8o9/c+ywk6S0XYF+NQ3dEIGv1otvYPcWGlJsiJejKBtCNi/KsmSAn
	 OxtVJdQftYcSEikfEmlG9IQ8XM4mWTuG/99dE//Kns7WWWxNdo+ESzfQ4+Kcl1KFje
	 h0Tm5Y5kT0UDsu+m43ZrLjB8RcextlNlh2hC7VOsTV5DBfMpw/J++D/wl/sgU1YKUO
	 eurYC0DBCLiHBfZBbjxs9LHMumQKPr2NlSaF6mEfbg/7hiVu+CHxB0bp6XL9PdFCAu
	 4aVIYtH4ZL6zQ==
Date: Wed, 12 Aug 2026 15:32:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-phy@lists.infradead.org, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/Mediatek USB3 PHY DRIVER" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek USB3 PHY DRIVER" <linux-mediatek@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] phy: mediatek: tphy: simplify main allocation
Message-ID: <djjg6jwpuu6l5wcc7zbxfi7j4n5hircmhivxohdtgufzrp6rlb@l6eyfdyfrxix>
References: <20260304041400.7236-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304041400.7236-1-rosenp@gmail.com>

On Tue, Mar 03, 2026 at 08:14:00PM -0800, Rosen Penev wrote:
> Use a flexible array member to replace kzalloc + kcalloc with a single
> kzalloc.
> 
> Shuffled some code around as __counted_by requires the counting variable
> to be assigned first.
> 
> Removed NULL check from of_get_match_data as it's never NULL per the
> device table.
> 

Please do not combine multiple fixes in a single patch. Also, the NULL check can
be kept for the case of sanity as it wouldn't hurt.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

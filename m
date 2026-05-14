Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AA3F4132;
	Thu, 14 May 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775492; cv=none; b=Y7cDSYeQSY8Vq2fq4/Z395bub9yi9WoQl9cpllr0dw80o1Zj8BEUPKaQCMEVlEV/BxjVg8Bjzdc72idOA8rNvCMtTSRoPR6t3YkmTawh0SsGFGAQ3gvBHQmFcmeGPoRbfd/3QrNpCsmy8wjWXKdIvwJygr+0+mEvB0uDEPl4zB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775492; c=relaxed/simple;
	bh=a/iNaIKbVrm7Lqc4Lt8ICQ/ivXXWN6UgmrAPOdkJyC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dxKdBSGwgSDTxXrl5xGyYK+bDYL4jmvpZDmgm+uPHwLIuwp5fxgP1nwWio8/QKswGONGqWp6ajeI2fL1htEcMS3WEi28SJBvTFoP2OqTwwKhoG3baH8myLkmRqmc68LlE/aGA1ncAKEcyEBbMoCaeji9x0mZZ9UiAbOHfITunYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6EqVblN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6EqVblN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEF4C2BCC9;
	Thu, 14 May 2026 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775491;
	bh=a/iNaIKbVrm7Lqc4Lt8ICQ/ivXXWN6UgmrAPOdkJyC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q6EqVblN3S5MrSn/05eDZ4ZNEj2+AOlv14F7JpPZWZDP9J5QPiTiIjT45VZBmwTS3
	 yMYMTVO+famxCqRJ4F1vbVSyxE1EdqyvfUbi5aSFsAci6x1t/77eES4+dleYFfRi6v
	 DnpbaKlZlWXCNd8mOzxdoI6jXO1riFZLZGSVTGq89/FFXbs3+Fre5iq4EKqmqrbAR+
	 4snhUXUj1VJeqg+mwweOBVZxRKKrf0RMeWjG1HGj9svvSMU11VZFtFtTaE6qFX3OH+
	 YcQoinzKvmKaOV0GeT3ywC0Xn9gDcJhq7E9ZGrN17akPKAOxrRmG5Bd0ji1CCOGnF3
	 cbYS6KfdPd4MQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260304043420.14151-1-rosenp@gmail.com>
References: <20260304043420.14151-1-rosenp@gmail.com>
Subject: Re: [PATCH] phy: mediatek: xsphy: reduce main allocation
Message-Id: <177877548793.1092446.559033310365842656.b4-ty@kernel.org>
Date: Thu, 14 May 2026 21:48:07 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 03 Mar 2026 20:34:20 -0800, Rosen Penev wrote:
> Instead of kzalloc and kcalloc, we can use a flex array to reduce to a
> single allocation.
> 
> Also added __counted_by() for extra possible analysis.
> 
> 

Applied, thanks!

[1/1] phy: mediatek: xsphy: reduce main allocation
      commit: fd6cd05ceabdf67635a4cef5145f79d1217bf11b

Best regards,
-- 
~Vinod



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9D331EBD;
	Mon, 12 Oct 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795118; cv=none; b=SSxBuKFwmf0tD3n/BbuhlrrbDVyjPqiAtfoT82VCnnRqbTc11Irzg+KyM00sRzZCkXvo/4lNqN3C0vhaJoKqPvPI5HHbw11FmFBKFs1CTslbkc1q7HasVUf+MA4vdnF4mOsS/cy4bJ9HMidmDEzg7sBdQ9XPnZ8LKpwRqwX7mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795118; c=relaxed/simple;
	bh=KuYORnh4XFHSjOuXAbf8BKrdcJA53nDf5tDune8yL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN5c3dhDwDLdiW1Ex5BUXK3PckEDudXBj4PfhuiGwzxpNRthe/uquN5ABblMlwNd2DWbIBPH2VgT85FhZu1Vns9AdPjKktMB8bRVsr2FdwGy3+l8E5DIegORqfYQm+nJnbxZSubrYNuoyi8cNAZfMLEfErIGw5Adwho2nVlNQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETjnOmAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETjnOmAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6601F0089B;
	Mon, 12 Oct 2026 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795117;
	bh=ZN2dzTiC+2BBssvLh2yHOghWh0HLc1sQSHswvJ543so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETjnOmAbywI1wneWq7BOKw4lGB2kkLvdv/6KXLwmxlZjfvqP9o+NJQThvZoFrUms8
	 f63ggiUz4KP0brhWLRhv2x7+QVl5scE6S1z6B+07a+Cuh/rNvtL/DeKO/WGwM4us/K
	 tzad4DgJ/0H9cQpP0TtZSFjlWnNwaJsYmadJzAaulUHh+ShNbrhNJoVt+vUN94QcSt
	 ng3p8Jq1R6MXudNMLjr7UaZ5uHJXlAaG8HbEf49lYr2yoteE2ERJwqTdDs5xLkna/n
	 FLLjyaG6T+H1iWUjfS83ZGnSXYRptXahGvCuS7jP4ZKr0Q4GOdID5kOVsuK4v0AQBt
	 yeoAk1qP58TIw==
Date: Mon, 12 Oct 2026 14:21:47 +0530
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
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] phy: mediatek: tphy: simplify main allocation
Message-ID: <asyfMEwzhwJFOIZa@debian>
References: <20260812181857.64544-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812181857.64544-1-rosenp@gmail.com>

On Wed, Aug 12, 2026 at 11:18:57AM -0700, Rosen Penev wrote:
> Use a flexible array member to replace kzalloc + kcalloc with a single
> kzalloc.
> 
> Shuffled some code around as __counted_by requires the counting variable
> to be assigned first.
> 
> Removed NULL check from of_get_match_data as it's never NULL per the
> device table.
> 

This statement is stale in v2 :(

- Mani

-- 
மணிவண்ணன் சதாசிவம்

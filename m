Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DA47CA87;
	Thu, 13 Aug 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628421; cv=none; b=ZhIEijNprNxTOfhxn2eHggGpnpfvKVnQmRHihG30r3AZaM1g4fzzecBqjTKdKGNLBTqrnMdZouBYl+kcUKcoFMD5GMTH4bVWuf4znjCYq0xfsoorhgo4lVUVDF4pb7leSm7sIEaZw5lWifk0Ufb47VwTnFnelIR9n7fCUDhwnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628421; c=relaxed/simple;
	bh=bOvvTxJwRAeeehEcmN1+v56tDgPAZJghrGSo7LRvNAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knIS8jKnHTCSU9ogViCLl50GOIG8/X6pvCaXosszm3Orh4TlUoW6V9/k/wNrW6Nv9RTnOjXabgdkiNQQEemUVKlS2radRNQrTRl8wdoqMf1CRaIiz3htI19WP44wV0fI6MIMvomAi6HKSXQpLI1iq7OISJGrP+IRKt/deJ5dcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7gJ4sPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7gJ4sPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57941F000E9;
	Thu, 13 Aug 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628419;
	bh=FQHX6qwH3K6Cws7imC/VISNvbPtmS5LtCAb0pnEIW4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7gJ4sPL/QLGTRofjuqgeInA8apUG+qo4OurrP85GJpr84S9Pw17xHY0jtHVXcpMJ
	 gEb9YOkZ87XkUuS01iGqtXyKLEk9ASVMiBnMDgnHHSqa7ODLMd2AvCjcmZ6UkM1Tco
	 5nmhg61sL0cD4novs9PZrdiJ43TlB+WIWz4YD+j5B2vqnCBmJj9ZexvaYnnftfQo4+
	 ARajYMF0RnJLoBdoQEA2y+Bot6NHtH/NApHbMhfguxf2iWzDGIdP1H72i640f3LYub
	 txUuDBDfvo2sU74ieusuKZ3RKuoQgIRhlE/R9ApOtNZgU3zK1DY7yURwY6RRnYdo8i
	 dv9cuvIjOZsdQ==
Date: Thu, 13 Aug 2026 15:40:11 +0200
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
Message-ID: <gauflzkiq4nsxciwzy4r3piodhnoriv5gh5mhsauk7bxgwclcp@3uiuv7i7qbh7>
References: <20260304041400.7236-1-rosenp@gmail.com>
 <djjg6jwpuu6l5wcc7zbxfi7j4n5hircmhivxohdtgufzrp6rlb@l6eyfdyfrxix>
 <CAKxU2N_VYNgYKhS11Frzio4fbg_ZnDsvCfEypvxSiw3-JV0_QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_VYNgYKhS11Frzio4fbg_ZnDsvCfEypvxSiw3-JV0_QQ@mail.gmail.com>

On Wed, Aug 12, 2026 at 11:15:43AM -0700, Rosen Penev wrote:
> On Wed, Aug 12, 2026 at 6:32 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2026 at 08:14:00PM -0800, Rosen Penev wrote:
> > > Use a flexible array member to replace kzalloc + kcalloc with a single
> > > kzalloc.
> > >
> > > Shuffled some code around as __counted_by requires the counting variable
> > > to be assigned first.
> > >
> > > Removed NULL check from of_get_match_data as it's never NULL per the
> > > device table.
> > >
> >
> > Please do not combine multiple fixes in a single patch. Also, the NULL check can
> > be kept for the case of sanity as it wouldn't hurt.
> hmm? There are no fixes here. Just a FAM conversion.

Doesn't matter. A patch should do only one thing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

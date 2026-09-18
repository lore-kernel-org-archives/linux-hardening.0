Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9F49BD86;
	Fri, 18 Sep 2026 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766200; cv=none; b=Tn307OKpF6EhpP4+3Pm10hTMRKAMRBwMB9MClrp9pLxiO7MxZRPu06K8ssdhx1lPwTa22ZbYRLq3QRlRNfc7NzgvCG1OFDEhNVFYbS2tDCyCn41OnjtpXMUvNk/2Ptwp/o+xqADR5/qQ4ypWzF6IUKrlVUrTWQnW2fymLrf4Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766200; c=relaxed/simple;
	bh=degIIcbCRvjwsRmFmL2dGhhNgkxJlq4ndAiAVJW1M+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gCe3zruxTj+TfaWyVadNGReIfMSqavZFiOYyp5JIUoG2ZAwETx2cy/jyUmzfLCbV3bHycXeD3yazIcda7hz9f8tPoBi3cqzhYwcbGS6cB1Fd6WHh8yL/UV0W6J07aw9T6pozTIxfNph6n2vSl58J3WnmKtdrV54WkDlmXbsLAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXjVL5f3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXjVL5f3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EC81F000FF;
	Fri, 18 Sep 2026 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766197;
	bh=nn28jhrlaAY2fftMjfIRkJUBt2vqeMHKyGKIhLBBzq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jXjVL5f3ZhrNlZUVNcFA4h0974qhsoXaDUcTIl1pVShMxIsHLcE6SP2A3/+6GAMqZ
	 2f7G45hqSMl2gAbBrCgFTVebZziV036my5T7ObtWDhymbH0/mAdNbFhUl7Ovt6Rjj6
	 3i6KqG4LFyamPsbyV4sBLu3s+i2vGa+3xj1YMvJECLIZb8Zh1fuesdb+uGpbaBgrS5
	 rCCf89PKAl1xv06rrbd2fHuIyQoWOWWjI//0wk2tRpa8zntD61jImjvKDTjQmCDPiC
	 D3Aokbli6oWUN8l5m+jEKHaTzjoMd7ghQpBgV2Eeo8PbgqVXSDy2IrSnou5YVRhwLZ
	 5wY+8/g/saVOA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260917211423.i.786-kees@kernel.org>
References: <20260917211423.i.786-kees@kernel.org>
Subject: Re: [PATCH] nvmem: core: Add const to pattrs allocation type
Message-Id: <178976619658.821969.9520455607016938775.b4-ty@kernel.org>
Date: Fri, 18 Sep 2026 22:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 17 Sep 2026 14:14:24 -0700, Kees Cook wrote:
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "const struct bin_attribute **", but the converted
> allocation type would be "struct bin_attribute **", which is the same
> type without the const qualifier. As there is no general way to safely
> add const qualifiers, take the size from the assignment target instead.
> No change in allocation size results.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: Add const to pattrs allocation type
      commit: 07242f2fa13247d558352d481a05a97793f9ab1d

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


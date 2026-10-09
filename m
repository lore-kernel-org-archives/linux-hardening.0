Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC75388899;
	Fri,  9 Oct 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567757; cv=none; b=DTi0pP8DOAxP8qI8iW5e2N8RHBplg1F2fn3OGbvLkYZ4ZmjagJw6G6FYIkzDzJUp3PHAFGs30x/9PjiPaXa2jLHdTg2Y6EbnGUDsoFFUREkQf2kyi/T2sskcB0AiYQlBZZZGxv9Zuu1QQmrzHgCdi3ft590cekYwgIBqHV1BvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567757; c=relaxed/simple;
	bh=MYZCFcnGVwravfQJoAJhoTJQ5YLQriFGFELEWuNGOxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qax6/a6qq1py4kkVAfozHIzY1kF3w3RJH7Cpx/APTaNpf31UjdPOJTCVU8hwx0gnN3ICQbKpsK99fWxiMTZHngwh38I31tJeKTje68TmJLKqREkxsW+JcPMxLVFOVrKa1msDaZICJ68e9l2oDWU9sgJYFtkAbUSQccEuda5gv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efXsdIoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efXsdIoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFE71F000FF;
	Fri,  9 Oct 2026 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791567756;
	bh=gR9DG1fEHiN2p3/i4oj6eVX6qR2LIOcWYTyiypTAGH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efXsdIoWwWqF4ntQor9o80SrU0oukoxl3br5/YUxzxL7ZYcB8kbRNKdthrT5gYshv
	 goU6Z+2TCoNResQwR5z8+wGLS6jt1WxFNob5uvozEBqmkqorlNKY+vzs4EG9ggRAnD
	 JOXHxndYjc3NDXybA+qGgV+TPLNabNB48qEmRpPlIvEX3HUC0wwxeRF7/3P7XDlaxO
	 RbidzmVdo3TTSLIms2n62RcS/LkhfSxrBFK9BZegveEeajldCKKpgQxt0vf0+gzvcH
	 LRqcF85Z8SERJTMcCPe1TEP3W+hsYsM/xm0KWmtKcabvxj85l8R7U8m9PJSc/vOF1Y
	 gZbj+KnxOkLig==
Date: Fri, 9 Oct 2026 19:42:28 +0200
From: Brian Masney <masneyb@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
	kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
Subject: Re: [PATCH v2 2/3] clk: toshiba: introduce a TC9564 SoC clock driver
Message-ID: <asknhPZLx1lbvam2@x1g10>
References: <20261005230927.2000398-1-elder@riscstar.com>
 <20261005230927.2000398-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005230927.2000398-3-elder@riscstar.com>
User-Agent: Mutt/2.4.2 (2026-08-30)

On Mon, Oct 05, 2026 at 06:09:25PM -0500, Alex Elder wrote:
> Define a new platform driver that manages clocks implemented by the
> Toshiba TC9564 SoC.  There are 21 clocks that can be enabled and
> disabled.  Two of these are reserved, so only 19 can be managed.
> 
> Two registers manage the state of the clocks.  The registers are
> accessed via a regmap supplied by a system controller, because the
> region of memory accessed is shared with other drivers.
> 
> Access to the memory region is provided via a BAR on a PCIe endpoint
> function embedded in the TC9564 SoC.  For that reason the PCIe clock
> cannot be manipulated by this driver (it is assumed to be enabled).
> Similarly, control is not available for the I2C clock, because the
> PCIe subsystem on the TC9564 relies on I2C.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Reviewed-by: Brian Masney <masneyb@kernel.org>


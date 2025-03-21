Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932701F1301;
	Fri, 21 Mar 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550059; cv=none; b=qs+1XHA2bZCP8dXaGSo1KoH152lPvaEfQXQ4PpirIKmlIqygEaqctpX5vaDQDUUPGEVqUDS9yqL37OdM33r+gFLprYkM84DBT7DgpilsEbfQoHrV9p7m6fc/Em7II/HTjODQwh6V63ygTcY7eM68Beq6bKYm17vVskpzwOKj2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550059; c=relaxed/simple;
	bh=ZUR3lzcRBOLhjpUcQQNzMmdrN44+Szn9WQ+beag+iII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYiovPSZumKAr4k0clsbfPy5aG5rbFNwx5sGXGSX6oSX0101JOaObgpe25WTZjL2I3pudnAJ7tMK9lI8JriBFDJMFkPnNYgmB2EuFlouh6pTEr4OgpGFlzF3Uw1JgAQhUqpltRLCnEKTeVG9Dp/9NrBViXMamsSiz0S3Dm6ZfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWekec6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWekec6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77739C4CEE3;
	Fri, 21 Mar 2025 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742550059;
	bh=ZUR3lzcRBOLhjpUcQQNzMmdrN44+Szn9WQ+beag+iII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWekec6kxiYnlS7QZErXiNsPc/l2TByldwfMbfk5qxHUAVgfeyqbcy/No4TD6IzpW
	 RPKF5LBKYJsHslyHY0Bzz4grHOOD50zPUyM/uSddpo615o0g4GUAgkenCW6q3wpPDk
	 UAzZvSOJkj/s+iN8D8GT1SDzw4pZ6kzp855K5UF8OheTgbsMsmAZu0CHcBmV7JC15m
	 Kq7RadEydjN8AudHG/NHMC1n72vg/6XWa3vTpVB7e713qzCx7q5nsqiGHRwRbQ3AA2
	 6XYde8EJUS3Frl5/iEzVLcDKK8L94ffbnoigiT7PkTqMhfyQH4HD5JjNaWQaA0r23L
	 qbDlQ3Jfx7O9g==
Date: Fri, 21 Mar 2025 10:40:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org, leohu@nvidia.com, tingkaic@nvidia.com, 
	dkodihalli@nvidia.com, Mars Yang <maryang@nvidia.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL
 BMC
Message-ID: <20250321-romantic-gentle-octopus-4aacd4@krzk-bin>
References: <20250320164633.101331-1-wthai@nvidia.com>
 <20250320164633.101331-3-wthai@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320164633.101331-3-wthai@nvidia.com>

On Thu, Mar 20, 2025 at 04:46:33PM +0000, Willie Thai wrote:
> This patch adds a binding for GB200NVL BMC.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell GB200NVL platform.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Usually this is just one line. Commit msgs should be concise. "Add
binding for foo bar, an baz based board for making frubies".

Best regards,
Krzysztof


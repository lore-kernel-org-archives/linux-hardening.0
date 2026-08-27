Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF62F7AD2;
	Thu, 27 Aug 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831467; cv=none; b=KS++qdgXnR7a1HehKrDW5c1oZGap2i2IW96s2/Ks2aQitSmAJMRfxNgYYyZyKdQ/TCxB8wvdbI1THaSpTgqi5H3Xcz0a+fXiRomxXlnSjGtg0YDLkvVFTEqVU5FP4DgCplBX5d9FNH+xeuuEDcguLIxtTHym3njSELsEDhqXPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831467; c=relaxed/simple;
	bh=igkNQlBP2BaTRIlMHhCubWZRuBMJE6Tgnv+PPM4/rRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGhZ6Rw/xEHUEEzaoIDnMHhNDQA/7iJuzw5UG1lhlJlL9pI8fcNb/XdUe6ytmwIsc5nriF0uYEaTN1LncdVdkeYh/zf/aPEv3DL8UMN8xZ62DuiNwFMzVXpQcMQesLt1Y4rc6Ke4ZF3jychaLM/guYlCOy35v7lvNNwijZ+tb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcTa+g+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcTa+g+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246AC1F000E9;
	Thu, 27 Aug 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787831466;
	bh=AJ4bFw8CfJZsyHlG9QLU5hpKk597i8D+mlzTAwmUmDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YcTa+g+wcKmXSmzNfKtICxQsXauqvCU2YG5aKOU02o2XuHX3ZeGqpdPRkhbeJNsfo
	 7zvBxm0ONpZ3BNM4eynoojaoWLHwdweOq2/PaeN65cu2sjqewbgi2QFZRdWpF7gQ8B
	 YLDmBpoFvnb+Qo0bYvnW3Aiv7xnne7V4nP/rnjySQWzbDizwDK7sNN0Ub4dWfGSwdq
	 CF5hmmAOxxRbYWh4krRVGLYl9NCJAl247eoA7d9kgjxG7dTCPC95iPqBpwk2zHKo6s
	 L0cKbuIRU6sOq3L0GcIKLV+BMPH+e87LqJw6PN88JVfHgEhq2W3BrWf0oGtv2Q6ad0
	 cr88I4/7Ay4yQ==
Date: Thu, 27 Aug 2026 13:51:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: vendor-prefixes: Add LeEco
Message-ID: <20260827-therapeutic-economic-sponge-f0ee47@quoll>
References: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
 <20260821-next-patches-v5-1-ec81cee63e09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-next-patches-v5-1-ec81cee63e09@gmail.com>

On Fri, Aug 21, 2026 at 02:27:00PM +0200, Adam Skladowski wrote:
> Add vendor prefix for now dead ecosystem company LeEco
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


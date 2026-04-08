Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D5359A8A;
	Wed,  8 Apr 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633833; cv=none; b=H9pdo6lhmbO/+bT0w/vLhw4JiTMqzNHOASSWqSjV7B/Hk1zd4ct5dS+OOoXTToXzc54A6nte2l77AmK0PhpWo4nlvL34CKaJJd1+MRHX7hpsMf+1Rs95EM2qGFCcF+od6efPRBZ66CoG1DdNrhTWah61G+8GnNWOYcD1ukW/+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633833; c=relaxed/simple;
	bh=wnU0fzE4WYNV8meUHL7yBM5tb0lY073DtCHpBVwob+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvsiimMoufaVxmET7ZLcxeuveSL+V+73TgyZkbK5UUjUg2FK1jRemoZB+wzyxCxQXwIp6kWTPei0QVGhfZRpLHuehKp5xsQJDu6Cp5bSKpjsBZ2mUCPN9zCIFw/bV6dtW8gAvUyQeKgFsbYXqwV86D5B8W+5BKAL6bffPPNOzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZUAOu2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZUAOu2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B35DC19424;
	Wed,  8 Apr 2026 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633833;
	bh=wnU0fzE4WYNV8meUHL7yBM5tb0lY073DtCHpBVwob+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZUAOu2edZ4J690rUEYDhTW+u8JTMGIIBLjDSmZ0Yywjb0Wu8UBv8mTqhIIpzW7zX
	 mmy1IIb5XDzugJlPEm7jQQoOTUpvXI7isyga0LUxwV2435VZeFkG2eYopp2wRj8ccy
	 AfFfrxopC4zuXiOtiTMS4ny87zD5ZFLEQg0EyX/eoP0euKdo8witJ4M/bjDJ/Ibyfd
	 0SrXeU13qKGN3uvFR2x4pekbzdDUgLxU3r5kK01KgshhU7//ztgDLdMoH1zoX1S51j
	 R9BA84vehKX8b5AjorB9DS6vV/B/a+7U6Xtz0VOvGDkK8BKwP/ZFCYKfFV6dJksM5H
	 CCb0umhbWbsDw==
Date: Wed, 8 Apr 2026 09:37:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Rob Herring <robh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: cache: qcom,llcc: Document Hawi SoC
Message-ID: <20260408-spiked-walrus-of-argument-9faa4a@quoll>
References: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
 <20260407-external_llcc_changes2set-v2-1-b5017ce2020b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-external_llcc_changes2set-v2-1-b5017ce2020b@oss.qualcomm.com>

On Tue, Apr 07, 2026 at 02:51:47PM -0700, Francisco Munoz Ruiz wrote:
> Add documentation for the Last Level Cache Controller (LLCC) bindings
> to support Hawi SoC where the System Cache Table (SCT) is programmed
> by firmware outside of Linux.
> 
> Introduce a property that specifies the base address of the shared
> memory region from which the driver should read SCT descriptors
> provided by firmware.
> 
> Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/cache/qcom,llcc.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


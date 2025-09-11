Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA82459C9;
	Thu, 11 Sep 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575042; cv=none; b=EnTCfYYUDWnpeIhWwkywhwOOsY2zCtSQDV0FX2ZKIS7t8bQrNvsDIxuYcM+EtWpFyeVbYU1n5eHZYjRUPuZIn9CfPoQyA9RXBP+sBGFL+uVyktx1Q4wAoh6xWfVyfkTQHy8kptDid3IEsIoVSxD3eXKW8y+0wkc7oKIKr7Iyks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575042; c=relaxed/simple;
	bh=3wMR5YUirmLoPyGcn3OfRq7EbTozCuJg0PvJ2aBv9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwJ036wkKP/KUpq9yJniH+M7/n5zZBi4DQ1f3d31qgBla1HT+BSM/7skOgvexVMxVkJ/HHKWIi659FqWR/p95g8zPxn8VL4E3drEYFLjXA9EemInkpZo8EHSE9Ll6U4C8/yHq/bQV5lUrmm5GaRM/bNeJB+xaVwLFJlPEjKc0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnlyHtvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnlyHtvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0020C4CEF1;
	Thu, 11 Sep 2025 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757575042;
	bh=3wMR5YUirmLoPyGcn3OfRq7EbTozCuJg0PvJ2aBv9I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnlyHtvqisURuISsrxVijo3amDU6SNauC29tvDoM5DfB2RP9YUPd7RIV6OvzUSYJU
	 h8NdDOFYfkWVxoPnC2KijSWlEBhSsrRVNcYOdSRWfWXfTfRTocu8rq6NZzPLtZ4OxS
	 wIBPZwcz5jD+wncSqii9eY+jk5QAfPB3377uPxHjpE4bKFTLHlvGIuzd1blS6J0XXb
	 clg7fTSP6fn4Xjcyms/h/IZR0fKwvxDF9LgPPxif7qfaT0n3SjIWAUxt1ncacOOEG7
	 pN7yvRZM8jxh03qk7W3fV+ulwgQE3mmZpcUFSvGqMoVwN+Pj77ILPgDmtMWIU9HfVp
	 LlREz9Hyd4Upw==
Date: Thu, 11 Sep 2025 09:17:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com, 
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, jarkko.nikula@linux.intel.com, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com, srinivas.goud@amd.com, 
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V6 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <20250911-zippy-lavender-raccoon-e5326a@kuoka>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910112954.553353-2-manikanta.guntupalli@amd.com>

On Wed, Sep 10, 2025 at 04:59:53PM +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.

and here you reflect the resolution of Rob's comments, otherwise you
will get the same question.

> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit subject and description.
> Moved allOf to after required.
> Removed xlnx,num-targets property.
> 
> Changes for V3:
> Updated commit description.
> Corrected the order of properties and removed resets property.
> Added compatible to required list.
> Added interrupts to example.
> 
> Changes for V4:
> Added h/w documentation details.
> 
> Changes for V5:
> Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
> 
> Changes for V6:
> Corrected the file name for $id in yaml to fix the dtschema warning.

Optionally here you put that resolution...

Best regards,
Krzysztof


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21752C15AF;
	Fri, 19 Sep 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315298; cv=none; b=tUscJ15CllpPC9X2Me5GDwYnSCJmWbuYxA65MeWgZll53jb331NemjGacItMIa5FiFwJiMIDNc6XW0SQFPWgyXQ8+NMEyDyMLMU2O1A/B+zhtHG+Mqn1m8iBex9IkPSusj/Svukk/8IroU8Ptl8U8fzev79YsVwUU+MxXJISAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315298; c=relaxed/simple;
	bh=goXMosi04cs696fzSOhqaLlCV7yhoQls3NSmu33eYr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPVSdX4e5bVbhHfxTlAll6M37fDjX3JgWc72ImnTxObuOyuu27dLZmPUcHC8GxS8CSiJwplBSb2YgTmwe9DV5uEBn0/wrAkt2fsxour8vrahvbYt0i4/I43paJz2DZCi391qGcmCBkC4fRVS9lDvmS5a//yi+/yre37T3wDtYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibiw7QD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibiw7QD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4809BC4CEF0;
	Fri, 19 Sep 2025 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758315297;
	bh=goXMosi04cs696fzSOhqaLlCV7yhoQls3NSmu33eYr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ibiw7QD+DTelbLjysa/Y0mwuQ2L3EV7Uaa4ZPs33v+stGqv/ZpA3DlQ40b7qDrPw8
	 1JFb3xZxTQufmmApRcyB3y+cdZ2h1+i1twUW0UyKyQZzbnjMwQkrJ3YTXnT7IpNxsL
	 ld6fH8aE0jYOdrH2AD21ZOC8g73DWsN3ygQm4e+rJdhQZxY8DsNJ2PAi0gimoocrbu
	 lubvXMj2hhqxcEWYxK7UUX5Tu+n9QDkQkn+6Yhn4ZLFx1fqrg2Oiyzt4aggrAaDRRh
	 r+8iulWiFQ4yh5UU4BkIZxZDDlPNTwcnCn4ZGlGGLZWoUQk4JC7lwVh1bnPYz3LgPy
	 xQi7tLxZ0pjjw==
Date: Fri, 19 Sep 2025 15:54:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: shubhrajyoti.datta@amd.com, gustavoars@kernel.org,
	linux-i3c@lists.infradead.org, jarkko.nikula@linux.intel.com,
	conor+dt@kernel.org, Frank.Li@nxp.com,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	srinivas.goud@amd.com, git@amd.com, manion05gk@gmail.com,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	kees@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH V6 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <175831529495.2200422.4249536925418655558.robh@kernel.org>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910112954.553353-2-manikanta.guntupalli@amd.com>


On Wed, 10 Sep 2025 16:59:53 +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.
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
> ---
>  .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


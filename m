Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C642BC23;
	Fri, 14 Aug 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703629; cv=none; b=qQX2eLg1/IqykoGNxHbzQ083H6jrZz1HS4xk6CG5HgHhj7YIcSacY2SeCmyzFXi0uSRXPwXtm94p1j4wz918DjF1o5w4VdevkA+E9cc5I217EcAm8lJrMyRNfISDsnHC3jXOFpFtlGYwMuI2Ghq4wM8TArMJsfrrJOMxTeiqcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703629; c=relaxed/simple;
	bh=MQHcRqVPY5gHDcJcbC44WmXX1TYa5feHRAArZfeVr24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keQ7rW3gWUF1j9AdW6ztm0O3IaQFV3orEg0N1SivgIapE4YCOAi2LzO50uqhpepAsrfDay9+lz5gT/gX32cI7R9ePGxyLiALU4Kfu1mBkZ14iQh1RbqcBPH5k0Cyq7i2xXSTfidjviu9c1R0Sq2ERaEaT/v9CJ7tLU0a2mOwEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDVkYqjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDVkYqjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F121F00A3E;
	Fri, 14 Aug 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786703615;
	bh=MQHcRqVPY5gHDcJcbC44WmXX1TYa5feHRAArZfeVr24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDVkYqjLYbLHtEzNmwAWCpTriNIguivL2mldI7KOSJD6k5qiIJu0i4xLzhMO/7xlG
	 S3gomBUE75DqFD8GRtoOc4qMFV09MJaUllr8TzlMeZR89QZsBOXgF3eCI9tydXWvSl
	 e1SJ+ak6ZCiT6li/qI/Z4M6lGy4E7rd25SnItoR2+SIbFbFF83MUG+J4E50et0CAVC
	 FDzu2dO12Dbh/s1NFVF6NVkhTHLECupvPX+pvidE3ut7fyfvlbE8L0CrmrzQqyPsaY
	 WM6ShiR/NzdT83jy/KSUq4Z+2mZgpUpgbgC2yoyXZgj93cacgEwpmzL8YmqsD+GqM7
	 nDt/+vkLvfQSw==
Date: Fri, 14 Aug 2026 12:33:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: Add LeEco
Message-ID: <20260814-sassy-glittering-koel-feda2e@quoll>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-1-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-1-79a779d76173@gmail.com>

On Mon, Aug 10, 2026 at 06:55:34PM +0200, Adam Skladowski wrote:
> Add vendor prefix for now dead ecosystem company LeEco
> Link: https://www.le.com/

Drop link please, points to some news or video stuff.

Best regards,
Krzysztof


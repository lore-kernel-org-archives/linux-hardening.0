Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B634677D;
	Tue,  5 May 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993643; cv=none; b=PuIfv+70Ljh1CX5rqKc0oDFKCXXjbBi/BFbzKmt3Jm1JaRb4gklOt7hcPYmgEdMzl531lEpu7H8cBj+Su7ooi7VBr7Ddh1MuGx8geKGrlrIJFNqxXo+WrPzcddUu9ShmoazJEgC5WqAyX8G1cTeRaADr+lwm+1d8fY8HDWkWFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993643; c=relaxed/simple;
	bh=jjj2k78KwRdKmv4e99Ej6WSHvFzXtDbpH3t9uUhqUQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igatOha2llbPQDu1WznVIIS8MGCAji1dNQVmP9pjoQGY++CwQxIurgR/qcV0XHem0mfqMN/EQ7ZyodOhm3FG+xIoFsaY8OMCyErMSlbw/PxeqLB21nUG/5G6lxTS2KGX3i9ow8pHR4lGx2IJPiGXDap1TACtHA4DZqcakxDCZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BxvctZ7l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VX0aSoh/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxvctZ7l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VX0aSoh/"
Date: Tue, 5 May 2026 17:07:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777993641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtWmLnPN4QnCqQ/IWMLrtRtebL1fNe5ZZfybv4/p+q8=;
	b=BxvctZ7lAhUq26ygVI+U0SLQPVxx6jlTano3sCjyLWTgRIYPnfc+9lCzUzPMCHMmy+jOd7
	Atz286wW20YIF/U61MsrvRCCV1pDoyBnVUqkdZPR5XJI3JOrWEGnsq0zhJDB+MEY/KwQEZ
	4EjaBwMJ5PG05ZcS3FbfXk45+kLmn7w9/pbD2nF1B/pbSnZp5WjhOjfduDrBqeMmaPT4pN
	vre/MtaEKL7hD70W7MjMMMm93atECpFodu/wOqvaUfVqi1+zV4BX+3j3HXD6oparLa52pz
	Ji0/eFspMXug5dBC6wqbNumSz8U/TFX527mm6JJBcrtXeNOAAFyOCuxDlLl39A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777993641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtWmLnPN4QnCqQ/IWMLrtRtebL1fNe5ZZfybv4/p+q8=;
	b=VX0aSoh/Ovgukr8ZhUVsJfyUm/RUc+feGJBtPwB84Qkn5bq/oV0pUAi5uj3Kyg4JXem7Yk
	telo4+qbw6v0//Aw==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: broadcom: bcm2712: add
 bcm2712-firmware compatible
Message-ID: <62cjph3247lcm54usdkgbc2oy6ubdqcg45ovtscgb3qkjayltr@6mvx6dcycyyx>
References: <20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de>
 <20260505-rpi-otp-driver-v2-4-e9176ec72837@linutronix.de>
 <6155d6aa-5e66-4043-a7b2-da447548056d@kernel.org>
 <64af1e4b-0cf6-4288-a3ee-f65fc9e14e94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64af1e4b-0cf6-4288-a3ee-f65fc9e14e94@kernel.org>

On Tue, May 05, 2026 at 11:22:54AM +0200, Krzysztof Kozlowski wrote:
> On 05/05/2026 11:21, Krzysztof Kozlowski wrote:
> > On 05/05/2026 09:25, Gregor Herburger wrote:
> >> The Raspberry Pi 5 firmware exposes additional features. Update the
> >> compatible to reflect these differences.
> >>
> >> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> >> ---
> >>  arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> >> index b7a6bc34ae1a..7283078fd441 100644
> >> --- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> >> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
> >> @@ -46,7 +46,7 @@ power_button: power-button {
> >>  
> >>  	firmware {
> >>  		firmware: rpi-firmware {
> >> -			compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
> >> +			compatible = "raspberrypi,bcm2712-firmware", "simple-mfd";
> > 
> > This breaks users without mentioning and without proper reason.
> > "Additional features" is not a reason to break users. At least not
> > without explaining the actual impact, but even with the impact IMO this
> > is just wrong.
> > 
> 
> 
> Heh, and you ignored completely our final comments in last discussion.

Oh. I actually had it in my first draft, but then got schema warnings and
messed it up somehow. Sorry for the noise. Will change it to the fallback in the
next version. Will send a new version with the suggestions from Sashiko.

Regards
-- 
Gregor Herburger

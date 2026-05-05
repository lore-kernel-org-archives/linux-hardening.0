Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA703254AF;
	Tue,  5 May 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971633; cv=none; b=A4My0FGp4YyxC0cDR/CPNoFbGlb5ovkZ2yaTFwFWo1LEpM/7hrf8jyuz7ym8xn30UFhbyIenRLWTvzdUPDND0424xLFJ/bh9AL77z5kG9+yj/AtL9Ej00StAPmARxBcq+IVZ8dKvM4KjpqRyF42M55xR+GTFEeIaijuWvvaHXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971633; c=relaxed/simple;
	bh=q/NatlP+cOQS2FmvC7zHrLNZ8KeWMGRc9gqXfXgWdIE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nb8DpQYxQOnNYnOmNesestvnDHM2LOGbUkmMdIDxKLG4gng4fMYhMr46RBjONzJd52BDT37L7uE2D179okDYVfhQe1wEIdvujU6v8dp0vTCc33jb95JNqgVZw2EjVrkNx7K9/4rxNOWhbg1IeYbcxNv0MMULRghY6bVlH8V0QRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd2gXySX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd2gXySX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73AEC2BCB4;
	Tue,  5 May 2026 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777971633;
	bh=q/NatlP+cOQS2FmvC7zHrLNZ8KeWMGRc9gqXfXgWdIE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Hd2gXySX/yopYveQ7ncqd+JJxc8m6aieD1vGJWHaXXGkOMVFdYUNrAKL1bg/Wz2Zw
	 m02e1kw5xEjz4DRaZNRvCWJiMe6CxA1obf5297rzFoE0oQhwTlNL6Dl0y5d2akJURZ
	 pvlUZZHEPPihMWjNF7RBMXwLdvMTiQ5vatUSE5qpWiRwbSKB9FWktUzA+AB1cXwV/0
	 SZ+GokEtmPxemeWde0C0e9IdA1snN8dypwKniHjbY9kYJlR2iiwt51/88Wd4nLJr+j
	 XG+iDHKM9h1t3XiKeq6Oyo0emqs60ivK30sH54wfK/T+HP+PCRXbKljSqVuFHMEsnl
	 so0BNnYIRNfww==
Date: Tue, 05 May 2026 04:00:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, 
 Srinivas Kandagatla <srini@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-rpi-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-hardening@vger.kernel.org
To: Gregor Herburger <gregor.herburger@linutronix.de>
In-Reply-To: <20260505-rpi-otp-driver-v2-1-e9176ec72837@linutronix.de>
References: <20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de>
 <20260505-rpi-otp-driver-v2-1-e9176ec72837@linutronix.de>
Message-Id: <177797163082.1577508.5643979416868173390.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible


On Tue, 05 May 2026 09:25:09 +0200, Gregor Herburger wrote:
> Add a compatible string for the bcm2712 firmware.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
>  .../devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260505-rpi-otp-driver-v2-1-e9176ec72837@linutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


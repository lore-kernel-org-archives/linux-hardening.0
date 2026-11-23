Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445923;
	b=JnUZtK0ZcyaNDxZHJNR+1RE7iihxaZ/fY2zDWe2MiA1/+hQgO4Rmjw90LxR/OvHlWuGa
	 0xXABnOcLS6Y1DtGId0acNU5HARE1O3NoTYUodVvRf3eIyrGWleoiOKOTy0l/zsNp4EnO
	 TaHhmKctADG7Sy/WhW0k8H8u7AduX0SuTid/wK54AlSD1pg9ptvO8VSu/cb0iPUwC2tp9
	 6Klys/TSOm827uUV+BUpdOJ/sVAEHnLfcRfItfKYVvu9o/jT5UuhRLtUEHbjbVZrxR82J
	 yACqiXK/F4yKP1q4YOs4835nnCcxuaSpL6npCnLfMGAUZgBTrA1/Km8RVkrDbqh83nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IFrYxJ9uxD4vVeZJrwzDiQh9DcS0onJOZvbvGDc1JU8=;
	b=pEjZ2a9Ei3zkT/9khikYB4MBtNAI7QeX65tihydacwSSqCzFPux4kHjI9Zrlifky9eCe
	 0E+EISZF7kdojrgtlXKSXwCvw3Om+GEt++wheXHso9oUAF6SxoCTyuC8NygI0c1whoJfK
	 ptdLDVNiG2OqrPQtBTQmSVGw3eHREl75jdXMEFpsiZ5i+kcAuAc8M3C7ighh01DSgM1rE
	 Ey8gEqCR4VLUjPDrvh0tuhurqRQU3V98AIdg6A6ruWBSit4xq8nlqmmV3KDe9iIDzcjn6
	 lR+iPade22kkdINMl0mX07O5ZJenAC/4g8xyNYFOHFrDGnGFq+4NSyudnhxycEy9mYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2qsWLN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D2606A327;
	Mon, 23 Nov 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2qsWLN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C451F000D1;
	Mon, 23 Nov 2026 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795445923;
	bh=IFrYxJ9uxD4vVeZJrwzDiQh9DcS0onJOZvbvGDc1JU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g2qsWLN4UyORalJCuyoZtcK4c1XcnbevUsXqK67HipUQN34ZCI1cD+cynaYtJI/PL
	 MSbfDRSCgwWjNoKdfa0mjDE5R//DTEiF+F8emfqaJuqF3FtV7W1vSABiVVE83LHCqj
	 SoB2j3L8SEOnCmrJWhjxQwOLOiQdKJ+kUHEL8TYpV101+OtOmHFN5SRhDgE4IgNkX8
	 9/82e5AHU15yYepJ0riV4QYNwQXGawZnxbugXQTjyOA4Gm/jUMl5E9Moh4yU9OO7+h
	 ELsXqoYR16Fy0spgwGTz1j5hFeJiXSMIxT5dzj5HQS3nTNyQ1NODy2c8BL6Da16hO+
	 jDXLSUDamZ8Wg==
Date: Mon, 23 Nov 2026 08:58:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: reserved-memory: ramoops: Update Kees's
 email
Message-ID: <179544591880.2458636.1601285565367516455.robh@kernel.org>
References: <20261113174237.i.303-kees@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113174237.i.303-kees@kernel.org>


On Fri, 13 Nov 2026 09:42:41 -0800, Kees Cook wrote:
> Don't rely on .mailmap to get things emailed to me. Update to my
> @kernel.org address.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  Documentation/devicetree/bindings/reserved-memory/ramoops.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


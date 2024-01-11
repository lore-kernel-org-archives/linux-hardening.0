Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBB4CDE9;
	Thu, 11 Jan 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIt5S9SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0CBC433A6;
	Thu, 11 Jan 2024 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704988192;
	bh=G9n/W8hlwgFdV2XQPUCibHVKDRupPUflmAwUSZ1qwoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIt5S9SOP2dAXfAI5csudeLa8eUfApLnPkda4VcyuWAAntp34FktC9PARGLSGqNhP
	 m6VZ7ggviPTdMIHnka1KPiSJRX03tAHXNJiGZ6FQ7nG6dCJ0rhfO8uuH+PBE60YwDX
	 sQeD+Uoqc5nMFWO/TsuI9vcw4eRMXQ5xQ6gTfLZKYYwlOVy91LjhKwn2I1z6E4WnCK
	 tmGesgVvOsU+mbo+sPfdiJSvpF1gBM2Ri+lkvDOGdpmZh0LZBOiKZGH0RQmFXd3l53
	 b0iJ1FaIvn3OJFlV9aEO2jIFzwVX1DDmXe08ppXIPIlwVXN8dind+QFVMms28AGNx/
	 Di6gb/IGLhCHg==
Date: Thu, 11 Jan 2024 15:49:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Keith Packard <keithpac@amazon.com>,
	Haibo Li <haibo.li@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: unwind: Add missing "Call trace:" line
Message-ID: <6784d8b9-4933-40e7-a00a-a7581bc11ea7@sirena.org.uk>
References: <20240110215554.work.460-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QeCY3H4cDzibhSMr"
Content-Disposition: inline
In-Reply-To: <20240110215554.work.460-kees@kernel.org>
X-Cookie: Does the name Pavlov ring a bell?


--QeCY3H4cDzibhSMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 01:56:01PM -0800, Kees Cook wrote:
> Every other architecture in Linux includes the line "Call trace:" before
> backtraces. In some cases ARM would print "Backtrace:", but this was
> only via 1 specific call path, and wasn't included in CPU Oops nor things
> like KASAN, UBSAN, etc that called dump_stack(). Regularize this line
> so CI systems and other things (like LKDTM) that depend on parsing
> "Call trace:" out of dmesg will see it for ARM.

Reviewed-by: Mark Brown <broonie@kernel.org>

--QeCY3H4cDzibhSMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWgDhUACgkQJNaLcl1U
h9BJewf8DvQ4N4ZXs9SBjfdUJ68ZkYO6tUnl5kMwZ8FBDrLj9+JBI11MRBZUv8Tb
bbzaBZmxZfPQQ0JXzrhspLC9le/mAwR3jTKh/zBRsBFCAGB0hJM2EJu0YxkYH2h7
wvHKV6TKoRfi3KPM3jspqeSguHfKfI3tItl9uqM3llyIPzsOD1yAdGlVq1HLFzH5
whVKwhqHo/SRNLevqIB3gnvClys7OwvHY1sr4jkLr2lOd0X0dgVUXJZVMoDMzsfU
FbUFPhVDDJwZekOgexc1W3ESBobXMjDuQPste90QTbwa2vU/1fQKc7rUAIes3CTs
rCxMoJim9kXmZLAf9UCL3sr0OtkK5Q==
=OAG9
-----END PGP SIGNATURE-----

--QeCY3H4cDzibhSMr--

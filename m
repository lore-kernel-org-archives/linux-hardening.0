Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FEC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FECE60F3A
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhJMPoN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhJMPoL (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B68C2608FE;
        Wed, 13 Oct 2021 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634139728;
        bh=BLd24JtMkDL+kr31RQ0SprqZYJDDoqvZZ1a5WPhYTec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSofEs1x3QOhSW1A+Gr66HnzUSjZHmofBH1ZfkPI2cSsYaG7MZZrgAEWyPYbJJeHe
         P13QzJ6Kx116W+YwqEtclD6NBAjWlclmScjatMIj6k9ELOfxtx3wPGSa2NM4Bw7Ypb
         SYpn0rokk0jWijZDUHuYcO1TKgNnOGuyyIIkJP82QZMMNEAjKFltkChEK7i148+7Te
         pfirTWLB47X+OPibFa1BALuCYOp14vo1jYTxIZiIG+H2k4GRn/hy7muMZh36Lr0QH4
         olAEelvBDh3VfkB2WK01bGhzh18LPUnw8eCx4PWguiTv7I/0UzT59nBmq34YJi61D0
         pBvI0cscXL6Cw==
Date:   Wed, 13 Oct 2021 16:42:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 9/9] arm64: implement dynamic shadow call stack for
 GCC
Message-ID: <YWb+TCAqugt4RFQg@sirena.org.uk>
References: <20211013152243.2216899-1-ardb@kernel.org>
 <20211013152243.2216899-10-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="00H17L26f+kuSy4i"
Content-Disposition: inline
In-Reply-To: <20211013152243.2216899-10-ardb@kernel.org>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--00H17L26f+kuSy4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 13, 2021 at 05:22:43PM +0200, Ard Biesheuvel wrote:

> +config UNWIND_PATCH_PAC_INTO_SCS
> +	def_bool y
> +	depends on CC_IS_GCC && SHADOW_CALL_STACK
> +	select UNWIND_TABLES
> +	select ARM64_PTR_AUTH_KERNEL
> +

This needs a dependency on the GCC relevant toolchain features for
pointer auth doesn't it?  Or just make it depend on rather than select
pointer auth.

--00H17L26f+kuSy4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFm/kwACgkQJNaLcl1U
h9D19gf+NclOK87GziIy5T7aAB3Y+3RfyRCGF61dsP/fqTEsdqVVC3sfveMa/Lci
eXVTs/cd2HqtNXLEquUV0mEyV83ttdvXZjO/6rbE+daouFuRaPyQLqGL1dAF6kJ5
AXYSQu6GmK1CilFWE5GTuOzAESpLgapTJ/kfiSGHSE4v/AvjFaYiPe1CEYWzawSE
ilMzfHw9bM8w+eClbtFM311vFTJD3SyTail0uZZTbJVSu4M3PeM24bExlh/QwqFV
7d9w5XpKpxy7xe0a/u7qkLffFm1nljUy7tY2WNSHRvqn+piqmAMmdD/LQBRsf3pq
XNVe6ti8At/Rb7uAyG2zkjUIp7vhYQ==
=uw3F
-----END PGP SIGNATURE-----

--00H17L26f+kuSy4i--

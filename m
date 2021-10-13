Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D45C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EEC61154
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMPq3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhJMPq2 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB64610CF;
        Wed, 13 Oct 2021 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634139865;
        bh=cnGlpW9Ly5FilYoIQdSEYJWtCFx9ARHjDe1Sg0ekjmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzajSGMwhKw54NOGhnE7F2IsJip06oWdwjPXrsJYaGK3G06B+XFFlztuYx4c9XNoI
         LidxNwB3DdGNxDs7GLMCJP1iB2KRAHG251FK3lWdOyZ3vowZPAkvVPDEFHtV+bJucF
         4dixNEHdc+FAeU6zcpd2qZFrWSL3sbltSgvY50rPHqf6EOTLV4tHhN5MMl5Jp0f8bX
         u7GfmPdSCsrEQIxDhCIlvMmwXCZv7wtbyvfeDdG8VTGr1U0EO2Fsme5nyxZfmT6PGF
         2r1zZHnPouBvQf9/2mmPLQUxJn0hUmg9yDeHJ2IkKFWJbJo2jQhjCAgSouVXxlSlyh
         hrHlN/4zmP3AQ==
Date:   Wed, 13 Oct 2021 16:44:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 6/9] arm64: smccc: create proper stack frames for
 HVC/SMC calls
Message-ID: <YWb+19izRou0L2tZ@sirena.org.uk>
References: <20211013152243.2216899-1-ardb@kernel.org>
 <20211013152243.2216899-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OIhNViKtqllNxFTS"
Content-Disposition: inline
In-Reply-To: <20211013152243.2216899-7-ardb@kernel.org>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--OIhNViKtqllNxFTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 13, 2021 at 05:22:40PM +0200, Ard Biesheuvel wrote:
> Create proper stack frames using the provided macros for HVC/SMC calling
> helpers that use the stack. This adds the PAC return address signing
> when enabled, and ensures that the unwinder can deal with occurrences
> of these routines appearing on the call stack.

Reviewed-by: Mark Brown <broonie@kernel.org>

--OIhNViKtqllNxFTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFm/tYACgkQJNaLcl1U
h9ClQQf/bxzPA/9s7Ggzd9YOq7uB9uMWO0CmgMzktgGs1JDQmAETht/rOoqRm5tU
zgDhHwbag7KbrViGK2SPpzm3iXvEM6omtIy7HY+4OsCxeZhPsjvhCMECFBilXT/5
NT61hz68sOHP6bujzZqd6BFZRtXQ2DCl/KyXdWExPyQdM38JiE4201j5+0Qozngm
c+5XRRnzVbKBF5gSdGE9vmwvGiT0THotq7WCWqORir+R8PAGwlwALAnvyJs8mGrW
EE7zOew/jxa5IeAoBJYYIn5McQGRBD53cymqfbg0iAG7NkZau1tNLCtIc5rGYoF8
L/1oZ+dcCHKnCw7kAEsQo8SlkqgbKQ==
=/qA3
-----END PGP SIGNATURE-----

--OIhNViKtqllNxFTS--

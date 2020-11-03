Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2DC2D0A3
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F94C221FB
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604424889;
	bh=ip59U7tSs/uZHMuxCZIR61tmzygdbBHUGZSDre8isGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OWynYHiQ5Htf55v5YvZpiXY03Wj3lszESDnqHh2/Iud9jM7jr0Jm7dufVfmy3po1u
	 Bf4c1VkiJZMARP3rMCgNrNPP1WRd++wRxKe+fZ4OVmGxhLVhZ0mgUAHKgxOJEtI+t4
	 h68pcMXChWUnIGDFyi17MEX69u7IQKSPI7DhspvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKCRet (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCRes (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 12:34:48 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3B621D91;
        Tue,  3 Nov 2020 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604424888;
        bh=ip59U7tSs/uZHMuxCZIR61tmzygdbBHUGZSDre8isGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cn6oexGmWcUT8AeX1aaNlsnN1iwcegecwZAwfuQYmSOYcoR925weIGH4XuHinqLD9
         fmRG+2VDec5XAOclpBvYzjRtyVuq1jMW/vxo83M/BTUE857W1XZVO4eI7PBwLAaiwd
         7Ftby+0twuq5orTtU1mBL40JWfOLaTdNJJYs2Hqw=
Date:   Tue, 3 Nov 2020 17:34:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201103173438.GD5545@sirena.org.uk>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <cover.1604393169.git.szabolcs.nagy@arm.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 10:25:37AM +0000, Szabolcs Nagy wrote:

> Re-mmap executable segments instead of mprotecting them in
> case mprotect is seccomp filtered.

> For the kernel mapped main executable we don't have the fd
> for re-mmap so linux needs to be updated to add BTI. (In the
> presence of seccomp filters for mprotect(PROT_EXEC) the libc
> cannot change BTI protection at runtime based on user space
> policy so it is better if the kernel maps BTI compatible
> binaries with PROT_BTI by default.)

Given that there were still some ongoing discussions on a more robust
kernel interface here and there seem to be a few concerns with this
series should we perhaps just take a step back and disable this seccomp
filter in systemd on arm64, at least for the time being?  That seems
safer than rolling out things that set ABI quickly, a big part of the
reason we went with having the dynamic linker enable PROT_BTI in the
first place was to give us more flexibility to handle any unforseen
consequences of enabling BTI that we run into.  We are going to have
similar issues with other features like MTE so we need to make sure that
whatever we're doing works with them too.

Also updated to Will's current e-mail address - Will, do you have
thoughts on what we should do here?

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hlK4ACgkQJNaLcl1U
h9DD3gf/WNywQ/sgsuMwVB40sA+4Df/FGYWXM9/N6kUbBvcnoS9DtrP5HUMkJBzB
XS2taPJPPVpHEm8WJti9lNOLj+5uLwGmPe9tv4APgATbU6xR9tpUaLqVTvnwGH9W
G3DRggj5ExKwSc0ArcrpLktH2MTraSmlN7OsEnIB2RMRNzkEacr+AlbDxHmnT1Co
SEbhoFrFKE452ptHVaHckiC6j6LGwDusc8uIOAaSHkNF9IbC+SU8UqnbiTkqbc68
q9vnCmiSjRFEHZgq/NV+PQVRQqkj2vIzFK3CDN5wotJQ0OGGbK6OmjuyLCYlqX1l
5S13yMzSMWD5ItabHkNWGMqfdrB0KA==
=oJHO
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

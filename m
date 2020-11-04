Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D76C388F7
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 10:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE3820786
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604487070;
	bh=EL3MPPblpZETCN5CGBbpdx2wNFw2ehB7q+0vul79rOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uSHsjHzPBaRhDhWogMYV8CIrmwWujaC8ef2Nag3Y0N0kYtAdjp68BxhRrlsmy/9i/
	 iuL+nihWuV3rAZqxUrK3QVl+ysAhiLSGb0nxr3MhEg+HeFXK/uhc+0wrXbB6tMkw0W
	 o3Ox9a/ziAKe24Aldy8/I/D0cFaV0RX4DA5gCkO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKDKvK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDKvJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 05:51:09 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C3D21734;
        Wed,  4 Nov 2020 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604487069;
        bh=EL3MPPblpZETCN5CGBbpdx2wNFw2ehB7q+0vul79rOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gnw8ix7jtk+FpSQ2JPIWzav2vH+eYG7WJxtrf3gv/xekAf36Ws7aUG0veeDYpGsdL
         ZjtWjWdRkESnWPvGc+DUh/VM2bj8OT7CsSAU3S2NIC1qWVtX/2BmeZkbk7CC9Iar2b
         vUlKB7Q91MQqaa5expOpYUMEFOz2ppmzbdDJ95Es=
Date:   Wed, 4 Nov 2020 10:50:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, libc-alpha@sourceware.org,
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
Message-ID: <20201104105058.GA4812@sirena.org.uk>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <8c99cc8e-41af-d066-b786-53ac13c2af8a@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <8c99cc8e-41af-d066-b786-53ac13c2af8a@arm.com>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 11:41:42PM -0600, Jeremy Linton wrote:
> On 11/3/20 11:34 AM, Mark Brown wrote:

> > Given that there were still some ongoing discussions on a more robust
> > kernel interface here and there seem to be a few concerns with this
> > series should we perhaps just take a step back and disable this seccomp
> > filter in systemd on arm64, at least for the time being?  That seems
> > safer than rolling out things that set ABI quickly, a big part of the

> So, that's a bigger hammer than I think is needed and punishes !BTI
> machines. I'm going to suggest that if we need to carry a temp patch its
> more like the glibc patch I mentioned in the Fedora defect. That patch
> simply logs a message, on the mprotect failures rather than aborting. Its
> fairly non-intrusive.

> That leaves seccomp functional, and BTI generally functional except when
> seccomp is restricting it. I've also been asked that if a patch like that is
> needed, its (temporary?) merged to the glibc trunk, rather than just being
> carried by the distro's.

The effect on pre-BTI hardware is an issue, another option would be for
systemd to disable this seccomp usage but only after checking for BTI
support in the system rather than just doing so purely based on the
architecture.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+ih5EACgkQJNaLcl1U
h9Dcpwf/XdKNaAx2fhe7pT7ULDO3eS7hkZsOWJAp/10DTzy4okkGEczgGoT+sN0F
5SY0u/yy8VpiUyQbxawQcWMFX4F8mwiNq6SH4GOFGL+zE4BbLUWULZsszOc2d4oQ
MmtZZPIE/+e8dNjvfe/rV+BEcKV4vTgVYHm/khWphDNYFymbinSrEkkCaTltcjdT
zr85iYltlC5uVO+WxbNhSc4rXx63oWZV3XCpUpwHf6go8ke0LrWqVH7XbZzXqrDC
h/c/vVfMESWXbxtPO46wo1g+KP+cL1ySrz2jK5LswI2aBDCyL3dWJSDaMeM7puX6
K37KSG088x6Vh/z2Qv2bjUci04ePeA==
=ta+U
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

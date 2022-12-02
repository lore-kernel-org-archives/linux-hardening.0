Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2AC4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 06:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBGbV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 01:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLBGbU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 01:31:20 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB12CB22D
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 22:31:18 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NNjkl36DJz9sV8;
        Fri,  2 Dec 2022 07:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1669962671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TAidHwLvCZiWXPKoDiPoA7+jsmvdHAxQZ4vloxVVvr8=;
        b=TP7EqhQtbjSAP8ZtIzVc2jlSVWi9XctekTvppuj18MmtrGc4opUIWADNGAhnLHRlUm5rJq
        XFicGjjbKPyzzH8iitGPDf3wO50msqfbJldDBNURAMLvXp7m5hB9i4gxDfvhs8W1BvefCq
        EShvU0bsQ7uvdMS1Rrt10A+NjywOCCdy1bTai36AHkG6WI8slWRH/epoGLbmjC/A7K6F5P
        VsLsRLfgqk5ITKQVl7bv5PFY6dJiTrRAzZKhmS7E68zhMdyXpiW2XDv/+urfTpV0eTf27n
        9CCJQhRKfVB4gmWEVRQUrBYndAE7fwu+Xtg7r4T/UVm1bOwu00Y4Se4eOteGfw==
Date:   Fri, 2 Dec 2022 07:31:06 +0100
From:   Stefan Bavendiek <stefan.bavendiek@mailbox.org>
To:     kernel-hardening@lists.openwall.com
Cc:     linux-hardening@vger.kernel.org
Subject: Re: Reducing runtime complexity
Message-ID: <Y4mbqmsMjTA63SlP@mailbox.org>
References: <Y4kJ4Hw0DVfy7S37@mailbox.org>
 <202212011520.F7FE481@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OjJW4BtemAF6EUG0"
Content-Disposition: inline
In-Reply-To: <202212011520.F7FE481@keescook>
X-MBO-RS-META: boiihxb3r6n4p47cknpzx7p59hi4msf4
X-MBO-RS-ID: 624dc7f5390c9debb5b
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--OjJW4BtemAF6EUG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 03:21:37PM -0800, Kees Cook wrote:
> On Thu, Dec 01, 2022 at 09:09:04PM +0100, Stefan Bavendiek wrote:
> > Some time ago I wrote a thesis about complexity in the Linux kernel and=
 how to reduce it in order to limit the attack surface[1].
> > While the results are unlikely to bring news to the audience here, it d=
id indicate some possible ways to avoid exposing optional kernel features w=
hen they are not needed.
> > The basic idea would be to either build or configure parts of the kerne=
l after or during the installation on a specific host.
> >=20
> > Distributions are commonly shipping the kernel as one large binary that=
 includes support for nearly every hardware driver and optional feature, bu=
t the end user will normally use very little of this.
> > In comparison, a custom kernel build for a particular device and use ca=
se, would be significantly smaller. While the reduced complexity won't be d=
irectly linked with reduction in attack surface, from my understanding the =
difference would make a relevant impact.
> >=20
> > The question I keep wondering about is how feasible this is for general=
 purpose distributions to have the kernel "rebuild" in this way when it is =
installed on a particular machine.
>=20
> Much of the functionality is modules, so once a system is booted and
> running the expected workloads, one can set the modules_disabled sysctl
> and block everything else from being loaded.
>=20
> -Kees
>=20
> --=20
> Kees Cook

Disableing modules in general will prevent quite a lot of functionality tha=
t would still be expected to work, like plugging in a usb device.
One approach may be to load everything that may possibly be required in the=
 future as well based on the use case of the specific system and then disab=
le loading additional modules, but that does not seem like a good solution =
either.

Perhaps exploring embedded device deployments is an idea, but in general th=
e idea is to ship a smaller kernel to something like Linux desktops without=
 limiting functionality that likely to be required.

- Stefan

--OjJW4BtemAF6EUG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjLwAv8xLYF1doyZLdIuckz2DLQMFAmOJm54ACgkQdIuckz2D
LQOSxhAAksnvYcW4WbFuMsSPeLIU3ORenpBT4p3Gzs577psCvT6i21Yhc0T+GsAB
VsXRT4QuAnRfMR8NfL8UPc5BaH9e1oETsgIn3OWdsxYxpwL4A/rj106QzBkMS1wW
/qeg0N6ctrqdnzgDbkTuoxrLtT3u1m9IyhyCh8lSOwcKoF9bXhuWV0BPbYmceRla
lajUTel/sKJcxKf1Sxz8r0nCIV/aPgLMVuHSz6+9QZ1/ApPQA4wdnkXLJO07LLlg
JFq6D5pSb0xzl66eh0t0s3aBG32TqRbjrvgh+FrOnkfNoQCOWs4L5Up/wHXroNaY
mp/E2hJQSfKYxdCEvIwhJFT/CmwKufPeqBGYv/O0mIvSTcZNphxn00lcR/xm+Agc
dUcfceWdFRMbm7pZ1M9btjrIwi2fJDDe3PJkGryFKw33sEVEpAmHiSSR2TCQPcfw
jl13tvjWnQQiCx7rwB2D1KqUV2FsiohXIXCV/oPVppK4GiMhh6ooME426k1KrGEa
ryZPDSfvCayhEMX/rOzsgLd3jCMx6d/0ZqgDZNS9uBvQIo3iVVlC/uulRoH1cI0H
zd9jhmjwPsI7KdNk71op45h8uNjfffuk39RR+RvdVkHlJzNvU7HpHj82BP290Tke
HCHxA77kJoC5JfKg3x6EbVrQJbmiHcMqMwg3rGdWjLtVT03fUIo=
=Hegd
-----END PGP SIGNATURE-----

--OjJW4BtemAF6EUG0--

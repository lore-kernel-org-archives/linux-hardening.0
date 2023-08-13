Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9EC001DB
	for <linux-hardening@archiver.kernel.org>; Sun, 13 Aug 2023 10:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHMKBg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 13 Aug 2023 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHMKBf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 13 Aug 2023 06:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4151708;
        Sun, 13 Aug 2023 03:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 314C061BE9;
        Sun, 13 Aug 2023 10:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D509BC433C8;
        Sun, 13 Aug 2023 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691920896;
        bh=5hO7G8BpKx5nLqEG8LO3RfxbwU3vMuk/JGHyD8Z2QPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNEi0tg2ThEOU476rUdbxfpBIRh3p8owJCpaS8oA7kQ8WJeDFHDmdQkhkxLjQg9u3
         tPQmoiEFXwniy2ScG0BxiJbYWEs17LtjbKj/F6oqvCMfHYCrVveh8HqHHNlpKy9Y0b
         4AYbVRa7pqxM5s1yc2sDNRpESknRRQ9nZkVdJkK8cmHYlzL1vKx6hr+3OqmrzWCRUo
         bAcrp0+iyINQGe/GalQ1ZYOSG4pjbYlJhWXhuFR3gPetlHkPRSGbm8QNqOQf6HXrt3
         wmeJ7QhD7abO+hPyJdY5+grsZhWUIenzv/SAW3yXKe8twRgJPVGcu+/g9DTPXfvjLA
         LDdNIcEBRq9IA==
Date:   Sun, 13 Aug 2023 11:01:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
Subject: Re: [PATCH v5 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Message-ID: <20230813-overarch-golf-e467a8adc559@spud>
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
 <20230812-pxa1908-lkml-v5-3-a5d51937ee34@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="geLVKEvy9vaVuliu"
Content-Disposition: inline
In-Reply-To: <20230812-pxa1908-lkml-v5-3-a5d51937ee34@skole.hr>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--geLVKEvy9vaVuliu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--geLVKEvy9vaVuliu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNip+QAKCRB4tDGHoIJi
0uMvAQCKjDQuz5Y5rfSWj6T8SBT3jfQqFD74ecb2X5GpM7fftgD8Co75UBnhhlzD
FVVRrZys1XbsY13gOt1vF3MQjAcP5g8=
=ZSrA
-----END PGP SIGNATURE-----

--geLVKEvy9vaVuliu--

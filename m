Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B857C04A6A
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Aug 2023 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjHHSSY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjHHSRs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D7196A9;
        Tue,  8 Aug 2023 10:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8D262428;
        Tue,  8 Aug 2023 07:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBAC433C7;
        Tue,  8 Aug 2023 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691480996;
        bh=x1L13VddAI4iND15BaelnnmmeBPHY/Ut6c6CffPYejo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV3hmWG/B0VINsfhJbi/OUjzXjGcKtG+i/5D8B04z3sfEmpOS/chk6SPInE+KOrf5
         43c6v4OEPDA4EDB31bnTmMioFmC26aAP065HMEpce9lcV/vzbrjfywRWMjdOHWiFjD
         a7moskD64pT3hF2VK/WxHFf344tQ6Xxi2V6qiSQ478BLNebYjY4j2zvvDzoHRKQcZc
         IN2NVA9QEFDNy6hH3bVhZVhuwb/m+zDCMMO/uz3k/6r7eaiAhYhmhzfjxZRevsvYV9
         DHnJ60gOoex7zvaM0smXDXfvuggoiWPqMyATXtIHUg++a/wkxntKcJqppP0ec9gW+g
         smw5NYwFhcviQ==
Date:   Tue, 8 Aug 2023 08:49:49 +0100
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
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Message-ID: <20230808-equator-professor-fcc4564b4ef5@spud>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
 <20230807-pxa1908-lkml-v4-3-cb387d73b452@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKM1rJC+2OjonCQb"
Content-Disposition: inline
In-Reply-To: <20230807-pxa1908-lkml-v4-3-cb387d73b452@skole.hr>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--DKM1rJC+2OjonCQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 05:42:37PM +0200, Duje Mihanovi=C4=87 wrote:
> diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bin=
dings/clock/marvell,pxa1908.h
> new file mode 100644
> index 000000000000..0c1f328bf534
> --- /dev/null
> +++ b/include/dt-bindings/clock/marvell,pxa1908.h
> +#define PXA1908_CLK_PLL4VCODIV3		38
> +#define PXA1908_MPMU_NR_CLKS		38

> +#define PXA1908_CLK_TWSI3		18
> +#define PXA1908_APBC_NR_CLKS		50

> +#define PXA1908_CLK_AICER		3
> +#define PXA1908_APBCP_NR_CLKS		50

> +#define PXA1908_CLK_DVC_DFC_DEBUG	16
> +#define PXA1908_APMU_NR_CLKS		50

How are these "NR_CLKS" things helpful to the binding?

--DKM1rJC+2OjonCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHznQAKCRB4tDGHoIJi
0tB0AP9WB00bkGFDXnoTipCneTMFFJkNGIcCMim70YGs/PIdNwEAgsNY8BDOP/Mj
dOmMDYrhdbMiafUMA6dZgar9DVSQfww=
=Oy5S
-----END PGP SIGNATURE-----

--DKM1rJC+2OjonCQb--

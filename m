Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F1C61DA4
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Mar 2023 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCFRBB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCFRAv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Mar 2023 12:00:51 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2764429414
        for <linux-hardening@vger.kernel.org>; Mon,  6 Mar 2023 09:00:28 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PVl582sK0z1S5Jh
        for <linux-hardening@vger.kernel.org>; Mon,  6 Mar 2023 11:53:16 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1678121594; x=1678985595; bh=uK+glyg
        nD/QeqUlfo72/hfCeJTh8hcZKk6WDctNDr6Q=; b=3RPgP/BMv0fYq+Gmo0DVDgr
        AalQE+KJp6SYXSeqEzydAkwUjFlmCwsnaafvlzYkFZ5vH2S4UxQmbi1o2Ngzp6v4
        4jldtsKMQU+4JfK0mVcfcDL667SS/s40MyPPWRM3EzyuXVczT/MSBfSlTzYk3+Z0
        OTnl51cdjSVC0RT1l1ckuIfZlApPWOG4poZWDKkAUoQoPU6A6Sm/Xkz8+vFrCOdJ
        v2gMaFCntMw2Uhk7Nsiu+TXvT45q8mP8iL++eL2/KaRnigv9Wh258Y+G4z6KgZkb
        o91HPvDaK2+tpDPjSPDKyTTB9MsOMDssTy8so+kfxLICiqgbOIfXLZBqELQiXFA=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LQV_S5dg657A for <linux-hardening@vger.kernel.org>;
        Mon,  6 Mar 2023 11:53:14 -0500 (EST)
Received: from dorothy.. (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PVl4p1NzFz1S4vb;
        Mon,  6 Mar 2023 11:52:57 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Subject: 
Date:   Mon,  6 Mar 2023 13:52:39 -0300
Message-Id: <20230306165246.14782-1-they@mint.lgbt>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Introduce Universal Flash Storage support on SM6125 and add support for t=
he Xiaomi Mi A3 based on the former platform.

Changes since v6:
- Add struct for v3-660 UFS PHY offsets and modify sm6115 UFS PHY to use =
it
- Set ufs_mem_phy reg size to 0xdb8 in sm6125.dtsi
- Drop "#address-cells" and "#size-cells" properties on reserved-memory n=
ode in xiaomi-laurel-sprout dts
- Move "status" last on &pon_resin node in xiaomi-laurel-sprout dts
- Modify "&pm6125_gpio" pointer to "&pm6125_gpios" in xiaomi-laurel-sprou=
t dts

v6: https://lore.kernel.org/linux-devicetree/20230108195336.388349-1-they=
@mint.lgbt/
v5: https://lore.kernel.org/linux-devicetree/20221231222420.75233-2-they@=
mint.lgbt/




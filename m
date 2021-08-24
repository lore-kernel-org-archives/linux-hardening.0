Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE2C4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04802610C7
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhHXJBF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:01:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:45459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhHXJBF (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 05:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629795611;
        bh=0VfrnapeUDvPazOxi1Wr6f/sh4SvDBH8hg1Xn2aOf04=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CGDHBZWvps2rhNGZP7hsrAkGuOmM6S0OynHmkg8kHcRGKrmQLaA/+kIRFPGQJjrOd
         /vSTJdFJZSkoNKVd2lmx/nf6kve2PUdNB6uM6NzVjqRIlTZ+lwPVckXE32fB6/lOgW
         5ygM9Uz+c87vXTaI1REIqHuVCWHVqPG4u/jBceHM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNsw4-1mgiKh0zMG-00OFI4; Tue, 24
 Aug 2021 11:00:11 +0200
Date:   Tue, 24 Aug 2021 10:59:58 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/3] staging/rtl8192u: Initialize variables in the
 definition block
Message-ID: <20210824073643.GA7396@titan>
References: <20210824072545.7321-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824072545.7321-1-len.baker@gmx.com>
X-Provags-ID: V03:K1:naE81iY4uFamsV4vjEQXBOsvAmqMssX3wtZ37GpsiPuUZCx5sHg
 P/khCM2CFHlHAW+Jg7kUQifM8yzM9MK/tqIVyZE+wCO7A0qwLfTFewPys65JMSq5eRRoXu/
 9NCl0LO4o0jh0P4J5OSmbpBVAo6uDhKn/vrXDmAZvNLicaZtT5srRorbaj22A7bPrmtc/9J
 0nBKBAgop+hwF8SQunIcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jZ6MUe0qtKY=:dbvYPtShHaawBk3L3Lhe9T
 bMX6PtEAwfR8y7J6IPT1z16+DlWRnRSmIIvMv1mVoVKH4iayUDxMD2y6z62zGGfLqWhbHME7R
 DiId9oNz0ydeteVhabD7aQknVTvObFCDlA40VW0OeeVBNuZ4WMe0++RgtYZYOyV2+T+ZhkMYC
 sBbamf4dx8KJitclaWotWsXBxIlde5u205YRZhU95PJMmof3r4/zTPw57n/lJNqb3/7s2HmbB
 D+oReVgC47oL65vtn1oNQ4GBehHwHuZpwZKskuqvjbq8LjATeW43j4z0GSZYtEKzihj5b1KKX
 OC6VSz5/ZKbXM+XpT9gxYLtKU0nnckyLuBp3pvpgUYOzp3BV5IHdgwl27qqijJCDY8URdkYc0
 XrT8K8Z9pqH9lGE+6DRVrUJMdVXUcSh1r2qarNb9x8bzeNwitq1pBIrYj4vleXtIV6Mj/1LQO
 N61HPh8OC8tFfXKzzEEtJ49l0Fe2XjYsHerPpFWami0NSOZsu01VfSG5IsgeBxiLkS0/Xoxc9
 Dwlj5NSzpYL0AGF4yrXABY3DMPhG6QxeF3lnYebdYlMbl95l112cn+cYzpBW8kbX4XEz6FJpI
 NatXMQaq4b5nZDiSpbhzc94eAsndJKzsjRt8ZRO787q8DkVUJnzAY+eTMk3EFf8vC2SqiBltE
 CyX1Pzjh2rsXNPsjSIRcCWB8jebF+z/I6cnKtrghBHnGzauhzr27u8f8O++cWTe7T7kAmt/NV
 szxXgvrFDIDmSFYhdrch4sZQT1Zju/GhxOYcMb+JNLQC4XPEWOMop5DI+sSIpOK/Cy3xAOI+I
 nrdDOXdksn7vqdHBIxU+IK14n7nFXEmI8AoN4yLZFMnq7aXMugV3Sxc2vo3+Ru2WS0d9uUVxX
 n62SIq0MWQrGoddCsp6TV0gHki4dLT90V6x0ibRrVFLTgfqIVYlxsUeppdtyCkjWS5Ji/JzH6
 mX20LUrSvDiIIbme2xRtvwIRgaqcDvynv081jLI3Sw+CbGFWVzaKofCe19L73+VUhwsNJV5jn
 QCmqn3OvkitMAQNxzrnt2N+oTaYmc8UXduotktKitylzX6S/cL/uw3wfCTWbGCnQgYvuuD895
 Wh1YpbYarf9DNb2GIfd80B9M8o1iVb+pRlB42l0gdq8BGs3LxWdFnFc/A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Initialize the pre_cmd_cnt, post_cmd_cnt and rf_cmd_cnt variables in the
definition block as it is not necessary to do this in the middle of the
function.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index 6a67708cdd89..ff6fe2ee3349 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1186,11 +1186,11 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
 	struct sw_chnl_cmd *pre_cmd;
-	u32 pre_cmd_cnt;
+	u32 pre_cmd_cnt =3D 0;
 	struct sw_chnl_cmd *post_cmd;
-	u32 post_cmd_cnt;
+	u32 post_cmd_cnt =3D 0;
 	struct sw_chnl_cmd *rf_cmd;
-	u32 rf_cmd_cnt;
+	u32 rf_cmd_cnt =3D 0;
 	struct sw_chnl_cmd *current_cmd =3D NULL;
 	u8 e_rfpath;
 	bool ret;
@@ -1225,7 +1225,6 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_de=
vice *dev, u8 channel,
 	/* FIXME: need to check whether channel is legal or not here */

 	/* <1> Fill up pre common command. */
-	pre_cmd_cnt =3D 0;
 	rtl8192_phy_SetSwChnlCmdArray(pre_cmd, pre_cmd_cnt++,
 				      MAX_PRECMD_CNT, CMD_ID_SET_TX_PWR_LEVEL,
 				      0, 0, 0);
@@ -1233,12 +1232,10 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 				      MAX_PRECMD_CNT, CMD_ID_END, 0, 0, 0);

 	/* <2> Fill up post common command. */
-	post_cmd_cnt =3D 0;
 	rtl8192_phy_SetSwChnlCmdArray(post_cmd, post_cmd_cnt++,
 				      MAX_POSTCMD_CNT, CMD_ID_END, 0, 0, 0);

 	/* <3> Fill up RF dependent command. */
-	rf_cmd_cnt =3D 0;
 	switch (priv->rf_chip) {
 	case RF_8225:
 		if (!(channel >=3D 1 && channel <=3D 14)) {
=2D-
2.25.1

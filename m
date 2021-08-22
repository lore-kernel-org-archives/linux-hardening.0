Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E2C4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC756120D
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHVO35 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 10:29:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:35617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhHVO34 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 10:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629642548;
        bh=v55i8H9V0YDthbmGH75+wnPIzwGg44O1DNoshimwrz4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TJsMtj2eBpJ2kdyDPHyqxDDzaqkNz+tnbmrOaro0WQ4bMj7ncKdAYf6AeGiyHHQ0H
         Fy2mszk/FY0Y52oQ99D0xoJtJy+jQV5CsINQ5Cu1dqAy6m0aHGM0INvLWST00p7kc4
         qrmAd3mDYIvyDyVJxl1v/9wadrLBT08NoOuWR+PY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MYNJq-1mUPOY0LL8-00VNDY; Sun, 22 Aug 2021 16:29:08 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] staging/rtl8192u: Avoid CamelCase in names of variables
Date:   Sun, 22 Aug 2021 16:28:19 +0200
Message-Id: <20210822142820.5109-2-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822142820.5109-1-len.baker@gmx.com>
References: <20210822142820.5109-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lCkinLXCS/jfjP/ORHr9naZephk3SR9ZvccxJbFvDvSoBD8/V56
 OrXmP675TuNQOxAkHxm51fBVTDYHn/NEDoy8bjaub5eFwSu/2LtvzncL2vEnY4DhpT1xJ9Y
 eMU1aUfhSnX8eCuFG1UpnzvGrM8RL/nugYMgimnqJoc3l0H8yPvwxDFUsou5Siesh3dCdx+
 uxK68S7tlw5YUGWgVPMAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cu/uPITe50w=:OM70h4/zvv9tq4ZpwmuGdt
 neFeZWbMuHXBp5i8sKyMlDg4cMRTkVQL/wGEQSlWu6Wno5Ixo5419E2b7G7vdNkug0tg1tBlS
 TQXPm+yFeZGMeR4b3JNkYFo7jDY9PjKKBjLokZHbvvTiCnoULci/4tyiYz5hm7Exg0ypcTgDM
 00a944lt6DcXZPABjI3n4zNLkMrTPdfRQVq6+tX7NXLvoMvHa5cAaMN2HDg2Pu04FLuHh2z93
 NabeL545/rM63uEpISCRytgnHlLlGjDLFIakWrMpLUQplF4rGSMYZae9DZaSTXjGrP1+p60Uy
 /pEYjdYowoH1kKTTykbmJLaHwZIdWvaodN4st0izSZ560oA4AYHX18+ah/+0UaHGmGqJ1BEvP
 WQrQcrcInnXvXg2NKNHhQrscOVitohH2H4OLnpU6/mkL2+HFEgn71i6sn/RWhNs7oVnvcxCZY
 G5lWY1rJn9W8A8jC+ooXZciPj0Mq23jLKVc22/GDkNsB7XfN07FSLvxw3KXzVZSQQdAxam8ie
 Ag/8ZSb0QaGQ/Pn1duBLGSO2s1cYz1IzwwO7el/kOb8yCEIGfMLxSSHeXLLNzlyuBNK1TJfnV
 vT3HZpKZq+gkWeoUyRIN0vAwrlrzTGEDGK68XKyqF7TS+DsY6YIJcyLcv0VwGHljTQj2wcHGX
 NQ4rrBTbJArZrqGCX9KTeG7mWzbywNofxdCLSeSB1ZQnbVpA5JMRoOsEksOXchwe//A5tsWa/
 zcmOXqt5e/cex1uWS7K7hKW6BDK3hfgzYjGvbauN1cq0JDTysS6al7LYSJlYUBRVhlBnD9fen
 dqu/GJPeiqCzzQf3KgJqMPHEVXDucs50s0oGboex6cb0tY03Koh3yIUxWOALCAR4hWfTr8Otk
 2SHFrgUdooNrYx/27/4HiC/nT1fEeCoeaLJba6cQYpp8z/+b/M2nnfAVMKNxqA2wka9IVBm19
 aJVz3M/GTf9EL855lN48CycXlhyaqeBxGR4qOE9w4ij/Ckc8ANIanSTm76nVHd1CV8n+kZ9UB
 nMPdhJ3Nd3ILpcNicdOnCQYQX+72+2BGNaDtz4G5MgE6ECinPxaXKCWiowyhBlUygHnUF2yd0
 IrFDchnMy2+wy63nyZHZBIOaz/IP4ZUPK3NyEZEwTJkIheXdkeVLPQM8Q==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Avoid CameCase in the names of all local variables inside the function
rtl8192_phy_SwChnlStepByStep().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 92 +++++++++++++--------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index 37b82553412e..ff6fe2ee3349 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1185,30 +1185,30 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 				       u8 *stage, u8 *step, u32 *delay)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
-	struct sw_chnl_cmd   *PreCommonCmd;
-	u32		   PreCommonCmdCnt;
-	struct sw_chnl_cmd   *PostCommonCmd;
-	u32		   PostCommonCmdCnt;
-	struct sw_chnl_cmd   *RfDependCmd;
-	u32		   RfDependCmdCnt;
-	struct sw_chnl_cmd  *CurrentCmd =3D NULL;
-	u8		   e_rfpath;
-	bool		   ret;
-
-	PreCommonCmd =3D kzalloc(sizeof(*PreCommonCmd) * MAX_PRECMD_CNT, GFP_KER=
NEL);
-	if (!PreCommonCmd)
+	struct sw_chnl_cmd *pre_cmd;
+	u32 pre_cmd_cnt =3D 0;
+	struct sw_chnl_cmd *post_cmd;
+	u32 post_cmd_cnt =3D 0;
+	struct sw_chnl_cmd *rf_cmd;
+	u32 rf_cmd_cnt =3D 0;
+	struct sw_chnl_cmd *current_cmd =3D NULL;
+	u8 e_rfpath;
+	bool ret;
+
+	pre_cmd =3D kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
+	if (!pre_cmd)
 		return false;

-	PostCommonCmd =3D kzalloc(sizeof(*PostCommonCmd) * MAX_POSTCMD_CNT, GFP_=
KERNEL);
-	if (!PostCommonCmd) {
-		kfree(PreCommonCmd);
+	post_cmd =3D kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
+	if (!post_cmd) {
+		kfree(pre_cmd);
 		return false;
 	}

-	RfDependCmd =3D kzalloc(sizeof(*RfDependCmd) * MAX_RFDEPENDCMD_CNT, GFP_=
KERNEL);
-	if (!RfDependCmd) {
-		kfree(PreCommonCmd);
-		kfree(PostCommonCmd);
+	rf_cmd =3D kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
+	if (!rf_cmd) {
+		kfree(pre_cmd);
+		kfree(post_cmd);
 		return false;
 	}

@@ -1225,21 +1225,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 	/* FIXME: need to check whether channel is legal or not here */

 	/* <1> Fill up pre common command. */
-	PreCommonCmdCnt =3D 0;
-	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
+	rtl8192_phy_SetSwChnlCmdArray(pre_cmd, pre_cmd_cnt++,
 				      MAX_PRECMD_CNT, CMD_ID_SET_TX_PWR_LEVEL,
 				      0, 0, 0);
-	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
+	rtl8192_phy_SetSwChnlCmdArray(pre_cmd, pre_cmd_cnt++,
 				      MAX_PRECMD_CNT, CMD_ID_END, 0, 0, 0);

 	/* <2> Fill up post common command. */
-	PostCommonCmdCnt =3D 0;
-
-	rtl8192_phy_SetSwChnlCmdArray(PostCommonCmd, PostCommonCmdCnt++,
+	rtl8192_phy_SetSwChnlCmdArray(post_cmd, post_cmd_cnt++,
 				      MAX_POSTCMD_CNT, CMD_ID_END, 0, 0, 0);

 	/* <3> Fill up RF dependent command. */
-	RfDependCmdCnt =3D 0;
 	switch (priv->rf_chip) {
 	case RF_8225:
 		if (!(channel >=3D 1 && channel <=3D 14)) {
@@ -1249,13 +1245,13 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 			ret =3D true;
 			goto out;
 		}
-		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
+		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
 					      MAX_RFDEPENDCMD_CNT,
 					      CMD_ID_RF_WRITE_REG,
 					      rZebra1_Channel,
 					      RF_CHANNEL_TABLE_ZEBRA[channel],
 					      10);
-		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
+		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
 					      MAX_RFDEPENDCMD_CNT,
 					      CMD_ID_END, 0, 0, 0);
 		break;
@@ -1269,11 +1265,11 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 			ret =3D true;
 			goto out;
 		}
-		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
+		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
 					      MAX_RFDEPENDCMD_CNT,
 					      CMD_ID_RF_WRITE_REG,
 					      rZebra1_Channel, channel, 10);
-		rtl8192_phy_SetSwChnlCmdArray(RfDependCmd, RfDependCmdCnt++,
+		rtl8192_phy_SetSwChnlCmdArray(rf_cmd, rf_cmd_cnt++,
 					      MAX_RFDEPENDCMD_CNT,
 					      CMD_ID_END, 0, 0, 0);
 		break;
@@ -1290,19 +1286,19 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 	do {
 		switch (*stage) {
 		case 0:
-			CurrentCmd =3D &PreCommonCmd[*step];
+			current_cmd =3D &pre_cmd[*step];
 			break;
 		case 1:
-			CurrentCmd =3D &RfDependCmd[*step];
+			current_cmd =3D &rf_cmd[*step];
 			break;
 		case 2:
-			CurrentCmd =3D &PostCommonCmd[*step];
+			current_cmd =3D &post_cmd[*step];
 			break;
 		}

-		if (CurrentCmd->cmd_id =3D=3D CMD_ID_END) {
+		if (current_cmd->cmd_id =3D=3D CMD_ID_END) {
 			if ((*stage) =3D=3D 2) {
-				(*delay) =3D CurrentCmd->ms_delay;
+				*delay =3D current_cmd->ms_delay;
 				ret =3D true;
 				goto out;
 			}
@@ -1311,31 +1307,31 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 			continue;
 		}

-		switch (CurrentCmd->cmd_id) {
+		switch (current_cmd->cmd_id) {
 		case CMD_ID_SET_TX_PWR_LEVEL:
 			if (priv->card_8192_version =3D=3D VERSION_819XU_A)
 				/* consider it later! */
 				rtl8192_SetTxPowerLevel(dev, channel);
 			break;
 		case CMD_ID_WRITE_PORT_ULONG:
-			write_nic_dword(dev, CurrentCmd->para_1,
-					CurrentCmd->para_2);
+			write_nic_dword(dev, current_cmd->para_1,
+					current_cmd->para_2);
 			break;
 		case CMD_ID_WRITE_PORT_USHORT:
-			write_nic_word(dev, CurrentCmd->para_1,
-				       (u16)CurrentCmd->para_2);
+			write_nic_word(dev, current_cmd->para_1,
+				       (u16)current_cmd->para_2);
 			break;
 		case CMD_ID_WRITE_PORT_UCHAR:
-			write_nic_byte(dev, CurrentCmd->para_1,
-				       (u8)CurrentCmd->para_2);
+			write_nic_byte(dev, current_cmd->para_1,
+				       (u8)current_cmd->para_2);
 			break;
 		case CMD_ID_RF_WRITE_REG:
 			for (e_rfpath =3D 0; e_rfpath < RF90_PATH_MAX; e_rfpath++) {
 				rtl8192_phy_SetRFReg(dev,
 						     (enum rf90_radio_path_e)e_rfpath,
-						     CurrentCmd->para_1,
+						     current_cmd->para_1,
 						     bZebra1_ChannelNum,
-						     CurrentCmd->para_2);
+						     current_cmd->para_2);
 			}
 			break;
 		default:
@@ -1345,14 +1341,14 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 		break;
 	} while (true);

-	(*delay) =3D CurrentCmd->ms_delay;
+	*delay =3D current_cmd->ms_delay;
 	(*step)++;
 	ret =3D false;

 out:
-	kfree(PreCommonCmd);
-	kfree(PostCommonCmd);
-	kfree(RfDependCmd);
+	kfree(pre_cmd);
+	kfree(post_cmd);
+	kfree(rf_cmd);

 	return ret;
 }
=2D-
2.25.1


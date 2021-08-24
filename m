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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D93C4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9443A61165
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhHXH1U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:27:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:41267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhHXH1U (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 03:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629789988;
        bh=v17RKsvGJ+zoaPgm4NV0ZimaezNoWpAZALPNlLCZSKA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M2pm69Cr9L9PRTmJyL0p8lc0yrNYulbJh27A8uDA7stNhjjebOhABc0MZRp7sjypo
         15mz32lJsKPsUgRRi2LNB2+Qcr6aQaMcfpk2cJvZvBH23h7+VelibBUhsLlqaFceRT
         OqmjF1rHCIetyRJgbV4Ra8giamZAWzLihdLWSY3U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N6sn1-1n6gd22uHH-018HgK; Tue, 24 Aug 2021 09:26:27 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/3] staging/rtl8192u: Avoid CamelCase in names of variables
Date:   Tue, 24 Aug 2021 09:25:43 +0200
Message-Id: <20210824072545.7321-2-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824072545.7321-1-len.baker@gmx.com>
References: <20210824072545.7321-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jULEbUMt/rThvxH2t+pF9WN49skqlHlsle5kt8EjnHFFj88p5qN
 R/OBFzDK1CVLWKP7AYQMrdZ7CJUxGgHSfTY6RmpFi8Fi3k+aL6sVBgoFvqR1fZL4Rrnf7x8
 L+41ma5qKeygxpcZMzxVBXcu2nzYNJ2XI/iA+dul0dF/8uHlMiK5sXN0AiGCMHt9Kx0FPfq
 5UPPjElNn2w5C8TpHDtWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZBF2KGwooXY=:GmjcWq6bGCWuL0GgLs9OYI
 m/mtNb0I7Xvc6S9JgRliIPtO8xs9Y5z9HoObJlEmnVF98IuFxrAP3ACAgDADKlndbS67QSemI
 CRrtXulPyWqML12W/Amn8D9GHnRoV8qCRJosO/qz0hubch+EV9Jlk5obgby5PnKE8rOQC3deM
 jAbdiMGPJB1kYNdmolOJtQlx+Vk50gswbq5z+rExY0rilLPkJLWGTS3sXsX/j3qcBDQ1LOF+1
 H745phnyf4uynj35WvKmQK1QgrC4m8c/nSSOEnSUvD+kHK5ZJ6Hr7NE5t7SU0gZ2sNWd7TJW3
 6UwNxsbbZzBdpSSBdy2fjvi78u5X6aa2SqK4aT+N3xYYSUQ+pePUH43juxekIWrVQNwRvzGLZ
 tVF802qZ0Zrjwrug0VBq7Qzd6I8Pg/uYnM33e9WATnkSqJbYL9fBuujKWW2ZS6CNhEvS9/5ad
 yWt8rp04gHxVyYBIcLtlq14IempusLSrkSVs4WueqdiHssLe57cN8IaQRnPn/E3o9lM/Hi3E9
 k74QrEzE/P/JO+pZDaY4zyYh7OivPey48wFSOWU0w4grY3c8SNu8ZXznLUuuKh4ppfOM2IFcB
 rY4y5eBvhW+gA4yQsOVhMXMqXxoJfWgtEZgmgKGu5prg4jtL9at7ZCmbQKtZCyO8OgjGWmZu7
 vNm54AJRmuLuiliyUaDqI8hgMlE3bTTYD/HyDNNCSWohoBE9IFp0ElcBg37AoWLqESju3CZZ+
 dkIwQpWs7KroPqXRWNjoUhVJmc+MPwEMwN9slSuuACGefnsdNpmvJwdM7aQiaZYuEP0PEjhT9
 YHBfisoEcmavpbT3mFiDJywk6qjyt+n1a3bnU+r/+39dAaB67m5g2hvaHs/ia6wh/uRmxm99v
 qAMhxH5pZ5v1Q0T22kTmP0+AfCI9zRUU6XgpzqvN1SMoXlPTkeWDQfkJXPAA/JBDcQ+yKmOuI
 TWcHT0vhTonIU2n63m3ZS9A9RzStPFdLQmNBzP+cEho9qgtdsOfkN3LpORe8cUwo7aeriqS7i
 LReA8m8sv6xEJ2NWA/kukwILjsK4Oh24ZmhFr11cdIM4oSdsq4hhpUJnsh4gS4cFpH2I1+ihU
 vmerTfZSHLtH8FeQHXl0R+K0zvZf6ShL0gtL7tcYfAksEFFNtVL5s7mlg==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Avoid CameCase in the names of all local variables inside the function
rtl8192_phy_SwChnlStepByStep().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 95 +++++++++++++--------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index 37b82553412e..6a67708cdd89 100644
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
+	u32 pre_cmd_cnt;
+	struct sw_chnl_cmd *post_cmd;
+	u32 post_cmd_cnt;
+	struct sw_chnl_cmd *rf_cmd;
+	u32 rf_cmd_cnt;
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

@@ -1225,21 +1225,20 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 	/* FIXME: need to check whether channel is legal or not here */

 	/* <1> Fill up pre common command. */
-	PreCommonCmdCnt =3D 0;
-	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
+	pre_cmd_cnt =3D 0;
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
+	post_cmd_cnt =3D 0;
+	rtl8192_phy_SetSwChnlCmdArray(post_cmd, post_cmd_cnt++,
 				      MAX_POSTCMD_CNT, CMD_ID_END, 0, 0, 0);

 	/* <3> Fill up RF dependent command. */
-	RfDependCmdCnt =3D 0;
+	rf_cmd_cnt =3D 0;
 	switch (priv->rf_chip) {
 	case RF_8225:
 		if (!(channel >=3D 1 && channel <=3D 14)) {
@@ -1249,13 +1248,13 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
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
@@ -1269,11 +1268,11 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
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
@@ -1290,19 +1289,19 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
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
@@ -1311,31 +1310,31 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
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
@@ -1345,14 +1344,14 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
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

